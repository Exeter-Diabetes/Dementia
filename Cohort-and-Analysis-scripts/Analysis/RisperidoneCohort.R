# Setup

# library(devtools)
# install_github("Exeter-Diabetes/CPRD-analysis-package")
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
library(tableone)
rm(list=ls())
library(bit64)
cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")

analysis = cprd$analysis("Joshua")
analysis_at_diag = cprd$analysis("at_diag")


# risperidone_cohort <- analysis$cached(name = "final_risperidone_After2004") %>%
#   filter(PrescriptionAfterDiagnosis == 1) %>%
# semi_join(cprd$tables$patidsWithLinkage, by = "patid") 

risperidone_cohort <- analysis$cached(name = "final_risperidone_cohortLinkedData")# %>%
# filter(PrescriptionAfterDiagnosis == 1) %>%
# semi_join(cprd$tables$patidsWithLinkage, by = "patid") 
risperidone_cohort %>% count() #### 30709


risperidone_cohort <- risperidone_cohort %>%
  # filter(PrescriptionAfterDiagnosis == 1) %>%
  left_join(analysis$cached(name = "clean_frailty_simple_medcodes") %>%
              filter(!is.na(obsdate)) %>%
              group_by(patid) %>%
              filter(obsdate == max(obsdate, na.rm = TRUE)) %>%
              ungroup() %>%
              rename(frailty = frailty_simple_cat) %>%
              distinct(patid, .keep_all = TRUE) %>% select("patid", "frailty"), by = "patid")


risperidone_cohort %>% count()    ##### n = 24,498


comorbids <- c(
  "angina",
  "heartfailure",
  # "hypertension",
  "myocardialinfarction",
  "stroke",
  "tia",  #transient ischaemic attack
  "falls",
  "lowerlimbfracture",
  "ihd",
  "pad",
  "af",
  "revasc",
  "qof_diabetes",
  'anxiety_disorders',
  'fh_diabetes',
  'fh_premature_cvd',
  'pulmonary_embolism',
  'deep_vein_thrombosis',
  'haem_cancer',
  'solid_cancer',
  'hearing_loss'
  
)


for (i in comorbids) {
  
  comod <- paste0("risperidone_comorbids_cohort_",i)
  print(comod)
  risperidone_cohort <- risperidone_cohort %>% 
    left_join(analysis$cached(name = comod), by = "patid")
  
}

colnames(risperidone_cohort)
###############################################################################################################

biomarkers <- c(
  # "weight",
  # "height",
  "bmi",
  "totalcholesterol",
  "dbp",
  "sbp"
)

for (i in biomarkers) {
  
  comod <- paste0("risperidone_biomarker_cohort_",i)
  print(comod)
  risperidone_cohort <- risperidone_cohort %>% 
    left_join(analysis$cached(name = comod), by = "patid")
  
}

colnames(risperidone_cohort)

risperidone_cohort %>% count()  


