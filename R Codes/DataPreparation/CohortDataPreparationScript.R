# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
library(tableone)
library(venn)
library(survival)
library(survminer)

cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")

codesets = cprd$codesets()
codes = codesets$getAllCodeSetVersion(v = "31/10/2021")

analysis = cprd$analysis("Joshua")
analysis_at_diag = cprd$analysis("at_diag")


print(colnames(cprd$tables$observation))
print(colnames(cprd$tables$patient))
print(colnames(cprd$tables$practice))


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



bipolar_disorder<- bipolar_disorder %>% analysis$cached("raw_bipolar_disorder_medcodes")
schizophrenia<- schizophrenia %>% analysis$cached("raw_schizophrenia_medcodes")

ExcludingSchizophreniaBipolar <- table %>%
  anti_join(bipolar_disorder, by = "patid") %>%
  anti_join(schizophrenia, by = "patid") %>%
  analysis$cached(name = "all_clean_Obs_withoutSchizo_Bipolar_final", indexes = "patid")

ExcludingSchizophreniaBipolar %>% count() ### 3,359,895

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




intermediate <- observation_data %>%
  group_by(patid) %>%
  mutate(
    earliest_obsdate = min(obsdate),
    diagnosedbeforeRegistration = ifelse(earliest_obsdate < regstartdate, 0, 1)) %>%
  ungroup()%>%
  analysis$cached(name = "all_clean_dementia_obs_intermediate", indexes = "patid")


CleanData <- intermediate %>%
  filter(earliest_obsdate >= as.Date('1980-01-01'), obsdate > as.Date('2004-01-01')) %>%
  analysis$cached(name = "all_dementia_observation_after_2004", indexes = "patid")
CleanData %>% count() ### 3,115,141


earliest_obs <- CleanData %>%
  group_by(patid) %>%
  slice_min(order_by = obsdate) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) %>%
  analysis$cached(name = "all_dementia_after_2004_earliestObs", indexes = "patid")




earliest_obs %>% select(date_of_birth)

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

ActiveAfter2004 <- completeData %>%
  filter((regenddate > as.Date('2004-01-01')) &
           (is.na(cprd_ddate) | cprd_ddate > as.Date('2004-01-01')))

# View(ActiveAfter2004 %>% collect())





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


Over65_cohort <- Over65 %>% collect()
table(Over65_cohort$gender)

table(Over65_cohort$died)



LinkedData <- Over65 %>%
  semi_join(cprd$tables$patidsWithLinkage, by = "patid") %>%
  left_join(cprd$tables$patientImd2015 %>% 
              select(patid, imd2015_10) %>%
              rename(deprivation = imd2015_10), by = "patid") %>%
  analysis$cached(name = "final_dementia_cohortLinkedData", indexes = "patid")

LinkedData %>% count() ### linkedData: 445386
# View(LinkedData %>% collect())


FinalData <- LinkedData %>% collect()

variables_of_interest <- c("diagnosedbeforeRegistration", "died", "ONS_died","death_composite", "primary_death_stroke","ethnicity",  "age_diagnosis", "age_category","HES_stroke", "GP_stroke", "stroke_composite" , "year_of_diagnosis", "gender_decode",
                           "alcohol_cat",  "smoking_cat", "qrisk2_smoking_cat","qrisk2_smoking_cat_uncoded", "gp_qrisk2_ethnicity", "hes_qrisk2_ethnicity","gp_5cat_ethnicity","hes_5cat_ethnicity", 
                           "gp_16cat_ethnicity", "hes_16cat_ethnicity"   
                           
                           
                           
)                 





binary_vars <- c("diagnosedbeforeRegistration",  "died", "age_category", "year_of_diagnosis",
                 "alcohol_cat",  "smoking_cat", "qrisk2_smoking_cat","qrisk2_smoking_cat_uncoded", "gp_qrisk2_ethnicity", "hes_qrisk2_ethnicity","gp_5cat_ethnicity","hes_5cat_ethnicity", 
                 "gp_16cat_ethnicity", "hes_16cat_ethnicity" ,  "primary_death_stroke", 
                 "HES_stroke", "ONS_died", "GP_stroke", "stroke_composite", "death_composite"
                 
)   



# Replace missing values in binary features with a placeholder value
FinalData[binary_vars] <- lapply(FinalData[binary_vars], function(x) ifelse(is.na(x), 0, x))
# Convert binary features to factor variables
FinalData[binary_vars] <- lapply(FinalData[binary_vars], as.factor)

# Create table one
my_tableone <- CreateTableOne(vars = variables_of_interest, data = FinalData)

# Print the table
print(my_tableone)


# view(FinalData)

##################################################################################################################################################

risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("clean_risperidone_prescriptions") 


earliest_obs_risperidone_prescription <- risperidone_prescriptions %>%
  filter(!is.na(issuedate)) %>%
  group_by(patid) %>%
  filter(issuedate == min(issuedate, na.rm = TRUE)) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) 



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



final_risperidone_cohort <- final_risperidone_cohort %>%
  filter(issuedate >= "2004-01-01") %>%
  analysis$cached(name = "final_risperidone_After2004", indexes = "patid")




