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
library(dplyr)
library(survival)
library(survminer)
library(ggplot2)

# # Initialize CPRDData
cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")

FinalMatched <- analysis$cached(name = "finalMatchedData")  %>%
  mutate(patid = as.character(patid)) %>%
  collect() 


FinalMatched$age_risperidone_cat <- gsub('^"|"$', '', FinalMatched$age_risperidone_cat)
FinalMatched$stroke_cat <- gsub('^"|"$', '', FinalMatched$stroke_cat)

table(FinalMatched$risperidone)

#Stroke
output_dir <- "C:/Users/njc232/OneDrive - University of Exeter/Documents/GitHub/Dementia/NewDataDownload/images/AnalysisPlots/"
dir.create(output_dir, showWarnings = FALSE)
#########################################

# Categorize stroke recency to less than a year, 1 - 5 years and over 5 years
FinalMatched <- FinalMatched %>%
  mutate(
    Stroke = stroke_compositeDate_post_first_stroke,
    recency = as.numeric(as.Date(issuedate) - as.Date(stroke_compositeDate_pre_latest_stroke)) / 365.25,
    recency_cat = case_when(
      recency < 1 ~ 0,
      recency >= 1 & recency <= 5 ~ 1,
      recency > 5 ~ 2,
      TRUE ~ NA_real_    
    )
  )

FinalMatched <- FinalMatched %>%
  mutate(recency_cat = as.factor(recency_cat))

##### record missing hypertension and total cholesterol records as unknown
FinalMatched <- FinalMatched %>%
  mutate(
    pre_index_totalcholesterol = ifelse(date_totalcholesterol < issuedate, totalcholesterol, "Unknown"),
    pre_index_hypertension = ifelse(is.na(obsdate_hypertension) | (obsdate_hypertension < issuedate), comorbidity_hypertension, "Unknown")
  )
#########################################
#Setup all outcomes
dat <- FinalMatched %>%
  
  mutate(cens_at=pmin(as.Date(issuedate)+(365.25),
                      as.Date(death_composite_date), 
                      lcd, 
                      regenddate,
                      na.rm=TRUE),
         
         stroke.pc = as.Date(post_index_date_first_stroke),
         stroke.hes = as.Date(HES_post_index_date_first_stroke),
         Stroke = as.Date(stroke_compositeDate_post_first_stroke),
         death = as.Date(death_composite_date),
         cvd = as.Date(post_index_date_first_cvd),
         tia = as.Date(post_index_date_first_tia),
         heartfailure = as.Date(post_index_date_first_heartfailure),
         myocardialinfarction = as.Date(post_index_date_first_myocardialinfarction),
         angina = as.Date(post_index_date_first_angina),
         pad = as.Date(post_index_date_first_pad),
         falls = as.Date(post_index_date_first_falls),
         lowerlimbfracture = as.Date(post_index_date_first_lowerlimbfracture),
         VTE = as.Date(post_index_date_first_VTE)
  )


# outcomes <- c("stroke.pc","stroke.hes","Stroke")#,"death", "cvd", "tia", "heartfailure", "myocardialinfarction", "angina", "pad", "falls", "lowerlimbfracture")

outcomes <- c("Stroke", "stroke.hes") #, "VTE", )#


for (i in outcomes) {
  
  outcome_var=paste0(i)
  censdate_var=paste0(i, "_censdate")
  censvar_var=paste0(i, "_censvar")
  censtime_var=paste0(i, "_censtime_yrs")
  dat <- dat %>%
    mutate({{censdate_var}}:=pmin(as.Date(!!sym(outcome_var)), as.Date(cens_at), na.rm=TRUE),
           {{censvar_var}}:=ifelse(!is.na(as.Date(!!sym(outcome_var))) & !!sym(censdate_var)==!!sym(outcome_var), 1, 0),
           {{censtime_var}}:=as.numeric(difftime(!!sym(censdate_var), issuedate, unit="days"))/365.25,
    )
}


# Define balanced set 
match.bal <- function(data) {
  data <- data %>% mutate(subclass.n = as.numeric(as.factor(subclass)))
  # Exclude controls who no longer have a matched case
  conc.ids <- data %>% filter(risperidone == 1) %>% select(subclass.n)
  conc.ids <- conc.ids$subclass.n
  data <- data %>% filter(subclass.n %in% conc.ids)
  # Exclude cases who no longer have a matched control
  disc.ids <- data %>% filter(risperidone == 0) %>% select(subclass.n)
  disc.ids <- disc.ids$subclass.n
  data <- data %>% filter(subclass.n %in% disc.ids)
}


##################### Define each subgroup separately ########
all_data <- dat
no_stroke <- dat %>% filter(stroke_composite_pre_index_date == 0)
with_stroke <- dat %>% filter(stroke_composite_pre_index_date == 1)
HES_stroke <- dat %>%
  mutate(
    Stroke = HES_post_index_date_first_stroke,
    stroke_composite_post_index_date = HES_post_index_date_stroke
  )
