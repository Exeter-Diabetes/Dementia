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
library(tidyr) 


# Initialize CPRDData
cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")

risperidone_prescriptions <- analysis$cached(name = "risperidone_prescriptions") %>%
  filter(issuedate >= "2004-01-01") %>%
  collect()

# Sort data by PatientID and PrescriptionDate
risperidone_prescriptions <- risperidone_prescriptions %>%
  arrange(patid, issuedate)

# Calculate earliest prescription 
earliest_prescriptions <- risperidone_prescriptions %>%
  group_by(patid) %>%
  summarise(
    FirstPrescriptionDate = min(issuedate),
  ) %>%
  ungroup()  


# Merge earliest prescription data with the original risperidone prescriptions
risperidone_with_gaps <- risperidone_prescriptions %>%
  left_join(earliest_prescriptions, by = "patid") %>%
  arrange(patid, issuedate)



# Calculate gaps and inferred stop date
risperidone_with_gaps <- risperidone_with_gaps %>%
  group_by(patid) %>%
  mutate(
    PrevPrescriptionDate = lag(issuedate),
    GapDays = as.numeric(difftime(issuedate, PrevPrescriptionDate, units = "days")),
    InferredStopDate = if_else(GapDays > 90, as.Date(PrevPrescriptionDate) + 30, as.Date(NA))
  ) %>%
  ungroup()



# Keep one row per patient with the calculated FinalCensorDate_prescription
final_risperidone_prescriptions <- risperidone_with_gaps %>%
  group_by(patid) %>%
  summarise(
    FirstPrescriptionDate = first(FirstPrescriptionDate),
    FinalCensorDate_prescription = first(na.omit(InferredStopDate))
  ) %>%
  mutate(patid = as.character(patid))

risperidone_prescriptions <- analysis$cached(name = "risperidone_prescriptions")

matched <- read.table("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final_paperDraft/Joshua_cumulative_matched_data_paperDraft.txt", header = TRUE, sep = "\t") %>%
  mutate(patid = as.character(patid))
# dat <- read.table("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final/Joshua_cumulative_matched_data.txt", header = TRUE, sep = "\t") %>%
#   mutate(patid = as.character(patid))
# 
# dat <- dat %>%
#   left_join(final_risperidone_prescriptions, by = "patid") %>%
#   mutate(
#     FinalCensorDate_prescription = ifelse(risperidone == 1, FinalCensorDate_prescription, NA)
#   ) %>%
#   select(-FirstPrescriptionDate)

# matched <- analysis$cached(name = "finalMatchedData")  %>%
#   collect() #%>%
# mutate(patid = as.character(patid))

dat <-  matched %>%  # Convert patid to character
  left_join(final_risperidone_prescriptions, by = "patid") %>%
  mutate(
    FinalCensorDate_prescription = ifelse(risperidone == 1, FinalCensorDate_prescription, NA)
  ) %>%
  select(-FirstPrescriptionDate)
# str(dat)

table(dat$risperidone)

#Stroke
output_dir <- "C:/Users/njc232/OneDrive - University of Exeter/Documents/GitHub/Dementia/NewDataDownload/images/AnalysisPlots/"  
dir.create(output_dir, showWarnings = FALSE)
#########################################

# Categorize stroke recency to less than a year, 1 - 5 years and over 5 years
dat <- dat %>%
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

dat <- dat %>%
  mutate(recency_cat = as.factor(recency_cat))

##### record missing hypertension and total cholesterol records as unknown

dat <- dat %>%
  mutate(
    pre_index_totalcholesterol = ifelse(date_totalcholesterol < issuedate, totalcholesterol, "Unknown"),
    pre_index_hypertension = ifelse(is.na(obsdate_hypertension) | (obsdate_hypertension < issuedate), comorbidity_hypertension, "Unknown")
  )
