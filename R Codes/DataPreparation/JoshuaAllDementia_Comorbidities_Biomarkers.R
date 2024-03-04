# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")



dementia_cohort <- dementia_cohort %>% analysis$cached("final_dementia_dementia_patients_cohort")
# table %>% count()    ##### n = 301405







#######################################################################################################################################
#######################################################################################################################################
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


analysis = cprd$analysis("all_patid")

analysis_Josh = cprd$analysis("Joshua")

for (i in comorbids) {
  
  print(paste("working out pre- and post-obsdate date code occurrences for", i))
  
  pre_obsdate_date_earliest_date_variable <- paste0("pre_obsdate_date_earliest_", i)
  pre_obsdate_date_latest_date_variable <- paste0("pre_obsdate_date_latest_", i)
  post_obsdate_date_date_variable <- paste0("post_obsdate_date_first_", i)
  comod <- paste0("raw_", i, "_medcodes")
  obsdate_var <- paste0("obsdate_", tolower(i))
  
  print(comod)
  
  comorbids_data <- comorbids_data %>% analysis$cached(name = comod)
  comorbids_data %>% count()
  print(head(comorbids_data))
  
  if (tolower(i) == "stroke") {
    result <- dementia_cohort %>%
      left_join(
        comorbids_data %>% 
          filter(!is.na(obsdate)) %>%
          select(patid, stroke_cat, obsdate), by = "patid") %>%
      mutate(!!paste0("obsdate_", tolower(i)) := obsdate.y, obsdate = obsdate.x) %>%
      select(-obsdate.y, -obsdate.x) %>%
      mutate(!!paste0("comorbidity_", tolower(i)) := ifelse(!is.na(!!sym(obsdate_var)), 1, 0))
    
    pre_obsdate_date <- result %>%
      filter(!!sym(obsdate_var) < obsdate) %>%
      group_by(patid) %>%
      summarise(
        pre_obsdate_date_earliest_date_variable = min(!!sym(obsdate_var), na.rm = TRUE),
        pre_obsdate_date_latest_date_variable = max(!!sym(obsdate_var), na.rm = TRUE)
      ) %>%
      ungroup()
    
    post_obsdate_date <- result %>%
      filter(!!sym(obsdate_var) > obsdate) %>%
      group_by(patid) %>%
      summarise(post_obsdate_date_date_variable = min(!!sym(obsdate_var), na.rm = TRUE)) %>%
      ungroup()
    
    
    
    
    finalResults <- result %>%
      left_join(pre_obsdate_date, by = "patid") %>%
      mutate(
        !!paste0("pre_obsdate_date_", tolower(i)) := !is.na(pre_obsdate_date_earliest_date_variable),
        !!paste0("pre_obsdate_date_earliest_", tolower(i)) := pre_obsdate_date_earliest_date_variable
      ) %>%
      left_join(post_obsdate_date, by = "patid") %>%
      mutate(
        !!paste0("post_obsdate_date_", tolower(i)) := !is.na(post_obsdate_date_date_variable),
        !!paste0("post_obsdate_date_first_", tolower(i)) := post_obsdate_date_date_variable
      ) %>%
      distinct(patid, .keep_all = TRUE) %>%
      select(
        "patid",
        paste0("obsdate_", tolower(i)),
        paste0("comorbidity_", tolower(i)),
        paste0("pre_obsdate_date_", tolower(i)),
        paste0("pre_obsdate_date_earliest_", tolower(i)),
        paste0("post_obsdate_date_", tolower(i)),
        paste0("post_obsdate_date_first_", tolower(i)),
        stroke_cat 
      )%>%     
      analysis_Josh$cached(paste0("dementia_cohort_comorbids_", tolower(i)), unique_indexes="patid")
    
  } 
  
  else {
    result <- dementia_cohort %>%
      left_join(
        comorbids_data %>% 
          filter(!is.na(obsdate)) %>%
          select(patid, obsdate), by = "patid") %>%
      mutate(!!paste0("obsdate_", tolower(i)) := obsdate.y, obsdate = obsdate.x) %>%
      select(-obsdate.y, -obsdate.x) %>%
      mutate(!!paste0("comorbidity_", tolower(i)) := ifelse(!is.na(!!sym(obsdate_var)), 1, 0))
    
    pre_obsdate_date <- result %>%
      filter(!!sym(obsdate_var) < obsdate) %>%
      group_by(patid) %>%
      summarise(
        pre_obsdate_date_earliest_date_variable = min(!!sym(obsdate_var), na.rm = TRUE),
        pre_obsdate_date_latest_date_variable = max(!!sym(obsdate_var), na.rm = TRUE)
      ) %>%
      ungroup()
    
    post_obsdate_date <- result %>%
      filter(!!sym(obsdate_var) > obsdate) %>%
      group_by(patid) %>%
      summarise(post_obsdate_date_date_variable = min(!!sym(obsdate_var), na.rm = TRUE)) %>%
      ungroup()
    
    finalResults <- result %>%
      left_join(pre_obsdate_date, by="patid") %>%
      mutate(
        !!paste0("pre_obsdate_date_", tolower(i)) := !is.na(pre_obsdate_date_earliest_date_variable)) %>%
      left_join(post_obsdate_date, by="patid") %>%
      mutate(
        !!paste0("post_obsdate_date_", tolower(i)) := !is.na(post_obsdate_date_date_variable)) %>%
      distinct(patid, .keep_all = TRUE) %>%
      select("patid", paste0("obsdate_", tolower(i)), paste0("comorbidity_", tolower(i)), paste0("pre_obsdate_date_", tolower(i)), paste0("post_obsdate_date_", tolower(i)))%>%    
      analysis_Josh$cached(paste0("dementia_cohort_comorbids_", tolower(i)), unique_indexes="patid")
  }
  finalResults %>% count()
  finalResults <- finalResults %>% collect()
  print(finalResults)
}