FullData <- risperidone_cohort %>%
  left_join(analysis$cached(name = "HES_risperidone_comorbids_stroke"), by = "patid") %>%
  left_join(analysis$cached(name = "Other_Antipsychotic_Earliest_prescriptions") %>%
              select(patid, issuedate, drug_name) %>%
              rename(Other_anti_psychotic_earliest_issuedate = issuedate)
            , by = "patid") %>%
  mutate(
    comorbidity_hypertension = case_when(
      (testvalue_sbp < 120) & (testvalue_dbp < 80) ~ "Normal",
      (testvalue_sbp >= 120 & testvalue_sbp <= 129) & (testvalue_dbp < 80) ~ "Elevated",
      (testvalue_sbp >= 130 & testvalue_sbp <= 139) | (testvalue_dbp <= 89 & testvalue_dbp >= 80) ~ "Stage 1",
      (testvalue_sbp >= 140 & testvalue_sbp <= 180) | (testvalue_dbp <= 120 & testvalue_dbp >= 90) ~ "Stage 2",
      (testvalue_sbp > 180 ) | (testvalue_dbp > 120) ~ "Stage 3 (severe)",
      TRUE ~ "Unknown"
    ),
    obsdate_hypertension =  pmin(date_dbp, date_sbp) ,
    
    
    totalcholesterol = case_when(
      testvalue_totalcholesterol < 4.14 ~ "< 160 mg/dl",
      (testvalue_totalcholesterol >= 4.15) & (testvalue_totalcholesterol <= 5.17) ~ "199 mg/dl",
      (testvalue_totalcholesterol >= 5.18) & (testvalue_totalcholesterol <= 6.21) ~ "200 - 239 mg/dl",
      (testvalue_totalcholesterol >= 6.22) & (testvalue_totalcholesterol <= 7.24) ~ "240 - 279 mg/dl",
      testvalue_totalcholesterol > 7.25 ~ "> 280 mg/dl",
      TRUE ~ "Unknown"
    ),
    
    
    pre_index_date_hypertension = ifelse(issuedate > obsdate_hypertension, 1, 0),
    sex = ifelse(gender==2, 0, gender),
    
    year_diagnosis_cat = case_when(
      year_of_diagnosis >= 2004 & year_of_diagnosis <= 2008 ~ "2004 - 2008",
      year_of_diagnosis >= 2009 & year_of_diagnosis <= 2012 ~ "2009 - 2012",
      year_of_diagnosis >= 2013 & year_of_diagnosis <= 2016 ~ "2013 - 2016",
      year_of_diagnosis >= 2017 & year_of_diagnosis <= 2020 ~ "2017 - 2020",
      year_of_diagnosis > 2020 ~ "> 2020",
      TRUE ~ NA_character_
    ),
    age_category = case_when(
      age_diagnosis >= 65 & age_diagnosis <= 74 ~ "65 - 74",
      age_diagnosis >= 75 & age_diagnosis <= 84 ~ "75 - 84",
      age_diagnosis >= 85  ~ "85+",
      TRUE ~ NA_character_),
    stroke_recency = as.numeric(issuedate - pre_index_date_latest_stroke) / 365.25,
    stroke_recency_cat = case_when(
      stroke_recency <= 1 ~ " <= 1",
      stroke_recency > 1 & stroke_recency <= 2 ~ "1 - 2",
      stroke_recency > 2 & stroke_recency <= 3 ~ "2 - 3",
      stroke_recency > 3 & stroke_recency <= 4 ~ "3 - 4",
      stroke_recency > 4 & stroke_recency <= 5 ~ "4 - 5",
      stroke_recency > 5 & stroke_recency <= 6 ~ "5 - 6",
      stroke_recency > 6 & stroke_recency <= 7 ~ "6 - 7",
      stroke_recency > 7 ~ " > 7"
    ),
    stroke_3_months_prior = ifelse(!is.na(pre_index_date_latest_stroke) & (issuedate - pre_index_date_latest_stroke) <= 90, 1, 0),
    stroke_6_months_prior = ifelse(!is.na(pre_index_date_latest_stroke) & (issuedate - pre_index_date_latest_stroke) <= 180, 1, 0),
    stroke_12_months_prior = ifelse(!is.na(pre_index_date_latest_stroke) & (issuedate - pre_index_date_latest_stroke) <= 365, 1, 0),
    BMI = case_when(
      testvalue_bmi < 18.5 ~ "Underweight",
      testvalue_bmi >= 18.5 & testvalue_bmi < 25 ~ "Normal",
      testvalue_bmi >= 25 & testvalue_bmi < 30 ~ "Overweight",
      testvalue_bmi >= 30 & testvalue_bmi < 40 ~ "Obesity",
      testvalue_bmi >= 40 ~ "Severely Obese",
      TRUE ~ "Unknown"
    ),
    frailty = if_else(is.na(frailty), "Unknown", as.character(frailty)),
    VTE = ifelse((comorbidity_deep_vein_thrombosis ==1) |(comorbidity_pulmonary_embolism ==1), 1, 0),
    
    Stroke_prior_to_risperidone	 = if_else(!is.na(obsdate_stroke) & !is.na(issuedate) & (obsdate_stroke < issuedate) & (comorbidity_stroke ==1), 1, 0),
    Stroke__within_year_after_1st_risperidone_presc	 = if_else(!is.na(obsdate_stroke) & !is.na(issuedate) & (as.numeric(datediff(obsdate_stroke , issuedate)) >= 0) & (as.numeric(datediff(obsdate_stroke , issuedate)) <= 365) & (comorbidity_stroke ==1), 1, 0),
    death_in_a_year_after_risperidone = if_else((died ==1) & !is.na(issuedate) & (as.numeric(datediff(death_composite_date, issuedate)) >= 0) & (as.numeric(datediff(death_composite_date , issuedate)) <= 365), 1, 0),
    stroke_death_in_a_year_after_risperidone = if_else((died==1) & !is.na(issuedate) & (as.numeric(datediff(death_composite_date, issuedate)) >= 0) & (as.numeric(datediff(obsdate_stroke , issuedate)) <= 365) & (comorbidity_stroke ==1), 1, 0),
    
    dementia_duration_prior_risperidone = floor(as.numeric(datediff(issuedate, earliest_obsdate)) / 365.25),
    
    prescribed_other_antipsyc_drug = if_else(!is.na(Other_anti_psychotic_earliest_issuedate), 1, 0),
    pre_indexdate_antipysch_prescr = if_else(Other_anti_psychotic_earliest_issuedate < issuedate, 1, 0),
    post_indexdate_antipysch_prescr = if_else(Other_anti_psychotic_earliest_issuedate > issuedate, 1, 0),
    same_indexdate_antipysch_prescr = if_else(Other_anti_psychotic_earliest_issuedate == issuedate, 1, 0),
    
    pre_indexdate_drug_name = ifelse((pre_indexdate_antipysch_prescr == 1), drug_name, NA_character_),
    same_indexdate_drug_name = ifelse((same_indexdate_antipysch_prescr == 1), drug_name, NA_character_),
    post_indexdate_drug_name = ifelse((post_indexdate_antipysch_prescr == 1), drug_name, NA_character_),
    
    primary_death_stroke = ifelse(is.na(primary_death_stroke), 0, primary_death_stroke),
    
    stroke_pre_compositeDate = if_else(
      !is.na(HES_pre_index_date_latest_stroke) & (is.na(pre_index_date_earliest_stroke) | HES_pre_index_date_latest_stroke <= pre_index_date_earliest_stroke),
      as.Date(HES_pre_index_date_latest_stroke),
      as.Date(pre_index_date_earliest_stroke)
    ),
    
    stroke_post_compositeDate = if_else(
      !is.na(HES_post_index_date_first_stroke) & (is.na(post_index_date_first_stroke) | HES_post_index_date_first_stroke <= post_index_date_first_stroke),
      as.Date(HES_post_index_date_first_stroke),
      as.Date(post_index_date_first_stroke)
    )
    ,
    # 
    Composite_pre_stroke = ifelse((!is.na(HES_pre_index_date_latest_stroke)|(!is.na(pre_index_date_earliest_stroke))), 1, 0),
    Composite_post_stroke = ifelse((!is.na(HES_post_index_date_first_stroke)|(!is.na(post_index_date_first_stroke))), 1, 0),
    Survival_time = ifelse(is.na(stroke_post_compositeDate),
                           (as.numeric(datediff(endoffollowup , issuedate)) / 365.25),
                           (as.numeric(datediff(stroke_post_compositeDate, issuedate)) / 365.25)),
    
    ## stroke from primary cause of death
    Composite_post_stroke = if_else(
      is.na(Composite_post_stroke) & !is.na(stroke_date_of_death),
      1,
      Composite_post_stroke
    ),
    stroke_post_compositeDate = if_else(
      is.na(stroke_post_compositeDate) & !is.na(stroke_date_of_death),
      as.Date(stroke_date_of_death),
      as.Date(stroke_post_compositeDate)
    ),
    
    
    
    
    # Stroke_prior_to_risperidone	 = if_else(!is.na(obsdate_stroke) & !is.na(issuedate) & (obsdate_stroke < issuedate) & (comorbidity_stroke ==1), 1, 0),
    Stroke_prior_to_risperidone	 = if_else(Composite_pre_stroke ==1, 1, 0),
    Stroke__within_year_after_1st_risperidone_presc	 = if_else(!is.na(stroke_post_compositeDate) & !is.na(issuedate) & (as.numeric(datediff(stroke_post_compositeDate , issuedate)) >= 0) & (as.numeric(datediff(stroke_post_compositeDate , issuedate)) <= 365) & (stroke_composite==1), 1, 0),
    
    # Stroke__within_year_after_1st_risperidone_presc	 = if_else(!is.na(obsdate_stroke) & !is.na(issuedate) & (as.numeric(datediff(obsdate_stroke , issuedate)) >= 0) & (as.numeric(datediff(obsdate_stroke , issuedate)) <= 365) & (comorbidity_stroke ==1), 1, 0),
    # death_in_a_year_after_risperidone = if_else((died ==1) & !is.na(issuedate) & (as.numeric(datediff(death_composite_date, issuedate)) >= 0) & (as.numeric(datediff(death_composite_date , issuedate)) <= 365), 1, 0),
    death_in_a_year_after_risperidone = if_else((death_composite ==1) & !is.na(issuedate) & (as.numeric(datediff(death_composite_date, issuedate)) >= 0) & (as.numeric(datediff(death_composite_date , issuedate)) <= 365), 1, 0),
    
    # stroke_death_in_a_year_after_risperidone = if_else((died==1) & !is.na(issuedate) & (as.numeric(datediff(death_composite_date, issuedate)) >= 0) & (as.numeric(datediff(obsdate_stroke , issuedate)) <= 365) & (comorbidity_stroke ==1), 1, 0),
    
    stroke_death_in_a_year_after_risperidone = if_else((death_composite==1) & !is.na(issuedate) & (as.numeric(datediff(death_composite_date, issuedate)) >= 0) & (as.numeric(datediff(stroke_post_compositeDate , issuedate)) <= 365) & (stroke_composite ==1), 1, 0),
    
    
  ) %>%
  select(-gender)%>%
  left_join(analysis$cached(name = "risperidone_prescriptions"), by = "patid") %>%
  rename(drugrecid = drugrecid.x, issueid = issueid.x, issuedate = issuedate.x, prodcodeid = prodcodeid.x, dosageid = dosageid.x, quantity = quantity.x, quantunitid = quantunitid.x, duration = duration.x, estnhscost = estnhscost.x, pracid = pracid.x, probobsid = prodcodeid.x, enterdate = enterdate.x, staffid = staffid.x, other_R_prescription_dates = issuedate.y) %>%
  select(-drugrecid.y, -issueid.y, -prodcodeid.y, -dosageid.y, -quantity.y, -quantunitid.y, -duration.y, -estnhscost.y, -pracid.y, -probobsid.y, -enterdate.y, -staffid.y) %>%
  group_by(patid) %>%
  mutate(
    Prescriptions_ever = n(),
    TimeSinceFirstPrescription = as.numeric(datediff(other_R_prescription_dates , issuedate)) / 365.25,
    # TimeSinceFirstPrescription = as.numeric(difftime(other_r_prescription_dates, issuedate)),
    Prescriptions_within_a_year = sum(TimeSinceFirstPrescription <= 1),
    Prescriptions_after_a_year = sum(TimeSinceFirstPrescription > 1)
  ) %>%
  filter(row_number() == 1) %>%
  ungroup() %>%
  mutate(
    Prescription_ever_cat = case_when(
      # Prescriptions_ever == 1 ~ "1",
      Prescriptions_ever %in% 1:10 ~ as.character(Prescriptions_ever),
      Prescriptions_ever %in% 11:20 ~ "11 - 20",
      Prescriptions_ever %in% 21:30 ~ "21 - 30",
      Prescriptions_ever %in% 31:40 ~ "31 - 40",
      Prescriptions_ever %in% 41:50 ~ "41 - 50",
      Prescriptions_ever %in% 51:100 ~ "51 - 100",
      Prescriptions_ever > 100 ~ ">100",
      TRUE ~ NA_character_
    ),
    Prescriptions_within_a_year_cat = case_when(
      # Prescriptions_within_a_year == 1 ~ "1",
      Prescriptions_within_a_year %in% 1:10 ~ as.character(Prescriptions_within_a_year),
      Prescriptions_within_a_year %in% 11:20 ~ "11 - 20",
      Prescriptions_within_a_year %in% 21:30 ~ "21 - 30",
      Prescriptions_within_a_year %in% 31:40 ~ "31 - 40",
      Prescriptions_within_a_year %in% 41:50 ~ "41 - 50",
      Prescriptions_within_a_year %in% 51:100 ~ "51 - 100",
      Prescriptions_within_a_year > 100 ~ ">100",
      TRUE ~ NA_character_
    ),
    Prescriptions_after_a_year_cat = case_when(
      # Prescriptions_after_a_year == 1 ~ "1",
      Prescriptions_after_a_year %in% 1:10 ~ as.character(Prescriptions_after_a_year),
      Prescriptions_after_a_year %in% 11:20 ~ "11 - 20",
      Prescriptions_after_a_year %in% 21:30 ~ "21 - 30",
      Prescriptions_after_a_year %in% 31:40 ~ "31 - 40",
      Prescriptions_after_a_year %in% 41:50 ~ "41 - 50",
      Prescriptions_after_a_year %in% 51:100 ~ "51 - 100",
      Prescriptions_after_a_year > 100 ~ ">100",
      TRUE ~ NA_character_
    )
  ) %>%
  
  left_join(analysis$cached(name = "clean_care_home_medcodes") %>%
              select(patid, obsdate, care_home_cat) %>%
              rename(homeCare_obsdate = obsdate)
            , by = "patid") %>%
  group_by(patid) %>%
  mutate(
    care_home = if_else(!is.na(homeCare_obsdate), 1, 0),
    care_home_before_indexdate = if_else((homeCare_obsdate < issuedate), 1, 0),
    care_home_at_indexdate = if_else((homeCare_obsdate == issuedate), 1, 0),
    R_issuedate_carehomeObsdate_difference = floor(as.numeric(datediff(issuedate, homeCare_obsdate))),
    care_home_90_days_after_indexdate = if_else(R_issuedate_carehomeObsdate_difference > 90, 1, 0)
  ) %>%
  distinct(patid, .keep_all = TRUE) #%>% collect() 