#########################################
#Setup all outcomes
dat <- dat %>%
  
  mutate(cens_at=pmin(as.Date(issuedate)+(365.25),
                      as.Date(death_composite_date), 
                      lcd, 
                      regenddate,
                      FinalCensorDate_prescription,
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

# str(dat)

# outcomes <- c("stroke.pc","stroke.hes","Stroke")#,"death", "cvd", "tia", "heartfailure", "myocardialinfarction", "angina", "pad", "falls", "lowerlimbfracture")

outcomes <- c("Stroke")#, "VTE", "stroke.hes")#


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
over_75 <- dat %>% filter(age_risperidone >= 75)
under_75 <- dat %>% filter(age_risperidone < 75)
no_other_drugs <- dat %>% filter(is.na(other_drug_issuedate))
CVD <- dat %>% filter(pre_index_date_cvd == 1)
No_CVD <- dat %>% filter(pre_index_date_cvd == 0)
diabetes <- dat %>% filter(pre_index_date_qof_diabetes == 1)
No_diabetes <- dat %>% filter(pre_index_date_qof_diabetes == 0)
VTE <- dat %>% filter(pre_index_date_VTE == 1)
No_VTE <- dat %>% filter(pre_index_date_VTE == 0)
BMI_Obese_overweight <- dat %>% filter(BMI == "Obesity" | BMI == "Overweight" | BMI == "Severely Obese")
BMI_Normal_underweight <- dat %>% filter(BMI == "Normal" | BMI == "Underweight")
atrialFibrillation <- dat %>% filter(pre_index_date_af == 1)
No_atrialFibrillation <- dat %>% filter(pre_index_date_af == 0)
risperidone_Age_65_74 <- dat %>% filter(age_risperidone_cat == "65 - 74")
risperidone_Age_75_84 <- dat %>% filter(age_risperidone_cat == "75 - 84")
risperidone_Age_85_plus <- dat %>% filter(age_risperidone_cat == "85+")
hypertension_stage1AndHigher <- dat %>% filter(pre_index_hypertension == "Stage 1" | pre_index_hypertension == "Stage 2" | pre_index_hypertension == "Stage 3")
hypertension_stage2AndHigher <- dat %>% filter(pre_index_hypertension == "Stage 2" | pre_index_hypertension == "Stage 3")
carehome_preIndexDate <- dat %>% filter(care_home_before_indexdate == 1)
HES_ONS_stroke <- dat %>%
  mutate(
    Stroke = pmin(HES_post_index_date_first_stroke, ONS_stroke_post_date, na.rm=TRUE),
    stroke_compositeDate_post_first_stroke = pmin(HES_post_index_date_first_stroke, ONS_stroke_post_date, na.rm=TRUE)
  )
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
  
  number_of_patients <- nrow(data)
  
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
  
  ARR <- abs(control_group - risperidone_group)
  
  # Calculate NNT (Number Needed to Treat)
  NNT <- 1 / ARR
  
  # Calculate standard error of ARR
  SE_ARR <- sqrt((control_event_rate * (1 - control_event_rate) / n_control) + (risperidone_event_rate * (1 - risperidone_event_rate) / n_treatment))
  
  # Calculate the 95% confidence interval for ARR
  Z <- 1.96
  ARR_CI_lower <- ARR - (Z * SE_ARR)
  ARR_CI_upper <- ARR + (Z * SE_ARR)
  
  # Ensure ARR_CI_lower and ARR_CI_upper are within valid range
  ARR_CI_lower <- max(ARR_CI_lower, 0)  # ARR cannot be negative
  ARR_CI_upper <- min(ARR_CI_upper, 1)  # ARR cannot be more than 1
  
  # Calculate the confidence interval for NNT
  NNT_CI_lower <- ifelse(ARR_CI_upper > 0, 1 / ARR_CI_upper, Inf)
  NNT_CI_upper <- ifelse(ARR_CI_lower > 0, 1 / ARR_CI_lower, Inf)
  
  # Create result dataframe
  res <- data.frame(
    outcome = outcome,
    subgroup = subgroup,
    model = model_type,
    hr = format(round(exp(model$coefficients[1]), 2), nsmall = 2),
    ci.l = format(round(exp(ci.l), 2), nsmall = 2),
    ci.u = format(round(exp(ci.u), 2), nsmall = 2),
    event_count_control = event_count_control,
    person_time_control = round(person_time_control, 2),
    incidence_rate_control_per_1000_PY = round(incidence_rate_control_per_1000_PY, 2),
    event_count_risperidone = event_count_risperidone,
    person_time_risperidone = round(person_time_risperidone, 2),
    incidence_rate_risperidone_per_1000_PY = round(incidence_rate_risperidone_per_1000_PY, 2),
    number_of_patients = number_of_patients,
    NNH = round(NNT, 2),
    ci.l_NNH = round(NNT_CI_lower, 2),
    ci.u_NNH = round(NNT_CI_upper, 2),
    ARR = round(ARR, 4)
  )
  
  return(list(sfit = sfit, res.hr = res))
}




# Initialize an empty list to store results
results <- list()

# Loop over each subgroup
for (subgroup_name in names(subgroups)) {
  data <- subgroups[[subgroup_name]]
  
  # Fit both unadjusted and adjusted models for each outcome
  for (outcome in outcomes) {
    # Fit unadjusted model
    res_unadjusted <- fit_cox_model(data, outcome, subgroup_name, "unadjusted")
    # 
    # 
    # unadjusted_file_name <- paste0(outcome, "_unadjusted_", subgroup_name, ".png")
    # plot.surv(res_unadjusted$sfit, outcome, subgroup_name, "unadjusted", data, unadjusted_file_name)
    
    
    # Store unadjusted results
    results[[paste0(outcome, "_unadjusted_", subgroup_name)]] <- res_unadjusted$res.hr
    
    # Plot and save survival plot for unadjusted model
    # plot.surv(res_unadjusted$sfit, outcome, subgroup_name, "unadjusted", data, paste0(outcome, "_unadjusted_", subgroup_name, ".pdf"))
    
    # Fit adjusted model
    res_adjusted <- fit_cox_model(data, outcome, subgroup_name, "adjusted")
    
    # Store adjusted results
    results[[paste0(outcome, "_adjusted_", subgroup_name)]] <- res_adjusted$res.hr
    
    # Plot and save survival plot for adjusted model
    # plot.surv(res_adjusted$sfit, outcome, subgroup_name, "adjusted", data, paste0(outcome, "_adjusted_", subgroup_name, ".pdf"))
    # adjusted_file_name <- paste0(outcome, "_adjusted_", subgroup_name, ".png")
    # plot.surv(res_adjusted$sfit, outcome, subgroup_name, "adjusted", data, adjusted_file_name)
  }
}

# Combine results into a single dataframe
results_df <- do.call(rbind, results)

# Print combined results dataframe
# Set the option to print all rows
options(max.print = nrow(results_df) * ncol(results_df))
print(results_df)


transformed_df_one_year_discontinuation <- results_df %>%
  mutate(
    Adjusted_HR = ifelse(model == "adjusted", paste0(hr, " (", ci.l, ", ", ci.u, ")"), NA),
    Unadjusted_HR = ifelse(model == "unadjusted", paste0(hr, " (", ci.l, ", ", ci.u, ")"), NA)
  ) %>%
  filter(!is.na(Adjusted_HR) | !is.na(Unadjusted_HR)) %>%
  pivot_longer(
    cols = starts_with("event_count"),
    names_to = "Group",
    values_to = "N.events"
  ) %>%
  mutate(Group = ifelse(str_detect(Group, "risperidone"), "Risperidone Users", "Matched Controls")) %>%
  pivot_longer(
    cols = starts_with("person_time"),
    names_to = "PersonTime_Group",
    values_to = "Person.years.at.risk"
  ) %>%
  filter(Group == "Risperidone Users" & str_detect(PersonTime_Group, "risperidone") |
           Group == "Matched Controls" & str_detect(PersonTime_Group, "control")) %>%
  select(-PersonTime_Group) %>%
  pivot_longer(
    cols = starts_with("incidence_rate"),
    names_to = "IncidenceRate_Group",
    values_to = "Incidence_rate_per_1000_PY"
  ) %>%
  filter(Group == "Risperidone Users" & str_detect(IncidenceRate_Group, "risperidone") |
           Group == "Matched Controls" & str_detect(IncidenceRate_Group, "control")) %>%
  select(-IncidenceRate_Group) %>%
  group_by(outcome, subgroup, Group) %>%
  summarise(
    N.events = first(N.events),
    Person.years.at.risk = first(Person.years.at.risk),
    Incidence_rate_per_1000_PY = first(Incidence_rate_per_1000_PY),
    Adjusted_HR = first(na.omit(Adjusted_HR)),
    NNH = first(NNH),
    Lower_CI_NNH = first(ci.l_NNH),
    Upper_CI_NNH = first(ci.u_NNH),
    ARR = first(ARR),
    .groups = 'drop'
  ) %>%
  arrange(subgroup, Group)

# Apply subgroup renaming
subgroup_labels <- c(
  "CVD" = "CVD history",
  "No_CVD" = "No CVD history",
  "no_stroke" = "No stroke history",
  "with_stroke" = "Stroke history",
  "all_data" = "Overall",
  "HES_stroke" = "HES stroke",
  "PreCovidPeriod_all" = "Pre-Covid period (Overall)",
  "PreCovidPeriod_no_cvd" = "Pre-Covid period (No CVD history)",
  "PreCovidPeriod_with_cvd" = "Pre-Covid period (CVD history)",
  "PreCovidPeriod_no_stroke" = "Pre-Covid period (No stroke history)",
  "PreCovidPeriod_with_stroke" = "Pre-Covid period (Stroke history)",
  "haemorrhagicstroke" = "Stroke type - haemorrhagic",
  "ischaemicstroke" = "Stroke type - ischaemic",
  "risperidone_Age_65_74" = "Prescription age 65 - 74 years",
  "risperidone_Age_75_84" = "Prescription age 75 - 84 years",
  "risperidone_Age_85_plus" = "Prescription age 85 years and above",
  "stroke_recency_1_5_years" = "Stroke recency 1 - 5 years",
  "stroke_recency_1_year" = "Stroke recency less than 1 year",
  "stroke_recency_over_5_years" = "Stroke recency over 5 years"
)

# Rename the subgroups
transformed_df_one_year_discontinuation <- transformed_df_one_year_discontinuation %>%
  mutate(subgroup = recode(subgroup, !!!subgroup_labels))

# Save the final transformed results to CSV with renamed subgroups
write.csv(transformed_df_one_year_discontinuation, "FinalResults_Renamed_Discontinuation.csv", row.names = FALSE)
# View the final renamed dataframe
View(transformed_df_one_year_discontinuation)
print(transformed_df_one_year_discontinuation, n = Inf)

View(transformed_df_one_year_discontinuation)
options(max.print = nrow(transformed_df_one_year_discontinuation) * ncol(transformed_df_one_year_discontinuation))

print(transformed_df_one_year_discontinuation, n = Inf)

library(tidycmprsk)
library(tidyverse)
library(rms)
library(survminer)
library(ggsurvfit)

#Add death as a competing risk
dat <- dat  %>% 
  mutate(
    Stroke.cr=ifelse(Stroke_censvar== 0 & death_composite_date == Stroke_censdate, 2, Stroke_censvar)  )

dat <- dat %>%
  mutate(
    Stroke.cr=ifelse(is.na(Stroke.cr),0,Stroke.cr)  )
table(dat$Stroke.cr)
describe(dat$Stroke.cr)



dat <- dat %>%
  mutate(
    Stroke.cr=as.factor(Stroke.cr)
  )
table(dat$Stroke.cr)

#Over cumulative incidence adj. for competing risk of death
cr.res <- 
  cuminc(Surv(Stroke_censtime_yrs, Stroke.cr) ~ risperidone, data = dat) %>% 
  ggcuminc() + 
  labs(
    x = "Years",
    title = "Cumulative Incidence of Stroke Adjusted for Competing Risk of Death: Discontinuation"
  ) + 
  add_confidence_interval() +
  add_risktable() +
  theme(
    legend.title = element_blank(),
    legend.position = "bottom"
  )

print(cr.res)




install.packages("cmprsk")
library(cmprsk)

# Fit the Fine-Gray model using cov1 for the covariate
fg_stroke <- crr(
  ftime = dat$Stroke_censtime_yrs,  # Time to stroke or censoring
  fstatus = dat$Stroke.cr,           # Competing risk indicator: 1 for stroke, 2 for death, 0 for censored
  cov1 = dat[, c("risperidone")]     # Specify the covariate using cov1
)

# Display the results
fg_stroke

# Extract the hazard ratio and confidence interval
risperidone_hr <- exp(fg_stroke$coef)
se_risperidone <- sqrt(diag(fg_stroke$var))
# Calculate 95% confidence intervals
lower_ci <- exp(fg_stroke$coef - 1.96 * se_risperidone)
upper_ci <- exp(fg_stroke$coef + 1.96 * se_risperidone)

# Display results
cat("Hazard Ratio (HR) for Risperidone:", risperidone_hr, "\n")
cat("95% Confidence Interval for HR:", lower_ci, "-", upper_ci, "\n")
