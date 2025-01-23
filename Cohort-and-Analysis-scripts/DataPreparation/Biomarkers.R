
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


table <- cprd$tables$validDateLookup
table %>% count() # 0

# clean_biomarker_values uses weight limits for adults
# Values <40, >350 and missing values removed
# Error in `filter()`:
#   ℹ In argument: `obsdate >= min_dob & obsdate <= gp_end_date`
# Caused by error:
#   ! Object `min_dob` not found.
# Run `rlang::last_trace()` to see where the error occurred.

# HbA1c

# clean_hba1c_medcodes <- raw_hba1c_medcodes %>%
#   
#   mutate(testvalue=ifelse(testvalue<=20,((testvalue-2.152)/0.09148),testvalue)) %>%
#   
#   clean_biomarker_values(testvalue, "hba1c") %>%
#   clean_biomarker_units(numunitid, "hba1c") %>%
#   
#   group_by(patid,obsdate) %>%
#   summarise(testvalue=mean(testvalue, na.rm=TRUE)) %>%
#   ungroup() %>%
#   
#   inner_join(cprd$tables$validDateLookup, by="patid") %>%
#   # filter(obsdate>=min_dob & obsdate<=gp_ons_end_date & year(obsdate)>=1990) %>%
#   filter(obsdate>=min_dob & obsdate<=gp_end_date & year(obsdate)>=1990) %>%
#   
#   select(patid, date=obsdate, testvalue) %>%
#   
#   analysis$cached("clean_hba1c_medcodes", indexes=c("patid", "date", "testvalue"))



############################################################################################

# Combine each biomarker with index date

## Get index date

analysis = cprd$analysis(analysis_prefix)

index_date <- as.Date("2020-07-01")


## Merge with biomarkers and calculate date difference between biomarker and index date

for (i in biomarkers) {
  
  print(i)
  
  clean_tablename <- paste0("clean_", i, "_medcodes")
  index_date_merge_tablename <- paste0("full_", i, "_index_date_2020_merge")
  
  data <- get(clean_tablename) %>%
    mutate(datediff=datediff(date, index_date))
  
  assign(index_date_merge_tablename, data)
  
}


# HbA1c

full_hba1c_index_date_2020_merge <- clean_hba1c_medcodes %>%
  mutate(datediff=datediff(date, index_date))


############################################################################################

# Find baseline values
## Within period defined above (-2 years to +7 days for all except HbA1c and height)
## Then use closest date to index date
## May be multiple values; use minimum test result, except for eGFR - use maximum
## Can get duplicates where person has identical results on the same day/days equidistant from the index date - choose first row when ordered by datediff

biomarkers_2020 <- cprd$tables$patient %>%
  select(patid)


## For all except HbA1c and height: between 2 years prior and 7 days after index date

biomarkers_no_height <- setdiff(biomarkers, "height")

for (i in biomarkers_no_height) {
  
  print(i)
  
  index_date_merge_tablename <- paste0("full_", i, "_index_date_2020_merge")
  interim_2020_biomarker_table <- paste0("biomarkers_2020_interim_", i)
  pre_biomarker_variable <- paste0("pre", i)
  pre_biomarker_date_variable <- paste0("pre", i, "date")
  pre_biomarker_datediff_variable <- paste0("pre", i, "datediff")
  
  
  data <- get(index_date_merge_tablename) %>%
    filter(datediff<=7 & datediff>=-730) %>%
    
    group_by(patid) %>%
    
    mutate(min_timediff=min(abs(datediff), na.rm=TRUE)) %>%
    filter(abs(datediff)==min_timediff) %>%
    
    mutate(pre_biomarker=ifelse(i=="egfr", max(testvalue, na.rm=TRUE), min(testvalue, na.rm=TRUE))) %>%
    filter(pre_biomarker==testvalue) %>%
    
    dbplyr::window_order(datediff) %>%
    filter(row_number()==1) %>%
    
    ungroup() %>%
    
    relocate(pre_biomarker, .after=patid) %>%
    relocate(date, .after=pre_biomarker) %>%
    relocate(datediff, .after=date) %>%
    
    rename({{pre_biomarker_variable}}:=pre_biomarker,
           {{pre_biomarker_date_variable}}:=date,
           {{pre_biomarker_datediff_variable}}:=datediff) %>%
    
    select(-c(testvalue, min_timediff))
  
  
  biomarkers_2020 <- biomarkers_2020 %>%
    left_join(data, by="patid") %>%
    analysis$cached(interim_2020_biomarker_table, unique_indexes="patid")
  
}


## Height - only keep readings at/post-index date, and find mean

height_2020 <- full_height_index_date_2020_merge %>%
  filter(datediff>=0) %>%
  group_by(patid) %>%
  summarise(height=mean(testvalue, na.rm=TRUE)) %>%
  ungroup()

biomarkers_2020 <- biomarkers_2020 %>%
  left_join(height_2020, by="patid")


## HbA1c: only between 6 months prior and 7 days after index date
### NB: in treatment response cohort, baseline HbA1c set to missing if occurs before previous treatment change

hba1c_2020 <- full_hba1c_index_date_2020_merge %>%
  
  filter(datediff<=7 & datediff>=-183) %>%
  
  group_by(patid) %>%
  
  mutate(min_timediff=min(abs(datediff), na.rm=TRUE)) %>%
  filter(abs(datediff)==min_timediff) %>%
  
  mutate(prehba1c=min(testvalue, na.rm=TRUE)) %>%
  filter(prehba1c==testvalue) %>%
  
  dbplyr::window_order(datediff) %>%
  filter(row_number()==1) %>%
  
  ungroup() %>%
  
  relocate(prehba1c, .after=patid) %>%
  relocate(date, .after=prehba1c) %>%
  relocate(datediff, .after=date) %>%
  
  rename(prehba1cdate=date,
         prehba1cdatediff=datediff) %>%
  
  select(-c(testvalue, min_timediff))


## Join HbA1c to main table

analysis = cprd$analysis(analysis_prefix)

biomarkers_2020 <- biomarkers_2020 %>%
  left_join(hba1c_2020, by="patid") %>% 
  analysis$cached("biomarkers_2020_jul", unique_indexes="patid")