# ######################################################################################################



variables_of_interest <- c("diagnosedbeforeRegistration","died","death_composite","ONS_died",  "age_diagnosis", "age_risperidone", "deprivation",  "gender_decode", "GP_stroke", "HES_stroke","stroke_composite", "primary_death_stroke", 
                           "Composite_pre_stroke", "Composite_post_stroke","comorbidity_stroke", "pre_index_date_stroke", "post_index_date_stroke", "Stroke_prior_to_risperidone",
                           "Stroke__within_year_after_1st_risperidone_presc",
                           "death_in_a_year_after_risperidone","sex",  "ethnicity", "age_category" , "year_of_diagnosis",
                           "year_of_prescription", "stroke_3_months_prior",
                           "stroke_6_months_prior", "stroke_12_months_prior", "stroke_recency_cat", "dementia_duration_prior_risperidone", "Survival_time",
                           "comorbidity_af", "pre_index_date_af", "post_index_date_af", "comorbidity_angina", "pre_index_date_angina",
                           "post_index_date_angina","comorbidity_anxiety_disorders", "pre_index_date_anxiety_disorders", "post_index_date_anxiety_disorders",
                           "comorbidity_falls", "pre_index_date_falls", "post_index_date_falls", "comorbidity_fh_diabetes", "pre_index_date_fh_diabetes",
                           "post_index_date_fh_diabetes", "comorbidity_fh_premature_cvd", "pre_index_date_fh_premature_cvd", "post_index_date_fh_premature_cvd",
                           "comorbidity_heartfailure", "pre_index_date_heartfailure", "post_index_date_heartfailure", "comorbidity_lowerlimbfracture", "pre_index_date_lowerlimbfracture", "post_index_date_lowerlimbfracture",
                           "comorbidity_myocardialinfarction", "pre_index_date_myocardialinfarction", "post_index_date_myocardialinfarction", "comorbidity_qof_diabetes",
                           "pre_index_date_qof_diabetes", "post_index_date_qof_diabetes", "comorbidity_revasc", "pre_index_date_revasc", "post_index_date_revasc",
                           "stroke_cat", "comorbidity_tia", "pre_index_date_tia",
                           "post_index_date_tia", "comorbidity_deep_vein_thrombosis", "pre_index_date_deep_vein_thrombosis", "post_index_date_deep_vein_thrombosis",
                           "comorbidity_haem_cancer", "pre_index_date_haem_cancer", "post_index_date_haem_cancer",
                           "comorbidity_pulmonary_embolism", "pre_index_date_pulmonary_embolism", "post_index_date_pulmonary_embolism",
                           "comorbidity_solid_cancer", "pre_index_date_solid_cancer", "post_index_date_solid_cancer", "VTE",
                           "BMI", "totalcholesterol", "testvalue_dbp", "testvalue_height", "testvalue_sbp", "testvalue_totalcholesterol",
                           "testvalue_weight", "gp_5cat_ethnicity", "gp_16cat_ethnicity", "gp_qrisk2_ethnicity", "alcohol_cat", "smoking_cat", "qrisk2_smoking_cat",
                           "qrisk2_smoking_cat_uncoded", "drug_name", "frailty",  "year_diagnosis_cat",
                           
                           "prescribed_other_antipsyc_drug","pre_indexdate_antipysch_prescr", "post_indexdate_antipysch_prescr", "same_indexdate_antipysch_prescr",
                           "time_between_pre_antipyscho_drug_n_risperidone", "time_between_post_antipyscho_drug_n_risperidone", "pre_indexdate_drug_name",
                           "same_indexdate_drug_name", "post_indexdate_drug_name",  "care_home", "care_home_before_indexdate",
                           "care_home_at_indexdate", "care_home_90_days_after_indexdate", "Prescriptions_ever", "TimeSinceFirstPrescription", "Prescription_ever_cat",
                           "Prescriptions_after_a_year_cat", "Prescriptions_within_a_year_cat", "consultation_counts_Cat", 
                           "comorbidity_hypertension", "pre_index_date_hypertension",
                           "comorbidity_hearing_loss", "pre_index_date_hearing_loss", "post_index_date_hearing_loss", "HES_comorbidity_stroke", 
                           "HES_pre_index_date_stroke", "HES_post_index_date_stroke", "hes_5cat_ethnicity" , "hes_16cat_ethnicity", "hes_qrisk2_ethnicity")


