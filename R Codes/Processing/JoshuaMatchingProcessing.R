# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
library(MatchIt)

cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")

set.seed(123) 

table <- table %>% analysis$cached("final_dementia_dementia_patients_cohort") 
table %>% count()    ##### n = 301405

risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("Risperidone_Prescriptions")
risperidone_prescriptions %>% count()    ##### n = 7621968


anti_psychotic <- anti_psychotic %>% analysis$cached("Other_Antipsychotic_Prescriptions") %>%
filter(drug_name != "prochlorperazine")
anti_psychotic %>% count()    ##### n = 59,081,585


R_after_12Months <- R_after_12Months %>% analysis$cached("risperidone_after_dementiaDiagnoses") 
R_after_12Months %>% count()    ##### n = 22252

TreatmentGroup <- R_after_12Months %>%
  select(-drug_name) %>%
  filter(((issuedate) >= "2004-01-01") & ((issuedate) <= "2004-12-31")) %>%
  left_join(anti_psychotic %>% select(patid, issuedate, drug_name), by = "patid") %>%
  collect() %>%
  mutate(
    other_drug_issuedate_180Days_later = as.Date(ifelse(!is.na(issuedate.y), issuedate.y + 180, NA))
  ) %>%
  filter(
    is.na(issuedate.y) |
      (issuedate.y <= issuedate.x & issuedate.x <= other_drug_issuedate_180Days_later & drug_name %in% c("quetiapine"))|
      (issuedate.x - issuedate.y) > 180)%>%
  rename(issuedate = issuedate.x, other_drug_issuedate = issuedate.y) %>%
   group_by(patid) %>%
   slice_min(order_by = issuedate)%>%
  distinct(patid, .keep_all = TRUE) %>%
  mutate(
    risperidone = 1,
    Prescribed_other_antipsychotic_Prior = as.numeric(!is.na(other_drug_issuedate) & other_drug_issuedate < issuedate))
    



subsetData <- table %>%
  filter((obsdate < "2004-01-01") & 
           (regstartdate < "2004-01-01") & 
           (pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE) > "2004-01-01")) 

subsetData %>% count()
# View(subsetData %>% collect())


ControlPartition_risp <- subsetData %>%
  left_join(risperidone_prescriptions %>% select(patid, issuedate), by = "patid") %>%
  filter(is.na(issuedate) | issuedate > "2004-12-31")%>%
  distinct(patid, .keep_all = TRUE)


ControlPartition_risp %>% count()
# View(ControlPartition_risp %>% collect())





ControlPartition_other_antiP <- ControlPartition_risp %>%
  left_join(anti_psychotic %>% select(patid, issuedate, drug_name), by = "patid") %>%
  filter(!(!is.na(issuedate.y) & issuedate.y > "2004-12-31")) %>%
  collect() %>%
  mutate(
    issuedate = as.Date(replicate(n(), sample(seq(as.Date("2004-01-01"), as.Date("2004-12-31"), by = "day"), 1))),
    other_drug_issuedate_180Days_later = as.Date(ifelse(!is.na(issuedate.y), issuedate.y + 180, NA))
  ) %>%
  filter(
         is.na(issuedate.y) | 
           (issuedate.y <= issuedate & issuedate <= other_drug_issuedate_180Days_later & drug_name %in% c("quetiapine"))| 
           (issuedate - issuedate.y) > 180)%>%
  rename(other_drug_issuedate = issuedate.y) %>%
  
  group_by(patid) %>%
  slice_min(order_by = issuedate)%>%
  distinct(patid, .keep_all = TRUE) %>%
  mutate(risperidone = 0,
         Prescribed_other_antipsychotic_Prior = as.numeric(!is.na(other_drug_issuedate) & other_drug_issuedate < issuedate))






# View(ControlPartition_other_antiP %>% select(issuedate, other_drug_issuedate, drug_name, obsdate, other_drug_issuedate_180Days_later))


variables = c("patid","consid", "obsdate", "gender","yob","mob","regstartdate", "regenddate","cprd_ddate", "lcd","region", "ethnicity_5cat","ethnicity_16cat", "ethnicity_qrisk2","missing_ethnicity", "diagnosedbefore", "died","gender_decode","dob", "date_of_birth", "age_diagnosis","Diff_start_endOfFollowup","endoffollowup", "age_category", "year_of_diagnosis", "YrOfDiag_cat","risperidone", "other_drug_issuedate", "year_of_diagnosis", "issuedate", "other_drug_issuedate_180Days_later", "Prescribed_other_antipsychotic_Prior")




selected_control <- ControlPartition_other_antiP %>%
  select(all_of(variables))



selected_treatment <- TreatmentGroup %>%
  select(all_of(variables))

# View(selected_control)
# View(selected_treatment)

combined_data_pre <- rbind(selected_control, selected_treatment)
View(combined_data_pre)


