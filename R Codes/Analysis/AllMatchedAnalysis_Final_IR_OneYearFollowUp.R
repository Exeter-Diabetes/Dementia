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

# Initialize CPRDData
cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")

# Retrieve risperidone prescriptions data
risperidone_prescriptions <- analysis$cached(name = "risperidone_prescriptions") %>%
  filter(issuedate >= "2004-01-01") %>% 
  collect()

# Sort data by PatientID and PrescriptionDate
risperidone_prescriptions <- risperidone_prescriptions %>%
  arrange(patid, issuedate)

# Calculate earliest prescription and end of study date
earliest_prescriptions <- risperidone_prescriptions %>%
  group_by(patid) %>%
  summarise(
    FirstPrescriptionDate = min(issuedate),
    # endOfStudy = min(FirstPrescriptionDate) + years(1)
  ) %>%
  ungroup()  # Ensure we ungroup after summarization

# view(earliest_prescriptions)

# # Merge with the original risperidone prescriptions to calculate gaps
# risperidone_with_gaps <- risperidone_prescriptions %>%
#   left_join(earliest_prescriptions, by = "patid") %>%
#   # arrange(patid, issuedate) %>%
#   group_by(patid) %>%
#   mutate(
#     PrevPrescriptionDate = lag(issuedate),
#     GapDays = as.numeric(difftime(issuedate, PrevPrescriptionDate, units = "days")),
#     InferredStopDate = ifelse(GapDays > 90, as.Date(PrevPrescriptionDate) + 30, NA)
#   )



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




# # Calculate the FollowUpEndDate and FinalCensorDate
# risperidone_with_gaps <- risperidone_with_gaps %>%
#   mutate(
#     FollowUpEndDate_prescription = ifelse(!is.na(InferredStopDate), InferredStopDate, endOfStudy),
#     FollowUpEndDate_prescription = as.Date(FollowUpEndDate_prescription),
#     FinalCensorDate_prescription = pmin(FollowUpEndDate_prescription, endOfStudy, na.rm = TRUE)
#   )
# view(risperidone_with_gaps)

# Keep one row per patient with the calculated FinalCensorDate_prescription
final_risperidone_prescriptions <- risperidone_with_gaps %>%
  group_by(patid) %>%
  summarise(
    FirstPrescriptionDate = first(FirstPrescriptionDate),
    FinalCensorDate_prescription = first(na.omit(InferredStopDate))
  ) %>%
  mutate(patid = as.character(patid))

# View the final dataset to verify
# view(final_risperidone_prescriptions)

# View the final dataset


dat <- read.table("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final/Joshua_cumulative_matched_data.txt", header = TRUE, sep = "\t") %>%
  mutate(patid = as.character(patid))
table(dat$risperidone)

dat <- dat %>%
  left_join(final_risperidone_prescriptions, by = "patid") %>%
  mutate(
    FinalCensorDate_prescription = ifelse(risperidone == 1, FinalCensorDate_prescription, NA)
  ) %>%
  select(-FirstPrescriptionDate)

table(dat$risperidone)

#Stroke
output_dir <- "C:/Users/njc232/OneDrive - University of Exeter/Documents/GitHub/Dementia/NewDataDownload/images/AnalysisPlots/"  # Change this to your desired path
dir.create(output_dir, showWarnings = FALSE)
#########################################
#Data check

#Composite
table(dat$stroke_composite_post_index_date)
describe(dat$stroke_compositeDate_post_first_stroke)

#Primary care
table(dat$post_index_date_stroke)
describe(dat$post_index_date_first_stroke)

#HES
table(dat$HES_post_index_date_stroke)
describe(dat$HES_post_index_date_first_stroke)
# dat$subclass <- as.factor(dat$subclass)
table(dat$ONS_stroke_post)



#Recreate composite
dat <- dat %>%
  mutate(
    Stroke = stroke_compositeDate_post_first_stroke,
    recency = as.numeric(as.Date(issuedate) - as.Date(stroke_compositeDate_pre_latest_stroke)) / 365.25,
    recency_cat = case_when(
      recency < 1 ~ 0,
      recency >= 1 & recency <= 5 ~ 1,
      recency > 5 ~ 2,
      TRUE ~ NA_real_    # Handle NA cases explicitly
    )
  )

dat <- dat %>%
  mutate(recency_cat = as.factor(recency_cat))
# view(dat %>% select(Stroke, HES_post_index_date_first_stroke, post_index_date_first_stroke,ONS_stroke_post_date, stroke_compositeDate_post_first_stroke,stroke_compositeDate_pre_latest_stroke, recency, recency_cat))

dat$Stroke <- as.Date(dat$Stroke)                     
describe(dat$Stroke)
describe(dat$stroke_compositeDate_post_first_stroke)

# adding the CVDs
dat <- dat %>%
  mutate(
    post_index_date_VTE = ifelse((post_index_date_pulmonary_embolism ==1) |(post_index_date_deep_vein_thrombosis ==1), 1, 0),
    post_index_date_first_VTE = pmin(post_index_date_first_pulmonary_embolism,post_index_date_first_deep_vein_thrombosis,na.rm=TRUE),
    post_index_date_cvd = ifelse((post_index_date_heartfailure==1) | 
                                   (post_index_date_myocardialinfarction==1) | 
                                   (post_index_date_angina==1) |
                                   (post_index_date_tia==1) |
                                   (post_index_date_ihd==1) |
                                   (post_index_date_pad==1) |
                                   (post_index_date_stroke==1), 1, 0),
    
    
    
    
    post_index_date_first_cvd = pmin(post_index_date_first_heartfailure,
                                     post_index_date_first_myocardialinfarction,
                                     post_index_date_first_angina,
                                     post_index_date_first_tia,
                                     post_index_date_first_ihd,
                                     post_index_date_first_pad,
                                     post_index_date_first_stroke,na.rm=TRUE),
    
    
    
    
    
  )

dat$post_index_date_first_cvd <- as.Date(dat$post_index_date_first_cvd)                     


