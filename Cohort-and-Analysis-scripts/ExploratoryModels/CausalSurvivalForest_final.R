# Load necessary libraries
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
library(tableone)
library(purrr)
library(bit64)
library(survival)
library(survminer)
library(ggplot2)
library(cmprsk)
library(rms)
library(MatchIt)
library(grf) # Generalized Random Forests for causal forests
library(tidyverse)
library(data.table)
library(pROC)
# library(survcomp)
library(survAUC)
library(pec)
# # Initialize CPRDData
# Initialize CPRDData
cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")


FinalMatched <- analysis$cached(name = "finalMatchedData")  %>%
  mutate(patid = as.character(patid)) %>%
  collect()


FinalMatched$age_risperidone_cat <- gsub('^"|"$', '', FinalMatched$age_risperidone_cat)
FinalMatched$stroke_cat <- gsub('^"|"$', '', FinalMatched$stroke_cat)

table(FinalMatched$risperidone)


dat <- dat %>%
  mutate(
    pre_index_totalcholesterol = ifelse(date_totalcholesterol < issuedate, totalcholesterol, "Unknown"),
    pre_index_hypertension = ifelse(is.na(obsdate_hypertension) | (obsdate_hypertension < issuedate), comorbidity_hypertension, "Unknown")
  )

#########################################
#Setup all outcomes
# Setup all outcomes
dat <- dat %>%
  
  mutate(
    # Calculate censoring time
    cens_at = pmin(
      as.Date(issuedate) + (365.25),
      as.Date(death_composite_date),
      lcd,
      regenddate,
      # FinalCensorDate_prescription,
      na.rm = TRUE
    ),
    
    
    # Calculate stroke censor date
    Stroke_censor = pmin(Stroke, as.Date(cens_at), na.rm = TRUE),
    
    # Calculate time to event in days
    time_to_event = as.numeric(difftime(Stroke_censor, issuedate, units = "days")),
    
   
  )




dat <- dat %>%
  mutate(
    # Adjust stroke_composite_post_index_date
    stroke_composite_post_index_date = ifelse(
      coalesce(Stroke, as.Date('9999-12-31')) > coalesce(Stroke_censor, as.Date('9999-12-31')),
      0,
      stroke_composite_post_index_date
    )
  )

# # Step 2: Filter Data and Select Covariates
dat <- dat %>% filter(stroke_composite_pre_index_date == 1)

covariates <- dat %>%
  select(c("age_diagnosis", "sex"
           # , "ethnicity" , "age_risperidone"
           # "pre_index_date_angina", "pre_index_date_heartfailure", "pre_index_date_myocardialinfarction",
           # "pre_index_date_tia", "pre_index_date_falls", "pre_index_date_lowerlimbfracture",
           # "pre_index_date_ihd", "pre_index_date_pad", "pre_index_date_af", "pre_index_date_revasc",
           # "pre_index_date_qof_diabetes", "pre_index_date_anxiety_disorders", "pre_index_date_fh_diabetes",
           # "pre_index_date_fh_premature_cvd", "pre_index_date_pulmonary_embolism", "pre_index_date_deep_vein_thrombosis",
  ))

# Convert to matrix and handle categorical variables
covariates_matrix <- model.matrix(~ . - 1, data = covariates)

# Step 3: Split the Data into Training and Testing Sets
set.seed(123) # Ensure reproducibility
train_indices <- sample(1:nrow(dat), size = 0.7 * nrow(dat))
train_data <- dat[train_indices, ]
test_data <- dat[-train_indices, ]

# Prepare covariates for training and testing
train_covariates <- covariates_matrix[train_indices, ]
test_covariates <- covariates_matrix[-train_indices, ]

# Outcome vectors for training data
train_time_to_event <- train_data$time_to_event
train_event_indicator <- train_data$stroke_composite_post_index_date

# Outcome vectors for testing data (for evaluation)
test_time_to_event <- test_data$time_to_event
test_event_indicator <- test_data$stroke_composite_post_index_date

