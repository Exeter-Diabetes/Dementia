# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
library(tableone)

library(survival)
library(survminer)

######## This script is used to define both the final dementia incident cohort and risperidone cohort. 
#### These are the variables that are found in the final dementia incident cohort

# [1] "patid"                        "consid"                       "pracid"                       "obsid"                       
# [5] "obsdate"                      "enterdate"                    "staffid"                      "parentsobsid"                
# [9] "medcodeid"                    "testvalue"                    "numunitid"                    "obstypeid"                   
# [13] "numrangelow"                  "numrangehigh"                 "probobsid"                    "dementiadementiacodelist_cat"
# [17] "usualgpstaffid"               "gender"                       "yob"                          "mob"                         
# [21] "emis_ddate"                   "regstartdate"                 "patienttypeid"                "regenddate"                  
# [25] "acceptable"                   "cprd_ddate"                   "lcd"                          "uts"                         
# [29] "region"                       "died"                         "gender_decode"                "date_of_birth"               
# [33] "earliest_obsdate"             "diagnosedbeforeRegistration"  "age_diagnosis"                "age_category"                
# [37] "year_of_diagnosis"            "alcohol_cat"                  "smoking_cat"                  "qrisk2_smoking_cat"          
# [41] "qrisk2_smoking_cat_uncoded"   "gp_5cat_ethnicity"            "gp_16cat_ethnicity"           "gp_qrisk2_ethnicity"         
# [45] "hes_5cat_ethnicity"           "hes_16cat_ethnicity"          "hes_qrisk2_ethnicity"         "epistart"                    
# [49] "epiend"                       "ICD"                          "stroke_earliest_gp_obsdate"   "stroke_cat"                  
# [53] "ONS_date_of_death"            "ONS_died"                     "HES_stroke"                   "GP_stroke"                   
# [57] "stroke_composite"             "death_composite"              "death_composite_date"         "endoffollowup"               
# [61] "Diff_start_endOfFollowup"     "stroke_compositeDate"         "stroke_date_of_death"         "primary_death_cause"         
# [65] "primary_death_stroke"         "cause_of_death_stroke_type"   "ethnicity"                    "FollowUp"                    
# [69] "DiagnosedAfterCompositeDeath" "deprivation"                 

cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")

codesets = cprd$codesets()
codes = codesets$getAllCodeSetVersion(v = "31/10/2021")

analysis = cprd$analysis("Joshua")
analysis_at_diag = cprd$analysis("at_diag")


print(colnames(cprd$tables$observation))
print(colnames(cprd$tables$patient))
print(colnames(cprd$tables$practice))



######### Reading all the dementia observations using codelists, patient information as well as practice data
table <- cprd$tables$observation %>%
  inner_join(codes$dementiadementiacodelist, by="medcodeid") %>%
  filter(!is.na(obsdate)) %>%
  inner_join(cprd$tables$patient %>%
               filter(acceptable==1)
             , by = "patid") %>%
  rename(pracid = pracid.x) %>%
  select(-pracid.y) %>%
  inner_join(cprd$tables$practice, by = "pracid")%>%
  analysis$cached(name = "all_raw_dementia_patients", indexes = "patid")

##### Dropping patients who have bipolar disoder and schizophrenia

bipolar_disorder<- bipolar_disorder %>% analysis$cached("raw_bipolar_disorder_medcodes")
schizophrenia<- schizophrenia %>% analysis$cached("raw_schizophrenia_medcodes")

ExcludingSchizophreniaBipolar <- table %>%
  anti_join(bipolar_disorder, by = "patid") %>%
  anti_join(schizophrenia, by = "patid") %>%
  analysis$cached(name = "all_clean_Obs_withoutSchizo_Bipolar_final", indexes = "patid")

ExcludingSchizophreniaBipolar %>% count() ### 3,359,895

##### Mark the deregistration date the last collection date for cases where regenddate is null
##### Implement the date of birth algorithm to complete the date of birth. The description can be z
# found here https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#general-notes-on-implementation