# View(final_risperidone_cohort %>% collect() %>% select('DifferenceBetween_PrescriptionAndDiagnosis', 'Prescription_moreThan_Year_prior', 'Prescription_Within_Year_prior', 'PrescriptionAfterDiagnosis', 'issuedate', 'obsdate'))



result_table <- final_risperidone_cohort %>%
  count(Prescription_moreThan_Year_prior, Prescription_Within_Year_prior, PrescriptionAfterDiagnosis)
print(result_table)

R_cohort <- final_risperidone_cohort%>%
  filter(PrescriptionAfterDiagnosis==1) %>%
  analysis$cached(name = "final_risperidone_afterdiagnosis_cohort_2004", indexes = "patid")


R_cohort_linkedData <- R_cohort %>%
  semi_join(cprd$tables$patidsWithLinkage, by = "patid") %>%
  left_join(cprd$tables$patientImd2015 %>% 
              select(patid, imd2015_10) %>%
              rename(deprivation = imd2015_10), by = "patid") %>%
  analysis$cached(name = "final_risperidone_cohortLinkedData", indexes = "patid")



R_cohort <- R_cohort %>% collect()
table(R_cohort$gender)

table(R_cohort$died)

# view(R_cohort)




R_cohort_linkedData <- R_cohort_linkedData %>% collect()
table(R_cohort_linkedData$gender)

table(R_cohort_linkedData$died)

view(R_cohort_linkedData)


variables_of_interest <- c("diagnosedbeforeRegistration", "died", "ONS_died","death_composite", "primary_death_stroke","ethnicity",  "age_diagnosis", "age_risperidone", "age_category","HES_stroke",  "GP_stroke", "stroke_composite" , "year_of_diagnosis", "gender_decode",
                           "alcohol_cat",  "smoking_cat", "qrisk2_smoking_cat","qrisk2_smoking_cat_uncoded", "gp_qrisk2_ethnicity", "hes_qrisk2_ethnicity","gp_5cat_ethnicity","hes_5cat_ethnicity", 'Prescription_moreThan_Year_prior', 'Prescription_Within_Year_prior', 'PrescriptionAfterDiagnosis' , 
                           "gp_16cat_ethnicity", "hes_16cat_ethnicity"   
                           
                           
                           
)                 





binary_vars <- c("diagnosedbeforeRegistration", "died", "age_category", "year_of_diagnosis",
                 "alcohol_cat",  "smoking_cat", "qrisk2_smoking_cat","qrisk2_smoking_cat_uncoded", "gp_qrisk2_ethnicity", "hes_qrisk2_ethnicity","gp_5cat_ethnicity","hes_5cat_ethnicity", 
                 "gp_16cat_ethnicity", "hes_16cat_ethnicity" ,  "primary_death_stroke", 'Prescription_moreThan_Year_prior', 'Prescription_Within_Year_prior', 'PrescriptionAfterDiagnosis' ,
                 "HES_stroke", "HES_pre_stroke", "HES_post_stroke", "ONS_died", "GP_stroke", "stroke_composite", "death_composite"
                 
)   




# View(FullData %>% select(variables_of_interest))
table <- R_cohort_linkedData %>% collect()

# binary_vars <-  c("diagnosedbeforeRegistration", "died", "age_category", "year_of_diagnosis", "gender_decode", 'Prescription_moreThan_Year_prior', 'Prescription_Within_Year_prior', 'PrescriptionAfterDiagnosis' )       

# View(FullData %>% select(binary_vars))

R_cohort_linkedData[binary_vars] <- lapply(R_cohort_linkedData[binary_vars], as.factor)


my_tableone <- CreateTableOne(vars = variables_of_interest, data = R_cohort_linkedData)

# Print the table

print(my_tableone)

#############################################

df <- LinkedData %>% collect()

confusion_matrix <- table(df$died, df$ONS_died)
print(confusion_matrix)
confusion_df <- as.data.frame(as.table(prop.table(confusion_matrix) * 100)) # Converting to percentages

# Create a heatmap plot
ggplot(confusion_df, aes(x = Var2, y = Var1, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.1f%%", Freq))) +  # Showing percentages
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(x = "ONS Died", y = "GP Died", title = "Confusion Matrix of GP Died vs ONS Died") +
  theme_minimal()




confusion_matrix <- table(df$GP_stroke, df$HES_stroke)
print(confusion_matrix)
confusion_df <- as.data.frame(as.table(prop.table(confusion_matrix) * 100)) # Converting to percentages

# Create a heatmap plot
ggplot(confusion_df, aes(x = Var2, y = Var1, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.1f%%", Freq))) +  # Showing percentages
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(x = "HES_stroke", y = "GP_stroke", title = "Confusion Matrix of GP_stroke vs HES_stroke") +
  theme_minimal()




# Create the confusion matrix for the ethnicity variable
confusion_matrix <- table(df$gp_5cat_ethnicity, df$hes_5cat_ethnicity)
print(confusion_matrix)
confusion_df <- as.data.frame(as.table(prop.table(confusion_matrix) * 100)) # Converting to percentages

# Create a heatmap plot
ggplot(confusion_df, aes(x = Var2, y = Var1, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.1f%%", Freq))) +  # Showing percentages
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(x = "hes_5cat_ethnicity", y = "gp_5cat_ethnicity", title = "Confusion Matrix of ethnicity") +
  theme_minimal()



