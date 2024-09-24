############################################################################################
# Setup
library(tidyverse)
library(aurum)
library(EHRBiomarkr)
rm(list=ls())

cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")
codesets = cprd$codesets()
codes = codesets$getAllCodeSetVersion(v = "31/10/2021")
current_list <- codesets$listCodeSets()


# minimum_date <- as.Date("2018-01-01")
# index_date <- as.Date("2020-07-01")
# end_date <- as.Date("2020-10-31")

analysis_prefix <- "Joshua"
analysis = cprd$analysis(analysis_prefix)

############################################################################################


# Define comorbidities
## If you add comorbidity to the end of this list, code should run fine to incorporate new comorbidity, as long as you delete final 'mm_comorbidities' table

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
  "qof_diabetes",
  'anxiety_disorders',
  'fh_diabetes',
  'fh_premature_cvd',
  ###### add-ons
  'schizophrenia',
  'bipolar_disorder',
  'care_home',
  'frailty_simple',
  'pulmonary_embolism',
  'deep_vein_thrombosis',
  'haem_cancer',
  'solid_cancer',
  'hearing_loss',
  
  'haemorrhagicstroke',
  'ischaemicstroke'
  
)


############################################################################################

# Pull out all raw code instances and cache with 'all_patid' prefix
## Some of these already exist from previous analyses
## Don't want to include ICD10 codes for hypertension - previous note from Andy: "Hypertension is really a chronic condition and it should really be diagnosed in primary care. I would be suspicious of the diagnosis in people with only a HES code. Might be one to look at in future and see if it triangulates with treatment (but a very low priority item I would say) - trust the GPs on hypertension."
## Can also decide whether only want primary reasons for hospitalisation (d_order=1) for ICD10 codes - see bottom of this section

analysis = cprd$analysis("Joshua")


for (i in comorbids) {
  
  if (length(codes[[i]]) > 0) {
    print(paste("making", i, "medcode table"))
    
    raw_tablename <- paste0("raw_", i, "_medcodes")
    
    data <- cprd$tables$observation %>%
      inner_join(codes[[i]], by="medcodeid") %>%
      analysis$cached(raw_tablename, indexes=c("patid", "obsdate"))
    
    assign(raw_tablename, data)
    
  }
  
  if (length(codes[[paste0("icd10_", i)]]) > 0) {
    print(paste("making", i, "ICD10 code table"))
    
    raw_tablename <- paste0("raw_", i, "_icd10")
    
    data <- cprd$tables$hesDiagnosisEpi %>%
      inner_join(codes[[paste0("icd10_",i)]], sql_on="LHS.ICD LIKE CONCAT(icd10,'%')") %>%
      analysis$cached(raw_tablename, indexes=c("patid", "epistart"))
    
    assign(raw_tablename, data)
    
  }
  
  
}


#################################### cleaning
for (i in comorbids) {
  
  
  
  print(i)
  if (length(codes[[i]]) > 0) {
    print(paste("making", i, "medcode table"))
  
  raw_tablename <- paste0("raw_", i, "_medcodes")
  clean_tablename <- paste0("clean_", i, "_medcodes")
  data <- get(raw_tablename) %>%
    inner_join(cprd$tables$validDateLookup, by="patid") %>%
    #filter(obsdate>=min_dob & obsdate<=gp_ons_end_date) %>%  #gp_ons_end_date not available on this dataset
    filter(obsdate>=min_dob & obsdate<=gp_end_date) %>%
    analysis$cached(clean_tablename, indexes=c("patid"))
  
  assign(clean_tablename, data)
  }
  
  
  
  if (length(codes[[paste0("icd10_", i)]]) > 0) {
    print(paste("making", i, "ICD10 code table"))
    
    raw_tablename <- paste0("raw_", i, "_icd10")
    
    
    
    clean_tablename <- paste0("clean_", i, "_icd10")
    data <- get(raw_tablename) %>%
      inner_join(cprd$tables$validDateLookup, by="patid") %>%
      #filter(obsdate>=min_dob & obsdate<=gp_ons_end_date) %>%  #gp_ons_end_date not available on this dataset
      filter(epistart>=min_dob & epistart<=gp_end_date) %>%
      analysis$cached(clean_tablename, indexes=c("patid"))
    
    
    # 
    # data <- cprd$tables$hesDiagnosisEpi %>%
    #   inner_join(codes[[paste0("icd10_",i)]], sql_on="LHS.ICD LIKE CONCAT(icd10,'%')") %>%
    #   analysis$cached(raw_tablename, indexes=c("patid", "epistart"))
    
    assign(clean_tablename, data)
    
  }
  
}

# Make new primary cause hospitalisation for heart failure, incident MI, and incident stroke comorbidities