observation_data <- ExcludingSchizophreniaBipolar %>%
  mutate(
    regenddate = ifelse(is.na(regenddate), as.Date("2023-11-30"), regenddate),
    died = ifelse(is.na(cprd_ddate), 0, 1),
    gender_decode = case_when(
      gender == 1 ~ 'M',
      gender == 2 ~ 'F',
      gender == 3 ~ 'I',
      TRUE ~ 'U'
    ),
    
    
    date_of_birth=as.Date(ifelse(is.na(mob), paste0(yob,"-07-01"), paste0(yob, "-",mob,"-15"))),
    cprd_ddate = ifelse(is.na(cprd_ddate),as.Date("3999-01-01"),cprd_ddate),
    # regstartdate = ifelse(regstartdate < date_of_birth, NA, regstartdate)
  ) %>%
  filter((obsdate > date_of_birth) & (obsdate < regenddate) & (obsdate < lcd) & (obsdate < cprd_ddate)) %>%
  analysis$cached(name = "all_clean_dementia_observations_final", indexes = "patid")



##### Storing the earliest date of diagnosis for each patient
intermediate <- observation_data %>%
  group_by(patid) %>%
  mutate(
    earliest_obsdate = min(obsdate),
    diagnosedbeforeRegistration = ifelse(earliest_obsdate < regstartdate, 0, 1)) %>%
  ungroup()%>%
  analysis$cached(name = "all_clean_dementia_obs_intermediate", indexes = "patid")


## Selecting patients with a dementia diagnosis code after 2004-04-01 and diagnosed after 1980-01-01
CleanData <- intermediate %>%
  filter(earliest_obsdate >= as.Date('1980-01-01'), obsdate > as.Date('2004-01-01')) %>%
  analysis$cached(name = "all_dementia_observation_after_2004", indexes = "patid")
CleanData %>% count() ### 3,115,141


### Select the first date of diagnosis within the study period
earliest_obs <- CleanData %>%
  group_by(patid) %>%
  slice_min(order_by = obsdate) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) %>%
  analysis$cached(name = "all_dementia_after_2004_earliestObs", indexes = "patid")



### Work out the age of diagnosis

completeData <- earliest_obs %>%
  mutate(
    age_diagnosis = floor(as.numeric(datediff(as.Date(earliest_obsdate), as.Date(date_of_birth))) / 365.25),
    age_category = case_when(
      age_diagnosis >= 65 & age_diagnosis <= 74 ~ '65 - 74',
      age_diagnosis >= 75 & age_diagnosis <= 84 ~ '75 - 84',
      age_diagnosis >= 85 & age_diagnosis <= 94 ~ '85 - 94',
      age_diagnosis >= 95 ~ '95+'
    ),
    
    year_of_diagnosis = year(obsdate),
  )

### Select patients who were active after 2004, i.e. alive and registered
ActiveAfter2004 <- completeData %>%
  filter((regenddate > as.Date('2004-01-01')) &
           (is.na(cprd_ddate) | cprd_ddate > as.Date('2004-01-01')))




#### Final pipeline selects patients who were diagnosed aged 65 and above. This part also integrates fromn the following tables:
# alcohol, 
# smoking,
# ethnicity,
# stroke from both cprd and hes,
# ONS,
# stroke as a primary cause of death


Over65<- ActiveAfter2004   %>%     
  filter(age_diagnosis >= 65)%>%
  filter(gender_decode != "I") %>%