#1 year outcomes
dat <- dat %>% mutate(
  # stroke.pc.days=as.numeric(post_index_date_first_stroke) - as.numeric(issuedate),
  stroke.hes.days=as.numeric(HES_post_index_date_first_stroke) - as.numeric(issuedate),
  # Stroke.days=as.numeric(stroke_compositeDate_post_first_stroke) - as.numeric(issuedate)
  stroke.pc.days=as.numeric(as.Date(post_index_date_first_stroke) - as.Date(issuedate)),
  stroke.hes.days=as.numeric(as.Date(HES_post_index_date_first_stroke) - as.Date(issuedate)),
  Stroke.days=as.numeric(as.Date(stroke_compositeDate_post_first_stroke) - as.Date(issuedate)),
  VTE.days=as.numeric(as.Date(post_index_date_first_VTE) - as.Date(issuedate)),
  
  
  
  
  cvd.days=as.numeric(as.Date(post_index_date_first_cvd) - as.Date(issuedate)),
  
  tia.days=as.numeric(as.Date(post_index_date_first_tia) - as.Date(issuedate)),
  heartfailure.days=as.numeric(as.Date(post_index_date_first_heartfailure) - as.Date(issuedate)),
  myocardialinfarction.days=as.numeric(as.Date(post_index_date_first_myocardialinfarction) - as.Date(issuedate)),
  angina.days=as.numeric(as.Date(post_index_date_first_angina) - as.Date(issuedate)),
  pad.days=as.numeric(as.Date(post_index_date_first_pad) - as.Date(issuedate)),
  falls.days=as.numeric(as.Date(post_index_date_first_falls) - as.Date(issuedate)),
  lowerlimbfracture.days=as.numeric(as.Date(post_index_date_first_lowerlimbfracture) - as.Date(issuedate)),
  
  
)

describe(dat$stroke.pc.days)
describe(dat$stroke.hes.days)
describe(dat$Stroke.days)
describe(dat$cvd.days)

dat <- dat %>% mutate(
  stroke.pc.1 = ifelse(stroke.pc.days<=365,1,NA),
  stroke.hes.1 = ifelse(stroke.hes.days<=365,1,NA),
  Stroke.1 = ifelse(Stroke.days<=365,1,NA),
  cvd.1 = ifelse(cvd.days <=365,1,NA),
  tia.1 = ifelse(tia.days <=365,1,NA),
  heartfailure.1 = ifelse(heartfailure.days <=365,1,NA),
  myocardialinfarction.1 = ifelse(myocardialinfarction.days <=365,1,NA),
  angina.1 = ifelse(angina.days <=365,1,NA),
  pad.1 = ifelse(pad.days <=365,1,NA),
  falls.1 = ifelse(falls.days <=365,1,NA),
  lowerlimbfracture.1 = ifelse(lowerlimbfracture.days <=365,1,NA),
  VTE.1 = ifelse(VTE.days <=365,1,NA),
  
)
describe(dat$stroke.pc.1)
describe(dat$stroke.hes.1)
describe(dat$Stroke.1)
describe(dat$cvd.1)

dat <- dat %>% mutate(
  stroke.fu.pc.1 = ifelse(stroke.pc.days>365,365,stroke.pc.days),
  stroke.fu.hes.1 = ifelse(stroke.hes.days>365,365,stroke.hes.days),
  stroke.fu.c.1 = ifelse(Stroke.days>365,365,Stroke.days),
  cvd.fu.1 = ifelse(cvd.days>365,365,cvd.days),
  tia.fu.1 = ifelse(tia.days>365,365,tia.days),
  heartfailure.fu.1 = ifelse(heartfailure.days>365,365,heartfailure.days),
  myocardialinfarction.fu.1 = ifelse(myocardialinfarction.days>365,365,myocardialinfarction.days),
  angina.fu.1 = ifelse(angina.days>365,365,angina.days),
  pad.fu.1 = ifelse(pad.days>365,365,pad.days),
  falls.fu.1 = ifelse(falls.days>365,365,falls.days),
  lowerlimbfracture.fu.1 = ifelse(lowerlimbfracture.days>365,365,lowerlimbfracture.days),
  VTE.fu.1 = ifelse(VTE.days>365,365,VTE.days),
  
)
describe(dat$stroke.fu.pc.1)
describe(dat$stroke.fu.hes.1)
describe(dat$stroke.fu.c.1)
describe(dat$cvd.fu.1)


# dat <- dat %>% sample_n(1000)
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


# outcomes <- c("stroke.pc","stroke.hes","Stroke")#,"death", "cvd", "tia", "heartfailure", "myocardialinfarction", "angina", "pad", "falls", "lowerlimbfracture")

outcomes <- c("Stroke", "VTE", "stroke.hes")#


for (i in outcomes) {
  
  outcome_var=paste0(i)
  censdate_var=paste0(i, "_censdate")
  censvar_var=paste0(i, "_censvar")
  censtime_var=paste0(i, "_censtime_yrs")
  # persontime_var <- paste0(i, "_person_time_yrs")
  dat <- dat %>%
    mutate({{censdate_var}}:=pmin(as.Date(!!sym(outcome_var)), as.Date(cens_at), na.rm=TRUE),
           {{censvar_var}}:=ifelse(!is.na(as.Date(!!sym(outcome_var))) & !!sym(censdate_var)==!!sym(outcome_var), 1, 0),
           {{censtime_var}}:=as.numeric(difftime(!!sym(censdate_var), issuedate, unit="days"))/365.25,
           # {{persontime_var}} := as.numeric(difftime(!!sym(censdate_var), issuedate, units = "days")) / 365.25
    )
}



#Analysis
dat <- dat %>% mutate(indexyr = year(issuedate))
describe(dat$indexyr)
#Baseline chars
Vars <- c("sex","age_risperidone","ethnicity","indexyr") 
FactorVars <- c("sex","ethnicity","indexyr")
Table <- CreateTableOne(vars=Vars,factorVars = FactorVars, strata="risperidone", data=dat)
tabPrint <-print(Table, catDigits=1, contDigits=1,nonnormal = F,noSpaces = TRUE, smd=T, test=F, varLabels=F)


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


##################### subgroups########