PreCovidPeriod_all <- dat %>% filter(obsdate <= as.Date("2020-02-10"))
PreCovidPeriod_no_stroke <- dat %>% filter(obsdate <= as.Date("2020-02-10") & stroke_composite_pre_index_date == 0)
PreCovidPeriod_with_stroke <- dat %>% filter(obsdate <= as.Date("2020-02-10") & stroke_composite_pre_index_date == 1)
PreCovidPeriod_no_cvd <- dat %>% filter(obsdate <= as.Date("2020-02-10") & pre_index_date_cvd == 0)
PreCovidPeriod_with_cvd <- dat %>% filter(obsdate <= as.Date("2020-02-10") & pre_index_date_cvd == 1)
# over_75 <- dat %>% filter(age_risperidone >= 75)
# under_75 <- dat %>% filter(age_risperidone < 75)
# no_other_drugs <- dat %>% filter(is.na(other_drug_issuedate))
CVD <- dat %>% filter(pre_index_date_cvd == 1)
No_CVD <- dat %>% filter(pre_index_date_cvd == 0)
# diabetes <- dat %>% filter(pre_index_date_qof_diabetes == 1)
# No_diabetes <- dat %>% filter(pre_index_date_qof_diabetes == 0)
# VTE <- dat %>% filter(pre_index_date_VTE == 1)
# No_VTE <- dat %>% filter(pre_index_date_VTE == 0)
# BMI_Obese_overweight <- dat %>% filter(BMI == "Obesity" | BMI == "Overweight" | BMI == "Severely Obese")
# BMI_Normal_underweight <- dat %>% filter(BMI == "Normal" | BMI == "Underweight")
# atrialFibrillation <- dat %>% filter(pre_index_date_af == 1)
# No_atrialFibrillation <- dat %>% filter(pre_index_date_af == 0)
risperidone_Age_65_74 <- dat %>% filter(age_risperidone_cat == "65 - 74")
risperidone_Age_75_84 <- dat %>% filter(age_risperidone_cat == "75 - 84")
risperidone_Age_85_plus <- dat %>% filter(age_risperidone_cat == "85+")
# hypertension_stage1AndHigher <- dat %>% filter(pre_index_hypertension == "Stage 1" | pre_index_hypertension == "Stage 2" | pre_index_hypertension == "Stage 3")
# hypertension_stage2AndHigher <- dat %>% filter(pre_index_hypertension == "Stage 2" | pre_index_hypertension == "Stage 3")
# carehome_preIndexDate <- dat %>% filter(care_home_before_indexdate == 1)
# HES_ONS_stroke <- dat %>%
#   mutate(
#     Stroke = pmin(HES_post_index_date_first_stroke, ONS_stroke_post_date, na.rm=TRUE),
#     stroke_compositeDate_post_first_stroke = pmin(HES_post_index_date_first_stroke, ONS_stroke_post_date, na.rm=TRUE)
#   )
stroke_recency_1_year <- dat %>% filter(recency < 1)
stroke_recency_1_5_years <- dat %>% filter(recency >= 1 & recency <= 5)
stroke_recency_over_5_years <- dat %>% filter(recency > 5)
ischaemicstroke <- dat %>% filter(stroke_cat == "ischaemic" | HES_post_index_stroke_type == "ischaemic" | (cause_of_death_stroke_type == "ischaemic" & !is.na(ONS_stroke_post_date)))
haemorrhagicstroke <- dat %>% filter(stroke_cat == "haemorrhagic" | HES_post_index_stroke_type == "haemorrhagic" | (cause_of_death_stroke_type == "haemorrhagic" & !is.na(ONS_stroke_post_date)))

# Combine all subgroups into a list
subgroups <- list(
  "all" = all_data,
  "no_stroke" = no_stroke, 
  "with_stroke" = with_stroke,
  "CVD" = CVD,
  "No_CVD" = No_CVD,
  "HES_stroke" = HES_stroke,
  "PreCovidPeriod_all" = PreCovidPeriod_all,
  "PreCovidPeriod_no_stroke" = PreCovidPeriod_no_stroke,
  "PreCovidPeriod_with_stroke" = PreCovidPeriod_with_stroke,
  "PreCovidPeriod_no_cvd" = PreCovidPeriod_no_cvd,
  "PreCovidPeriod_with_cvd" = PreCovidPeriod_with_cvd,
  # "over_75" = over_75,
  # "under_75" = under_75,
  # "no_other_drugs" = no_other_drugs,
  # "diabetes" = diabetes,
  # "No_diabetes" = No_diabetes,
  # "With_VTE" = VTE,
  # "No_VTE" = No_VTE,
  # "BMI_Obese_overweight" = BMI_Obese_overweight,
  # "BMI_Normal_underweight" = BMI_Normal_underweight,
  # "atrialFibrillation" = atrialFibrillation,
  # "No_atrialFibrillation" = No_atrialFibrillation,
  "risperidone_Age_65_74" = risperidone_Age_65_74,
  "risperidone_Age_75_84" = risperidone_Age_75_84,
  "risperidone_Age_85+" = risperidone_Age_85_plus,
  # "hypertension_stage1AndHigher" = hypertension_stage1AndHigher,
  # "hypertension_stage2AndHigher" = hypertension_stage2AndHigher,
  # "carehome_preIndexDate" = carehome_preIndexDate,
  # "HES&ONS_stroke" = HES_ONS_stroke,
  "stroke_recency_1_year" = stroke_recency_1_year,
  "stroke_recency_1_5_years" = stroke_recency_1_5_years,
  "stroke_recency_over_5_years" = stroke_recency_over_5_years,
  "ischaemicstroke" = ischaemicstroke,
  "haemorrhagicstroke" = haemorrhagicstroke
)