binary_vars <- c("diagnosedbeforeRegistration", "died","death_composite","ONS_died", "deprivation","age_category","year_of_prescription", "year_of_diagnosis", "gender_decode", "GP_stroke", "HES_stroke","stroke_composite", "primary_death_stroke", 
                 "Composite_pre_stroke", "Composite_post_stroke", "comorbidity_af", "pre_index_date_af", "post_index_date_af", "comorbidity_angina", "pre_index_date_angina", "post_index_date_angina",
                 "comorbidity_anxiety_disorders", "pre_index_date_anxiety_disorders", "post_index_date_anxiety_disorders", "comorbidity_falls", "pre_index_date_falls",
                 "post_index_date_falls", "comorbidity_fh_diabetes", "pre_index_date_fh_diabetes", "post_index_date_fh_diabetes", "comorbidity_fh_premature_cvd",
                 "pre_index_date_fh_premature_cvd", "post_index_date_fh_premature_cvd", "comorbidity_heartfailure", "pre_index_date_heartfailure", "post_index_date_heartfailure",
                 "comorbidity_lowerlimbfracture", "pre_index_date_lowerlimbfracture",
                 "post_index_date_lowerlimbfracture", "comorbidity_myocardialinfarction", "pre_index_date_myocardialinfarction", "post_index_date_myocardialinfarction",
                 "comorbidity_qof_diabetes", "pre_index_date_qof_diabetes", "post_index_date_qof_diabetes", "comorbidity_revasc", "pre_index_date_revasc", "post_index_date_revasc",
                 "comorbidity_stroke", "pre_index_date_stroke", "post_index_date_stroke", "comorbidity_tia","comorbidity_deep_vein_thrombosis", "pre_index_date_deep_vein_thrombosis", "post_index_date_deep_vein_thrombosis",
                 "comorbidity_haem_cancer", "pre_index_date_haem_cancer", "post_index_date_haem_cancer",
                 "comorbidity_pulmonary_embolism", "pre_index_date_pulmonary_embolism", "post_index_date_pulmonary_embolism",
                 "comorbidity_solid_cancer", "pre_index_date_solid_cancer", "post_index_date_solid_cancer",
                 "pre_index_date_tia", "post_index_date_tia", "gp_5cat_ethnicity", "VTE",
                 "gp_16cat_ethnicity", "gp_qrisk2_ethnicity", "qrisk2_smoking_cat", "sex", "Stroke_prior_to_risperidone", "Stroke__within_year_after_1st_risperidone_presc",
                 "death_in_a_year_after_risperidone", "prescribed_other_antipsyc_drug","pre_indexdate_antipysch_prescr", "post_indexdate_antipysch_prescr", "same_indexdate_antipysch_prescr",
                 "care_home", "care_home_before_indexdate", "care_home_at_indexdate", "care_home_90_days_after_indexdate", "stroke_3_months_prior", "stroke_6_months_prior", 
                 "stroke_12_months_prior", "pre_index_date_hypertension",
                 "comorbidity_hearing_loss", "pre_index_date_hearing_loss", "post_index_date_hearing_loss", "HES_comorbidity_stroke", "HES_pre_index_date_stroke", "HES_post_index_date_stroke"
)
FullData <- FullData %>% collect()
FullData[binary_vars] <- lapply(FullData[binary_vars], as.factor)