library(dplyr)
library(survival)
library(survminer)
library(ggplot2)

# Your initial data processing steps remain the same
dat <- dat %>%
  mutate(
    pre_index_totalcholesterol = ifelse(date_totalcholesterol < issuedate, totalcholesterol, "Unknown"),
    pre_index_hypertension = ifelse(obsdate_hypertension < issuedate, comorbidity_hypertension, "Unknown")
  )

# Define each subgroup separately to ensure independent processing
all_data <- dat

no_stroke <- dat %>% filter(stroke_composite_pre_index_date == 0)
write.table(no_stroke, file = "no_stroke_data.txt", sep = "\t", row.names = FALSE)

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
  "HES_stroke" = HES_stroke,
  "PreCovidPeriod_all" = PreCovidPeriod_all,
  "PreCovidPeriod_no_stroke" = PreCovidPeriod_no_stroke,
  "PreCovidPeriod_with_stroke" = PreCovidPeriod_with_stroke,
  "PreCovidPeriod_no_cvd" = PreCovidPeriod_no_cvd,
  "PreCovidPeriod_with_cvd" = PreCovidPeriod_with_cvd,
  "over_75" = over_75,
  "under_75" = under_75,
  "no_other_drugs" = no_other_drugs,
  "CVD" = CVD,
  "No_CVD" = No_CVD,
  "diabetes" = diabetes,
  "No_diabetes" = No_diabetes,
  "With_VTE" = VTE,
  "No_VTE" = No_VTE,
  "BMI_Obese_overweight" = BMI_Obese_overweight,
  "BMI_Normal_underweight" = BMI_Normal_underweight,
  "atrialFibrillation" = atrialFibrillation,
  "No_atrialFibrillation" = No_atrialFibrillation,
  "risperidone_Age_65_74" = risperidone_Age_65_74,
  "risperidone_Age_75_84" = risperidone_Age_75_84,
  "risperidone_Age_85+" = risperidone_Age_85_plus,
  "hypertension_stage1AndHigher" = hypertension_stage1AndHigher,
  "hypertension_stage2AndHigher" = hypertension_stage2AndHigher,
  "carehome_preIndexDate" = carehome_preIndexDate,
  "HES&ONS_stroke" = HES_ONS_stroke,
  "stroke_recency_1_year" = stroke_recency_1_year,
  "stroke_recency_1_5_years" = stroke_recency_1_5_years,
  "stroke_recency_over_5_years" = stroke_recency_over_5_years,
  "ischaemicstroke" = ischaemicstroke,
  "haemorrhagicstroke" = haemorrhagicstroke
)


# 
# "12weeksFollowUp"  = dat %>% 
#   mutate(
#     cens_at=pmin(as.Date(issuedate)+(84),
#                  as.Date(death_composite_date), 
#                  lcd, 
#                  regenddate,
#                  na.rm=TRUE),
#     Stroke_censdate = pmin(as.Date(Stroke), as.Date(cens_at)),
#     Stroke_censvar = ifelse(!is.na(as.Date(Stroke)) & (Stroke == Stroke_censdate), 1, 0 ),
#     Stroke_censtime_yrs = as.numeric(difftime(Stroke_censdate, issuedate, units="days"))  / 365.25,
# Stroke_person_time_yrs := as.numeric(difftime(Stroke_censdate, issuedate, units = "days")) / 365.25





# view(subgroups[["CVD"]] %>% select(issuedate, death_composite_date, lcd, regenddate, cens_at, Stroke_censdate, Stroke_censvar, Stroke_censtime_yrs, Stroke))

# view(subgroups[["12weeksFollowUp"]] %>% select(issuedate, death_composite_date, lcd, regenddate, cens_at, Stroke_censdate, Stroke_censvar, Stroke_censtime_yrs, Stroke))
# view(subgroups[["HES&ONS_stroke"]] %>% select(Stroke, HES_post_index_date_first_stroke, ONS_stroke_post_date, stroke_compositeDate_post_first_stroke, post_index_date_first_stroke))
# view(dat %>% select(Stroke, HES_post_index_date_first_stroke, ONS_stroke_post_date, stroke_compositeDate_post_first_stroke, post_index_date_first_stroke))
# view(subgroups[["12weeksFollowUp"]] %>% select(Stroke, HES_post_index_date_first_stroke, ONS_stroke_post_date, stroke_compositeDate_post_first_stroke, post_index_date_first_stroke))

# Apply match.bal to all subgroups
for (subgroup_name in names(subgroups)) {
  subgroups[[subgroup_name]] <- match.bal(subgroups[[subgroup_name]])
}
# Define outcomes
# outcomes <- c("stroke.pc", "stroke.hes", "Stroke", "death", "cvd")

