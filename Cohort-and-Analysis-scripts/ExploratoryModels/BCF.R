# Load necessary libraries (including Bayesian Causal Forest package)
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
library(bcf)  # Bayesian Causal Forest
library(data.table)
library(pROC)
library(survAUC)
library(pec)

# Read in the data
# dat <- read.table("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final/Joshua_cumulative_matched_data.txt", 
#                   header = TRUE, sep = "\t") %>%
#   mutate(patid = as.character(patid))

cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")


FinalMatched <- analysis$cached(name = "finalMatchedData")  %>%
  mutate(patid = as.character(patid)) %>%
  collect()


FinalMatched$age_risperidone_cat <- gsub('^"|"$', '', FinalMatched$age_risperidone_cat)
FinalMatched$stroke_cat <- gsub('^"|"$', '', FinalMatched$stroke_cat)

table(FinalMatched$risperidone)
dat <- FinalMatched

# Standardize continuous variables
continuous_vars <- dat %>%
  select(age_diagnosis, age_risperidone, period_before_prescription)

continuous_scaled <- scale(continuous_vars)

# One-hot encoding for categorical variables
categorical_vars <- dat %>%
  select(ethnicity, BMI, deprivation)

categorical_matrix <- model.matrix(~ . - 1, data = categorical_vars)

# Binary features
binary_vars <- dat %>%
  select(pre_index_date_angina, pre_index_date_heartfailure, pre_index_date_myocardialinfarction,
         pre_index_date_tia, pre_index_date_falls, pre_index_date_lowerlimbfracture,
         pre_index_date_ihd, pre_index_date_pad, pre_index_date_af, pre_index_date_revasc,
         pre_index_date_qof_diabetes, pre_index_date_anxiety_disorders, pre_index_date_fh_diabetes,
         pre_index_date_fh_premature_cvd, pre_index_date_pulmonary_embolism, pre_index_date_deep_vein_thrombosis,
         pre_index_date_haem_cancer, pre_index_date_solid_cancer, pre_index_date_hearing_loss, pre_index_date_VTE, 
         Prescribed_other_antipsychotic_Prior)#, pre_index_date_hypertension)

# Combine all covariates
covariates_matrix <- cbind(continuous_scaled, categorical_matrix, binary_vars)

# Splitting the data into training and testing sets
# set.seed(123)
# train_indices <- sample(1:nrow(dat), size = 0.7 * nrow(dat))
# train_data <- dat[train_indices, ]
# test_data <- dat[-train_indices, ]

set.seed(123)  # Ensure reproducibility

# Step 1: Split the data into training and test sets (70% train, 30% test)
train_indices <- sample(1:nrow(dat), size = 0.7 * nrow(dat))
train_data <- dat[train_indices, ]
test_data <- dat[-train_indices, ]

# Step 2: Prepare covariates for training and testing
train_covariates <- covariates_matrix[train_indices, ]
test_covariates <- covariates_matrix[-train_indices, ]

# Step 3: Outcome vectors and treatment assignment
train_time_to_event <- train_data$time_to_event
train_event_indicator <- train_data$stroke_composite_post_index_date
test_time_to_event <- test_data$time_to_event
test_event_indicator <- test_data$stroke_composite_post_index_date

train_W <- as.numeric(train_data$risperidone)
test_W <- as.numeric(test_data$risperidone)

# Step 4: Downsampling the non-users to match the number of users
num_users <- sum(train_W == 1)   # Number of users (minority group)
num_non_users <- sum(train_W == 0)   # Number of non-users (majority group)

# Downsample the non-users
set.seed(123)  # Ensure reproducibility
non_user_indices <- which(train_W == 0)
downsampled_non_user_indices <- sample(non_user_indices, num_users)

# Combine indices for downsampled non-users and all users
downsampled_indices <- c(downsampled_non_user_indices, which(train_W == 1))

train_data_downsampled <- train_data[downsampled_indices, ]
train_covariates_downsampled <- train_covariates[downsampled_indices, ]
train_time_to_event_downsampled <- train_time_to_event[downsampled_indices]
train_event_indicator_downsampled <- train_event_indicator[downsampled_indices]
train_W_downsampled <- train_W[downsampled_indices]


set.seed(1234)
train_covariates_matrix <- as.matrix(train_covariates_downsampled)
test_covariates_matrix <- as.matrix(test_covariates)

y <- train_event_indicator_downsampled
z <- as.numeric(train_W_downsampled)
x_control <- train_covariates_matrix
propensity_scores <- train_data_downsampled$distance 


bcf_model <- bcf(
  y = y,
  z = z,
  pihat = propensity_scores,
  x_control = train_covariates_matrix,
  x_moderate = train_covariates_matrix,
  nburn = 300,  
  nsim = 500,  
  ntree_control = 50, 
  ntree_moderate = 20,  
  save_tree_directory = NULL, 
  no_output = FALSE,
  verbose = TRUE,
  n_threads = 4  
)


# Predict the treatment effects on the test set
bcf_predictions <- predict(bcf_model, newdata = test_covariates_matrix)

# Extract the treatment effects
bcf_treatment_effects <- bcf_predictions$tau

# Mean and standard deviation of the treatment effects
mean_treatment_effect <- mean(bcf_treatment_effects, na.rm = TRUE)
sd_treatment_effect <- sd(bcf_treatment_effects, na.rm = TRUE)

cat("Mean Treatment Effect (Bayesian Causal Forest):", mean_treatment_effect, "\n")
cat("Standard Deviation of Treatment Effects:", sd_treatment_effect, "\n")

# Visualizations for Bayesian Causal Forest

# Convert treatment effects to a dataframe
treatment_effects_df <- data.frame(TreatmentEffect = bcf_treatment_effects)

# Violin Plot
ggplot(treatment_effects_df, aes(x = "", y = TreatmentEffect)) +
  geom_violin(trim = FALSE, fill = "skyblue", color = "black") +
  geom_boxplot(width = 0.1, position = position_dodge(0.9), color = "black", alpha = 0.7) +
  labs(title = "Violin Plot of Estimated Treatment Effects: Bayesian Causal Forest",
       x = "",
       y = "Estimated Treatment Effect") +
  theme_minimal()

# Density Plot of Treatment Effects
ggplot(treatment_effects_df, aes(x = TreatmentEffect)) +
  geom_density(fill = "skyblue", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of Treatment Effects: Bayesian Causal Forest",
       x = "Estimated Treatment Effect",
       y = "Density") +
  theme_minimal()

