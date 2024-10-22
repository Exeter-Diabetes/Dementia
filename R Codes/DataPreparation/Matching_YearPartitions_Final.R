# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
library(MatchIt)


cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")



# 
# This is the script we used to create the matched control
# 
# - The script reads data from the following tables:
#   * Final dementia incident cohort (**final_dementia_cohortLinkedData**) this will be used to create the matched control patients
# * Risperidone prescriptions (**risperidone_prescriptions**)
# * Other antipsychotic prescriptions (**Other_Antipsychotic_Prescriptions**)
# * Final risperidone cohort (**final_risperidone_cohortLinkedData**)
# - Since the matching is done by calender year. We have partitioned the script to loop through the years, starting from 2004 upto 2023.
# - #### Treatment Group:
#   - Select patients prescribed risperidone in the current calendar year
# - Remove anyone who was prescribed any other antipsychotic other than prochlorperazine three months prior to risperidone prescription
# - Censor any patient in the treatment group that gets prescribed other antipsychotic within a year of follow up after risperidone prescription
# 
# - #### Control Group:
#   - Select patients who were first diagnosed (earliest date of diagnosis) and registered before the begining of the current calendar year
# - The patients in this group must not have had risperidone prescription before the end of the current calendar year. (**NB: patients in the control group might be prescribed risperidone at some later stage**)
# - Randomly generate index dates for this group since they don't have a prescription date
#      - Remove those who were prescribed other antipsychotics other than prochlorperazine three months before the generated date
#      - If these patients get prescribed risperidone within a year of follow up, mark their prescription date as their end of follow up. Suppose we are in 2004 and our follow up starts on September 24 and this patient gets prescribed risperidone in March of 2005. We then censor this patient
#      - Also censor those prescrbed any other antipsychotic within the follow up period
#        
# - Then the two groups are combined to form one table which is used to process:
#    - CPRD Comorbidities (**pre index and post index**)
#    - HES stroke data (**pre index and post index**)
#    - ONS stroke data (**stroke being primary cause of death**)
#    - Create a composite stroke variable
#    - Defined VTE from pulmonary_embolism or deep_vein_thrombosis)
#    - Processed the biomarkers
# - Matching variables
#   - Exact matching
#     - Sex
#     - History of stroke
#     - History of CVD
#     - Current age categorised (65 - 74, 75 - 84 and 85+ years)
#  
#   - Nearest neighbour matching
#      - Care home status before index date,
#      - deprivation,
#      - age at risperidone prescription,
#      - Angina,
#      - Cardiovascular disease (CVD),
#      - Venous thromboembolism (VTE),
#      - Heart failure,
#      - Body mass index (BMI),
#      - Prescribed other antipsychotic prior to index date,
#      - Disease duration before prescription,
#      - Myocardial infarction,
#      - Stroke,
#      - Transient ischemic attack (TIA),
#      - Falls,
#      - Lower limb fracture,
#      - Ischemic heart disease (IHD),
#      - Peripheral arterial disease (PAD),
#      - Atrial fibrillation (AF),
#      - Revascularization,
#      - Diabetes,
#      - Anxiety disorders,
#      - Family history of diabetes,
#      - Family history of premature cardiovascular disease (CVD),
#      - Pulmonary embolism,
#      - Deep vein thrombosis (DVT),
#      - Hematologic cancer,
#      - Solid cancer,
#      - Hearing loss,
#      - Ethnicity,
#      - Hypertension,
#      - Total cholesterol
# - The matching uses 1:5 (each risperidone user was matched with up to five people with dementia not prescribed risperidone ) ratio and it is done with replacement
# - Finally ran the matching algorithm to create the matched controls then move to the following calendar year









analysis = cprd$analysis("Joshua")

set.seed(123) 

dementia_cohort <- analysis$cached(name="final_dementia_cohortLinkedData") 

risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("risperidone_prescriptions") %>%
  filter(issuedate >= "2004-01-01")

anti_psychotic <- anti_psychotic %>% analysis$cached("Other_Antipsychotic_Prescriptions") 



R_after_diagnosis <- analysis$cached(name="final_risperidone_cohortLinkedData") #%>%