# Define the plot.surv function
plot.surv <- function(fit, outcome, subgroup, model_type, data, file_name) {
  
  # Calculate survival at 12 weeks (0.23 years) and 1 year
  times <- c(12 / 52, 1)
  labels <- c("12 weeks", "1 year")
  survival_diffs <- numeric(length(times))
  ci_lowers <- numeric(length(times))
  ci_uppers <- numeric(length(times))
  
  for (i in 1:length(times)) {
    time_in_years <- times[i]
    summary_fit <- summary(fit, times = time_in_years)
    
    survival_risperidone_0 <- summary_fit$surv[1]  # Control group
    survival_risperidone_1 <- summary_fit$surv[2]  # Treatment group
    
    # Calculate the difference
    survival_diffs[i] <- survival_risperidone_0 - survival_risperidone_1
    
    # Standard errors
    std_err_0 <- summary_fit$std.err[1]
    std_err_1 <- summary_fit$std.err[2]
    
    # Calculate the standard error of the difference
    diff_se <- sqrt(std_err_0^2 + std_err_1^2)
    
    # Confidence intervals
    ci_lowers[i] <- survival_diffs[i] - 1.96 * diff_se
    ci_uppers[i] <- survival_diffs[i] + 1.96 * diff_se
  }
  
  # Create a text string for the Absolute Risk Difference annotation
  ard_text <- sprintf("Absolute Risk Difference:\n12 weeks: %.2f%% (%.2f%%, %.2f%%)\n1 year: %.2f%% (%.2f%%, %.2f%%)",
                      survival_diffs[1] * 100, ci_lowers[1] * 100, ci_uppers[1] * 100,
                      survival_diffs[2] * 100, ci_lowers[2] * 100, ci_uppers[2] * 100)
  
  # Plot the survival curves
  ggsurv <- ggsurvplot(
    fit,
    data = data,
    fun = function(x) {100 - x * 100},  # Cumulative probability plot
    censor = FALSE,
    size = 1.5,
    pval = FALSE,
    conf.int = TRUE,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",  # Set legend title here
    xlim = c(0, 1),  # Limit x-axis to 1 year
    ylim = c(0, 25),  # Increase y-axis limit to 20
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    risk.table.y.text.col = TRUE,
    fontsize = 5,
    font.x = c(14), font.y = c(14), font.tickslab = c(14),
    axes.offset = TRUE,
    palette = c("#ED0000FF", "#00468BFF"),  # Custom color palette
    linetype = "strata",
    legend = c(0.15, 0.8),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light() +
      theme(legend.title = element_text(size = 12, face = "plain"),  # Set legend title face to plain
            legend.text = element_text(size = 12)),
    tables.theme = theme_cleantable()
  )
  
  # Annotate the plot with the Absolute Risk Difference text
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.15, y = 16, 
             label = ard_text, 
             size = 4, hjust = 0) +
    annotate("text", x = 0.2, y = 24.5, 
             # label = "D: With CVD", 
             label = paste(subgroup, "_", model_type),
             size = 5, hjust = 0, fontface = "bold")
  
  # Combine the main plot and the risk table
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))
  
  # Save the combined plot to a PDF file with improved resolution
  # ggsave(file_name, plot = combined_plot, device = "png", 
  #        width = 8, height = 6, dpi = 360)
  ggsave(file.path(output_dir, file_name), plot = combined_plot, device = "png", width = 8, height = 6, dpi = 360)
  
  
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
  
  # Calculate event count and person-time
  event_count <- sum(data[[paste0(outcome, "_censvar")]] == 1)
  person_time <- sum(data[[paste0(outcome, "_censtime_yrs")]])
  incidence_rate_per_1000_PY <- (event_count / person_time) * 1000
  number_of_patients <- nrow(data)
  
  # Fit survival model
  sfit <- survfit(Surv(data[[paste0(outcome, "_censtime_yrs")]], data[[paste0(outcome, "_censvar")]]) ~ risperidone, data = data)
  
  # Calculate ARD
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
  
  # Calculate ARR
  # ARR <- risperidone_event_rate - control_event_rate
  ARR <- abs(control_group - risperidone_group)
  
  # Calculate NNT
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
  
  # Standard Error of ARD
  # se_ARD <- sqrt((risperidone_event_rate * (1 - risperidone_event_rate) / n_treatment) + (control_event_rate * (1 - control_event_rate) / n_control))
  # 
  # # Confidence intervals for ARD
  # ci.l_ARD <- absoluteRiskDifference - (1.96 * se_ARD)
  # ci.u_ARD <- absoluteRiskDifference + (1.96 * se_ARD)
  # 
  # # Convert ARD CIs to NNH CIs
  # ci.l_NNH <- ifelse(ci.u_ARD != 0, 1 / ci.u_ARD, Inf)
  # ci.u_NNH <- ifelse(ci.l_ARD != 0, 1 / ci.l_ARD, Inf)
  # 
  
  # Create result dataframe
  res <- data.frame(
    outcome = outcome,
    subgroup = subgroup,
    model = model_type,
    hr = format(round(exp(model$coefficients[1]), 2), nsmall = 2),
    ci.l = format(round(exp(ci.l), 2), nsmall = 2),
    ci.u = format(round(exp(ci.u), 2), nsmall = 2),
    event_count = event_count,
    person_time = round(person_time, 2),
    incidence_rate_per_1000_PY = round(incidence_rate_per_1000_PY, 2),
    number_of_patients = number_of_patients,
    NNH = round(NNT, 2),
    ci.l_NNH = round(NNT_CI_lower, 2),
    ci.u_NNH = round(NNT_CI_upper, 2),
    # risperidone_event_rate = round(risperidone_event_rate, 4),
    # control_event_rate = round(control_event_rate, 4),
    # absoluteRiskDifference = absoluteRiskDifference,
    # ARR = round(ARR, 2)
    ARR= ARR
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
    
    
    unadjusted_file_name <- paste0(outcome, "_unadjusted_", subgroup_name, ".png")
    plot.surv(res_unadjusted$sfit, outcome, subgroup_name, "unadjusted", data, unadjusted_file_name)
    
    
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
    adjusted_file_name <- paste0(outcome, "_adjusted_", subgroup_name, ".png")
    plot.surv(res_adjusted$sfit, outcome, subgroup_name, "adjusted", data, adjusted_file_name)
  }
}

# Combine results into a single dataframe
results_df <- do.call(rbind, results)

# Print combined results dataframe
# Set the option to print all rows
options(max.print = nrow(results_df) * ncol(results_df))

# Assuming `results_df` is your data frame
print(results_df)




library(dplyr)

# Transform the results_df
transformed_df <- results_df %>%
  select(outcome, subgroup, event_count, person_time, incidence_rate_per_1000_PY, ARR, number_of_patients, NNH, ci.l_NNH, ci.u_NNH, 
         hr, ci.l, ci.u, model) %>%
  mutate(
    Adjusted_HR = ifelse(model == "adjusted", paste0(hr, " (", ci.l, ", ", ci.u, ")"), NA),
    Unadjusted_HR = ifelse(model == "unadjusted", paste0(hr, " (", ci.l, ", ", ci.u, ")"), NA)
  ) %>%
  group_by(outcome, subgroup) %>%
  summarise(
    event_count = first(event_count),
    person_time = first(person_time),
    incidence_rate = first(incidence_rate_per_1000_PY),
    number_of_patients = first(number_of_patients),
    ARR = ARR,
    NNH = first(NNH),
    ci.l_NNH = first(ci.l_NNH),
    ci.u_NNH = first(ci.u_NNH),
    Adjusted_HR = first(na.omit(Adjusted_HR)),
    Unadjusted_HR = first(na.omit(Unadjusted_HR)),
    .groups = 'drop'
  )