my_tableone <- CreateTableOne(vars = variables_of_interest, data = FullData)

# Print the table

print(my_tableone)
require("survival")
library(survminer)



FullData$stroke_composite <- as.numeric(as.character(FullData$stroke_composite))

FullData$Composite_post_stroke <- as.numeric(as.character(FullData$Composite_post_stroke))

fit <- survfit(Surv(Survival_time, Composite_post_stroke) ~ Composite_pre_stroke, data = FullData)
# summary(fit)
ggsurv <- ggsurvplot(
  fit,
  data = FullData,
  fun = function(x) {100 - x * 100},  # Cumulative probability plot
  censor = FALSE,
  size = 1.5,
  pval = TRUE,
  conf.int = TRUE,
  # legend.title = "",
  legend.labs = c("No stroke before index date", "Stroke before index date"),
  risk.table = TRUE,
  risk.table.title = "Strata",
  xlim = c(0, 1.45),
  ylim = c(0, 25),
  xlab = "Time to event (years)",
  ylab = "Cumulative incidence (%)",
  break.time.by = 0.2,
  # ggtheme = theme_light(),
  risk.table.y.text.col = TRUE,
  fontsize = 5,
  font.x = c(14), font.y = c(14), font.tickslab = c(14),
  axes.offset = TRUE,
  palette = c("#ED0000FF", "#00468BFF"),
  linetype = "strata",
  legend = c(0.28, 0.8),
  risk.table.height = 0.25,
  risk.table.y.text = FALSE,
  ggtheme = theme_light() +
    theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)),  
  tables.theme = theme_cleantable(),
  pval.size = 5,  # Set the size of the p-value text
  pval.coord = c(0.7, 14)  # Adjust the position of the p-value text
)