# raw_primary_hhf_icd10 <- raw_heartfailure_icd10 %>%
#   filter(d_order==1) %>%
#   analysis$cached("raw_primary_hhf_icd10", indexes=c("patid", "epistart"))
# 
# raw_primary_incident_mi_icd10 <- raw_incident_mi_icd10 %>%
#   filter(d_order==1) %>%
#   analysis$cached("raw_primary_incident_mi_icd10", indexes=c("patid", "epistart"))
# 
# raw_primary_incident_stroke_icd10 <- raw_incident_mi_icd10 %>%
#   filter(d_order==1) %>%
#   analysis$cached("raw_primary_incident_stroke_icd10", indexes=c("patid", "epistart"))
# 
# 
# ## Add to beginning of list so don't have to remake interim (shortened to _im due to restrictions in identifier length in MySQL) tables when add new comorbidity to end of above list
# comorbids <- c("primary_hhf", "primary_incident_mi", "primary_incident_stroke", comorbids)


############################################################################################

# analysis = cprd$analysis(analysis_prefix) #dit was "mm" maar daaronder kan ik het niet opslaan omdat er daar al een table bestaat
# 
# 
# # Add in CV and HF and KF death outcomes
# ## Do for all IDs as quicker
# ## No patid duplicates in ONS death table so dont need to worry about these
# 
death_causes <- cprd$tables$onsDeath %>%
  select(patid, starts_with("cause"), dod) %>%
  rename(primary_death_cause=cause,
         secondary_death_cause1=cause1,
         secondary_death_cause2=cause2,
         secondary_death_cause3=cause3,
         secondary_death_cause4=cause4,
         secondary_death_cause5=cause5,
         secondary_death_cause6=cause6,
         secondary_death_cause7=cause7,
         secondary_death_cause8=cause8,
         secondary_death_cause9=cause9,
         secondary_death_cause10=cause10,
         secondary_death_cause11=cause11,
         secondary_death_cause12=cause12,
         secondary_death_cause13=cause13,
         secondary_death_cause14=cause14,
         secondary_death_cause15=cause15)






# Define a function to process primary death causes for each comorbidity
process_primary_death <- function(comorbidity) {
  comorbidity_code <- paste0("icd10_", comorbidity)
  
  if (length(codes[[comorbidity_code]]) > 0) {
    print(paste("processing primary death cause for", comorbidity))
    
    primary_death_column <- paste0("primary_death_", comorbidity)
    primary_death_table <- paste0("death_", comorbidity, "_primary")
    
    data <- death_causes %>%
      inner_join(codes[[comorbidity_code]], sql_on = "LHS.primary_death_cause LIKE CONCAT(icd10,'%')") %>%
      select(patid, dod, primary_death_cause) %>%
      rename(date_of_death = dod) %>%
      mutate(!!primary_death_column := 1L) %>%
      analysis$cached(primary_death_table, unique_indexes = "patid")
    
    assign(primary_death_table, data)
  } 
}



# Process primary death causes for all comorbidities
for (comorbidity in comorbids) {
  process_primary_death(comorbidity)
}






