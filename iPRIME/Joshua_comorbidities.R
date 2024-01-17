# Setup
library(tidyverse)
library(aurum)
library(EHRBiomarkr)
rm(list=ls())

cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")

codesets = cprd$codesets()
codes = codesets$getAllCodeSetVersion(v = "31/10/2021")
current_list <- codesets$listCodeSets()



analysis_prefix <- "Joshua_comorbidities"
analysis = cprd$analysis(analysis_prefix)

############################################################################################


heart_failure <- cprd$tables$observation %>%
  inner_join(codes$heartfailure, by="medcodeid") %>%
  analysis$cached("heart_failure", indexes=c("patid", "obsdate"))


#############################  myocardialinfarction ##############################


myocardial_infarction <- cprd$tables$observation %>%
  inner_join(codes$myocardialinfarction, by="medcodeid") %>%
  analysis$cached("myocardial_infarction", indexes=c("patid", "obsdate"))


#############################  hypertension ##############################


hypertension <- cprd$tables$observation %>%
  inner_join(codes$hypertension, by="medcodeid") %>%
  analysis$cached("hypertension", indexes=c("patid", "obsdate"))




#############################  angina ##############################


angina <- cprd$tables$observation %>%
  inner_join(codes$angina, by="medcodeid") %>%
  analysis$cached("angina", indexes=c("patid", "obsdate"))

#############################  fall ##############################


fall <- cprd$tables$observation %>%
  inner_join(codes$falls, by="medcodeid") %>%
  analysis$cached("fall", indexes=c("patid", "obsdate"))

#############################  stroke ##############################

stroke <- cprd$tables$observation %>%
  inner_join(codes$stroke, by="medcodeid") %>%
  analysis$cached("stroke", indexes=c("patid", "obsdate", "stroke_cat"))

#############################  lowerlimbfracture ##############################

lowerlimbfracture <- cprd$tables$observation %>%
  inner_join(codes$lowerlimbfracture, by="medcodeid") %>%
  analysis$cached("lowerlimbfracture", indexes=c("patid", "obsdate"))