# Apply match.bal to all subgroups
for (subgroup_name in names(subgroups)) {
  subgroups[[subgroup_name]] <- match.bal(subgroups[[subgroup_name]])
}



# Modify the function to return results in the desired format
fit_cox_model <- function(data, outcome, subgroup, model_type) {
  # Define formula based on model_type
  if (model_type == "unadjusted") {
    formula <- as.formula(paste0("Surv(", outcome, "_censtime_yrs, ", outcome, "_censvar) ~ risperidone"))
  } else {
    formula <- as.formula(paste0("Surv(", outcome, "_censtime_yrs, ", outcome, "_censvar) ~ risperidone + sex + age_risperidone + ethnicity + pre_index_date_stroke + pre_index_date_qof_diabetes + pre_index_date_haem_cancer + pre_index_date_ihd + pre_index_date_af + pre_index_date_myocardialinfarction + pre_index_date_heartfailure + pre_index_date_hypertension"))
  }
  
  # Fit Cox model
  model <- coxph(formula, data = data, x = TRUE, y = TRUE, robust = TRUE, weights = data$weights, cluster = data$subclass)
  
  # Extract coefficients and standard errors
  se <- as.numeric(summary(model)$coefficients[1, "robust se", drop = FALSE])
  ci.l <- model$coefficients[1] - (1.96 * se)
  ci.u <- model$coefficients[1] + (1.96 * se)
  
  # Calculate event count and person-time for each group (control and risperidone users)
  event_count_control <- sum(data[[paste0(outcome, "_censvar")]] == 1 & data$risperidone == 0)
  person_time_control <- sum(data[[paste0(outcome, "_censtime_yrs")]][data$risperidone == 0])
  incidence_rate_control_per_1000_PY <- (event_count_control / person_time_control) * 1000
  
  event_count_risperidone <- sum(data[[paste0(outcome, "_censvar")]] == 1 & data$risperidone == 1)
  person_time_risperidone <- sum(data[[paste0(outcome, "_censtime_yrs")]][data$risperidone == 1])
  incidence_rate_risperidone_per_1000_PY <- (event_count_risperidone / person_time_risperidone) * 1000
  
  # Compute standard errors for the incidence rates using standard error propagation
  se_incidence_rate_control <- sqrt(event_count_control) / person_time_control * 1000
  se_incidence_rate_risperidone <- sqrt(event_count_risperidone) / person_time_risperidone * 1000
  
  # Calculate the 95% confidence intervals for the incidence rates
  ci.l_incidence_rate_control <- incidence_rate_control_per_1000_PY - (1.96 * se_incidence_rate_control)
  ci.u_incidence_rate_control <- incidence_rate_control_per_1000_PY + (1.96 * se_incidence_rate_control)
  
  ci.l_incidence_rate_risperidone <- incidence_rate_risperidone_per_1000_PY - (1.96 * se_incidence_rate_risperidone)
  ci.u_incidence_rate_risperidone <- incidence_rate_risperidone_per_1000_PY + (1.96 * se_incidence_rate_risperidone)
  
  # Fit survival model
  sfit <- survfit(Surv(data[[paste0(outcome, "_censtime_yrs")]], data[[paste0(outcome, "_censvar")]]) ~ risperidone, data = data)
  
  # Calculate ARD (Absolute Risk Difference)
  time_point <- 1
  summary_sfit <- summary(sfit, times = time_point)
  risperidone_group <- summary_sfit$surv[which(summary_sfit$strata == "risperidone=1")]
  control_group <- summary_sfit$surv[which(summary_sfit$strata == "risperidone=0")]
  absoluteRiskDifference <- control_group - risperidone_group
  
  
  # Calculate event rates (cumulative incidence) at the specified time point
  risperidone_event_rate <- 1 - risperidone_group
  control_event_rate <- 1 - control_group
  
  # Sample sizes
  n_treatment <- sum(data$risperidone == 1)
  n_control <- sum(data$risperidone == 0)
  
  # Calculate NNT (Number Needed to Treat)
  ARR <- abs(control_group - risperidone_group)
  
  
  # Calculate NNT (Number Needed to Treat)
  NNH <- 1 / ARR
  
  # Calculate standard error of ARR
  SE_ARR <- sqrt((control_event_rate * (1 - control_event_rate) / n_control) + (risperidone_event_rate * (1 - risperidone_event_rate) / n_treatment))
  
  # Calculate the 95% confidence interval for ARR
  ARR_CI_lower <- ARR - (1.96 * SE_ARR)
  ARR_CI_upper <- ARR + (1.96 * SE_ARR)
  
  # Ensure ARR_CI_lower and ARR_CI_upper are within valid range
  ARR_CI_lower <- max(ARR_CI_lower, 0)  # ARR cannot be negative
  ARR_CI_upper <- min(ARR_CI_upper, 1)  # ARR cannot be more than 1
  
  # Calculate the confidence interval for NNH
  NNH_CI_lower <- ifelse(ARR_CI_upper > 0, 1 / ARR_CI_upper, Inf)
  NNH_CI_upper <- ifelse(ARR_CI_lower > 0, 1 / ARR_CI_lower, Inf)
  
  res <- data.frame(
    subgroup = subgroup,
    outcome = outcome,
    Group = c("Matched Controls", "Risperidone Users"),
    N_total = c(nrow(data[data$risperidone == 0, ]), nrow(data[data$risperidone == 1, ])),
    N_events = c(event_count_control, event_count_risperidone),
    Person_years_at_risk = c(round(person_time_control, 0), round(person_time_risperidone, 0)),
    Incidence_rate_per_1000_PY = c(
      paste0(round(incidence_rate_control_per_1000_PY, 1), 
             " (", round(ci.l_incidence_rate_control, 1), ", ", round(ci.u_incidence_rate_control, 1), ")"),
      paste0(round(incidence_rate_risperidone_per_1000_PY, 1), 
             " (", round(ci.l_incidence_rate_risperidone, 1), ", ", round(ci.u_incidence_rate_risperidone, 1), ")")
    ),
    Adjusted_HR_with_CI = paste0(
      round(exp(model$coefficients[1]), 2), 
      " (", round(exp(ci.l), 2), ", ", round(exp(ci.u), 2), ")"
    ),
    NNH = round(NNH, 2),
    NNH_CI_lower = round(NNH_CI_lower, 2),  # Lower CI for NNH
    NNH_CI_upper = round(NNH_CI_upper, 2),  # Upper CI for NNH
    ARR = round(ARR, 4)  # Absolute Risk Reduction
  )
  
  return(res)
}

