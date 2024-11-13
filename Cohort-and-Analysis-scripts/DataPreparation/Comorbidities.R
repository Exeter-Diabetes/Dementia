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