print(ggsurv)


#######################################################################################

CompleteData <- FullData

res.cox <- coxph(Surv(Survival_time, Composite_post_stroke) ~ Composite_pre_stroke, data = CompleteData)

res.cox



# Fit the Cox proportional hazards model

res.cox <- coxph(Surv(Survival_time, Composite_post_stroke) ~ age_diagnosis + Composite_pre_stroke + sex, data = CompleteData)


res.cox <- coxph(Surv(Survival_time, Composite_post_stroke) ~ age_diagnosis + Composite_pre_stroke + sex, data = CompleteData)

summary(res.cox)


###########################################################################################################################################
######################################################################################################################



CensoringData_1year <- CompleteData %>%
  mutate(
    timeDiff = issuedate + years(1),  # Adding one year to issuedate
    AdjustedEndOfFollowUp = pmin(timeDiff, endoffollowup),  # Choose the minimum of timeDiff and endoffollowup
    # post_index_date_first_stroke = if_else(post_index_date_first_stroke > timeDiff, timeDiff, post_index_date_first_stroke),
    # post_index_date_stroke = if_else((post_index_date_first_stroke > timeDiff) &(post_index_date_stroke ==1), 0, post_index_date_stroke),
    Composite_post_stroke = if_else((stroke_post_compositeDate > timeDiff) &(Composite_post_stroke ==1), 0, Composite_post_stroke),
    Survival_time = if_else(is.na(stroke_post_compositeDate),
                            as.numeric(AdjustedEndOfFollowUp - issuedate) / 365.25,
                            as.numeric((stroke_post_compositeDate - issuedate)) / 365.25),
    stime.1 = ifelse(Survival_time>1,1,Survival_time)
  ) 