# Initialize an empty list to store results
results <- list()

# Loop over each subgroup
for (subgroup_name in names(subgroups)) {
  data <- subgroups[[subgroup_name]]
  
  # Fit both unadjusted and adjusted models for each outcome
  for (outcome in outcomes) {
    # Fit unadjusted model
    # res_unadjusted <- fit_cox_model(data, outcome, subgroup_name, "unadjusted")
    # results[[paste0(outcome, "_unadjusted_", subgroup_name)]] <- res_unadjusted

    # Fit adjusted model
    res_adjusted <- fit_cox_model(data, outcome, subgroup_name, "adjusted")
    results[[paste0(outcome, "_adjusted_", subgroup_name)]] <- res_adjusted
  }
}

results_df <- do.call(rbind, results)

# Print combined results dataframe
# Set the option to print all rows
options(max.print = nrow(results_df) * ncol(results_df))




# Define a list of new subgroup names
subgroup_renames <- c(
  "all" = "Overall",
  "no_stroke" = "No stroke history",
  "with_stroke" = "Stroke history",
  "CVD" = "CVD history",
  "No_CVD" = "No CVD history",
  "HES_stroke" = "HES Stroke",
  "PreCovidPeriod_all" = "Pre-COVID overall",
  "PreCovidPeriod_no_stroke" = "Pre-COVID No stroke history",
  "PreCovidPeriod_with_stroke" = "Pre-COVID Stroke history",
  "PreCovidPeriod_no_cvd" = "Pre-COVID No CVD history",
  "PreCovidPeriod_with_cvd" = "Pre-COVID CVD history",
  "ischaemicstroke" = "Stroke type Ischaemic",
  "haemorrhagicstroke" = "Stroke type Haemorrhagic",
  "risperidone_Age_65_74" = "Prescription age 65-74",
  "risperidone_Age_75_84" = "Prescription age 75-84",
  "risperidone_Age_85+" = "Prescription age 85 years and above",
  "stroke_recency_1_year" = "Stroke recency less than 1 year",
  "stroke_recency_1_5_years" = "Stroke recency 1-5 years",
  "stroke_recency_over_5_years" = "Stroke recency Over 5 years"
)

# Apply renames to the subgroup column in results_df
results_df <- results_df %>%
  mutate(subgroup = recode(subgroup, !!!subgroup_renames))

# Print the updated results_df
print(results_df)

# Write the final results to a CSV file
write.csv(results_df, "OneYearFollowUpResults.csv", row.names = FALSE)


####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################

library(survival)
library(survminer)
library(ggpubr)
library(gridExtra)

# merge the plots to create a 2x2 combined plots