# View the transformed results
# Print the entire DataFrame without truncation
# print(transformed_df, n = Inf, row.names = FALSE)
# Export to CSV
write.csv(transformed_df, "transformed_results.csv", row.names = FALSE)

# Or view in RStudio Viewer
View(transformed_df)
options(max.print = nrow(transformed_df) * ncol(transformed_df))

print(transformed_df, n = Inf)


library(tidycmprsk)
library(tidyverse)
library(rms)
library(survminer)
library(ggsurvfit)

#Add death as a competing risk
dat <- dat  %>% 
  mutate(
    Stroke.cr=ifelse(Stroke_censvar== 0 & death_composite_date == Stroke_censdate, 2, Stroke_censvar),
    
    VTE.cr=ifelse(VTE_censvar== 0 & death_composite_date == VTE_censdate, 2, VTE_censvar)
  )

dat <- dat %>%
  mutate(
    Stroke.cr=ifelse(is.na(Stroke.cr),0,Stroke.cr),
    VTE.cr=ifelse(is.na(VTE.cr),0,VTE.cr)
  )
table(dat$Stroke.cr)
describe(dat$Stroke.cr)


table(dat$VTE.cr)
describe(dat$VTE.cr)

dat <- dat %>%
  mutate(
    Stroke.cr=as.factor(Stroke.cr),
    VTE.cr=as.factor(VTE.cr),
    
  )
table(dat$Stroke.cr)

#Over cumulative incidence adj. for competing risk of death
cr.res <- 
  cuminc(Surv(Stroke_censtime_yrs, Stroke.cr) ~ risperidone, data = dat) %>% 
  ggcuminc() + 
  labs(
    x = "Years",
    title = "Cumulative Incidence of Stroke Adjusted for Competing Risk of Death: One year follow-up"
  ) + 
  add_confidence_interval() +
  add_risktable() +
  theme(
    legend.title = element_blank(),
    legend.position = "bottom"
  )

print(cr.res)


# Cause-specific Cox model for stroke (competing event: death)
cox_stroke_cs <- coxph(Surv(Stroke_censtime_yrs, Stroke.cr == 1) ~ risperidone, data = dat)
summary(cox_stroke_cs)

# Cause-specific Cox model for death (competing event: stroke)
cox_death_cs <- coxph(Surv(Stroke_censtime_yrs, Stroke.cr == 2) ~ risperidone, data = dat)
summary(cox_death_cs)


# # Fit the Fine-Gray model for Stroke (1 = stroke event, 2 = death as competing event)
# fg_stroke <- crr(
#   time = dat$Stroke_censtime_yrs,
#   fstatus = dat$Stroke.cr,  # 1 = stroke, 2 = death
#   cov1 = dat$risperidone  # covariate of interest, e.g., risperidone
# )
# 
# summary(fg_stroke)

#VTE

#Over cumulative incidence adj. for competing risk of death
cr.res <- 
  cuminc(Surv(VTE_censtime_yrs, VTE.cr) ~ risperidone, data = dat) %>% 
  ggcuminc() + 
  labs(
    x = "Years",
    title = "Cumulative Incidence of VTE Adjusted for Competing Risk of Death"
  ) + 
  add_confidence_interval() +
  add_risktable() +
  theme(
    legend.title = element_blank(),
    legend.position = "bottom"
  )

print(cr.res)

#################### pdf saved plots


library(survival)
library(survminer)
library(ggpubr)

plot_combined_survival <- function(fit, data, output_file) {
  # Calculate survival at 12 weeks (0.23 years) and 1 year
  times <- c(12 / 52, 1)
  labels <- c("12 weeks", "1 year")
  survival_diffs <- numeric(length(times))
  ci_lowers <- numeric(length(times))
  ci_uppers <- numeric(length(times))

  for (i in 1:length(times)) {
    time_in_years <- times[i]
    summary_fit <- summary(fit, times = time_in_years)

    survival_risperidone_0 <- summary_fit$surv[1]  # Control group
    survival_risperidone_1 <- summary_fit$surv[2]  # Treatment group

    # Calculate the difference
    survival_diffs[i] <- survival_risperidone_0 - survival_risperidone_1

    # Standard errors
    std_err_0 <- summary_fit$std.err[1]
    std_err_1 <- summary_fit$std.err[2]

    # Calculate the standard error of the difference
    diff_se <- sqrt(std_err_0^2 + std_err_1^2)

    # Confidence intervals
    ci_lowers[i] <- survival_diffs[i] - 1.96 * diff_se
    ci_uppers[i] <- survival_diffs[i] + 1.96 * diff_se
  }

  # Create a text string for the Absolute Risk Difference annotation
  ard_text <- sprintf("Absolute Risk Difference:\n12 weeks: %.2f%% (%.2f%%, %.2f%%)\n1 year: %.2f%% (%.2f%%, %.2f%%)",
                      survival_diffs[1] * 100, ci_lowers[1] * 100, ci_uppers[1] * 100,
                      survival_diffs[2] * 100, ci_lowers[2] * 100, ci_uppers[2] * 100)

  # Plot the survival curves
  ggsurv <- ggsurvplot(
    fit,
    data = data,
    fun = function(x) {100 - x * 100},  # Cumulative probability plot
    censor = FALSE,
    size = 1.5,
    pval = FALSE,
    conf.int = TRUE,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",  # Set legend title here
    xlim = c(0, 1),  # Limit x-axis to 1 year
    ylim = c(0, 20),  # Increase y-axis limit to 20
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    risk.table.y.text.col = TRUE,
    fontsize = 5,
    font.x = c(14), font.y = c(14), font.tickslab = c(14),
    axes.offset = TRUE,
    palette = c("#ED0000FF", "#00468BFF"),  # Custom color palette
    linetype = "strata",
    legend = c(0.18, 0.8),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light() +
      theme(legend.title = element_text(size = 12, face = "plain"),  # Set legend title face to plain
            legend.text = element_text(size = 12)),
    tables.theme = theme_cleantable()
  )

  # Annotate the plot with the Absolute Risk Difference text
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.3, y = 16,
             label = ard_text,
             size = 4, hjust = 0) +
    annotate("text", x = 0.5, y = 19,
             label = "A: No Stroke",
             size = 5, hjust = 0, fontface = "bold")

  # Combine the main plot and the risk table
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))

  # Save the combined plot to a PDF file with improved resolution
  ggsave(output_file, plot = combined_plot, device = "png",
         width = 8, height = 6, dpi = 600)
}