summary(CensoringData_1year$stime.full)
summary(CensoringData_1year$Survival_time)
table(CensoringData_1year$Composite_post_stroke)
table(CensoringData_1year$Composite_post_stroke)





test <- CompleteData %>%
  mutate(
    fail.full  = ifelse(!is.na(stroke_post_compositeDate),1, NA),
    sdate.full = as.Date(ifelse(is.na(fail.full),endoffollowup,stroke_post_compositeDate)),
    stime.full = as.numeric(sdate.full - issuedate) / 365.25,
    fail.1 = ifelse(stime.full>1,NA,fail.full),
    fail.1 = ifelse(is.na(fail.1),0,fail.1),
    # stime.1 = ifelse(stime.full>1,1,stime.full)
    stime.1 = ifelse(stime.full>1,1,stime.full)
  )
summary(test$stime.full)
summary(test$stime.1)
table(test$fail.full)
table(test$fail.1)





test <- test %>%
  #filter(Survival_time <= 1) %>%
  mutate(
    endoffollowup_death = ifelse(death_composite_date == sdate.full, 1, 0),
    endoffollowup_deregistration = ifelse(regenddate == sdate.full, 1, 0),
    endoffollowup_lcd = ifelse(lcd == sdate.full, 1, 0),
    deregistration_death_overlap = ifelse(death_composite_date==regenddate, 1, 0),
    stroke_death_overlap = ifelse(death_composite_date==stroke_post_compositeDate & stime.full <=1, 1, 0)
  )


variables <- c("endoffollowup_death", "endoffollowup_deregistration", "endoffollowup_lcd", "deregistration_death_overlap",
               "stroke_death_overlap")
test[variables] <- lapply(test[variables], as.factor)

my_tableone <- CreateTableOne(vars = variables, data = test)

print(my_tableone)

test <- test %>% 
  mutate(issuedeath.diff = as.numeric(death_composite_date - issuedate) / 365.25)
summary(test$death_composite_date)
summary(test$issuedate)
summary(test$lcd)
summary(test$regenddate)




test$Composite_post_stroke <- as.numeric(as.character(test$Composite_post_stroke))

fit <- survfit(Surv(stime.1, Composite_post_stroke) ~ Composite_pre_stroke, data = test)
# summary(fit)
ggsurv <- ggsurvplot(
  fit,
  data = test,
  fun = function(x) {100 - x * 100},  # Cumulative probability plot
  censor = FALSE,
  size = 1.5,
  pval = TRUE,
  conf.int = TRUE,
  legend.title = "Censoring at 1 year after index date",
  legend.labs = c("No stroke before index date", "Stroke before index date"),
  risk.table = TRUE,
  risk.table.title = "Strata",
  xlim = c(0, 1),
  ylim = c(0, 25),
  xlab = "Time to event (years)",
  ylab = "Cumulative incidence (%)",
  break.time.by = 0.2,
  # ggtheme = theme_light(),
  risk.table.y.text.col = TRUE,
  fontsize = 5,
  font.x = c(14), font.y = c(14), font.tickslab = c(14),
  axes.offset = TRUE,
  palette = c("#ED0000FF", "#00468BFF"),
  linetype = "strata",
  legend = c(0.28, 0.9),
  risk.table.height = 0.25,
  risk.table.y.text = FALSE,
  ggtheme = theme_light() +
    theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)),  
  tables.theme = theme_cleantable(),
  pval.size = 5,  # Set the size of the p-value text
  pval.coord = c(0.7, 6)  # Adjust the position of the p-value text
)