plot_combined_survival <- function(fit, data, output_file, title_label) {
  times <- c(12 / 52, 1)
  survival_diffs <- numeric(length(times))
  ci_lowers <- numeric(length(times))
  ci_uppers <- numeric(length(times))
  
  for (i in 1:length(times)) {
    time_in_years <- times[i]
    summary_fit <- summary(fit, times = time_in_years)
    
    survival_risperidone_0 <- summary_fit$surv[1]
    survival_risperidone_1 <- summary_fit$surv[2]
    
    survival_diffs[i] <- survival_risperidone_0 - survival_risperidone_1
    std_err_0 <- summary_fit$std.err[1]
    std_err_1 <- summary_fit$std.err[2]
    
    diff_se <- sqrt(std_err_0^2 + std_err_1^2)
    ci_lowers[i] <- survival_diffs[i] - 1.96 * diff_se
    ci_uppers[i] <- survival_diffs[i] + 1.96 * diff_se
  }
  
  ard_text <- sprintf("Absolute Risk Difference:\n12 weeks: %.2f%% (%.2f%%, %.2f%%)\n1 year: %.2f%% (%.2f%%, %.2f%%)",
                      survival_diffs[1] * 100, ci_lowers[1] * 100, ci_uppers[1] * 100,
                      survival_diffs[2] * 100, ci_lowers[2] * 100, ci_uppers[2] * 100)
  
  ggsurv <- ggsurvplot(
    fit,
    data = data,
    fun = function(x) {100 - x * 100},
    censor = FALSE,
    size = 1.5,
    conf.int = TRUE,
    conf.int.alpha = 0.4,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",
    xlim = c(0, 1),
    ylim = c(0, 20),
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    fontsize = 5,
    font.x = c(16), font.y = c(16), font.tickslab = c(14),
    palette = c("#ED0000FF", "#00468BFF"),
    linetype = "strata",
    legend = "none",  # Remove the legend
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light(base_family = "Arial") +
      theme(axis.title.x = element_text(size = 16, face = "bold"),
            axis.title.y = element_text(size = 16, face = "bold")),
    tables.theme = theme_cleantable()
  )
  
  # Adjust the annotation positions to occupy the top half of the plot
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.01, y = 18, label = ard_text, size = 5, hjust = 0, fontface = "plain") +
    annotate("text", x = 0.5, y = 19, label = title_label, size = 6, hjust = 0, fontface = "bold")
  
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))
  
  # Save the plot with high DPI
  ggsave(output_file, plot = combined_plot, width = 16, height = 12, dpi = 600, device = "png")
  return(combined_plot)
}


# Generate and save plots for each subgroup
fit_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["CVD"]])
fit_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["with_stroke"]])
fit_no_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["No_CVD"]])
fit_no_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["no_stroke"]])

# Generate plots for each subgroup
plot1 <- plot_combined_survival(fit_no_stroke, subgroups[["no_stroke"]], "no_stroke_plot.jpg", "A: No stroke history")
plot2 <- plot_combined_survival(fit_stroke, subgroups[["with_stroke"]], "with_stroke_plot.jpg", "B: Stroke history")
plot3 <- plot_combined_survival(fit_no_CVD, subgroups[["No_CVD"]], "no_CVD_plot.jpg", "C: No CVD history")
plot4 <- plot_combined_survival(fit_CVD, subgroups[["CVD"]], "with_CVD_plot.jpg", "D: CVD history")

# Arrange the plots in a 2x2 grid
grid_plot <- grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

# Save the final 2x2 plot
ggsave("combined_survival_2x2.jpg", plot = grid_plot, width = 16, height = 12, dpi = 300)



fit_HES_stroke <- survfit(Surv(stroke.hes_censtime_yrs, stroke.hes_censvar) ~ risperidone, data = subgroups[["stroke_recency_1_year"]])

plot_HES <- plot_combined_survival(fit_HES_stroke, subgroups[["with_stroke"]], "HES_stroke_plot.jpg", "HES stroke: < 1 year")

ggsave("HES_lessThanYear.jpg", plot = plot_HES, width = 16, height = 12, dpi = 300)


# install.packages("cmprsk")
# library(cmprsk)

#
# # Define the competing risk variable across the entire dataset
dat <- dat %>%
  mutate(
    Stroke.cr = ifelse(Stroke_censvar == 0 & death_composite_date == Stroke_censdate, 2, Stroke_censvar),
    Stroke.cr = ifelse(is.na(Stroke.cr), 0, Stroke.cr)
  ) %>%
  mutate(Stroke.cr = as.numeric(Stroke.cr)) 

# Define each subgroup
all_data <- dat
no_stroke <- dat %>% filter(stroke_composite_pre_index_date == 0)
with_stroke <- dat %>% filter(stroke_composite_pre_index_date == 1)
CVD <- dat %>% filter(pre_index_date_cvd == 1)
No_CVD <- dat %>% filter(pre_index_date_cvd == 0)
#
# # Combine all subgroups into a list for easier processing
subgroups <- list(
  "all" = all_data,
  "no_stroke" = no_stroke,
  "with_stroke" = with_stroke,
  "No_CVD" = No_CVD,
  "CVD" = CVD
)

# # Define a function to fit the Fine-Gray model and extract HR and CI
get_hr_ci <- function(data) {
  # Check if there are any events in the subgroup
  if (sum(data$Stroke.cr == 1) > 0) {
    # Fit the Fine-Gray model
    fg_model <- crr(
      ftime = data$Stroke_censtime_yrs,  # Time to stroke or censoring
      fstatus = data$Stroke.cr,          # Competing risk indicator
      cov1 = data[, "risperidone"]       # Specify the covariate using cov1
    )

    # Calculate HR and confidence intervals
    hr <- exp(fg_model$coef)
    se <- sqrt(diag(fg_model$var))
    lower_ci <- exp(fg_model$coef - 1.96 * se)
    upper_ci <- exp(fg_model$coef + 1.96 * se)

    # Return as a list
    list(HR = hr, Lower_CI = lower_ci, Upper_CI = upper_ci)
  } else {
    # Return NA if there are no events in the subgroup
    list(HR = NA, Lower_CI = NA, Upper_CI = NA)
  }
}
#
# # Loop through each subgroup and store results in a data frame
results_CR <- lapply(subgroups, get_hr_ci)