# Plot combined survival for 12 weeks and 1 year and save to a PDF
fit <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["no_stroke"]])
plot_combined_survival(fit, subgroups[["no_stroke"]], "no_stroke.eps")

#### with stroke


library(survival)
library(survminer)
library(ggpubr)

plot_combined_survival <- function(fit, data, output_file) {
  # Calculate survival at 12 weeks (0.23 years) and 1 year
  times <- c(12 / 52, 1)
  labels <- c("12 weeks", "1 year")
  survival_diffs <- numeric(length(times))
  ci_lowers <- numeric(length(times))
  ci_uppers <- numeric(length(times))

  for (i in 1:length(times)) {
    time_in_years <- times[i]
    summary_fit <- summary(fit, times = time_in_years)

    survival_risperidone_0 <- summary_fit$surv[1]  # Control group
    survival_risperidone_1 <- summary_fit$surv[2]  # Treatment group

    # Calculate the difference
    survival_diffs[i] <- survival_risperidone_0 - survival_risperidone_1

    # Standard errors
    std_err_0 <- summary_fit$std.err[1]
    std_err_1 <- summary_fit$std.err[2]

    # Calculate the standard error of the difference
    diff_se <- sqrt(std_err_0^2 + std_err_1^2)

    # Confidence intervals
    ci_lowers[i] <- survival_diffs[i] - 1.96 * diff_se
    ci_uppers[i] <- survival_diffs[i] + 1.96 * diff_se
  }

  # Create a text string for the Absolute Risk Difference annotation
  ard_text <- sprintf("Absolute Risk Difference:\n12 weeks: %.2f%% (%.2f%%, %.2f%%)\n1 year: %.2f%% (%.2f%%, %.2f%%)",
                      survival_diffs[1] * 100, ci_lowers[1] * 100, ci_uppers[1] * 100,
                      survival_diffs[2] * 100, ci_lowers[2] * 100, ci_uppers[2] * 100)

  # Plot the survival curves
  ggsurv <- ggsurvplot(
    fit,
    data = data,
    fun = function(x) {100 - x * 100},  # Cumulative probability plot
    censor = FALSE,
    size = 1.5,
    pval = FALSE,
    conf.int = TRUE,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",  # Set legend title here
    xlim = c(0, 1),  # Limit x-axis to 1 year
    ylim = c(0, 20),  # Increase y-axis limit to 20
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    risk.table.y.text.col = TRUE,
    fontsize = 5,
    font.x = c(14), font.y = c(14), font.tickslab = c(14),
    axes.offset = TRUE,
    palette = c("#ED0000FF", "#00468BFF"),  # Custom color palette
    linetype = "strata",
    legend = c(0.18, 0.8),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light() +
      theme(legend.title = element_text(size = 12, face = "plain"),  # Set legend title face to plain
            legend.text = element_text(size = 12)),
    tables.theme = theme_cleantable()
  )

  # Annotate the plot with the Absolute Risk Difference text
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.3, y = 16,
             label = ard_text,
             size = 4, hjust = 0) +
    annotate("text", x = 0.5, y = 19,
             label = "B: With Stroke",
             size = 5, hjust = 0, fontface = "bold")

  # Combine the main plot and the risk table
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))

  # Save the combined plot to a PDF file with improved resolution
  ggsave(output_file, plot = combined_plot, device = "png",
         width = 8, height = 6, dpi = 600)
}

# Plot combined survival for 12 weeks and 1 year and save to a PDF
fit <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["with_stroke"]])
plot_combined_survival(fit, subgroups[["with_stroke"]], "with_stroke.eps")


##### no cvd


library(survival)
library(survminer)
library(ggpubr)

plot_combined_survival <- function(fit, data, output_file) {
  # Calculate survival at 12 weeks (0.23 years) and 1 year
  times <- c(12 / 52, 1)
  labels <- c("12 weeks", "1 year")
  survival_diffs <- numeric(length(times))
  ci_lowers <- numeric(length(times))
  ci_uppers <- numeric(length(times))

  for (i in 1:length(times)) {
    time_in_years <- times[i]
    summary_fit <- summary(fit, times = time_in_years)

    survival_risperidone_0 <- summary_fit$surv[1]  # Control group
    survival_risperidone_1 <- summary_fit$surv[2]  # Treatment group

    # Calculate the difference
    survival_diffs[i] <- survival_risperidone_0 - survival_risperidone_1

    # Standard errors
    std_err_0 <- summary_fit$std.err[1]
    std_err_1 <- summary_fit$std.err[2]

    # Calculate the standard error of the difference
    diff_se <- sqrt(std_err_0^2 + std_err_1^2)

    # Confidence intervals
    ci_lowers[i] <- survival_diffs[i] - 1.96 * diff_se
    ci_uppers[i] <- survival_diffs[i] + 1.96 * diff_se
  }

  # Create a text string for the Absolute Risk Difference annotation
  ard_text <- sprintf("Absolute Risk Difference:\n12 weeks: %.2f%% (%.2f%%, %.2f%%)\n1 year: %.2f%% (%.2f%%, %.2f%%)",
                      survival_diffs[1] * 100, ci_lowers[1] * 100, ci_uppers[1] * 100,
                      survival_diffs[2] * 100, ci_lowers[2] * 100, ci_uppers[2] * 100)

  # Plot the survival curves
  ggsurv <- ggsurvplot(
    fit,
    data = data,
    fun = function(x) {100 - x * 100},  # Cumulative probability plot
    censor = FALSE,
    size = 1.5,
    pval = FALSE,
    conf.int = TRUE,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",  # Set legend title here
    xlim = c(0, 1),  # Limit x-axis to 1 year
    ylim = c(0, 20),  # Increase y-axis limit to 20
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    risk.table.y.text.col = TRUE,
    fontsize = 5,
    font.x = c(14), font.y = c(14), font.tickslab = c(14),
    axes.offset = TRUE,
    palette = c("#ED0000FF", "#00468BFF"),  # Custom color palette
    linetype = "strata",
    legend = c(0.18, 0.8),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light() +
      theme(legend.title = element_text(size = 12, face = "plain"),  # Set legend title face to plain
            legend.text = element_text(size = 12)),
    tables.theme = theme_cleantable()
  )

  # Annotate the plot with the Absolute Risk Difference text
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.3, y = 16,
             label = ard_text,
             size = 4, hjust = 0) +
    annotate("text", x = 0.5, y = 19,
             label = "C: No CVD",
             size = 5, hjust = 0, fontface = "bold")

  # Combine the main plot and the risk table
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))

  # Save the combined plot to a PDF file with improved resolution
  ggsave(output_file, plot = combined_plot, device = "png",
         width = 8, height = 6, dpi = 600)
}