combined_data <- rbind(selected_control, selected_treatment)
# View(combined_data)



# Check for duplicates in combined_data_pre
duplicates_combined_data_pre <- TreatmentGroup[duplicated(TreatmentGroup), ]

# Display the duplicates (if any)
View(duplicates_combined_data_pre)




comorbids <- c(
   "angina",
   "heartfailure",
   "hypertension",
   "myocardialinfarction",
   "stroke",
   "tia",  #transient ischaemic attack
   "falls",
   "lowerlimbfracture",
   "ihd",
   "pad",
   "af",
   "revasc",
   "diabetes"
)



analysis_allPatid = cprd$analysis("all_patid")

for (i in comorbids) {
  
  print(paste("working out pre- and post-obsdate date code occurrences for", i))
  
  comod <- paste0("raw_", i, "_medcodes")
  print(comod)
  comorbids_data <- comorbids_data %>% analysis_allPatid$cached(name = comod)
  comorbids_partition <- comorbids_data %>% filter(obsdate <= "2004-12-31")
  
  common_patids <- semi_join(comorbids_partition, table, by = "patid") 
  print(common_patids)
  
  print("almost there")
  pre_index_date_earliest_date_variable <- paste0("pre_index_date_earliest_", i)
  pre_index_date_latest_date_variable <- paste0("pre_index_date_latest_", i)
  post_index_date_date_variable <- paste0("post_index_date_first_", i)
  comod <- paste0("raw_", i, "_medcodes")
  obsdate_var <- paste0("obsdate_", tolower(i))
  if (tolower(i) == "stroke") {
    combined_data <- combined_data %>%
      left_join(common_patids %>% 
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
        # !!paste0("pre_index_date_earliest_", tolower(i)) := pre_index_date_earliest_date_variable
      ) %>%
      left_join(post_index_date, by = "patid") %>%
      mutate(
        !!paste0("post_index_date_", tolower(i)) := as.numeric(!is.na(post_index_date_date_variable)),
        # !!paste0("post_index_date_first_", tolower(i)) := post_index_date_date_variable
      )%>%
     distinct(patid, .keep_all = TRUE) %>%
      select(-pre_index_date_earliest_date_variable,-pre_index_date_latest_date_variable, -post_index_date_date_variable)
  }

  
  
  else {
    combined_data <- combined_data %>%
      left_join(common_patids %>% 
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
        # !!paste0("pre_index_date_earliest_", tolower(i)) := pre_index_date_earliest_date_variable
      ) %>%
      left_join(post_index_date, by = "patid") %>%
      mutate(
        !!paste0("post_index_date_", tolower(i)) := as.numeric(!is.na(post_index_date_date_variable)),
        # !!paste0("post_index_date_first_", tolower(i)) := post_index_date_date_variable
      )%>%
      distinct(patid, .keep_all = TRUE) %>%
      select(-pre_index_date_earliest_date_variable,-pre_index_date_latest_date_variable, -post_index_date_date_variable)
  }
  
}
# View(comorbids_data %>% collect())
  # combined_data %>% count()
  View(combined_data)
  
  
  
  
  # Check for duplicates in combined_data_pre
  duplicates_combined_data <- combined_data[duplicated(combined_data), ]
  
  # Display the duplicates (if any)
  View(duplicates_combined_data)
  
  
  ########################################################################################################################################################
  ###################################### Biomarkers#######################################################################################################
  library(EHRBiomarkr)
  # Define biomarkers
  ## Keep HbA1c separate as processed differently
  ## If you add biomarker to the end of this list, code should run fine to incorporate new biomarker, as long as you delete final 'baseline_biomarkers' table
  
  biomarkers <- c(
    # "weight",
    # "height",
    "bmi"
    # "totalcholesterol",
    # "dbp",
    # "sbp"
  )
  FullData <- combined_data
  
  # Pull out all raw biomarker values and cache
  
  analysis = cprd$analysis("all_patid")
  
  for (i in biomarkers) {
    

    
    testvalue_variable <- paste0("testvalue_", i)
    date_variable <- paste0("date_", i)
    missing_variable <- paste0("missing_", i)
    
    clean_tablename <- paste0("clean_", i, "_medcodes")
    biomarkers_data <- biomarkers_data %>% analysis$cached(name = clean_tablename)
    biomarkers_partition <- biomarkers_data %>% filter(date <= "2004-12-31")
    
    common_patids <- semi_join(biomarkers_partition, table, by = "patid") %>% collect()
    print(common_patids)
    
  
    latest_bio <- common_patids %>%
      left_join(FullData, by = "patid") %>%
      filter(date <= issuedate) %>%
      group_by(patid) %>%
      filter(date == max(date, na.rm = TRUE)) %>%
      ungroup() %>%
      select(patid, date, testvalue) %>%
      rename(!!date_variable := date, !!testvalue_variable := testvalue)
    
    
    
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
      )
    )
  
  View(FullData)
  
  TempData <- FullData %>%
    filter(is.na(BMI))
  View(TempData)
  
  
  
  
  ############################################################################################################################################## Alcohol #####################################################
  analysis = cprd$analysis("Joshua")
  
  raw_alcohol_medcodes <- raw_alcohol_medcodes %>% analysis$cached("dementia_dementia_alcohol_levels") %>% filter(obsdate_alcohol < "2004-12-31") %>% collect()   #### 1,036,735 
  # View(raw_alcohol_medcodes)
  
  index_dates <- FullData %>%
    select(patid, obsdate, date_of_birth, lcd, cprd_ddate, regenddate)
  
  
  
  pre_index_date_alcohol_codes <- index_dates %>%
    inner_join(raw_alcohol_medcodes, by = "patid") %>%
    filter(
      (date_of_birth < obsdate_alcohol | obsdate_alcohol < lcd | obsdate_alcohol < cprd_ddate | obsdate_alcohol <= regenddate) &
        (as.numeric(obsdate_alcohol - obsdate) / 365.25) <= 7
    )%>% select(patid, alcohol_cat, obsdate_alcohol)
  
  
  # View(pre_index_date_alcohol_codes)
  
  
  
  ## Find if ever previously a 'harmful' drinker (category 3)
  harmful_drinker_ever <- pre_index_date_alcohol_codes %>%
    filter(alcohol_cat=="AlcoholConsumptionLevel3") %>%
    distinct(patid) %>%
    mutate(harmful_drinker_ever=1L)
  # View(harmful_drinker_ever)
  
  
  ## Find most recent code
  ### If different categories on same day, use highest
  most_recent_code <- pre_index_date_alcohol_codes %>%
    mutate(alcohol_cat_numeric = ifelse(alcohol_cat=="AlcoholConsumptionLevel0", 0L,
                                        ifelse(alcohol_cat=="AlcoholConsumptionLevel1", 1L,
                                               ifelse(alcohol_cat=="AlcoholConsumptionLevel2", 2L,
                                                      ifelse(alcohol_cat=="AlcoholConsumptionLevel3", 3L, NA))))) %>%
    group_by(patid) %>%
    filter(obsdate_alcohol==max(obsdate_alcohol, na.rm=TRUE)) %>%
    filter(alcohol_cat_numeric==max(alcohol_cat_numeric, na.rm=TRUE)) %>%
    ungroup() 
  # View(most_recent_code)
  
  
  
  
  
  ## Pull together
  alcohol_cat <- index_dates %>%
    left_join(harmful_drinker_ever, by="patid") %>%
    left_join(most_recent_code, by="patid") %>%
    mutate(alcohol_cat_numeric=ifelse(!is.na(harmful_drinker_ever) & harmful_drinker_ever==1, 3L, alcohol_cat_numeric),
           
           alcohol_cat=case_when(
             is.na(alcohol_cat_numeric) ~ "Missing",
             alcohol_cat_numeric==0 ~ "None",
             alcohol_cat_numeric==1 ~ "Within limits",
             alcohol_cat_numeric==2 ~ "Excess",
             alcohol_cat_numeric==3 ~ "Harmful"
           )) %>%
    select(patid, alcohol_cat)%>%
    distinct(patid, .keep_all = TRUE)
  
  # View(alcohol_cat)
  
  
  unique_patids <- n_distinct(alcohol_cat$patid)
  print(unique_patids)
  
  
  
  duplicated_rows <- alcohol_cat[duplicated(alcohol_cat$patid) | duplicated(alcohol_cat$patid, fromLast = TRUE), ]
  
  # View(duplicated_rows)
  
  FullData <- FullData %>%
    left_join(alcohol_cat, by="patid")
  
  
  
  ############################################################################################################################################## Prescriptions  #####################################################
  
  
################################# Matching #########################################
  
m.out2 <- matchit(risperidone ~ + gender + age_diagnosis +comorbidity_angina + comorbidity_heartfailure + comorbidity_hypertension + comorbidity_myocardialinfarction + comorbidity_stroke + comorbidity_tia + comorbidity_falls + comorbidity_lowerlimbfracture + comorbidity_ihd + comorbidity_pad + comorbidity_af + comorbidity_revasc+ comorbidity_diabetes + BMI + Prescribed_other_antipsychotic_Prior + alcohol_cat, data = FullData,
                  method = "nearest", distance = "glm", link = "probit", replace = TRUE, caliper = 0.05, ratio = 5)
m.out2



summary(m.out2, un = FALSE)



plot(summary(m.out2))

# Assuming m.out2 is the matchit object
matched_data <- match.data(m.out2)

# Save the matched data to a CSV file
# write.csv(matched_data, "matched_data.csv", row.names = FALSE)

# View the matched data
View(matched_data)