results_df_CR <- do.call(rbind, lapply(names(results_CR), function(name) {
  data.frame(
    Subgroup = name,
    HR = round(results_CR[[name]]$HR,2),
    Lower_CI = round(results_CR[[name]]$Lower_CI,2),
    Upper_CI = round(results_CR[[name]]$Upper_CI,2)
  )
}))

print(results_df_CR)

write.csv(results_df_CR, "PaperDraftFinal_CompetingRisk.csv", row.names = FALSE)


########################  12 weeeks follow up #####################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################



########################################
#Setup all outcomes
dat <- FinalMatched %>%
  
  mutate(cens_at=pmin(as.Date(issuedate)+(84),
                      as.Date(death_composite_date), 
                      lcd, 
                      regenddate,
                      na.rm=TRUE),
         
         stroke.pc = as.Date(post_index_date_first_stroke),
         stroke.hes = as.Date(HES_post_index_date_first_stroke),
         Stroke = as.Date(stroke_compositeDate_post_first_stroke),
         death = as.Date(death_composite_date),
         cvd = as.Date(post_index_date_first_cvd),
         tia = as.Date(post_index_date_first_tia),
         heartfailure = as.Date(post_index_date_first_heartfailure),
         myocardialinfarction = as.Date(post_index_date_first_myocardialinfarction),
         angina = as.Date(post_index_date_first_angina),
         pad = as.Date(post_index_date_first_pad),
         falls = as.Date(post_index_date_first_falls),
         lowerlimbfracture = as.Date(post_index_date_first_lowerlimbfracture),
         VTE = as.Date(post_index_date_first_VTE)
  )



for (i in outcomes) {
  
  outcome_var <- paste0(i)
  censdate_var <- paste0(i, "_censdate")
  censvar_var <- paste0(i, "_censvar")
  censtime_var <- paste0(i, "_censtime_yrs")
  
  dat <- dat %>%
    mutate(
      !!sym(censdate_var) := pmin(as.Date(!!sym(outcome_var)), as.Date(cens_at), na.rm = TRUE),
      !!sym(censvar_var) := ifelse(!is.na(as.Date(!!sym(outcome_var))) & 
                                     !!sym(censdate_var) == !!sym(outcome_var) & 
                                     as.numeric(difftime(!!sym(outcome_var), issuedate, unit = "days")) / 7 <= 12, 1, 0),
      !!sym(censtime_var) := pmin(as.numeric(difftime(!!sym(censdate_var), issuedate, unit = "days")) / 7, 12)
    )
}

##################### subgroups########


# Define each subgroup separately to ensure independent processing
all_data <- dat
no_stroke <- dat %>% filter(stroke_composite_pre_index_date == 0)
with_stroke <- dat %>% filter(stroke_composite_pre_index_date == 1)
CVD <- dat %>% filter(pre_index_date_cvd == 1)
No_CVD <- dat %>% filter(pre_index_date_cvd == 0)

# # Combine all subgroups into a list
# subgroups <- list(
#   "all" = all_data,
#   "no_stroke" = no_stroke, 
#   "with_stroke" = with_stroke,
#   "No_CVD" = No_CVD,
#   "CVD" = CVD
#   
#   
# )
# Combine all subgroups into a list
subgroups <- list(
  "all" = all_data,
  "no_stroke" = no_stroke, 
  "with_stroke" = with_stroke,
  "CVD" = CVD,
  "No_CVD" = No_CVD,
  "HES_stroke" = HES_stroke,
  "PreCovidPeriod_all" = PreCovidPeriod_all,
  "PreCovidPeriod_no_stroke" = PreCovidPeriod_no_stroke,
  "PreCovidPeriod_with_stroke" = PreCovidPeriod_with_stroke,
  "PreCovidPeriod_no_cvd" = PreCovidPeriod_no_cvd,
  "PreCovidPeriod_with_cvd" = PreCovidPeriod_with_cvd,
  # "over_75" = over_75,
  # "under_75" = under_75,
  # "no_other_drugs" = no_other_drugs,
  # "diabetes" = diabetes,
  # "No_diabetes" = No_diabetes,
  # "With_VTE" = VTE,
  # "No_VTE" = No_VTE,
  # "BMI_Obese_overweight" = BMI_Obese_overweight,
  # "BMI_Normal_underweight" = BMI_Normal_underweight,
  # "atrialFibrillation" = atrialFibrillation,
  # "No_atrialFibrillation" = No_atrialFibrillation,
  "risperidone_Age_65_74" = risperidone_Age_65_74,
  "risperidone_Age_75_84" = risperidone_Age_75_84,
  "risperidone_Age_85+" = risperidone_Age_85_plus,
  # "hypertension_stage1AndHigher" = hypertension_stage1AndHigher,
  # "hypertension_stage2AndHigher" = hypertension_stage2AndHigher,
  # "carehome_preIndexDate" = carehome_preIndexDate,
  # "HES&ONS_stroke" = HES_ONS_stroke,
  "stroke_recency_1_year" = stroke_recency_1_year,
  "stroke_recency_1_5_years" = stroke_recency_1_5_years,
  "stroke_recency_over_5_years" = stroke_recency_over_5_years,
  "ischaemicstroke" = ischaemicstroke,
  "haemorrhagicstroke" = haemorrhagicstroke
)