print(ggsurv)





# view(CensoringData_1year %>% select(Survival_time, AdjustedEndOfFollowUp, endoffollowup, issuedate, timeDiff, stroke_post_compositeDate))

proportionUnderstanding_censoring <- CensoringData_1year %>%
  filter(Survival_time <= 1) %>%
  mutate(
    endoffollowup_death = ifelse(endoffollowup == death_composite_date, 1, 0),
    endoffollowup_deregistration = ifelse(endoffollowup == regenddate, 1, 0),
    endoffollowup_lcd = ifelse(endoffollowup == lcd, 1, 0),
    deregistration_death_overlap = ifelse(death_composite_date==regenddate, 1, 0)
    
  )
variables <- c("endoffollowup_death", "endoffollowup_deregistration", "endoffollowup_lcd", "deregistration_death_overlap" )


proportionUnderstanding_censoring[variables] <- lapply(proportionUnderstanding_censoring[variables], as.factor)


my_tableone <- CreateTableOne(vars = variables, data = proportionUnderstanding_censoring)

# Print the table

print(my_tableone)




#######################################################################################

res.cox <- coxph(Surv(Survival_time, Composite_post_stroke) ~ stroke_pre_compositeDate, data = Excluding_12_monthsPriorStroke)

res.cox



# Fit the Cox proportional hazards model

res.cox <- coxph(Surv(Survival_time, Composite_post_stroke) ~ age_diagnosis + Composite_pre_stroke + sex, data = Excluding_12_monthsPriorStroke)


res.cox <- coxph(Surv(Survival_time, Composite_post_stroke) ~ age_diagnosis + Composite_pre_stroke + sex, data = Excluding_12_monthsPriorStroke)

summary(res.cox)

# surv_fit <- survfit(res.cox)



#############################################################################################################
# CompleteData <- CompleteData %>%
#   collect() #%>%
# mutate(
#   FollowUp =  as.numeric((as.Date(pmin(regenddate, death_composite_date, lcd, na.rm = TRUE)) - as.Date(issuedate))/365.25)
# )
CompleteData$death_composite <- as.numeric(as.character(CompleteData$death_composite))

library(survminer)
# fit <- survfit(Surv(time, status) ~ sex, data = lung)
fit <- survfit(Surv(FollowUp,death_composite) ~ gender_decode,data=CompleteData)
ggsurv <- ggsurvplot(
  fit,                     # survfit object with calculated statistics.
  data = CompleteData,             # data used to fit survival curves.
  risk.table = TRUE,       # show risk table.
  pval = TRUE,             # show p-value of log-rank test.
  conf.int = TRUE,         # show confidence intervals for 
  # point estimates of survival curves.
  palette = c("#E7B800", "#2E9FDF"),
  xlim = c(0,22),         # present narrower X axis, but not affect
  # survival estimates.
  xlab = "Time in years",   # customize X axis label.
  break.time.by = 3,     # break X axis in time intervals by 500.
  ggtheme = theme_light(), # customize plot and risk table with a theme.
  risk.table.y.text.col = T,# colour risk table text annotations.
  risk.table.height = 0.25, # the height of the risk table
  risk.table.y.text = FALSE,# show bars instead of names in text annotations
  # in legend of risk table.
  # ncensor.plot = TRUE,      # plot the number of censored subjects at time t
  # ncensor.plot.height = 0.25,
  conf.int.style = "step",  # customize style of confidence intervals
  surv.median.line = "hv",  # add the median survival pointer.
  legend.labs =
    c("Female", "Male")    # change legend labels.
)
ggsurv


median_times <- surv_median(fit)

# Print the median survival times
print(median_times)





unique_age_categories <- levels(CompleteData$age_category)

fit <- survfit(Surv(FollowUp, death_composite) ~ age_category, data = CompleteData)

ggsurv <- ggsurvplot(
  fit,
  data = CompleteData,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = TRUE,
  palette = c("#E7B800", "#2E9FDF", "#55CC00", "#FF0000"),
  xlim = c(0, 22),
  xlab = "Time in years",
  break.time.by = 3,
  ggtheme = theme_light(),
  risk.table.y.text.col = TRUE,
  risk.table.height = 0.35,
  risk.table.y.text = FALSE,
  conf.int.style = "step",
  surv.median.line = "hv",
  legend.labs = unique_age_categories,
  risk.table.y.text.size = 3,          # Adjust the size of the risk table numbers
  risk.table.y.text.fontsize = 3,      # Adjust the font size of the risk table numbers
  size = 1  # Adjust the size of the plot
)

# Explicitly print the plot before saving
print(ggsurv)

median_times <- surv_median(fit)

# Print the median survival times
print(median_times)