left_join(analysis_at_diag$cached(name = "alcohol"), by = "patid") %>%
  left_join(analysis_at_diag$cached(name = "smoking"), by = "patid") %>%
  select(-index_date) %>%
  left_join(analysis$cached(name = "gp_ethnicity"), by = "patid") %>%
  left_join(analysis$cached(name = "hes_ethnicity") %>% select(patid, hes_5cat_ethnicity,hes_16cat_ethnicity, hes_qrisk2_ethnicity), by = "patid") %>%
  left_join(analysis$cached(name = "clean_stroke_icd10") %>%
              select(patid, epistart, epiend, ICD) %>%
              group_by(patid) %>%
              slice_min(epistart), by = "patid") %>%
  ungroup() %>%
  left_join(analysis$cached(name = "clean_stroke_medcodes") %>%
              select(patid, obsdate, stroke_cat) %>%
              rename(stroke_earliest_gp_obsdate = obsdate) %>%
              group_by(patid) %>%
              slice_min(stroke_earliest_gp_obsdate), by = "patid") %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) %>%
  left_join(cprd$tables$onsDeath %>%
              select(patid, dod), by = "patid") %>%
  rename(ONS_date_of_death = dod) %>%
  
  mutate(
    ONS_died = ifelse(is.na(ONS_date_of_death), 0, 1),
    HES_stroke = ifelse(is.na(ICD), 0, 1),
    GP_stroke = ifelse(is.na(stroke_earliest_gp_obsdate), 0, 1),
    
    stroke_composite = ifelse(((!is.na(stroke_earliest_gp_obsdate)) | (!is.na(epistart))), 1, 0),
    # stroke_compositeDate = as.Date(pmin(stroke_earliest_gp_obsdate, epistart, na.rm = TRUE)),
    cprd_ddate = ifelse(cprd_ddate == "3999-01-01", NA, cprd_ddate),
    death_composite = ifelse(((!is.na(cprd_ddate)) | (!is.na(ONS_date_of_death))), 1, 0),
    # death_composite_date = as.Date(pmin(cprd_ddate, ONS_date_of_death, na.rm = TRUE)),
    
    death_composite_date = case_when(
      !is.na(cprd_ddate) & !is.na(ONS_date_of_death) ~ as.Date(pmin(cprd_ddate, ONS_date_of_death)),
      is.na(cprd_ddate) & !is.na(ONS_date_of_death) ~ as.Date(ONS_date_of_death),
      !is.na(cprd_ddate) & is.na(ONS_date_of_death) ~ as.Date(cprd_ddate),
      TRUE ~ NA_Date_),
    endoffollowup = if_else(
      !is.na(regenddate) & (is.na(death_composite_date) | regenddate <= death_composite_date) & (is.na(lcd) | regenddate <= lcd),
      regenddate,
      if_else(!is.na(death_composite_date) & (is.na(lcd) | death_composite_date <= lcd),
              death_composite_date,
              lcd)
    ),

    Diff_start_endOfFollowup = as.numeric(datediff(
      endoffollowup,
      if_else(
        !is.na(earliest_obsdate) & (is.na(regstartdate) | earliest_obsdate >= regstartdate),
        obsdate,
        regstartdate
      )
    )) / 365.25,
    
    # Diff_start_endOfFollowup = as.numeric((as.Date(pmin(regenddate, death_composite_date, lcd, na.rm = TRUE)) - as.Date(pmax(obsdate, regstartdate, na.rm = TRUE)))/365.25),
    # endoffollowup = pmin(regenddate, death_composite_date, lcd, na.rm = TRUE),
    # 
    
    stroke_compositeDate = as.Date(ifelse(
      is.na(stroke_earliest_gp_obsdate), epistart,
      ifelse(is.na(epistart), stroke_earliest_gp_obsdate,
             ifelse(stroke_earliest_gp_obsdate < epistart, stroke_earliest_gp_obsdate, epistart)))),

    death_composite_date = as.Date(ifelse(
      is.na(cprd_ddate), ONS_date_of_death,
      ifelse(is.na(ONS_date_of_death), cprd_ddate,
             ifelse(cprd_ddate < ONS_date_of_death, cprd_ddate, ONS_date_of_death))))
    
  ) %>%
  left_join(analysis$cached(name = "death_stroke_primary") %>%
              rename(stroke_date_of_death = date_of_death), by = "patid") %>%
  left_join(codes$icd10_ischaemicstroke %>% mutate(setname = "ischaemic"), by = c("primary_death_cause" = "icd10")) %>%
  left_join(codes$icd10_haemorrhagicstroke %>% mutate(setname = "haemorrhagic"), by = c("primary_death_cause" = "icd10")) %>%
  mutate(
    cause_of_death_stroke_type = coalesce(setname.x, setname.y)
  ) %>%
  select(-setname.x, -setname.y, -icd10_ischaemicstroke_cat, -icd10_haemorrhagicstroke_cat)%>%
  mutate(
    
    hes_5cat_ethnicity = case_when(
      hes_5cat_ethnicity == 0 ~ "White",
      hes_5cat_ethnicity == 1 ~ "South Asian",
      hes_5cat_ethnicity == 2 ~ "Black",
      hes_5cat_ethnicity == 3 ~ "Other",
      hes_5cat_ethnicity == 4 ~ "Mixed",
      TRUE ~ "Unknown"
    ),
    hes_16cat_ethnicity = case_when(
      hes_16cat_ethnicity == 1 ~ "White British",
      hes_16cat_ethnicity == 2 ~ "White Irish",
      hes_16cat_ethnicity == 3 ~ "Other White",
      hes_16cat_ethnicity == 4 ~ "White and Black Caribbean",
      hes_16cat_ethnicity == 5 ~ "White and Black African",
      hes_16cat_ethnicity == 6 ~ "White and Asian",
      hes_16cat_ethnicity == 7 ~ "Other Mixed",
      hes_16cat_ethnicity == 8 ~ "Indian",
      hes_16cat_ethnicity == 9 ~ "Pakistani",
      hes_16cat_ethnicity == 10 ~ "Bangladeshi",
      hes_16cat_ethnicity == 11 ~ "Other Asian",
      hes_16cat_ethnicity == 12 ~ "Caribbean",
      hes_16cat_ethnicity == 13 ~ "African",
      hes_16cat_ethnicity == 14 ~ "Other Black",
      hes_16cat_ethnicity == 15 ~ "Chinese",
      hes_16cat_ethnicity == 16 ~ "Other",
      TRUE ~ "Unknown"
    ),
    hes_qrisk2_ethnicity = case_when(
      hes_qrisk2_ethnicity == 0 ~ "missing",
      hes_qrisk2_ethnicity == 1 ~ "White",
      hes_qrisk2_ethnicity == 2 ~ "Indian",
      hes_qrisk2_ethnicity == 3 ~ "Pakistani",
      hes_qrisk2_ethnicity == 4 ~ "Bangladeshi",
      hes_qrisk2_ethnicity == 5 ~ "Other Asian",
      hes_qrisk2_ethnicity == 6 ~ "Black Caribbean",
      hes_qrisk2_ethnicity == 7 ~ "Black African",
      hes_qrisk2_ethnicity == 8 ~ "Chinese",
      hes_qrisk2_ethnicity == 9 ~ "Other",
      TRUE ~ "Unknown"
    ),
    gp_5cat_ethnicity = case_when(
      gp_5cat_ethnicity == 0 ~ "White",
      gp_5cat_ethnicity == 1 ~ "South Asian",
      gp_5cat_ethnicity == 2 ~ "Black",
      gp_5cat_ethnicity == 3 ~ "Other",
      gp_5cat_ethnicity == 4 ~ "Mixed",
      TRUE ~ "Unknown"  
    ),
    gp_16cat_ethnicity = case_when(
      gp_16cat_ethnicity == 1 ~ "White British",
      gp_16cat_ethnicity == 2 ~ "White Irish",
      gp_16cat_ethnicity == 3 ~ "Other White",
      gp_16cat_ethnicity == 4 ~ "White and Black Caribbean",
      gp_16cat_ethnicity == 5 ~ "White and Black African",
      gp_16cat_ethnicity == 6 ~ "White and Asian",
      gp_16cat_ethnicity == 7 ~ "Other Mixed",
      gp_16cat_ethnicity == 8 ~ "Indian",
      gp_16cat_ethnicity == 9 ~ "Pakistani",
      gp_16cat_ethnicity == 10 ~ "Bangladeshi",
      gp_16cat_ethnicity == 11 ~ "Other Asian",
      gp_16cat_ethnicity == 12 ~ "Caribbean",
      gp_16cat_ethnicity == 13 ~ "African",
      gp_16cat_ethnicity == 14 ~ "Other Black",
      gp_16cat_ethnicity == 15 ~ "Chinese",
      gp_16cat_ethnicity == 16 ~ "Other",
      TRUE ~ "Unknown"  
    ),
    gp_qrisk2_ethnicity = case_when(
      gp_qrisk2_ethnicity == 0 ~ "missing",
      gp_qrisk2_ethnicity == 1 ~ "White",
      gp_qrisk2_ethnicity == 2 ~ "Indian",
      gp_qrisk2_ethnicity == 3 ~ "Pakistani",
      gp_qrisk2_ethnicity == 4 ~ "Bangladeshi",
      gp_qrisk2_ethnicity == 5 ~ "Other Asian",
      gp_qrisk2_ethnicity == 6 ~ "Black Caribbean",
      gp_qrisk2_ethnicity == 7 ~ "Black African",
      gp_qrisk2_ethnicity == 8 ~ "Chinese",
      gp_qrisk2_ethnicity == 9 ~ "Other",
      TRUE ~ "Unknown"  
    ),
    ethnicity = ifelse(gp_5cat_ethnicity == "Unknown", hes_5cat_ethnicity, gp_5cat_ethnicity),
    alcohol_cat = if_else(is.na(alcohol_cat), "Unknown", as.character(alcohol_cat)),
    qrisk2_smoking_cat = if_else(is.na(qrisk2_smoking_cat), "Unknown", as.character(qrisk2_smoking_cat)),
    qrisk2_smoking_cat_uncoded = if_else(is.na(qrisk2_smoking_cat_uncoded), "Unknown", as.character(qrisk2_smoking_cat_uncoded)),
    smoking_cat = if_else(is.na(smoking_cat), "Unknown", as.character(smoking_cat)),
    # FollowUp =  as.numeric((as.Date(pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE)) - as.Date(earliest_obsdate))/365.25)
      FollowUp = as.numeric(datediff(endoffollowup , earliest_obsdate)) / 365.25,
    DiagnosedAfterCompositeDeath = ifelse(death_composite_date < earliest_obsdate, 1, 0)
  )%>%
  filter(DiagnosedAfterCompositeDeath==0 | is.na(DiagnosedAfterCompositeDeath))%>%
 analysis$cached(name = "final_dementia_after2004", indexes = "patid")


