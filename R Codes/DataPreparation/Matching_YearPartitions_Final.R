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

dementia_cohort <- analysis$cached(name="final_dementia_after2004") %>%
  semi_join(cprd$tables$patidsWithLinkage, by = "patid")


risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("risperidone_prescriptions") %>%
  filter(issuedate >= "2004-01-01")

anti_psychotic <- anti_psychotic %>% analysis$cached("Other_Antipsychotic_Prescriptions") 



R_after_diagnosis <- analysis$cached(name="final_risperidone_afterdiagnosis_cohort_2004") %>%
  semi_join(cprd$tables$patidsWithLinkage, by = "patid") 

variables = c("patid","consid", "obsdate", "sex","yob","mob","regstartdate","earliest_obsdate", "regenddate","cprd_ddate", "lcd","region", "diagnosedbefore", "died","gender_decode","dob", "date_of_birth", "age_diagnosis","Diff_start_endOfFollowup","endoffollowup", "age_category", "year_of_diagnosis", "YrOfDiag_cat","risperidone", "other_drug_issuedate", "year_of_diagnosis", "issuedate", "three_months_after_other_psychotic", "Prescribed_other_antipsychotic_Prior", "age_risperidone")


# Create an empty list to store matched data frames
matched_data_list <- list()
cumulative_matched_data <- data.frame()
sink("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_2/summary_output.txt", append = TRUE)



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
      age_risperidone = floor(as.numeric(as.Date(issuedate) - as.Date(date_of_birth))/365.25)
    )
  
    
    
    
    
    
    
  
  ###### Control group Processing #######################
  # diagnosed of dementia before 01/01/year
  # Registered with GP before 01/01/year
  # Still active beyond 01/01/year: death, lcd and regenddate > 01/01/year ---- this part is implemented two blocks below because pmin doesn't work when the data is on the server.
  # I implement it after after collecting the data
  subsetData <- dementia_cohort %>%
    filter((earliest_obsdate < paste0(year, "-01-01")) & 
             (regstartdate < paste0(year, "-01-01")))
  # & 
  #   (pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE) > paste0(year, "-01-01"))) 
  
  
  # Not prescribed risperidone before 31/12/year
  ControlPartition_risp <- subsetData %>%
    left_join(risperidone_prescriptions %>% select(patid, issuedate), by = "patid") %>%
    filter(is.na(issuedate) | issuedate > paste0(year, "-12-31"))%>%
    distinct(patid, .keep_all = TRUE)
  
  
  
  
  
  
  ControlPartition_other_antiP <- ControlPartition_risp %>%
    left_join(anti_psychotic %>% select(patid, issuedate, drug_name), by = "patid") %>%
    rename(other_drug_issuedate = issuedate.y) %>% 
    filter(pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE) > paste0(year, "-01-01"))%>%
    collect() %>%
        mutate(
      issuedate = as.Date(replicate(n(), sample(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-12-31")), by = "day"), 1))), # generating the dates
      three_months_after_other_psychotic = as.Date(ifelse(!is.na(other_drug_issuedate), other_drug_issuedate + 90, NA))
    )  %>%
    
    rowwise() %>%
    mutate(
      pminDateTemp = pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE),
      issuedate = if_else(     # if the date is after pminDateTemp, regenerate it to be between the beginning of the year and pminDateTemp
        issuedate > pminDateTemp,
        sample(seq(as.Date(paste0(year, "-01-01")), pminDateTemp, by = "day"), 1),
        issuedate
      )
    ) %>%
    filter(
      is.na(other_drug_issuedate)| (other_drug_issuedate > issuedate | issuedate > three_months_after_other_psychotic | drug_name %in% c("prochlorperazine"))
    ) %>%
    group_by(patid) %>%
    slice_min(order_by = issuedate)%>%
    distinct(patid, .keep_all = TRUE) %>%
    mutate(risperidone = 0,
           Prescribed_other_antipsychotic_Prior = as.numeric(!is.na(other_drug_issuedate) & (other_drug_issuedate < issuedate)),
           period_before_prescription = as.numeric((issuedate - earliest_obsdate)/365.25),
           sex = case_when(
             gender == 1 ~ 1,
             gender == 2 ~ 0,
           ),
           age_risperidone = floor(as.numeric(issuedate - date_of_birth)/365.25))
  

  # Select control variables
  selected_control <- ControlPartition_other_antiP %>%
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
    
    print(paste("working out pre- and post-obsdate date code occurrences for", i, " for year: ", year))
    
    comod <- paste0("raw_", i, "_medcodes")
    comorbids_data <- comorbids_data %>% analysis_allPatid$cached(name = comod)
    comorbids_partition <- comorbids_data 
    
    # common_patids <- semi_join(comorbids_partition, dementia_cohort, by = "patid") 
    pre_index_date_earliest_date_variable <- paste0("pre_index_date_earliest_", i)
    pre_index_date_latest_date_variable <- paste0("pre_index_date_latest_", i)
    post_index_date_date_variable <- paste0("post_index_date_first_", i)
    comod <- paste0("raw_", i, "_medcodes")
    obsdate_var <- paste0("obsdate_", tolower(i))
    if (tolower(i) == "stroke") {
      combined_data <- combined_data %>%
        left_join(comorbids_partition %>% 
                    filter(!is.na(obsdate)) %>%
                    select(patid, stroke_cat, obsdate) %>%
                    group_by(patid) %>%
                    ungroup() %>%
                    collect(), 
                  by = "patid", relationship = "many-to-many") %>%
        mutate(!!paste0("obsdate_", tolower(i)) := obsdate.y, obsdate = obsdate.x) %>%
        select(-obsdate.y, -obsdate.x) %>%
        mutate(!!paste0("comorbidity_", tolower(i)) := ifelse(!is.na(!!sym(obsdate_var)), 1, 0))
      
      pre_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) <= issuedate) %>%
        group_by(patid) %>%
        summarise(
          pre_index_date_earliest_date_variable = min(!!sym(obsdate_var), na.rm = TRUE),
          pre_index_date_latest_date_variable = max(!!sym(obsdate_var), na.rm = TRUE)
        ) %>%
        ungroup()
      
      post_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) > issuedate) %>%
        group_by(patid) %>%
        summarise(post_index_date_date_variable = min(!!sym(obsdate_var), na.rm = TRUE)) %>%
        ungroup()
      
      combined_data <- combined_data %>%
        left_join(pre_index_date, by = "patid") %>%
        mutate(
          !!paste0("pre_index_date_", tolower(i)) := as.numeric(!is.na(pre_index_date_earliest_date_variable)),
        ) %>%
        left_join(post_index_date, by = "patid") %>%
        mutate(
          !!paste0("post_index_date_", tolower(i)) := as.numeric(!is.na(post_index_date_date_variable)),
          !!paste0("post_index_date_first_", tolower(i)) := post_index_date_date_variable
          
        )%>%
        distinct(patid, .keep_all = TRUE) %>%
        select(-pre_index_date_earliest_date_variable,-pre_index_date_latest_date_variable, -post_index_date_date_variable)
    }
    
    
    else {
      combined_data <- combined_data %>%
        left_join(comorbids_partition %>% 
                    filter(!is.na(obsdate)) %>%
                    select(patid, obsdate) %>%
                    group_by(patid) %>%
                    ungroup() %>%
                    collect(), 
                  by = "patid", relationship = "many-to-many") %>%
        mutate(!!paste0("obsdate_", tolower(i)) := obsdate.y, obsdate = obsdate.x) %>%
        select(-obsdate.y, -obsdate.x) %>%
        mutate(!!paste0("comorbidity_", tolower(i)) := ifelse(!is.na(!!sym(obsdate_var)), 1, 0))
      
      pre_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) <= issuedate) %>%
        group_by(patid) %>%
        summarise(
          pre_index_date_earliest_date_variable = min(!!sym(obsdate_var), na.rm = TRUE),
          pre_index_date_latest_date_variable = max(!!sym(obsdate_var), na.rm = TRUE)
        ) %>%
        ungroup()
      
      post_index_date <- combined_data %>%
        filter(!!sym(obsdate_var) > issuedate) %>%
        group_by(patid) %>%
        summarise(post_index_date_date_variable = min(!!sym(obsdate_var), na.rm = TRUE)) %>%
        ungroup()
      
      combined_data <- combined_data %>%
        left_join(pre_index_date, by = "patid") %>%
        mutate(
          !!paste0("pre_index_date_", tolower(i)) := as.numeric(!is.na(pre_index_date_earliest_date_variable)),
        ) %>%
        left_join(post_index_date, by = "patid") %>%
        mutate(
          !!paste0("post_index_date_", tolower(i)) := as.numeric(!is.na(post_index_date_date_variable)),
          !!paste0("post_index_date_first_", tolower(i)) := post_index_date_date_variable
        )%>%
        distinct(patid, .keep_all = TRUE) %>%
        select(-pre_index_date_earliest_date_variable,-pre_index_date_latest_date_variable, -post_index_date_date_variable)
    }
    
  }
  
  
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
      Survival_time = ifelse(is.na(post_index_date_first_stroke),
                             (as.numeric(pmin(cprd_ddate, lcd, regenddate,na.rm = TRUE) - issuedate) / 365.25),
                             (as.numeric(post_index_date_first_stroke - issuedate) / 365.25)),
      
      obsdate_hypertension =  pmin(date_dbp, date_sbp) ,
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
  
  
  m.out2 <- matchit(risperidone ~ + sex + age_risperidone +pre_index_date_angina + pre_index_date_heartfailure + BMI + Prescribed_other_antipsychotic_Prior  + period_before_prescription  + pre_index_date_myocardialinfarction + pre_index_date_stroke +
                      pre_index_date_tia + pre_index_date_falls +pre_index_date_lowerlimbfracture + pre_index_date_ihd + pre_index_date_pad + pre_index_date_af + pre_index_date_revasc + pre_index_date_qof_diabetes + pre_index_date_anxiety_disorders+ pre_index_date_fh_diabetes +
                      pre_index_date_fh_premature_cvd + pre_index_date_pulmonary_embolism + pre_index_date_deep_vein_thrombosis +
                      pre_index_date_hearing_loss + VTE + gp_5cat_ethnicity + comorbidity_hypertension + Survival_time + totalcholesterol, data = FullData,
                    method = "nearest", distance = "glm", link = "logit", replace = TRUE, caliper = 0.05, ratio = 5)
  print(summary(m.out2, un = FALSE))
  
 
  pdf(paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_2/plot_", year, ".pdf"), width = 10, height = 8) 

  plot(summary(m.out2), cex = 0.8) 
  dev.off()
  
  plot(summary(m.out2))
  
  summary_data <- summary(m.out2, un = FALSE)
  
  match.t <- get_matches(m.out2)
  write.table(match.t, file = paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_2/match_t_", year, ".txt"), sep = "\t", row.names = FALSE)
  # Save matched data to the list
  file_name <- paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_2/matched_data_iteration_", year, ".txt")
  
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
write.table(all_matched_data, "C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_2/Joshua_all_matched_data.txt", sep = "\t", row.names = FALSE)

write.table(cumulative_matched_data, file = "C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_2/Joshua_cumulative_matched_data.txt",sep = "\t", row.names = FALSE)