# Apply match.bal to all subgroups
for (subgroup_name in names(subgroups)) {
  subgroups[[subgroup_name]] <- match.bal(subgroups[[subgroup_name]])
}



# Modify the function to return results in the desired format
fit_cox_model_12_weeks <- function(data, outcome, subgroup, model_type) {
  # Define formula based on model_type
  if (model_type == "unadjusted") {
    formula <- as.formula(paste0("Surv(", outcome, "_censtime_yrs, ", outcome, "_censvar) ~ risperidone"))
  } else {
    formula <- as.formula(paste0("Surv(", outcome, "_censtime_yrs, ", outcome, "_censvar) ~ risperidone + sex + age_risperidone + ethnicity + pre_index_date_stroke + pre_index_date_qof_diabetes + pre_index_date_haem_cancer + pre_index_date_ihd + pre_index_date_af + pre_index_date_myocardialinfarction + pre_index_date_heartfailure + pre_index_date_hypertension"))
  }
  
  # Fit Cox model
  model <- coxph(formula, data = data, x = TRUE, y = TRUE, robust = TRUE, weights = data$weights, cluster = data$subclass)
  
  # Extract coefficients and standard errors
  se <- as.numeric(summary(model)$coefficients[1, "robust se", drop = FALSE])
  ci.l <- model$coefficients[1] - (1.96 * se)
  ci.u <- model$coefficients[1] + (1.96 * se)
  
  # Calculate event count and person-time for each group (control and risperidone users)
  event_count_control <- sum(data[[paste0(outcome, "_censvar")]] == 1 & data$risperidone == 0)
  person_time_control <- data %>%
    filter(risperidone == 0) %>%
    summarise(person_time = sum(pmin(get(paste0(outcome, "_censtime_yrs")), 12 / 52), na.rm = TRUE)) %>%
    pull(person_time) 
  
  incidence_rate_control_per_1000_PY <- (event_count_control / person_time_control) * 1000
  
  event_count_risperidone <- sum(data[[paste0(outcome, "_censvar")]] == 1 & data$risperidone == 1)
  person_time_risperidone <- data %>%
    filter(risperidone == 1) %>%
    summarise(person_time = sum(pmin(get(paste0(outcome, "_censtime_yrs")), 12 / 52), na.rm = TRUE)) %>%
    pull(person_time) 
  
  incidence_rate_risperidone_per_1000_PY <- (event_count_risperidone / person_time_risperidone) * 1000
  
  # Compute standard errors for the incidence rates using standard error propagation
  se_incidence_rate_control <- sqrt(event_count_control) / person_time_control * 1000
  se_incidence_rate_risperidone <- sqrt(event_count_risperidone) / person_time_risperidone * 1000
  
  # Calculate the 95% confidence intervals for the incidence rates
  ci.l_incidence_rate_control <- incidence_rate_control_per_1000_PY - (1.96 * se_incidence_rate_control)
  ci.u_incidence_rate_control <- incidence_rate_control_per_1000_PY + (1.96 * se_incidence_rate_control)
  
  ci.l_incidence_rate_risperidone <- incidence_rate_risperidone_per_1000_PY - (1.96 * se_incidence_rate_risperidone)
  ci.u_incidence_rate_risperidone <- incidence_rate_risperidone_per_1000_PY + (1.96 * se_incidence_rate_risperidone)
  
  # Fit survival model
  sfit <- survfit(Surv(data[[paste0(outcome, "_censtime_yrs")]], data[[paste0(outcome, "_censvar")]]) ~ risperidone, data = data)
  
  
  time_point <- 12/52
  summary_sfit <- summary(sfit, times = time_point)
  risperidone_group <- summary_sfit$surv[which(summary_sfit$strata == "risperidone=1")]
  control_group <- summary_sfit$surv[which(summary_sfit$strata == "risperidone=0")]
  absoluteRiskDifference <- control_group - risperidone_group
  
  
  # Calculate event rates (cumulative incidence) at the specified time point
  risperidone_event_rate <- 1 - risperidone_group
  control_event_rate <- 1 - control_group
  
  # Sample sizes
  n_treatment <- sum(data$risperidone == 1)
  n_control <- sum(data$risperidone == 0)
  
  # Calculate NNT (Number Needed to Treat)
  ARR <- abs(control_group - risperidone_group)
  
  
  # Calculate NNT (Number Needed to Treat)
  NNH <- 1 / ARR
  
  # Calculate standard error of ARR
  SE_ARR <- sqrt((control_event_rate * (1 - control_event_rate) / n_control) + (risperidone_event_rate * (1 - risperidone_event_rate) / n_treatment))
  
  # Calculate the 95% confidence interval for ARR
  ARR_CI_lower <- ARR - (1.96 * SE_ARR)
  ARR_CI_upper <- ARR + (1.96 * SE_ARR)
  
  # Ensure ARR_CI_lower and ARR_CI_upper are within valid range
  ARR_CI_lower <- max(ARR_CI_lower, 0)  # ARR cannot be negative
  ARR_CI_upper <- min(ARR_CI_upper, 1)  # ARR cannot be more than 1
  
  # Calculate the confidence interval for NNH
  NNH_CI_lower <- ifelse(ARR_CI_upper > 0, 1 / ARR_CI_upper, Inf)
  NNH_CI_upper <- ifelse(ARR_CI_lower > 0, 1 / ARR_CI_lower, Inf)
  
  res <- data.frame(
    subgroup = subgroup,
    # outcome = outcome,
    Group = c("Matched Controls", "Risperidone Users"),
    N_total = c(nrow(data[data$risperidone == 0, ]), nrow(data[data$risperidone == 1, ])),
    N_events = c(event_count_control, event_count_risperidone),
    Person_years_at_risk = c(round(person_time_control, 0), round(person_time_risperidone, 0)),
    Incidence_rate_per_1000_PY = c(
      paste0(round(incidence_rate_control_per_1000_PY, 1), 
             " (", round(ci.l_incidence_rate_control, 1), ", ", round(ci.u_incidence_rate_control, 1), ")"),
      paste0(round(incidence_rate_risperidone_per_1000_PY, 1), 
             " (", round(ci.l_incidence_rate_risperidone, 1), ", ", round(ci.u_incidence_rate_risperidone, 1), ")")
    ),
    Adjusted_HR_with_CI = paste0(
      round(exp(model$coefficients[1]), 2), 
      " (", round(exp(ci.l), 2), ", ", round(exp(ci.u), 2), ")"
    ),
    NNH = round(NNH, 2),
    NNH_CI_lower = round(NNH_CI_lower, 2),  # Lower CI for NNH
    NNH_CI_upper = round(NNH_CI_upper, 2),  # Upper CI for NNH
    ARR = round(ARR, 4)  # Absolute Risk Reduction
  )
  
  return(res)
}


