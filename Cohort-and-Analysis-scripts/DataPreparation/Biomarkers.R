
# Extracts and cleans all biomarker values (and creates eGFR readings from creatinine if not already done in all_patid_ckd_stages script)

# Merges with index date

# Finds biomarker values at baseline (index date): -2 years to +7 days relative to index date for all except:
## HbA1c: -6 months to +7 days
## Height: mean of all values >= index date

# NB: creatinine_blood and eGFR tables may already have been cached as part of all_patid_ckd_stages script
## and HbA1c tables may already have been cached as part of all_diabetes_cohort script


############################################################################################

# Setup
library(tidyverse)
library(aurum)
library(EHRBiomarkr)
rm(list=ls())

cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")

codesets = cprd$codesets()
codes = codesets$getAllCodeSetVersion(v = "31/10/2021")

analysis_prefix <- "Joshua"

analysis = cprd$analysis(analysis_prefix)



############################################################################################

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
############################################################################################

# Pull out all raw biomarker values and cache

# analysis = cprd$analysis("all_patid")

for (i in biomarkers) {
  
  print(i)
  
  raw_tablename <- paste0("raw_", i, "_medcodes")
  
  data <- cprd$tables$observation %>%
    inner_join(codes[[i]], by="medcodeid") %>%
    analysis$cached(raw_tablename, indexes=c("patid", "obsdate", "testvalue", "numunitid"))
  
  assign(raw_tablename, data)
  
}


# HbA1c

# raw_hba1c_medcodes <- cprd$tables$observation %>%
#   inner_join(codes$hba1c, by="medcodeid") %>%
#   analysis$cached("raw_hba1c_medcodes", indexes=c("patid", "obsdate", "testvalue", "numunitid"))


############################################################################################

# Clean biomarkers:
## Only keep those within acceptable value limits
## Only keep those with valid unit codes (numunitid)
## If multiple values on the same day, take mean
## Remove those with invalid dates (before DOB or after LCD/death/deregistration)
### HbA1c only: remove if <1990 and assume in % and convert to mmol/mol if <=20 (https://github.com/Exeter-Diabetes/CPRD-Codelists#hba1c)


# analysis = cprd$analysis("all_patid")


for (i in biomarkers) {
  
  print(i)
  
  raw_tablename <- paste0("raw_", i, "_medcodes")
  clean_tablename <- paste0("clean_", i, "_medcodes")
  print("we are here")
  data <- get(raw_tablename) %>%
    clean_biomarker_values(testvalue, i) %>%
    clean_biomarker_units(numunitid, i) %>%
    
    group_by(patid,obsdate) %>%
    summarise(testvalue=mean(testvalue, na.rm=TRUE)) %>%
    ungroup() %>%
    
    inner_join(cprd$tables$validDateLookup, by="patid") %>%
    #filter(obsdate>=min_dob & obsdate<=gp_ons_end_date) %>%  #gp_ons_end_date not available on this dataset
    filter(obsdate>=min_dob & obsdate<=gp_end_date) %>%
    
    select(patid, date=obsdate, testvalue) %>%
    
    analysis$cached(clean_tablename, indexes=c("patid", "date", "testvalue"))
  
  assign(clean_tablename, data)
  
}


