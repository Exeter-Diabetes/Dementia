# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
library(MatchIt)


cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")

set.seed(123) 

dementia_cohort <- analysis$cached(name="final_dementia_cohortLinkedData") #%>%
  # semi_join(cprd$tables$patidsWithLinkage, by = "patid")


risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("risperidone_prescriptions") %>%
  filter(issuedate >= "2004-01-01")

anti_psychotic <- anti_psychotic %>% analysis$cached("Other_Antipsychotic_Prescriptions") 



R_after_diagnosis <- analysis$cached(name="final_risperidone_afterdiagnosis_cohort_2004") #%>%
  # semi_join(cprd$tables$patidsWithLinkage, by = "patid") 

# variables = c("patid","consid", "obsdate", "death_composite_date","R_issuedate", "sex","regstartdate","earliest_obsdate", "regenddate","cprd_ddate", "lcd","region", "died","gender_decode", "date_of_birth", "age_diagnosis","Diff_start_endOfFollowup","endoffollowup", "age_category", "year_of_diagnosis","risperidone", "other_drug_issuedate", "year_of_diagnosis", "issuedate", "three_months_after_other_psychotic", "Prescribed_other_antipsychotic_Prior", "age_risperidone", "ethnicity")

variables = c("patid","consid", "obsdate", "death_composite_date", "R_issuedate","sex","regstartdate","earliest_obsdate", "regenddate","cprd_ddate", "lcd","region", "died", "gender_decode", "date_of_birth", "age_diagnosis","Diff_start_endOfFollowup","endoffollowup", "age_category", "year_of_diagnosis","risperidone", "other_drug_issuedate", "year_of_diagnosis", "issuedate", "three_months_after_other_psychotic", "Prescribed_other_antipsychotic_Prior", "age_risperidone", "ethnicity", "death_composite", "FollowUp")

# Create an empty list to store matched data frames
matched_data_list <- list()
cumulative_matched_data <- data.frame()
sink("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResultsUpdatedAlgorithm_Censored/summary_output.txt", append = TRUE)



total_matched_count <- 0
total_unmatched_count <- 0