# Initialize an empty list to store results
results_12Weeks <- list()

# Loop over each subgroup
for (subgroup_name in names(subgroups)) {
  data <- subgroups[[subgroup_name]]
  
  # Fit both unadjusted and adjusted models for each outcome
  for (outcome in outcomes) {
    # Fit unadjusted model
    # res_unadjusted <- fit_cox_model_12_weeks(data, outcome, subgroup_name, "unadjusted")
    # results_12Weeks[[paste0(outcome, "_unadjusted_", subgroup_name)]] <- res_unadjusted
    
    # Fit adjusted model
    res_adjusted <- fit_cox_model_12_weeks(data, outcome, subgroup_name, "adjusted")
    results_12Weeks[[paste0(outcome, "_adjusted_", subgroup_name)]] <- res_adjusted
  }
}

# Combine results into a single dataframe
results_df_12Weeks <- do.call(rbind, results_12Weeks)

# Print combined results dataframe
# Set the option to print all rows
options(max.print = nrow(results_df_12Weeks) * ncol(results_df_12Weeks))
print(results_df_12Weeks)


# # Define a list of new subgroup names
subgroup_renames <- c(
  "all" = "Overall",
  "no_stroke" = "No stroke history",
  "with_stroke" = "Stroke history",
  "CVD" = "CVD history",
  "No_CVD" = "No CVD history",
  "HES_stroke" = "HES Stroke",
  "PreCovidPeriod_all" = "Pre-COVID overall",
  "PreCovidPeriod_no_stroke" = "Pre-COVID No stroke history",
  "PreCovidPeriod_with_stroke" = "Pre-COVID Stroke history",
  "PreCovidPeriod_no_cvd" = "Pre-COVID No CVD history",
  "PreCovidPeriod_with_cvd" = "Pre-COVID CVD history",
  "ischaemicstroke" = "Stroke type Ischaemic",
  "haemorrhagicstroke" = "Stroke type Haemorrhagic",
  "risperidone_Age_65_74" = "Prescription age 65-74",
  "risperidone_Age_75_84" = "Prescription age 75-84",
  "risperidone_Age_85+" = "Prescription age 85 years and above",
  "stroke_recency_1_year" = "Stroke recency less than 1 year",
  "stroke_recency_1_5_years" = "Stroke recency 1-5 years",
  "stroke_recency_over_5_years" = "Stroke recency Over 5 years"
)

# Apply renames to the subgroup column in results_df
results_df_12Weeks <- results_df_12Weeks %>%
  mutate(subgroup = recode(subgroup, !!!subgroup_renames))

# Print the updated results_df
print(results_df_12Weeks)


write.csv(results_df_12Weeks, "12WeeksFollowUpResults.csv", row.names = FALSE)