View(finalResults)
########################################################################################################################################################
######################################Biomarkers#####################################################################################
library(EHRBiomarkr)
# Define biomarkers
## Keep HbA1c separate as processed differently
## If you add biomarker to the end of this list, code should run fine to incorporate new biomarker, as long as you delete final 'baseline_biomarkers' table

biomarkers <- c(
  "weight",
  "height",
  "bmi",
  "totalcholesterol",
  "dbp",
  "sbp"
)


# Pull out all raw biomarker values and cache

analysis = cprd$analysis("all_patid")

for (i in biomarkers) {
  
  print(i)
  
  
  testvalue_variable <- paste0("testvalue_", i)
  date_variable <- paste0("date_", i)
  missing_variable <- paste0("missing_", i)
  
  clean_tablename <- paste0("clean_", i, "_medcodes")
  biomarkers_data <- biomarkers_data %>% analysis$cached(name = clean_tablename)
  print(nrow(biomarkers_data))
  print(nrow(dementia_cohort %>% collect()))
  print(nrow(biomarkers_data %>% collect()))
  
  
  result_table <- dementia_cohort %>% 
    left_join(biomarkers_data, by = "patid") %>% 
    group_by(patid) %>% 
    mutate(
      # !!missing_variable := is.na(date), 
      !!date_variable := date, 
      !!testvalue_variable := ifelse(!is.na(testvalue.y), testvalue.y, NA)) %>% 
    filter(date <= issuedate) %>% 
    filter(date == max(date, na.rm = TRUE)) %>% 
    select(patid, !!date_variable, !!testvalue_variable)%>%    
    analysis_Josh$cached(paste0("dementia_cohort_biomarker_", tolower(i)), unique_indexes="patid")

  
}



############################################################################################################################################## Alcohol #####################################################
analysis = cprd$analysis("Joshua")

raw_alcohol_medcodes <- raw_alcohol_medcodes %>% analysis$cached("dementia_dementia_alcohol_levels") #### 1,036,735 
# View(raw_alcohol_medcodes)

index_dates <- dementia_cohort %>%
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
           alcohol_cat_numeric==0 ~ "None",
           alcohol_cat_numeric==1 ~ "Within limits",
           alcohol_cat_numeric==2 ~ "Excess",
           alcohol_cat_numeric==3 ~ "Harmful"
         )) %>%
  select(patid, alcohol_cat)%>%
  distinct(patid, .keep_all = TRUE)

# View(alcohol_cat)

# 
# unique_patids <- n_distinct(alcohol_cat$patid)
# print(unique_patids)



# duplicated_rows <- alcohol_cat[duplicated(alcohol_cat$patid) | duplicated(alcohol_cat$patid, fromLast = TRUE), ]

# View(duplicated_rows)

dementia_cohort <- dementia_cohort %>%
  left_join(alcohol_cat, by="patid") %>%
  analysis_Josh$cached("dementia_cohort_alcohol", unique_indexes="patid")