# Plot combined survival for 12 weeks and 1 year and save to a PDF
fit <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["No_CVD"]])
plot_combined_survival(fit, subgroups[["No_CVD"]], "No_cvd.eps")









#####  cvd


library(survival)
library(survminer)
library(ggpubr)

plot_combined_survival <- function(fit, data, output_file) {
  # Calculate survival at 12 weeks (0.23 years) and 1 year
  times <- c(12 / 52, 1)
  labels <- c("12 weeks", "1 year")
  survival_diffs <- numeric(length(times))
  ci_lowers <- numeric(length(times))
  ci_uppers <- numeric(length(times))

  for (i in 1:length(times)) {
    time_in_years <- times[i]
    summary_fit <- summary(fit, times = time_in_years)

    survival_risperidone_0 <- summary_fit$surv[1]  # Control group
    survival_risperidone_1 <- summary_fit$surv[2]  # Treatment group

    # Calculate the difference
    survival_diffs[i] <- survival_risperidone_0 - survival_risperidone_1

    # Standard errors
    std_err_0 <- summary_fit$std.err[1]
    std_err_1 <- summary_fit$std.err[2]

    # Calculate the standard error of the difference
    diff_se <- sqrt(std_err_0^2 + std_err_1^2)

    # Confidence intervals
    ci_lowers[i] <- survival_diffs[i] - 1.96 * diff_se
    ci_uppers[i] <- survival_diffs[i] + 1.96 * diff_se
  }

  # Create a text string for the Absolute Risk Difference annotation
  ard_text <- sprintf("Absolute Risk Difference:\n12 weeks: %.2f%% (%.2f%%, %.2f%%)\n1 year: %.2f%% (%.2f%%, %.2f%%)",
                      survival_diffs[1] * 100, ci_lowers[1] * 100, ci_uppers[1] * 100,
                      survival_diffs[2] * 100, ci_lowers[2] * 100, ci_uppers[2] * 100)

  # Plot the survival curves
  ggsurv <- ggsurvplot(
    fit,
    data = data,
    fun = function(x) {100 - x * 100},  # Cumulative probability plot
    censor = FALSE,
    size = 1.5,
    pval = FALSE,
    conf.int = TRUE,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",  # Set legend title here
    xlim = c(0, 1),  # Limit x-axis to 1 year
    ylim = c(0, 20),  # Increase y-axis limit to 20
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    risk.table.y.text.col = TRUE,
    fontsize = 5,
    font.x = c(14), font.y = c(14), font.tickslab = c(14),
    axes.offset = TRUE,
    palette = c("#ED0000FF", "#00468BFF"),  # Custom color palette
    linetype = "strata",
    legend = c(0.18, 0.8),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light() +
      theme(legend.title = element_text(size = 12, face = "plain"),  # Set legend title face to plain
            legend.text = element_text(size = 12)),
    tables.theme = theme_cleantable()
  )

  # Annotate the plot with the Absolute Risk Difference text
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.3, y = 16,
             label = ard_text,
             size = 4, hjust = 0) +
    annotate("text", x = 0.5, y = 19,
             label = "D: With CVD",
             size = 5, hjust = 0, fontface = "bold")

  # Combine the main plot and the risk table
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))

  # Save the combined plot to a PDF file with improved resolution
  ggsave(output_file, plot = combined_plot, device = "png",
         width = 8, height = 6, dpi = 600)
}

# Plot combined survival for 12 weeks and 1 year and save to a PDF
fit <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["CVD"]])
plot_combined_survival(fit, subgroups[["CVD"]], "cvd.eps")







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

# Your updated plot_combined_survival function
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
    font.x = c(16), font.y = c(16), font.tickslab = c(14), # Increased font sizes
    palette = c("#ED0000FF", "#00468BFF"),
    linetype = "strata",
    legend = c(0.18, 0.875),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light(base_family = "Arial") +  # Specify a font family
      theme(legend.title = element_text(size = 14, face = "bold"),
            legend.text = element_text(size = 14),
            axis.title.x = element_text(size = 16, face = "bold"),  # Bold x-axis title
            axis.title.y = element_text(size = 16, face = "bold")), # Bold y-axis title
    tables.theme = theme_cleantable()
  )
  
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0, y = 12.5, label = ard_text, size = 5, hjust = 0, fontface = "plain") +  # Adjusted size
    annotate("text", x = 0.5, y = 19, label = title_label, size = 6, hjust = 0, fontface = "bold")
  
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))
  
  # Save the plot with high DPI
  ggsave(output_file, plot = combined_plot, width = 16, height = 12, dpi = 600, device = "png") # Adjust the device if needed
  return(combined_plot)
}

# Generate and save plots for each subgroup
fit_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["CVD"]])
fit_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["with_stroke"]])
fit_no_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["No_CVD"]])
fit_no_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["no_stroke"]])