# Treatment assignment for training and testing
train_W <- as.numeric(train_data$risperidone)
test_W <- as.numeric(test_data$risperidone)

# Standardize covariates
train_covariates_scaled <- scale(train_covariates)
test_covariates_scaled <- scale(test_covariates)

# Step 5: Train the Causal Survival Forest Model
horizon <- 84
# Number of users (minority group)
num_users <- sum(train_W == 1)

# Number of non-users (majority group)
num_non_users <- sum(train_W == 0)

# Downsample the non-users to match the number of users
set.seed(123)  # For reproducibility
non_user_indices <- which(train_W == 0)
downsampled_non_user_indices <- sample(non_user_indices, num_users)

# Combine indices for downsampled non-users and all users
downsampled_indices <- c(downsampled_non_user_indices, which(train_W == 1))

# Create the downsampled training set
train_data_downsampled <- train_data[downsampled_indices, ]
train_covariates_downsampled <- train_covariates[downsampled_indices, ]
train_time_to_event_downsampled <- train_time_to_event[downsampled_indices]
train_event_indicator_downsampled <- train_event_indicator[downsampled_indices]
train_W_downsampled <- train_W[downsampled_indices]

# # Standardize covariates for downsampled training data
# train_covariates_downsampled_scaled <- scale(train_covariates_downsampled)


# 
# # Proceed with the causal forest model training using downsampled data
causal_forest_model <- causal_survival_forest(
  X = train_covariates_downsampled,
  Y = train_time_to_event_downsampled,
  D = train_event_indicator_downsampled,
  W = train_W_downsampled,
  target = "RMST",
  num.trees = 400,  # Adjust as needed
  sample.fraction = 0.50,  # Adjusted sampling fraction
  min.node.size = 5,
  honesty = TRUE,
  honesty.fraction = 0.5,
  honesty.prune.leaves = TRUE,
  alpha = 0.05,
  stabilize.splits = TRUE,
  num.threads = 8,
  tune.parameters = "all",
  seed = 1234,
  mtry = min(ceiling(sqrt(ncol(train_covariates_downsampled)) + 20), ncol(train_covariates_downsampled)),
  horizon = horizon
)
weights <- ifelse(train_W == 1, 1 / sum(train_W == 1), 1 / sum(train_W == 0))


# treatment_effects <- predict(causal_forest_model, newdata = test_covariates, horizon = horizon)$predictions
treatment_effects <- predict(causal_forest_model, newdata = test_covariates)

treatment_effect_values <- treatment_effects$predictions

# c_index <- survival::concordance.index(
#   x = treatment_effects$predictions,
#   surv.time = test_time_to_event,  # Actual time-to-event data
#   surv.event = test_event_indicator  # Censoring indicator
# )
# c_index

mean_treatment_effect <- mean(treatment_effect_values, na.rm = TRUE)
sd_treatment_effect <- sd(treatment_effect_values, na.rm = TRUE)

cat("Mean Treatment Effect:", mean_treatment_effect, "\n")
cat("Standard Deviation of Treatment Effects:", sd_treatment_effect, "\n")

treatment_effects_df <- data.frame(treatment_effects = treatment_effect_values)

ggplot(treatment_effects_df, aes(x = "", y = treatment_effects)) +
  geom_violin(trim = FALSE, fill = "skyblue", color = "black") +
  geom_boxplot(width = 0.1, position = position_dodge(0.9), color = "black", alpha = 0.7) +
  labs(title = "Violin Plot of Estimated Treatment Effects: with_stroke",
       x = "",
       y = "Estimated Treatment Effect") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_blank(),
    axis.text.y = element_text(size = 10)
  )


# Load necessary libraries
library(ggplot2)

treatment_effects_df <- data.frame(treatment_effects = treatment_effect_values)

ggplot(treatment_effects_df, aes(x = "", y = treatment_effects)) +
  geom_violin(trim = FALSE, fill = "skyblue", color = "black") +
  geom_boxplot(width = 0.1, position = position_dodge(0.9), color = "black", alpha = 0.7) +
  labs(title = "Violin Plot of Estimated Treatment Effects: with_stroke",
       x = "",
       y = "Estimated Treatment Effect") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_blank(),
    axis.text.y = element_text(size = 10)
  )