variables = c("patid","consid","censoringDate", "cause_of_death_stroke_type", "deprivation","earliest_other_antipsychotic_date_post_R_prescription", "obsdate", "death_composite_date", "R_issuedate","sex","regstartdate","earliest_obsdate", "regenddate","cprd_ddate", "lcd","region", "died", "gender_decode", "date_of_birth", "age_diagnosis","Diff_start_endOfFollowup","endoffollowup", "age_category", "year_of_diagnosis","risperidone", "other_drug_issuedate", "year_of_diagnosis", "issuedate", "three_months_after_other_psychotic", "Prescribed_other_antipsychotic_Prior", "age_risperidone", "ethnicity", "death_composite", "FollowUp")

# Create an empty list to store matched data frames
matched_data_list <- list()
cumulative_matched_data <- data.frame()
sink("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final_paperDraft/summary_output.txt", append = TRUE)



total_matched_count <- 0
total_unmatched_count <- 0

for (year in 2004:2023) {
  
  
  print(paste("Processing data for year", year))
  
  
  ###### Treatment group #################################
  # prescribed risperidone in current year
  # extra exclusion of anyone prescribed any other antipsychotic (excluding prochlorperazine) in the 90 days prior to Risperidone start date
  # 
  
  
  
  
  
  TreatmentGroup <- R_after_diagnosis %>%
    filter(issuedate >= paste0(year, "-01-01")& issuedate <= paste0(year, "-12-31")) %>%
    left_join(anti_psychotic %>% select(patid, issuedate, drug_name), by = "patid") %>%
    rename(
      other_drug_issuedate = issuedate.y,
      issuedate = issuedate.x,
      # drug_name = drug_name.y
    ) %>%
    # select(-drug_name.x) %>%
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
    #### censor patients who were prescribed other antipsychotic within a year of follow-up
    # This is done by looking at the earliest prescription of the other antipsychotic post risperidone initiation
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
      censoringDate = issuedate + 365,
      endoffollowup = as.Date(ifelse(
        !is.na(earliest_other_antipsychotic_date_post_R_prescription) & 
          earliest_other_antipsychotic_date_post_R_prescription <= censoringDate & 
          firstDrugPost_R_prescription != "prochlorperazine", 
        earliest_other_antipsychotic_date_post_R_prescription, 
        endoffollowup
      ))
    ) %>%
    distinct(patid, .keep_all = TRUE)
  
  
  
  
  
  
  
  
  ###### Control group Processing #######################
  # diagnosed of dementia before 01/01/year
  # Registered with GP before 01/01/year
  # Still active beyond 01/01/year: death, lcd and regenddate > 01/01/year 
  
  
  ControlGroup <- dementia_cohort %>%
    filter((earliest_obsdate < paste0(year, "-01-01")) & (regstartdate < paste0(year, "-01-01"))) %>%
    # read risperidone prescriptions. this is to ensure we exclude people prescribed risperidone in or before the current calendar year 
    left_join(risperidone_prescriptions %>% 
                select(patid, issuedate) %>%
                filter(is.na(issuedate) | issuedate > paste0(year, "-12-31")) %>% 
                rename(R_issuedate = issuedate),
              by = "patid") %>%
    #### Read other antipsychotic prescriptions, this will make sure we exclude those with prescriptions three months prior
    left_join(anti_psychotic %>% 
                select(patid, issuedate, drug_name) %>%
                rename(other_drug_issuedate = issuedate), 
              by = "patid") %>%
    
    collect() %>%
    #### Since the control group does not have index date. At this point we randomly generate the index date restricted to be within beginning and end of the current year
    mutate(
      issuedate = as.Date(replicate(n(), sample(seq(as.Date(paste0(year, "-01-01")), as.Date(paste0(year, "-12-31")), by = "day"), 1))),
      endoffollowup = as.Date(endoffollowup)  # Ensure endoffollowup is in Date format
    ) %>%
    #### Making sure if a patient gets prescribed risperidone (R_issuedate) that this happens after the generated date but before end of follow up (min(lcd, death, regend))
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
  ###### update end of follow up if a patient is prescribed risperidone after the generated date
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
    
    filter(issuedate <= endoffollowup) %>%
    
    #### censoring prescription of other antipsychotics within a year of follow up other than prochlorperazine
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
      censoringDate = issuedate + 365,
      endoffollowup = as.Date(ifelse(
        !is.na(earliest_other_antipsychotic_date_post_R_prescription) & 
          earliest_other_antipsychotic_date_post_R_prescription <= censoringDate & 
          firstDrugPost_R_prescription != "prochlorperazine", 
        earliest_other_antipsychotic_date_post_R_prescription, 
        endoffollowup
      ))
    ) %>%
    distinct(patid, .keep_all = TRUE)
  
 
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
  
  ### process the comorbidities, both  pre-index and post-index dates
  
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
  
  #### integrate the HES data
  
  HES_strokeData <- HES_strokeData %>% analysis$cached("clean_stroke_icd10") %>%
    select(patid, epistart, ICD) %>%
    rename(stroke_epistart = epistart ) %>%
    left_join(analysis$cached(name = "clean_haemorrhagicstroke_icd10") %>% select(patid, epistart)%>%
                rename(HES_haemorrhagic_epistart = epistart ), by = "patid")%>%
    left_join(analysis$cached(name = "clean_ischaemicstroke_icd10") %>% select(patid, epistart)%>%
                rename(HES_ischaemics_epistart = epistart ), by = "patid") %>%
    collect()
  
 
  
  result2 <- combined_data %>%
    left_join(HES_strokeData, by = "patid") %>%
    mutate(
      HES_Stroke = ifelse(!is.na(stroke_epistart), 1, 0),
      HES_haemorrhagic_Stroke = ifelse(!is.na(HES_haemorrhagic_epistart), 1, 0),
      HES_ischaemics_Stroke = ifelse(!is.na(HES_ischaemics_epistart), 1, 0),
      
    )
  
  pre_index_date <- result2 %>%
    filter(stroke_epistart <= issuedate) %>%
    group_by(patid) %>%
    summarise(
      HES_pre_index_date_earliest_stroke = min(stroke_epistart, na.rm = TRUE),
      HES_pre_index_date_latest_stroke = max(stroke_epistart, na.rm = TRUE),
      
      
      HES_pre_index_date_earliest_haemorrhagic = if_else(
        all(is.na(HES_haemorrhagic_epistart)), NA_Date_, min(HES_haemorrhagic_epistart, na.rm = TRUE)
      ),
      HES_pre_index_date_latest_haemorrhagic = if_else(
        all(is.na(HES_haemorrhagic_epistart)), NA_Date_, max(HES_haemorrhagic_epistart, na.rm = TRUE)
      ),
     
      HES_pre_index_date_earliest_ischaemics = if_else(
        all(is.na(HES_ischaemics_epistart)), NA_Date_, min(HES_ischaemics_epistart, na.rm = TRUE)
      ),
      HES_pre_index_date_latest_ischaemics = if_else(
        all(is.na(HES_ischaemics_epistart)), NA_Date_, max(HES_ischaemics_epistart, na.rm = TRUE)
      )
    ) %>%
    ungroup()
  
  post_index_date <- result2 %>%
    filter(stroke_epistart > issuedate) %>%
    group_by(patid) %>%
    summarise(
      HES_post_index_date_first_stroke = min(stroke_epistart, na.rm = TRUE),
      
      HES_post_index_date_first_haemorrhagic = if_else(
        all(is.na(HES_haemorrhagic_epistart)), NA_Date_, min(HES_haemorrhagic_epistart, na.rm = TRUE)
      ),
      
      HES_post_index_date_first_ischaemics = if_else(
        all(is.na(HES_ischaemics_epistart)), NA_Date_, min(HES_ischaemics_epistart, na.rm = TRUE)
      )
    ) %>%
    ungroup()
  
  
  combined_data <- result2 %>%
    left_join(pre_index_date, by = "patid") %>%
    mutate(
      HES_pre_index_date_stroke = ifelse(!is.na(HES_pre_index_date_earliest_stroke), 1, 0),
      HES_pre_index_date_haemorrhagic = ifelse(!is.na(HES_pre_index_date_earliest_haemorrhagic), 1, 0),
      HES_pre_index_date_ischaemics = ifelse(!is.na(HES_pre_index_date_earliest_ischaemics), 1, 0),
      
      HES_pre_index_stroke_type = case_when(
        !is.na(HES_pre_index_date_earliest_ischaemics) & 
          (is.na(HES_pre_index_date_earliest_haemorrhagic) | 
             HES_pre_index_date_earliest_ischaemics <= HES_pre_index_date_earliest_haemorrhagic) ~ "ischaemic",
        
        !is.na(HES_pre_index_date_earliest_haemorrhagic) & 
          (is.na(HES_pre_index_date_earliest_ischaemics) | 
             HES_pre_index_date_earliest_haemorrhagic < HES_pre_index_date_earliest_ischaemics) ~ "haemorrhagic",
        
        TRUE ~ NA_character_  
      ),
      
      HES_pre_index_stroke_type_date = pmin(
        HES_pre_index_date_earliest_ischaemics,
        HES_pre_index_date_earliest_haemorrhagic,
        na.rm = TRUE)
      
    ) %>%
    left_join(post_index_date, by = "patid") %>%
    mutate(
      HES_post_index_date_stroke = ifelse(!is.na(HES_post_index_date_first_stroke), 1, 0),
      HES_post_index_date_haemorrhagic = ifelse(!is.na(HES_post_index_date_first_haemorrhagic), 1, 0),
      HES_post_index_date_ischaemics = ifelse(!is.na(HES_post_index_date_first_ischaemics), 1, 0),
      
      HES_post_index_stroke_type = case_when(
        !is.na(HES_post_index_date_first_ischaemics) & 
          (is.na(HES_post_index_date_first_haemorrhagic) | 
             HES_post_index_date_first_ischaemics <= HES_post_index_date_first_haemorrhagic) ~ "ischaemic",
        
        !is.na(HES_post_index_date_first_haemorrhagic) & 
          (is.na(HES_post_index_date_first_ischaemics) | 
             HES_post_index_date_first_haemorrhagic < HES_post_index_date_first_ischaemics) ~ "haemorrhagic",
        
        TRUE ~ NA_character_  
      ),
      
      HES_post_index_stroke_type_date = pmin(
        HES_post_index_date_first_ischaemics,
        HES_post_index_date_first_haemorrhagic,
        na.rm = TRUE
      )
      
      
    ) %>%
    ##### Stroke as a primary cause of death
    left_join(analysis$cached(name ="death_stroke_primary") %>%
                rename(stroke_date_of_death = date_of_death)%>%
                collect(), by = "patid") %>%
    distinct(patid, .keep_all = TRUE) %>%
    mutate(
      stroke_composite_pre_index_date = ifelse((HES_pre_index_date_stroke==1) | (pre_index_date_stroke==1), 1, 0),
      stroke_composite_post_index_date = ifelse((HES_post_index_date_stroke==1) | (post_index_date_stroke==1), 1, 0),
      stroke_composite = ifelse(((!is.na(HES_Stroke)) | (!is.na(comorbidity_stroke))), 1, 0),
     
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
      
      ONS_stroke_post_date = if_else(
        is.na(stroke_compositeDate_post_first_stroke) & !is.na(stroke_date_of_death),
        as.Date(stroke_date_of_death),
        NA_Date_  
      ),
      
      ONS_stroke_post = if_else(!is.na(ONS_stroke_post_date), 1, 0),
    
      stroke_compositeDate_post_first_stroke = if_else(
        !is.na(stroke_compositeDate_post_first_stroke) & 
          (is.na(ONS_stroke_post_date) | stroke_compositeDate_post_first_stroke <= ONS_stroke_post_date),
        as.Date(stroke_compositeDate_post_first_stroke),
        as.Date(ONS_stroke_post_date)
      ),
      
      stroke_composite_post_index_date = if_else(
        !is.na(stroke_compositeDate_post_first_stroke) | ONS_stroke_post == 1, 1, 0
      ),
      
      
      
      
      # Update stroke_composite_post_index_date for the control group if prescribed R and had stroke after issuedate
      stroke_composite_post_index_date <- ifelse(
        (risperidone == 0) & 
          (!is.na(R_issuedate)) & 
          (R_issuedate > issuedate) & 
          (stroke_compositeDate_post_first_stroke > R_issuedate),
        0,
        stroke_composite_post_index_date
      ),
      
  
      
      
      
      post_index_date_VTE = ifelse((post_index_date_pulmonary_embolism ==1) |(post_index_date_deep_vein_thrombosis ==1), 1, 0),
      post_index_date_first_VTE = pmin(post_index_date_first_pulmonary_embolism,post_index_date_first_deep_vein_thrombosis,na.rm=TRUE),
      post_index_date_cvd = ifelse((post_index_date_heartfailure==1) | 
                                     (post_index_date_myocardialinfarction==1) | 
                                     (post_index_date_angina==1) |
                                     (post_index_date_tia==1) |
                                     (post_index_date_ihd==1) |
                                     (post_index_date_pad==1) |
                                     (stroke_composite_post_index_date==1), 1, 0),
      
      
      post_index_date_first_cvd = pmin(post_index_date_first_heartfailure,
                                       post_index_date_first_myocardialinfarction,
                                       post_index_date_first_angina,
                                       post_index_date_first_tia,
                                       post_index_date_first_ihd,
                                       post_index_date_first_pad,
                                       # post_index_date_first_stroke,
                                       stroke_compositeDate_post_first_stroke,
                                       
                                       na.rm=TRUE),
      
      
      
      pre_index_date_VTE = ifelse((pre_index_date_pulmonary_embolism ==1) |(pre_index_date_deep_vein_thrombosis ==1), 1, 0),
      pre_index_date_first_VTE = pmin(pre_index_date_latest_pulmonary_embolism,pre_index_date_latest_deep_vein_thrombosis,na.rm=TRUE),
      pre_index_date_cvd = ifelse((pre_index_date_heartfailure==1) | 
                                    (pre_index_date_myocardialinfarction==1) | 
                                    (pre_index_date_angina==1) |
                                    (pre_index_date_tia==1) |
                                    (pre_index_date_ihd==1) |
                                    (pre_index_date_pad==1) |
                                    # (pre_index_date_stroke==1), 
                                  (stroke_composite_pre_index_date==1),1, 0),
      
      
      
      
      pre_index_date_latest_cvd = pmin(pre_index_date_latest_heartfailure,
                                       pre_index_date_latest_myocardialinfarction,
                                       pre_index_date_latest_angina,
                                       pre_index_date_latest_tia,
                                       pre_index_date_latest_ihd,
                                       pre_index_date_latest_pad,
                                       stroke_compositeDate_pre_latest_stroke,na.rm=TRUE)
      
      
      
      
      
      
      
      
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
      deprivation = ifelse(is.na(deprivation), "Unknown", deprivation),
      date_dbp = as.Date(date_dbp),
      date_sbp = as.Date(date_sbp),
      obsdate_hypertension = case_when(
        !is.na(date_dbp) & !is.na(date_sbp) & date_dbp == date_sbp ~ as.Date(date_dbp),
        is.na(date_dbp) & !is.na(date_sbp) ~ as.Date(date_sbp),
        !is.na(date_dbp) & is.na(date_sbp) ~ as.Date(date_dbp),
        !is.na(date_dbp) & !is.na(date_sbp) & date_dbp != date_sbp ~ pmin(date_dbp, date_sbp, na.rm = TRUE),
        TRUE ~ NA_Date_
      ),
      pre_index_date_hypertension = ifelse(issuedate > obsdate_hypertension, 1, 0),
      post_index_date_hypertension = ifelse(issuedate < obsdate_hypertension, 1, 0),
      Survival_time = ifelse(is.na(stroke_compositeDate_post_first_stroke),
                             (as.numeric(endoffollowup - issuedate) / 365.25),
                             (as.numeric(stroke_compositeDate_post_first_stroke - issuedate) / 365.25)),
      
      # obsdate_hypertension =  pmin(date_dbp, date_sbp) ,
      obsdate_hypertension = ifelse(
        is.na(date_dbp) & !is.na(date_sbp), as.Date(date_sbp),
        ifelse(
          !is.na(date_dbp) & is.na(date_sbp), as.Date(date_dbp),
          ifelse(
            date_dbp > date_sbp, as.Date(date_sbp), as.Date(date_dbp)
          )
        )
      )
    ,
      
      totalcholesterol = case_when(
        testvalue_totalcholesterol < 4.14 ~ "(< 160 mg/dl)",
        (testvalue_totalcholesterol >= 4.15) & (testvalue_totalcholesterol <= 5.17) ~ "(199 mg/dl)",
        (testvalue_totalcholesterol >= 5.18) & (testvalue_totalcholesterol <= 6.21) ~ "(200 - 239 mg/dl)",
        (testvalue_totalcholesterol >= 6.22) & (testvalue_totalcholesterol <= 7.24) ~ "(240 - 279 mg/dl)",
        testvalue_totalcholesterol > 7.25 ~ "(> 280 mg/dl)",
        TRUE ~ "Unknown" 
      ),
      
      age_risperidone_cat = case_when(
        age_risperidone >= 65 & age_risperidone <= 74 ~ "65 - 74",
        age_risperidone >= 75 & age_risperidone <= 84 ~ "75 - 84",
        age_risperidone >= 85 ~ "85+"
      )
    )%>%
    left_join(
      analysis$cached(name = "clean_care_home_medcodes") %>%
        select(patid, obsdate, care_home_cat) %>%
        rename(homeCare_obsdate = obsdate) %>%
        collect(),
      by = "patid"
    ) %>%
    group_by(patid) %>%
    mutate(
      care_home = if_else(!is.na(homeCare_obsdate), 1, 0),
      care_home_before_indexdate = if_else(!is.na(homeCare_obsdate) & (homeCare_obsdate < issuedate), 1, 0),
      care_home_at_indexdate = if_else(!is.na(homeCare_obsdate) & (homeCare_obsdate == issuedate), 1, 0),
      R_issuedate_carehomeObsdate_difference = floor(as.numeric((issuedate - homeCare_obsdate))),
      care_home_90_days_after_indexdate = if_else(R_issuedate_carehomeObsdate_difference > 90, 1, 0)
    ) %>%
    distinct(patid, .keep_all = TRUE)
  
  
  
  
  
  
  

  
  ################################# Matching #########################################
  # 
  m.out2 <- matchit(risperidone ~ + sex + care_home_before_indexdate + deprivation + age_risperidone +pre_index_date_angina + pre_index_date_cvd + pre_index_date_VTE + pre_index_date_heartfailure + BMI + Prescribed_other_antipsychotic_Prior  + period_before_prescription  + pre_index_date_myocardialinfarction + stroke_composite_pre_index_date +
                      pre_index_date_tia + pre_index_date_falls +pre_index_date_lowerlimbfracture + pre_index_date_ihd + pre_index_date_pad + pre_index_date_af + pre_index_date_revasc + pre_index_date_qof_diabetes + pre_index_date_anxiety_disorders+ pre_index_date_fh_diabetes +
                      pre_index_date_fh_premature_cvd + pre_index_date_pulmonary_embolism + pre_index_date_deep_vein_thrombosis + pre_index_date_haem_cancer + pre_index_date_solid_cancer +
                      pre_index_date_hearing_loss + ethnicity + comorbidity_hypertension + totalcholesterol + age_risperidone_cat, data = FullData, exact = ~sex + stroke_composite_pre_index_date + age_risperidone_cat + pre_index_date_cvd, 
                    method = "nearest", distance = "glm", link = "logit", replace = TRUE, caliper = 0.05, ratio = 5)
  m.out2
  summary(m.out2)
  
  print(summary(m.out2, un = FALSE))
  

  
  

  
  summary_data <- summary(m.out2, un = FALSE)
  
  match.t <- get_matches(m.out2)
  write.table(match.t, file = paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final_paperDraft/match_t_", year, ".txt"), sep = "\t", row.names = FALSE)
  # Save matched data to the list
  file_name <- paste0("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final_paperDraft/matched_data_iteration_", year, ".txt")
  
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
write.table(all_matched_data, "C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final_paperDraft/Joshua_all_matched_data_paperDraft.txt", sep = "\t", row.names = FALSE)


cumulative_matched_data <- cumulative_matched_data %>%
  mutate(
    date_dbp = as.Date(date_dbp),
    date_sbp = as.Date(date_sbp),
    issuedate = as.Date(issuedate),
    endoffollowup = as.Date(endoffollowup),
    stroke_compositeDate_post_first_stroke = as.Date(stroke_compositeDate_post_first_stroke),
    
    # Calculate obsdate_hypertension
    obsdate_hypertension = case_when(
      !is.na(date_dbp) & !is.na(date_sbp) & date_dbp == date_sbp ~ as.Date(date_dbp),
      is.na(date_dbp) & !is.na(date_sbp) ~ as.Date(date_sbp),
      !is.na(date_dbp) & is.na(date_sbp) ~ as.Date(date_dbp),
      !is.na(date_dbp) & !is.na(date_sbp) & date_dbp != date_sbp ~ pmin(date_dbp, date_sbp, na.rm = TRUE),
      TRUE ~ NA_Date_
    ))
write.table(cumulative_matched_data, file = "C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedData_exact_final_paperDraft/Joshua_cumulative_matched_data_paperDraft.txt",sep = "\t", row.names = FALSE)