# ####################################secondary cause of death
# 
# 
# # Define a function to process secondary death causes for each comorbidity
# process_secondary_death <- function(comorbidity) {
#   comorbidity_code <- paste0("icd10_", comorbidity)
#   
#   if (length(codes[[comorbidity_code]]) > 0) {
#     print(paste("Processing secondary death cause for", comorbidity))
#     
#     secondary_death_column <- paste0("secondary_death_", comorbidity)
#     secondary_death_table <- paste0("death_", comorbidity, "_secondary")
#     
#     data <- death_causes %>%
#       inner_join(codes[[comorbidity_code]], sql_on = "LHS.secondary_death_cause1 LIKE CONCAT(icd10,'%')") %>%
#       select(patid, dod) %>%
#       rename(date_of_death = dod) %>%
#       mutate(!!secondary_death_column := 1L) %>%
#       analysis$cached(secondary_death_table, unique_indexes = "patid")
#     
#     assign(secondary_death_table, data)
#   }
# }
# 
# # Process primary and secondary death causes for all comorbidities
# for (comorbidity in comorbids) {
#   process_primary_death(comorbidity)
#   process_secondary_death(comorbidity)
# }
# # 
# # Primary cause
# 
# cv_death_primary <- death_causes %>%
#   inner_join(codes$icd10_cv_death, sql_on="LHS.primary_death_cause LIKE CONCAT(icd10,'%')") %>%
#   select(patid) %>%
#   mutate(cv_death_primary_cause=1L) %>%
#   analysis$cached("death_cv_primary", unique_indexes="patid")
# 
# hf_death_primary <- death_causes %>%
#   inner_join(codes$icd10_heartfailure, sql_on="LHS.primary_death_cause LIKE CONCAT(icd10,'%')") %>%
#   select(patid)%>%
#   mutate(hf_death_primary_cause=1L) %>%
#   analysis$cached("death_hf_primary", unique_indexes="patid")
# 
# kf_death_primary <- death_causes %>%
#   inner_join(codes$icd10_kf_death, sql_on="LHS.primary_death_cause LIKE CONCAT(icd10,'%')") %>%
#   select(patid) %>%
#   mutate(kf_death_primary_cause=1L) %>%
#   analysis$cached("death_kf_primary", unique_indexes="patid")
# 
# 
# # Secondary causes
# ## Reshape as easier
# 
# secondary_death_causes <- death_causes %>%
#   select(patid, secondary_death_cause1:secondary_death_cause15) %>%
#   pivot_longer(cols=-patid, values_to="secondary_death_cause")
# 
# cv_death_secondary <- secondary_death_causes %>%
#   inner_join(codes$icd10_cv_death, sql_on="LHS.secondary_death_cause LIKE CONCAT(icd10,'%')") %>%
#   distinct(patid) %>%
#   analysis$cached("death_cv_secondary", unique_indexes="patid")
# 
# hf_death_secondary <- secondary_death_causes %>%
#   inner_join(codes$icd10_heartfailure, sql_on="LHS.secondary_death_cause LIKE CONCAT(icd10,'%')") %>%
#   distinct(patid) %>%
#   analysis$cached("death_hf_secondary", unique_indexes="patid")
# 
# kf_death_secondary <- secondary_death_causes %>%
#   inner_join(codes$icd10_kf_death, sql_on="LHS.secondary_death_cause LIKE CONCAT(icd10,'%')") %>%
#   distinct(patid) %>%
#   analysis$cached("death_kf_secondary", unique_indexes="patid")
# 
# 
# # Join primary and secondary for any cause
# 
# cv_death_any <- cv_death_primary %>%
#   select(-cv_death_primary_cause) %>%
#   union(cv_death_secondary) %>%
#   mutate(cv_death_any_cause=1L) %>%
#   analysis$cached("death_cv_any", unique_indexes="patid")
# 
# hf_death_any <- hf_death_primary%>%
#   select(-hf_death_primary_cause) %>%
#   union(hf_death_secondary) %>%
#   mutate(hf_death_any_cause=1L) %>%
#   analysis$cached("death_hf_any", unique_indexes="patid")
# 
# kf_death_any <- kf_death_primary%>%
#   select(-kf_death_primary_cause) %>%
#   union(kf_death_secondary) %>%
#   mutate(kf_death_any_cause=1L) %>%
#   analysis$cached("death_kf_any", unique_indexes="patid")
# 
# ## Join together and with all primary and secondary cause
# 
# death_causes <- cprd$tables$onsDeath %>%
#   select(patid, starts_with("cause")) %>%
#   rename(primary_death_cause=cause,
#          secondary_death_cause1=cause1,
#          secondary_death_cause2=cause2,
#          secondary_death_cause3=cause3,
#          secondary_death_cause4=cause4,
#          secondary_death_cause5=cause5,
#          secondary_death_cause6=cause6,
#          secondary_death_cause7=cause7,
#          secondary_death_cause8=cause8,
#          secondary_death_cause9=cause9,
#          secondary_death_cause10=cause10,
#          secondary_death_cause11=cause11,
#          secondary_death_cause12=cause12,
#          secondary_death_cause13=cause13,
#          secondary_death_cause14=cause14,
#          secondary_death_cause15=cause15) %>%
#   left_join(cv_death_primary, by="patid") %>%
#   left_join(cv_death_any, by="patid") %>%
#   left_join(hf_death_primary, by="patid") %>%
#   left_join(hf_death_any, by="patid") %>%
#   left_join(kf_death_primary, by="patid") %>%
#   left_join(kf_death_any, by="patid") %>%
#   analysis$cached("death_causes", unique_indexes="patid")


############################################################################################

# Clean and combine medcodes, ICD10 codes and OPCS4 codes, then merge with index date
## Remove medcodes before DOB or after lcd/deregistration/death
## Remove HES codes before DOB or after 31/10/2021 (latest date in HES records) or death
## NB: for baseline_biomarkers, cleaning and combining with index date is 2 separate steps, but as there are fewer cleaning steps for comorbidities I have made this one step here