### Getting patients with a linked data to finalise the cohort

LinkedData <- Over65 %>%
  semi_join(cprd$tables$patidsWithLinkage, by = "patid") %>%
  left_join(cprd$tables$patientImd2015 %>% 
              select(patid, imd2015_10) %>%
              rename(deprivation = imd2015_10), by = "patid") %>%
  analysis$cached(name = "final_dementia_cohortLinkedData", indexes = "patid")



##################################################################################################################################################

# These are the variables are in the final risperidone cohort:
# [1] "patid"                                      "issueid"                                    "drugrecid"                                 
# [4] "issuedate"                                  "prodcodeid"                                 "dosageid"                                  
# [7] "quantity"                                   "quantunitid"                                "duration"                                  
# [10] "estnhscost"                                 "min_dob"                                    "gp_end_date"                               
# [13] "consid"                                     "obsid"                                      "obsdate"                                   
# [16] "parentsobsid"                               "medcodeid"                                  "testvalue"                                 
# [19] "numunitid"                                  "obstypeid"                                  "numrangelow"                               
# [22] "numrangehigh"                               "dementiadementiacodelist_cat"               "usualgpstaffid"                            
# [25] "gender"                                     "yob"                                        "mob"                                       
# [28] "emis_ddate"                                 "regstartdate"                               "patienttypeid"                             
# [31] "regenddate"                                 "acceptable"                                 "cprd_ddate"                                
# [34] "lcd"                                        "uts"                                        "region"                                    
# [37] "died"                                       "gender_decode"                              "date_of_birth"                             
# [40] "earliest_obsdate"                           "diagnosedbeforeRegistration"                "age_diagnosis"                             
# [43] "age_category"                               "year_of_diagnosis"                          "alcohol_cat"                               
# [46] "smoking_cat"                                "qrisk2_smoking_cat"                         "qrisk2_smoking_cat_uncoded"                
# [49] "gp_5cat_ethnicity"                          "gp_16cat_ethnicity"                         "gp_qrisk2_ethnicity"                       
# [52] "hes_5cat_ethnicity"                         "hes_16cat_ethnicity"                        "hes_qrisk2_ethnicity"                      
# [55] "epistart"                                   "epiend"                                     "ICD"                                       
# [58] "stroke_earliest_gp_obsdate"                 "stroke_cat"                                 "ONS_date_of_death"                         
# [61] "ONS_died"                                   "HES_stroke"                                 "GP_stroke"                                 
# [64] "stroke_composite"                           "death_composite"                            "death_composite_date"                      
# [67] "endoffollowup"                              "Diff_start_endOfFollowup"                   "stroke_compositeDate"                      
# [70] "stroke_date_of_death"                       "primary_death_cause"                        "primary_death_stroke"                      
# [73] "cause_of_death_stroke_type"                 "ethnicity"                                  "FollowUp"                                  
# [76] "DiagnosedAfterCompositeDeath"               "pracid"                                     "probobsid"                                 
# [79] "enterdate"                                  "staffid"                                    "DifferenceBetween_PrescriptionAndDiagnosis"
# [82] "age_risperidone"                            "Prescription_moreThan_Year_prior"           "Prescription_Within_Year_prior"            
# [85] "PrescriptionAfterDiagnosis"                 "year_of_prescription"                       "HES_pre_stroke"                            
# [88] "HES_post_stroke"                            "deprivation"   

risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("clean_risperidone_prescriptions") 

#### getting the earliest date of prescription
earliest_obs_risperidone_prescription <- risperidone_prescriptions %>%
  filter(!is.na(issuedate)) %>%
  group_by(patid) %>%
  filter(issuedate == min(issuedate, na.rm = TRUE)) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) 

#### Linking the data with the dementia cohort. Working out the duration before prescription (time between diagnosis and prescription)

final_risperidone_cohort <- inner_join(
  earliest_obs_risperidone_prescription,       
  Over65,
  by = "patid"
) %>%
  mutate(
    pracid = coalesce(pracid.x, pracid.y),
    probobsid = coalesce(probobsid.x, probobsid.y),
    enterdate = coalesce(enterdate.x, enterdate.y),
    staffid = coalesce(staffid.x, staffid.y),
    DifferenceBetween_PrescriptionAndDiagnosis = as.numeric(datediff(issuedate, earliest_obsdate)) / 365.25,
    # DifferenceBetween_PrescriptionAndDiagnosis = as.numeric(as.numeric(issuedate - obsdate) / (30.44)),  # Convert to months
    age_risperidone = floor(as.numeric(datediff(issuedate, date_of_birth)) / 365.25),
    Prescription_moreThan_Year_prior = ifelse(DifferenceBetween_PrescriptionAndDiagnosis < -1, 1, 0),
    Prescription_Within_Year_prior = ifelse(DifferenceBetween_PrescriptionAndDiagnosis <= 0 & DifferenceBetween_PrescriptionAndDiagnosis >= -1, 1, 0),
    PrescriptionAfterDiagnosis = ifelse(DifferenceBetween_PrescriptionAndDiagnosis > 0, 1, 0),
    year_of_prescription = year(issuedate),
    HES_pre_stroke = ifelse(!is.na(epistart), ifelse(obsdate > epistart, 1, 0), 0),
    HES_post_stroke = ifelse(!is.na(epistart), ifelse(obsdate < epistart, 1, 0), 0),
  ) %>%
  select(-ends_with(".x"), -ends_with(".y"))


### Looking at prescriptions that we given after 2004
final_risperidone_cohort <- final_risperidone_cohort %>%
  filter(issuedate >= "2004-01-01") %>%
  analysis$cached(name = "final_risperidone_After2004", indexes = "patid")


#### Patients prescribed after diagnosis
R_cohort <- final_risperidone_cohort%>%
  filter(PrescriptionAfterDiagnosis==1) %>%
  analysis$cached(name = "final_risperidone_afterdiagnosis_cohort_2004", indexes = "patid")

#### Final risperidone cohort with a linked data
R_cohort_linkedData <- R_cohort %>%
  semi_join(cprd$tables$patidsWithLinkage, by = "patid") %>%
  left_join(cprd$tables$patientImd2015 %>% 
              select(patid, imd2015_10) %>%
              rename(deprivation = imd2015_10), by = "patid") %>%
  analysis$cached(name = "final_risperidone_cohortLinkedData", indexes = "patid")