for (year in 2004:2023) {
  
  
  print(paste("Processing data for year", year))
  
  
  ###### Treatment group #################################
  # prescribed R in year
  # extra exclusion of anyone prescribed any other antipsychotic (excluding prochlorperazine) in the 90 days prior to Risperidone start date
  
  

  
  
  TreatmentGroup <- R_after_diagnosis %>%
    filter(issuedate >= paste0(year, "-01-01")& issuedate <= paste0(year, "-12-31")) %>%
    left_join(anti_psychotic %>% select(patid, issuedate, drug_name), by = "patid") %>%
    rename(
      other_drug_issuedate = issuedate.y,
      issuedate = issuedate.x,
      drug_name = drug_name.y
    ) %>%
    select(-drug_name.x) %>%
    collect() %>%
    mutate(
      three_months_after_other_psychotic = as.Date(ifelse(!is.na(other_drug_issuedate), other_drug_issuedate + 90, NA))
    )%>%
    filter(
      is.na(other_drug_issuedate)| (other_drug_issuedate > issuedate | issuedate > three_months_after_other_psychotic | drug_name %in% c("prochlorperazine")))%>%
    group_by(patid) %>%
    slice_min(order_by = issuedate)%>%
    distinct(patid, .keep_all = TRUE) %>%
    mutate(
      risperidone = 1,
      Prescribed_other_antipsychotic_Prior = as.numeric(!is.na(other_drug_issuedate) & other_drug_issuedate < issuedate),
      sex = case_when(
        gender == 1 ~ 1,
        gender == 2 ~ 0,
      ),
      age_risperidone = floor(as.numeric(as.Date(issuedate) - as.Date(date_of_birth))/365.25),
      R_issuedate = issuedate
      
    ) %>%
    #### censoring any antipsychotic within a year after R index date
    left_join(
      anti_psychotic %>%
        filter(issuedate > as.Date(paste0(year, "-12-31"))) %>%  # Include only records after the initial period filter
        select(patid, issuedate, drug_name) %>%
        collect() %>%
        rename(other_antipsychotic_date_post_R_prescription = issuedate, firstDrugPost_R_prescription = drug_name),
      by = "patid"
    ) %>%
    group_by(patid) %>%
    slice_min(order_by = other_antipsychotic_date_post_R_prescription, with_ties = FALSE) %>%
    ungroup() %>%
    mutate(
      earliest_other_antipsychotic_date_post_R_prescription = other_antipsychotic_date_post_R_prescription,
      censoringDate = issuedate + 365
    ) %>%
    filter(is.na(earliest_other_antipsychotic_date_post_R_prescription) | earliest_other_antipsychotic_date_post_R_prescription > censoringDate) %>%
    distinct(patid, .keep_all = TRUE)
  
    
    
    
    
    
    
  
  ###### Control group Processing #######################
  # diagnosed of dementia before 01/01/year
  # Registered with GP before 01/01/year
  # Still active beyond 01/01/year: death, lcd and regenddate > 01/01/year ---- this part is implemented two blocks below because pmin doesn't work when the data is on the server.
  # I implement it after after collecting the data
  # subsetData <- dementia_cohort %>%
  #   filter((earliest_obsdate < paste0(year, "-01-01")) & 
  #            (regstartdate < paste0(year, "-01-01")))
  # & 
  #   (pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE) > paste0(year, "-01-01"))) 
  
  
  ControlGroup <- dementia_cohort %>%
    filter((earliest_obsdate < paste0(year, "-01-01")) & (regstartdate < paste0(year, "-01-01"))) %>%
    
    left_join(risperidone_prescriptions %>% 
                select(patid, issuedate) %>%
                filter(is.na(issuedate) | issuedate > paste0(year, "-12-31")) %>% 
                rename(R_issuedate = issuedate),
              by = "patid") %>%
    
    left_join(anti_psychotic %>% 
                select(patid, issuedate, drug_name) %>%
                rename(other_drug_issuedate = issuedate), 
              by = "patid") %>%
    
    collect() %>%
    
    mutate(
      issuedate = as.Date(replicate(n(), sample(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-12-31")), by = "day"), 1))),
      endoffollowup = as.Date(endoffollowup)  
    ) %>%
    
    filter(is.na(R_issuedate) | (R_issuedate > issuedate & endoffollowup > issuedate)) %>%
    filter(is.na(other_drug_issuedate) | other_drug_issuedate < issuedate) %>%
    
    mutate(
      three_months_after_other_psychotic = as.Date(ifelse(!is.na(other_drug_issuedate), other_drug_issuedate + 90, NA))
    ) %>%
    
    group_by(patid) %>%
    slice_max(order_by = other_drug_issuedate) %>%
    filter(
      is.na(other_drug_issuedate) |
        issuedate > three_months_after_other_psychotic |
        drug_name %in% c("prochlorperazine")
    ) %>%
    
    ungroup() %>%  
    distinct(patid, .keep_all = TRUE) %>%
    
    mutate(
      endoffollowup = as.Date(ifelse(!is.na(R_issuedate) & R_issuedate > issuedate, R_issuedate, endoffollowup)),
      risperidone = 0,
      Prescribed_other_antipsychotic_Prior = as.numeric(!is.na(other_drug_issuedate) & other_drug_issuedate < issuedate),
      sex = case_when(
        gender == 1 ~ 1,
        gender == 2 ~ 0
      ),
      age_risperidone = floor(as.numeric(as.Date(issuedate) - as.Date(date_of_birth)) / 365.25)
    ) %>%
    
    filter(issuedate < endoffollowup)  %>%
    #### censoring any antipsychotic within a year after R index date
    left_join(
      anti_psychotic %>%
        filter(issuedate > as.Date(paste0(year, "-12-31"))) %>%  # Include only records after the initial period filter
        select(patid, issuedate, drug_name) %>%
        collect() %>%
        rename(other_antipsychotic_date_post_R_prescription = issuedate, firstDrugPost_R_prescription = drug_name),
      by = "patid"
    ) %>%
    group_by(patid) %>%
    slice_min(order_by = other_antipsychotic_date_post_R_prescription, with_ties = FALSE) %>%
    ungroup() %>%
    mutate(
      earliest_other_antipsychotic_date_post_R_prescription = other_antipsychotic_date_post_R_prescription,
      censoringDate = issuedate + 365
    ) %>%
    filter(is.na(earliest_other_antipsychotic_date_post_R_prescription) | earliest_other_antipsychotic_date_post_R_prescription > censoringDate) %>%
    distinct(patid, .keep_all = TRUE)
  
  
  
  # # Not prescribed risperidone before 31/12/year
  # ControlPartition_risp <- subsetData %>%
  #   left_join(risperidone_prescriptions %>% select(patid, issuedate), by = "patid") %>%
  #   filter(is.na(issuedate) | issuedate > paste0(year, "-12-31"))%>%
  #   distinct(patid, .keep_all = TRUE)
  # 

  # Select control variables
  selected_control <- ControlGroup %>%
    select(all_of(variables))
  
  
  # Select treatment variables
  selected_treatment <- TreatmentGroup %>%
    select(all_of(variables))
  
  # Ensuring that the cases in the treatment are not in the controls
  filtered_control <- selected_control[!selected_control$patid %in% selected_treatment$patid, ]
  
  combined_data <- rbind(filtered_control, selected_treatment)%>%
    mutate(period_before_prescription = as.numeric(issuedate - earliest_obsdate)/365.25) %>%
    left_join(analysis$cached(name = "gp_ethnicity") %>% collect(), by = "patid") %>%
    mutate(
      gp_5cat_ethnicity = case_when(
        gp_5cat_ethnicity == 0 ~ "White",
        gp_5cat_ethnicity == 1 ~ "South Asian",
        gp_5cat_ethnicity == 2 ~ "Black",
        gp_5cat_ethnicity == 3 ~ "Other",
        gp_5cat_ethnicity == 4 ~ "Mixed",
        TRUE ~ "Unknown"  
      )
    )
 
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
  
  
  analysis_allPatid = cprd$analysis("Joshua")
  
  for (i in comorbids) {
    

    comod <- paste0("clean_", i, "_medcodes")
    comorbids_data <- comorbids_data %>% analysis$cached(name = comod)
    comorbids_partition <- comorbids_data 
    
    pre_index_date_earliest_date_variable <- paste0("pre_index_date_earliest_", tolower(i))
    pre_index_date_latest_date_variable <- paste0("pre_index_date_latest_", tolower(i))
    post_index_date_date_variable <- paste0("post_index_date_first_", tolower(i))
    obsdate_var <- paste0("obsdate_", tolower(i))
    
    if (tolower(i) == "stroke") {
      combined_data <- combined_data %>%
        left_join(comorbids_partition %>%
                    select(patid, stroke_cat, obsdate) %>%
                    rename(!!obsdate_var := obsdate) %>% collect(),
                  by = "patid") %>%
        mutate(!!paste0("comorbidity_", tolower(i)) := ifelse(!is.na(!!sym(obsdate_var)), 1, 0))
      
      pre_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) <= issuedate) %>%
        group_by(patid) %>%
        summarise(
          !!pre_index_date_earliest_date_variable := min(!!sym(obsdate_var), na.rm = TRUE),
          !!pre_index_date_latest_date_variable := max(!!sym(obsdate_var), na.rm = TRUE)
        ) %>%
        ungroup()
      
      post_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) > issuedate) %>%
        group_by(patid) %>%
        summarise(!!post_index_date_date_variable := min(!!sym(obsdate_var), na.rm = TRUE)) %>%
        ungroup()
      
      combined_data <- combined_data %>%
        left_join(pre_index_date, by = "patid") %>%
        mutate(
          !!paste0("pre_index_date_", tolower(i)) := as.numeric(!is.na(!!sym(pre_index_date_earliest_date_variable))),
          !!pre_index_date_earliest_date_variable := !!sym(pre_index_date_earliest_date_variable),
          !!pre_index_date_latest_date_variable := !!sym(pre_index_date_latest_date_variable)
        ) %>%
        left_join(post_index_date, by = "patid") %>%
        mutate(
          !!paste0("post_index_date_", tolower(i)) := as.numeric(!is.na(!!sym(post_index_date_date_variable))),
          !!post_index_date_date_variable := !!sym(post_index_date_date_variable)
        ) %>%
        distinct(patid, .keep_all = TRUE)
    } else {
      combined_data <- combined_data %>%
        left_join(comorbids_partition %>%
                    select(patid, obsdate) %>%
                    rename(!!obsdate_var := obsdate)  
                  %>% collect(),
                  by = "patid") %>%
        mutate(!!paste0("comorbidity_", tolower(i)) := ifelse(!is.na(!!sym(obsdate_var)), 1, 0))
      
      
      pre_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) <= issuedate) %>%
        group_by(patid) %>%
        summarise(
          !!pre_index_date_earliest_date_variable := min(!!sym(obsdate_var), na.rm = TRUE),
          !!pre_index_date_latest_date_variable := max(!!sym(obsdate_var), na.rm = TRUE)
        ) %>%
        ungroup()
      
      post_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) > issuedate) %>%
        group_by(patid) %>%
        summarise(!!post_index_date_date_variable := min(!!sym(obsdate_var), na.rm = TRUE)) %>%
        ungroup()
      
      combined_data <- combined_data %>%
        left_join(pre_index_date, by = "patid") %>%
        mutate(
          !!paste0("pre_index_date_", tolower(i)) := as.numeric(!is.na(!!sym(pre_index_date_earliest_date_variable))),
          !!pre_index_date_earliest_date_variable := !!sym(pre_index_date_earliest_date_variable),
          !!pre_index_date_latest_date_variable := !!sym(pre_index_date_latest_date_variable)
        ) %>%
        left_join(post_index_date, by = "patid") %>%
        mutate(
          !!paste0("post_index_date_", tolower(i)) := as.numeric(!is.na(!!sym(post_index_date_date_variable))),
          !!post_index_date_date_variable := !!sym(post_index_date_date_variable)
        ) %>%
        distinct(patid, .keep_all = TRUE)
    }
  }
  
  
  
  HES_strokeData <- HES_strokeData %>% analysis$cached("clean_stroke_icd10") %>%
    select(patid, epistart, ICD) %>%
    collect()%>%
    
    rename(stroke_epistart = epistart ) %>%
    mutate(
      HES_stroke = ifelse(is.na(ICD), 0, 1)
    )
  
  
  result2 <- combined_data %>%
    left_join(HES_strokeData, by = "patid") %>%
    mutate(
      HES_Stroke = ifelse(!is.na(stroke_epistart), 1, 0)
    )
  
  
  
  pre_index_date <- result2 %>%
    filter(stroke_epistart <= issuedate) %>%
    group_by(patid) %>%
    summarise(
      HES_pre_index_date_earliest_stroke = min(stroke_epistart, na.rm = TRUE),
      HES_pre_index_date_latest_stroke = max(stroke_epistart, na.rm = TRUE)
    ) %>%
    ungroup()
  
  post_index_date <- result2 %>%
    filter(stroke_epistart > issuedate) %>%
    group_by(patid) %>%
    summarise(
      HES_post_index_date_first_stroke = min(stroke_epistart), na.rm = TRUE) %>%
    ungroup()
  
  
  combined_data <- result2 %>%
    left_join(pre_index_date, by = "patid") %>%
    mutate(
      HES_pre_index_date_stroke = ifelse(!is.na(HES_pre_index_date_earliest_stroke), 1, 0)) %>%
    left_join(post_index_date, by = "patid") %>%
    mutate(
      HES_post_index_date_stroke = ifelse(!is.na(HES_post_index_date_first_stroke), 1, 0)) %>%
    left_join(analysis$cached(name ="death_stroke_primary") %>%
                rename(stroke_date_of_death = date_of_death)%>%
                collect(), by = "patid") %>%
    distinct(patid, .keep_all = TRUE) %>%
    mutate(
      stroke_composite_pre_index_date = ifelse((HES_pre_index_date_stroke==1) | (pre_index_date_stroke==1), 1, 0),
      stroke_composite_post_index_date = ifelse((HES_post_index_date_stroke==1) | (post_index_date_stroke==1), 1, 0),
      stroke_composite = ifelse(((!is.na(HES_Stroke)) | (!is.na(comorbidity_stroke))), 1, 0),
      # stroke_compositeDate_pre_earliest_stroke = as.Date(pmin(HES_pre_index_date_earliest_stroke, pre_index_date_earliest_stroke, na.rm = TRUE)),
      # stroke_compositeDate_pre_latest_stroke = as.Date(pmin(HES_pre_index_date_latest_stroke, pre_index_date_latest_stroke, na.rm = TRUE)),
      # stroke_compositeDate_post_first_stroke = as.Date(pmin(HES_post_index_date_first_stroke, post_index_date_first_stroke, na.rm = TRUE))
      
      
      
      stroke_compositeDate_pre_earliest_stroke = if_else(
        !is.na(HES_pre_index_date_earliest_stroke) & (is.na(pre_index_date_earliest_stroke) | HES_pre_index_date_earliest_stroke <= pre_index_date_earliest_stroke),
        as.Date(HES_pre_index_date_earliest_stroke),
        as.Date(pre_index_date_earliest_stroke)
      ),
      
      stroke_compositeDate_pre_latest_stroke = if_else(
        !is.na(HES_pre_index_date_latest_stroke) & (is.na(pre_index_date_latest_stroke) | HES_pre_index_date_latest_stroke <= pre_index_date_latest_stroke),
        as.Date(HES_pre_index_date_latest_stroke),
        as.Date(pre_index_date_latest_stroke)
      ),
      
      stroke_compositeDate_post_first_stroke = if_else(
        !is.na(HES_post_index_date_first_stroke) & (is.na(post_index_date_first_stroke) | HES_post_index_date_first_stroke <= post_index_date_first_stroke),
        as.Date(HES_post_index_date_first_stroke),
        as.Date(post_index_date_first_stroke)
      )
      
    )%>%
    mutate(
      stroke_composite_post_index_date = if_else(
        is.na(stroke_composite_post_index_date) & !is.na(stroke_date_of_death),
        1,
        stroke_composite_post_index_date
      ),
      stroke_compositeDate_post_first_stroke = if_else(
        is.na(stroke_compositeDate_post_first_stroke) & !is.na(stroke_date_of_death),
        as.Date(stroke_date_of_death),
        as.Date(stroke_compositeDate_post_first_stroke)
      ),
      
      # Update stroke_composite_post_index_date for the control if prescribed R and had stroke after issuedate
      stroke_composite_post_index_date <- ifelse(
        (risperidone == 0) & 
          (!is.na(R_issuedate)) & 
          (R_issuedate > issuedate) & 
          (stroke_compositeDate_post_first_stroke > R_issuedate),
        0,
        stroke_composite_post_index_date
      ),
      
      # Update stroke_compositeDate_post_first_stroke for the control if prescribed R and had stroke after issuedate
      stroke_compositeDate_post_first_stroke <- ifelse(
        (risperidone == 0) & 
          (!is.na(R_issuedate)) & 
          (R_issuedate > issuedate) & 
          (stroke_compositeDate_post_first_stroke > R_issuedate),
        NA,
        stroke_compositeDate_post_first_stroke
      )
      
    )
  


  ########################################################################################################################################################
  ###################################### Biomarkers#######################################################################################################
  library(EHRBiomarkr)
  # Define biomarkers
  ## Keep HbA1c separate as processed differently
  ## If you add biomarker to the end of this list, code should run fine to incorporate new biomarker, as long as you delete final 'baseline_biomarkers' table
  
  biomarkers <- c(
    # "weight",
    # "height",
    "bmi",
    "totalcholesterol",
    "dbp",
    "sbp"
  )
  FullData <- combined_data
  
  # analysis = cprd$analysis("all_patid")
  for (i in biomarkers) {
    testvalue_variable <- paste0("testvalue_", i)
    date_variable <- paste0("date_", i)

    clean_tablename <- paste0("clean_", i, "_medcodes")
    biomarkers_data <- analysis$cached(name = clean_tablename)
    
    common_patids <- semi_join(biomarkers_data, dementia_cohort, by = "patid")
    
    latest_bio <- common_patids %>%
      filter(date <= paste0(year, "-12-31")) %>%
      group_by(patid) %>%
      filter(date == max(date, na.rm = TRUE)) %>%
      ungroup() %>%
      select(patid, date, testvalue) %>%
      rename(!!date_variable := date, !!testvalue_variable := testvalue) %>%
      collect()
    
    FullData <- FullData %>%
      left_join(latest_bio, by = "patid")
  }
  
 
  
  
  FullData <- FullData %>%
    mutate(
      BMI = case_when(
        is.na(testvalue_bmi) ~ "Missing",
        testvalue_bmi < 18.5 ~ "Underweight",
        testvalue_bmi >= 18.5 & testvalue_bmi < 25 ~ "Normal",
        testvalue_bmi >= 25 & testvalue_bmi < 30 ~ "Overweight",
        testvalue_bmi >= 30 & testvalue_bmi < 40 ~ "Obesity",
        testvalue_bmi >= 40 ~ "Severely Obese",
      ),
      VTE = ifelse((comorbidity_deep_vein_thrombosis ==1) |(comorbidity_pulmonary_embolism ==1), 1, 0),
      comorbidity_hypertension = case_when(
        (testvalue_sbp < 120) & (testvalue_dbp < 80) ~ "Normal",
        (testvalue_sbp >= 120 & testvalue_sbp <= 129) & (testvalue_dbp < 80) ~ "Elevated",
        (testvalue_sbp >= 130 & testvalue_sbp <= 139) | (testvalue_dbp <= 89 & testvalue_dbp >= 80) ~ "Stage 1",
        (testvalue_sbp >= 140 & testvalue_sbp <= 180) | (testvalue_dbp <= 120 & testvalue_dbp >= 90) ~ "Stage 2",
        (testvalue_sbp > 180 ) | (testvalue_dbp > 120) ~ "Stage 3 (severe)",
        TRUE ~ "Unknown"
      ),
      obsdate_hypertension = case_when(
        !is.na(date_dbp) & !is.na(date_sbp) & date_dbp == date_sbp ~ as.character(date_dbp),
        TRUE ~ NA_character_  
      ),
      pre_index_date_hypertension = ifelse(issuedate > obsdate_hypertension, 1, 0),
      post_index_date_hypertension = ifelse(issuedate < obsdate_hypertension, 1, 0),
      Survival_time = ifelse(is.na(stroke_compositeDate_post_first_stroke),
                             (as.numeric(endoffollowup - issuedate) / 365.25),
                             (as.numeric(stroke_compositeDate_post_first_stroke - issuedate) / 365.25)),
      
      # obsdate_hypertension =  pmin(date_dbp, date_sbp) ,
      obsdate_hypertension = ifelse(
        is.na(date_dbp) & !is.na(date_sbp), date_sbp,
        ifelse(
          !is.na(date_dbp) & is.na(date_sbp), date_dbp,
          ifelse(
            date_dbp > date_sbp, date_sbp, date_dbp
          )
        )
      ),
      
      totalcholesterol = case_when(
        testvalue_totalcholesterol < 4.14 ~ "(< 160 mg/dl)",
        (testvalue_totalcholesterol >= 4.15) & (testvalue_totalcholesterol <= 5.17) ~ "(199 mg/dl)",
        (testvalue_totalcholesterol >= 5.18) & (testvalue_totalcholesterol <= 6.21) ~ "(200 - 239 mg/dl)",
        (testvalue_totalcholesterol >= 6.22) & (testvalue_totalcholesterol <= 7.24) ~ "(240 - 279 mg/dl)",
        testvalue_totalcholesterol > 7.25 ~ "(> 280 mg/dl)",
        TRUE ~ "Unknown" 
      )
    )
  
  
  
  
  
  

  
  ################################# Matching #########################################
  # 
  
  m.out2 <- matchit(risperidone ~ + sex + age_risperidone +pre_index_date_angina + pre_index_date_heartfailure + BMI + Prescribed_other_antipsychotic_Prior  + period_before_prescription  + pre_index_date_myocardialinfarction + stroke_composite_pre_index_date +
                      pre_index_date_tia + pre_index_date_falls +pre_index_date_lowerlimbfracture + pre_index_date_ihd + pre_index_date_pad + pre_index_date_af + pre_index_date_revasc + pre_index_date_qof_diabetes + pre_index_date_anxiety_disorders+ pre_index_date_fh_diabetes +
                      pre_index_date_fh_premature_cvd + pre_index_date_pulmonary_embolism + pre_index_date_deep_vein_thrombosis + pre_index_date_haem_cancer + pre_index_date_solid_cancer +
                      pre_index_date_hearing_loss + VTE + ethnicity + comorbidity_hypertension + Survival_time + totalcholesterol, data = FullData,
                    method = "nearest", distance = "glm", link = "logit", replace = TRUE, caliper = 0.05, ratio = 5)
  print(summary(m.out2, un = FALSE))
  
 
  pdf(paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResultsUpdatedAlgorithm_Censored/plot_", year, ".pdf"), width = 10, height = 8) 

  plot(summary(m.out2), cex = 0.8) 
  dev.off()
  
  plot(summary(m.out2))
  
  summary_data <- summary(m.out2, un = FALSE)
  
  match.t <- get_matches(m.out2)
  write.table(match.t, file = paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResultsUpdatedAlgorithm_Censored/match_t_", year, ".txt"), sep = "\t", row.names = FALSE)
  # Save matched data to the list
  file_name <- paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResultsUpdatedAlgorithm_Censored/matched_data_iteration_", year, ".txt")
  
  # Write matched data to the file
  write.table(match.data(m.out2), file_name, sep = "\t", row.names = FALSE)
  
  matched_data_list[[as.character(year)]] <- match.data(m.out2)
  
  match.t$year <- year
  cumulative_matched_data <- rbind(cumulative_matched_data, match.t)
  
}



sink()
# Combine matched data frames into a single data frame
all_matched_data <- dplyr::bind_rows(matched_data_list, .id = "Year")

# Save the combined matched data to a txt file
write.table(all_matched_data, "C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResultsUpdatedAlgorithm_Censored/Joshua_all_matched_data.txt", sep = "\t", row.names = FALSE)

write.table(cumulative_matched_data, file = "C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResultsUpdatedAlgorithm_Censored/Joshua_cumulative_matched_data.txt",sep = "\t", row.names = FALSE)