# analysis = cprd$analysis(analysis_prefix)
# 
# 
# ## Clean comorbidity data and combine with index date
# 
# for (i in comorbids) {
#   
#   print(paste("merging index date with", i, "code occurrences"))
#   
#   index_date_merge_tablename <- paste0("full_", i, "_index_date_merge")
#   
#   medcode_tablename <- paste0("raw_", i, "_medcodes")
#   icd10_tablename <- paste0("raw_", i, "_icd10")
#   opcs4_tablename <- paste0("raw_", i, "_opcs4")
#   
#   
#   if (exists(medcode_tablename)) {
#     
#     medcodes <- get(medcode_tablename) %>%
#       select(patid, date=obsdate, code=medcodeid) %>%
#       mutate(source="gp")
#     
#   }
#   
#   if (exists(icd10_tablename)) {
#     
#     icd10_codes <- get(icd10_tablename) %>%
#       select(patid, date=epistart, code=ICD) %>%
#       mutate(source="hes_icd10")
#     
#   }
#   
#   if (exists(opcs4_tablename)) {
#     
#     opcs4_codes <- get(opcs4_tablename) %>%
#       select(patid, date=evdate, code=OPCS) %>%
#       mutate(source="hes_opcs4")
#     
#   }
#   
#   
#   if (exists("medcodes")) {
#     
#     all_codes <- medcodes
#     rm(medcodes)
#     
#     if(exists("icd10_codes")) {
#       all_codes <- all_codes %>%
#         union_all(icd10_codes)
#       rm(icd10_codes)
#     }
#     
#     if(exists("opcs4_codes")) {
#       all_codes <- all_codes %>%
#         union_all(opcs4_codes)
#       rm(opcs4_codes)
#     }
#   }
#   
#   else if (exists("icd10_codes")) {
#     
#     all_codes <- icd10_codes
#     rm(icd10_codes)
#     
#     if(exists("opcs4_codes")) {
#       all_codes <- all_codes %>%
#         union_all(opcs4_codes)
#       rm(opcs4_codes)
#     }
#   }
#   
#   else if(exists("opcs4_codes")) {
#     
#     all_codes <- opcs4_codes
#     rm(opcs4_codes)
#   }
#   
#   all_codes_clean <- all_codes %>%
#     inner_join(cprd$tables$validDateLookup, by="patid") %>%
#     filter(date>=min_dob & ((source=="gp" & date<=gp_end_date) | ((source=="hes_icd10" | source=="hes_opcs4") & (is.na(gp_end_date) | date<=gp_end_date)))) %>% ## first gp_end_date was gp_ons-end_date; latter 2 were gp_ons_death_date
#     select(patid, date, source, code)
#   
#   rm(all_codes)
#   
#   data <- all_codes_clean %>%
#     mutate(datediff=datediff(date, index_date)) %>%
#     analysis$cached(index_date_merge_tablename, index="patid")
#   
#   rm(all_codes_clean)
#   
#   assign(index_date_merge_tablename, data)
#   
#   rm(data)
#   
# }
# 
# 
# ############################################################################################
# 
# # Find earliest pre-index date, latest pre-index date and first post-index date dates
# 
# comorbidities <- cprd$tables$patient %>%
#   select(patid)
# 
# for (i in comorbids) {
#   
#   print(paste("working out pre- and post-index date code occurrences for", i))
#   
#   index_date_merge_tablename <- paste0("full_", i, "_index_date_merge")
#   interim_comorbidity_table <- paste0("comorbidities_interim_", i)
#   pre_index_date_earliest_date_variable <- paste0("pre_index_date_earliest_", i)
#   pre_index_date_latest_date_variable <- paste0("pre_index_date_latest_", i)
#   pre_index_date_variable <- paste0("pre_index_date_", i)
#   post_index_date_date_variable <- paste0("post_index_date_first_", i)
#   
#   pre_index_date <- get(index_date_merge_tablename) %>%
#     filter(date<=index_date) %>%
#     group_by(patid) %>%
#     summarise({{pre_index_date_earliest_date_variable}}:=min(date, na.rm=TRUE),
#               {{pre_index_date_latest_date_variable}}:=max(date, na.rm=TRUE)) %>%
#     ungroup()
#   
#   post_index_date <- get(index_date_merge_tablename) %>%
#     filter(date>index_date) %>%
#     group_by(patid,) %>%
#     summarise({{post_index_date_date_variable}}:=min(date, na.rm=TRUE)) %>%
#     ungroup()
#   
#   pre_index_date_earliest_date_variable <- as.symbol(pre_index_date_earliest_date_variable)
#   
#   comorbidities <- comorbidities %>%
#     left_join(pre_index_date, by="patid") %>%
#     mutate({{pre_index_date_variable}}:=!is.na(pre_index_date_earliest_date_variable)) %>%
#     left_join(post_index_date, by="patid") %>%
#     analysis$cached(interim_comorbidity_table, unique_indexes="patid")
# }
# 
# comorbidities <- comorbidities %>% analysis$cached("comorbidities_2020_jul", unique_indexes="patid")