ggplot(treatment_effects_df, aes(x = treatment_effect_values)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Histogram of Estimated Treatment Effects: with_stroke",
       x = "Estimated Treatment Effect",
       y = "Frequency") +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  )




# Load necessary library
library(survival)

# Example data
predictions <- as.numeric(treatment_effect_values)  # Predicted treatment effects or survival probabilities
time_to_event <- test_time_to_event            # Actual time to event
event_indicator <- test_event_indicator        # Event indicator

# Create a survival object
surv_obj <- Surv(time = time_to_event, event = event_indicator)

# Compute the concordance index
c_index <- survConcordance(surv_obj ~ predictions)$concordance

# Display the result
cat("Concordance Index (C-index):", c_index, "\n")



# Load necessary library
library(survival)

# Example data
predictions <- as.numeric(treatment_effect_values)  # Predicted treatment effects or survival probabilities
time_to_event <- test_time_to_event            # Actual time to event
event_indicator <- test_event_indicator        # Event indicator

# Create a survival object
surv_obj <- Surv(time = time_to_event, event = event_indicator)

# Fit a Cox proportional hazards model
cox_model <- coxph(surv_obj ~ predictions)

# Compute the concordance index
c_index <- summary(cox_model)$concordance[1]

# Display the result
cat("Concordance Index (C-index):", c_index, "\n")


summary(treatment_effect_values)


# Step 1: Prepare the data
ITE_predictions <- predict(causal_forest_model, newdata = test_covariates)$predictions
ground_truth_effects <- test_time_to_event  # Assuming this is the ground truth

comparison_df <- data.frame(
  ITE_Predictions = treatment_effect_values,
  Ground_Truth = ground_truth_effects
)

summary(dat$age_diagnosis)

# Predict treatment effects on training data
train_treatment_effects <- predict(causal_forest_model, newdata = train_covariates)

# Predict treatment effects on testing data (already done previously)
test_treatment_effects <- predict(causal_forest_model, newdata = test_covariates, horizon = horizon)


# Mean and Standard Deviation of Treatment Effects on Training Data
mean_train_treatment_effect <- mean(train_treatment_effects$predictions, na.rm = TRUE)
sd_train_treatment_effect <- sd(train_treatment_effects$predictions, na.rm = TRUE)

# Mean and Standard Deviation of Treatment Effects on Testing Data
mean_test_treatment_effect <- mean(test_treatment_effects$predictions, na.rm = TRUE)
sd_test_treatment_effect <- sd(test_treatment_effects$predictions, na.rm = TRUE)

# Print the results
cat("Training Data - Mean Treatment Effect:", mean_train_treatment_effect, "\n")
cat("Training Data - Standard Deviation of Treatment Effects:", sd_train_treatment_effect, "\n\n")

cat("Testing Data - Mean Treatment Effect:", mean_test_treatment_effect, "\n")
cat("Testing Data - Standard Deviation of Treatment Effects:", sd_test_treatment_effect, "\n")


# Create a combined data frame for visualization
combined_treatment_effects_df <- data.frame(
  TreatmentEffect = c(train_treatment_effects$predictions, test_treatment_effects$predictions),
  Dataset = factor(c(rep("Training", length(train_treatment_effects$predictions)), rep("Testing", length(test_treatment_effects$predictions))))
)

# Violin Plot with Boxplot Overlay
ggplot(combined_treatment_effects_df, aes(x = Dataset, y = TreatmentEffect, fill = Dataset)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.1, position = position_dodge(0.9), color = "black", alpha = 0.7) +
  labs(title = "Comparison of Estimated Treatment Effects: Training vs. Testing Data, with_stroke",
       x = "Dataset",
       y = "Estimated Treatment Effect") +
  theme_minimal() +
  scale_fill_manual(values = c("skyblue", "lightgreen"))


