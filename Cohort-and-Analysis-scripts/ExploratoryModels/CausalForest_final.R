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


# Initialize CPRDData
cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")


FinalMatched <- analysis$cached(name = "finalMatchedData")  %>%
  mutate(patid = as.character(patid)) %>%
  collect()


FinalMatched$age_risperidone_cat <- gsub('^"|"$', '', FinalMatched$age_risperidone_cat)
FinalMatched$stroke_cat <- gsub('^"|"$', '', FinalMatched$stroke_cat)

table(FinalMatched$risperidone)

dat <- FinalMatched


dat <- dat %>%
  mutate(
    pre_index_totalcholesterol = ifelse(date_totalcholesterol < issuedate, totalcholesterol, "Unknown"),
    pre_index_hypertension = ifelse(is.na(obsdate_hypertension) | (obsdate_hypertension < issuedate), comorbidity_hypertension, "Unknown")
  )

dat <- dat %>% filter(stroke_composite_pre_index_date == 0)

covariates <- dat %>%
  select(c("age_diagnosis", "age_risperidone", "gender_decode", "ethnicity",
           "pre_index_date_angina", "pre_index_date_heartfailure", "pre_index_date_myocardialinfarction",
           "pre_index_date_tia", "pre_index_date_falls", "pre_index_date_lowerlimbfracture",
           "pre_index_date_ihd", "pre_index_date_pad", "pre_index_date_af", "pre_index_date_revasc",
           "pre_index_date_qof_diabetes", "pre_index_date_anxiety_disorders", "pre_index_date_fh_diabetes",
           "pre_index_date_fh_premature_cvd", "pre_index_date_pulmonary_embolism", "pre_index_date_deep_vein_thrombosis",
           "pre_index_date_haem_cancer", "pre_index_date_solid_cancer", "pre_index_date_hearing_loss", "pre_index_hypertension"))

# Convert to matrix and handle categorical variables
covariates_matrix <- model.matrix(~ . - 1, data = covariates)

# Outcome: stroke occurrence (binary)
Y <- as.numeric(dat$stroke_composite_post_index_date)

# Treatment: whether the patient took risperidone (binary)
W <- as.numeric(dat$risperidone)

# Split the data into training and testing sets
train_indices <- sample(1:nrow(dat), size = 0.7 * nrow(dat))
train_data <- dat[train_indices, ]
test_data <- dat[-train_indices, ]

# Prepare training and testing covariates
train_covariates <- covariates_matrix[train_indices, ]
test_covariates <- covariates_matrix[-train_indices, ]

# Training outcome and treatment
train_Y <- as.numeric(train_data$stroke_composite_post_index_date)
train_W <- as.numeric(train_data$risperidone)

# Remove rows with NA values in train_Y or train_W
non_na_train_indices <- complete.cases(train_Y, train_W)
train_Y <- train_Y[non_na_train_indices]
train_W <- train_W[non_na_train_indices]
train_covariates <- train_covariates[non_na_train_indices, ]

# Testing outcome and treatment
test_Y <- as.numeric(test_data$stroke_composite_post_index_date)
test_W <- as.numeric(test_data$risperidone)

# Remove rows with NA values in test_Y or test_W
non_na_test_indices <- complete.cases(test_Y, test_W)
test_Y <- test_Y[non_na_test_indices]
test_W <- test_W[non_na_test_indices]
test_covariates <- test_covariates[non_na_test_indices, ]

# Train the causal forest model with adjusted parameters
causal_forest_model <- causal_forest(
  X = train_covariates,
  Y = train_Y,
  W = train_W,
  num.trees = 300,         # Increased number of trees
  min.node.size = 5         # Smaller node size
)

# Predict treatment effects for the test data
treatment_effects <- predict(causal_forest_model, test_covariates)$predictions
treatment_effects
individual_effects <- predict(causal_forest_model)
# head(individual_effects)

# Assuming test_set is a separate dataset
test_predictions <- predict(causal_forest_model, newdata = test_covariates)
# test_predictions
# Summarize the predicted treatment effects
summary(treatment_effects)

# Calculate the mean and standard deviation
mean_treatment_effect <- mean(treatment_effects, na.rm = TRUE)
sd_treatment_effect <- sd(treatment_effects, na.rm = TRUE)

# Print the results
cat("Mean Treatment Effect:", mean_treatment_effect, "\n")
cat("Standard Deviation of Treatment Effects:", sd_treatment_effect, "\n")



variable_names <- colnames(train_covariates)
importance_scores <- variable_importance(causal_forest_model)
# Convert importance_scores to a vector
importance_vector <- as.vector(importance_scores)

# Create data frame
importance_df <- data.frame(
  Variable = variable_names,
  Importance = importance_vector
)

# Arrange in descending order of importance
importance_df <- importance_df[order(-importance_df$Importance), ]

# Plot Variable Importance
ggplot(importance_df, aes(x = reorder(Variable, Importance), y = Importance)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  labs(
    title = "Variable Importance in Causal Forest Model: no stroke history",
    x = "Variable",
    y = "Importance Score"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  )

# Define a subgroup based on a covariate of interest
# For example, let's consider 'age_diagnosis' as a key variable
subgroup_indices <- which(test_covariates[, "age_diagnosis"] > 65)
#
# # Calculate the mean treatment effect in this subgroup
mean_treatment_effect_subgroup <- mean(treatment_effects[subgroup_indices], na.rm = TRUE)
#
# # Print the result
cat("Mean Treatment Effect for Age > 65:", mean_treatment_effect_subgroup, "\n")
#
#
# Plot the density of treatment effects
ggplot(data.frame(treatment_effects), aes(x = treatment_effects)) +
  geom_density(fill = "skyblue", alpha = 0.7) +
  labs(title = "Density of Treatment Effects",
       x = "Estimated Treatment Effect",
       y = "Density") +
  theme_minimal()


# # Add the subgroup information to a data frame
results_df <- data.frame(
  treatment_effects = treatment_effects,
  age_group = ifelse(test_covariates[, "age_diagnosis"] > 65, ">65", "<=65")
)
#
# # Plot boxplot
ggplot(results_df, aes(x = age_group, y = treatment_effects, fill = age_group)) +
  geom_boxplot() +
  labs(title = "Treatment Effects by Age Group",
       x = "Age Group",
       y = "Estimated Treatment Effect") +
  theme_minimal()

# # Scatter plot of treatment effects versus age
ggplot(data.frame(age_diagnosis = test_covariates[, "age_diagnosis"],
                  treatment_effects = treatment_effects),
       aes(x = age_diagnosis, y = treatment_effects)) +
  geom_point(alpha = 0.5) +
  labs(title = "Treatment Effects vs. Age Diagnosis",
       x = "Age at Diagnosis",
       y = "Estimated Treatment Effect") +
  theme_minimal()
#




# Load necessary libraries
library(ggplot2)

# Create a data frame for the treatment effects
treatment_effects_df <- data.frame(
  treatment_effects = treatment_effects
)

# Generate the violin plot
ggplot(treatment_effects_df, aes(x = "", y = treatment_effects)) +
  geom_violin(trim = FALSE, fill = "skyblue", color = "black") +  # Create the violin plot
  geom_boxplot(width = 0.1, position = position_dodge(0.9), color = "black", alpha = 0.7) +  # Add a boxplot inside the violin plot
  labs(title = "Violin Plot of Estimated Treatment Effects: no stroke history",
       x = "",
       y = "Estimated Treatment Effect") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_blank(),
    axis.text.y = element_text(size = 10)
  )




