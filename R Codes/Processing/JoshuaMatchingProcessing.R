# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")



table <- table %>% analysis$cached("final_dementia_dementia_patients_cohort")
table %>% count()    ##### n = 301405

risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("Risperidone_Prescriptions") 
risperidone_prescriptions %>% count()    ##### n = 7621968


anti_psychotic <- anti_psychotic %>% analysis$cached("Other_Antipsychotic_Prescriptions")
anti_psychotic %>% count()    ##### n = 59,081,585


R_after_12Months <- R_after_12Months %>% analysis$cached("risperidone_after_dementiaDiagnoses")
R_after_12Months %>% count()    ##### n = 22252

View(R_after_12Months %>% collect())
subsetData <- table %>%
  filter((obsdate < "2004-01-01") & (regstartdate < "2004-01-01") & (pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE) >"2004-01-01"))

subsetData %>% count()