# Generate plots for each subgroup
plot1 <- plot_combined_survival(fit_no_stroke, subgroups[["no_stroke"]], "no_stroke_plot.png", "A: No Stroke")
plot2 <- plot_combined_survival(fit_stroke, subgroups[["with_stroke"]], "with_stroke_plot.png", "B: With Stroke")
plot3 <- plot_combined_survival(fit_no_CVD, subgroups[["No_CVD"]], "no_CVD_plot.png", "C: No CVD")
plot4 <- plot_combined_survival(fit_CVD, subgroups[["CVD"]], "with_CVD_plot.png", "D: With CVD")

# Arrange the plots in a 2x2 grid
grid_plot <- grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

# Save the final 2x2 plot
ggsave("combined_survival_2x2.png", plot = grid_plot, width = 16, height = 12, dpi = 600)









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

# Your updated plot_combined_survival function
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
    conf.int.alpha = 0.7,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",
    xlim = c(0, 1),
    ylim = c(0, 20),
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    fontsize = 5,
    font.x = c(16), font.y = c(16), font.tickslab = c(14), # Increased font sizes
    palette = c("#ED0000FF", "#00468BFF"),
    linetype = "strata",
    legend = c(0.18, 0.875),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light(base_family = "Arial") +  # Specify a font family
      theme(legend.title = element_text(size = 14, face = "bold"),
            legend.text = element_text(size = 14),
            axis.title.x = element_text(size = 16, face = "bold"),  # Bold x-axis title
            axis.title.y = element_text(size = 16, face = "bold")), # Bold y-axis title
    tables.theme = theme_cleantable()
  )
  
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0, y = 12.5, label = ard_text, size = 5, hjust = 0, fontface = "plain") +  # Adjusted size
    annotate("text", x = 0.5, y = 19, label = title_label, size = 6, hjust = 0, fontface = "bold")
  
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))
  
  # Save the plot with high DPI
  ggsave(output_file, plot = combined_plot, width = 16, height = 12, dpi = 600, device = "png") # Adjust the device if needed
  return(combined_plot)
}

# Generate and save plots for each subgroup
fit_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["CVD"]])
fit_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["with_stroke"]])
fit_no_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["No_CVD"]])
fit_no_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["no_stroke"]])

# Generate plots for each subgroup
plot1 <- plot_combined_survival(fit_no_stroke, subgroups[["no_stroke"]], "no_stroke_plot.eps", "A: No Stroke")
plot2 <- plot_combined_survival(fit_stroke, subgroups[["with_stroke"]], "with_stroke_plot.eps", "B: With Stroke")
plot3 <- plot_combined_survival(fit_no_CVD, subgroups[["No_CVD"]], "no_CVD_plot.eps", "C: No CVD")
plot4 <- plot_combined_survival(fit_CVD, subgroups[["CVD"]], "with_CVD_plot.eps", "D: With CVD")

# Arrange the plots in a 2x2 grid
grid_plot <- grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

# Save the final 2x2 plot
ggsave("combined_survival_2x2.eps", plot = grid_plot, width = 16, height = 12, dpi = 300)





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

# Your updated plot_combined_survival function
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
    conf.int.alpha = 0.7,
    legend.labs = c("Matched Controls", "Risperidone Users"),
    risk.table = TRUE,
    legend.title = "",
    xlim = c(0, 1),
    ylim = c(0, 20),
    xlab = "Time to event (years)",
    ylab = "Cumulative incidence (%)",
    break.time.by = 0.2,
    fontsize = 5,
    font.x = c(16), font.y = c(16), font.tickslab = c(14), # Increased font sizes
    palette = c("#ED0000FF", "#00468BFF"),
    linetype = "strata",
    legend = c(0.18, 0.875),
    risk.table.height = 0.25,
    risk.table.y.text = FALSE,
    ggtheme = theme_light(base_family = "Arial") +  # Specify a font family
      theme(legend.title = element_text(size = 14, face = "bold"),
            legend.text = element_text(size = 14),
            axis.title.x = element_text(size = 16, face = "bold"),  # Bold x-axis title
            axis.title.y = element_text(size = 16, face = "bold")), # Bold y-axis title
    tables.theme = theme_cleantable()
  )
  
  ggsurv$plot <- ggsurv$plot +
    annotate("text", x = 0.001, y = 12.5, label = ard_text, size = 5, hjust = 0, fontface = "plain") +  # Adjusted size
    annotate("text", x = 0.5, y = 19, label = title_label, size = 6, hjust = 0, fontface = "bold")
  
  combined_plot <- ggarrange(ggsurv$plot, ggsurv$table, ncol = 1, nrow = 2, heights = c(2, 0.5))
  
  # Save the plot with high DPI
  ggsave(output_file, plot = combined_plot, width = 16, height = 12, dpi = 600, device = "png") # Adjust the device if needed
  return(combined_plot)
}

# Generate and save plots for each subgroup
fit_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["CVD"]])
fit_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["with_stroke"]])
fit_no_CVD <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["No_CVD"]])
fit_no_stroke <- survfit(Surv(Stroke_censtime_yrs, Stroke_censvar) ~ risperidone, data = subgroups[["no_stroke"]])

# Generate plots for each subgroup
plot1 <- plot_combined_survival(fit_no_stroke, subgroups[["no_stroke"]], "no_stroke_plot.jpg", "A: No Stroke")
plot2 <- plot_combined_survival(fit_stroke, subgroups[["with_stroke"]], "with_stroke_plot.jpg", "B: With Stroke")
plot3 <- plot_combined_survival(fit_no_CVD, subgroups[["No_CVD"]], "no_CVD_plot.jpg", "C: No CVD")
plot4 <- plot_combined_survival(fit_CVD, subgroups[["CVD"]], "with_CVD_plot.jpg", "D: With CVD")

# Arrange the plots in a 2x2 grid
grid_plot <- grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

# Save the final 2x2 plot
ggsave("combined_survival_2x2.jpg", plot = grid_plot, width = 16, height = 12, dpi = 300)


