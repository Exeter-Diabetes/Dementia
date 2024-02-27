# Setup
library(aurum)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list=ls())
library(bit64)
cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")
analysis = cprd$analysis("Joshua")

analysis_ethn = cprd$analysis("all_patid")
Ethnicity <- Ethnicity %>% analysis_ethn$cached("ethnicity")
# Ethnicity <- Ethnicity %>% analysis$cached("ethnicity_copied")


######### Reading all dementia dementia patient ######################################################
table <- table %>% analysis$cached("dementia_dementia_all_patients_final")
table %>% count()    ##### n = 1528238
# This data was created by using the following SQL script

    # CREATE TABLE full_cprd_analysis_dev.Joshua_dementia_dementia_all_patients_final AS
    # SELECT
    # o.*,
    # p.usualgpstaffid, p.gender, p.yob, p.mob, p.emis_ddate, p.regstartdate, p.patienttypeid, p.regenddate, p.acceptable, p.cprd_ddate,
    # pr.lcd, pr.region,
    # c.setname, c.version
    # FROM
    # full_cprd_data.observation AS o
    # JOIN
    # full_cprd_data.patient AS p ON o.patid = p.patid
    # JOIN
    # full_cprd_data.practice AS pr ON p.pracid = pr.pracid
    # JOIN
    # full_cprd_analysis_dev.code_sets AS c ON o.medcodeid = c.codeid
    # WHERE
    # c.setname = 'dementiadementiacodelist';

Schizophrenia <- Schizophrenia %>% analysis$cached("schizophrenia_patients")

      # CREATE TABLE full_cprd_analysis_dev.Joshua_schizophrenia_patients AS
      # SELECT
      # obs.*,
      # codes.*,
      # pat.usualgpstaffid,
      # pat.gender,
      # pat.yob,
      # pat.mob,
      # pat.emis_ddate,
      # pat.regstartdate,
      # pat.patienttypeid,
      # pat.regenddate,
      # pat.acceptable,
      # pat.cprd_ddate
      # FROM
      # full_cprd_data.observation AS obs
      # JOIN
      # full_cprd_analysis_dev.code_sets AS codes ON obs.medcodeid = codes.codeid
      # JOIN
      # full_cprd_data.patient AS pat ON obs.patid = pat.patid
      # WHERE
      # codes.setname = 'schizophrenia';
Schizophrenia %>% count() ### 794737
bipolar_disorder <- bipolar_disorder %>% analysis$cached("bipolardisoder_patients")

    # CREATE TABLE full_cprd_analysis_dev.Joshua_bipolardisoder_patients AS
    # SELECT
    # obs.*,
    # codes.*,
    # pat.usualgpstaffid,
    # pat.gender,
    # pat.yob,
    # pat.mob,
    # pat.emis_ddate,
    # pat.regstartdate,
    # pat.patienttypeid,
    # pat.regenddate,
    # pat.acceptable,
    # pat.cprd_ddate
    # FROM
    # full_cprd_data.observation AS obs
    # JOIN
    # full_cprd_analysis_dev.code_sets AS codes ON obs.medcodeid = codes.codeid
    # JOIN
    # full_cprd_data.patient AS pat ON obs.patid = pat.patid
    # WHERE
    # codes.setname = 'bipolar_disorder';

bipolar_disorder %>% count() ## 1091851




############# Selecting the earliest observation ##########################################################
earliest_obs <- table %>%
  filter(!is.na(obsdate) & acceptable == 1) %>%
  group_by(patid) %>%
  filter(obsdate == min(obsdate, na.rm = TRUE)) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) %>%
  left_join(Ethnicity, by = "patid") %>%
  anti_join(Schizophrenia, by = "patid") %>%
  anti_join(bipolar_disorder, by = "patid") %>%
  mutate(
    missing_ethnicity = as.numeric(is.na(ethnicity_5cat) & is.na(ethnicity_16cat) & is.na(ethnicity_qrisk2))
  )

# exc_schizo <- earliest_obs %>% 
#   anti_join(Schizophrenia, by = "patid")
# exc_schizo %>% count() ### 334532
# 
# common_patids_count <- earliest_obs %>%
#   semi_join(Schizophrenia, by = "patid") %>%
#   distinct(patid) 
# common_patids_count %>% count()  ##### 2554
# 
# common_patids_count_bipolar <- earliest_obs %>%
#   semi_join(bipolar_disorder, by = "patid") %>%
#   distinct(patid) 
# common_patids_count_bipolar %>% count()  ##### 6579



earliest_obs %>% count() ### 334532


dementia_dementia_earliest_obs_patients <- earliest_obs %>% 
  select('patid', 'obsdate') %>%
  analysis$cached(name = "dementia_dementia_earliest_obs_patients", indexes = c("patid", "obsdate"))


earliest_obs %>% count() #####  n = 334532
earliest_observation_data <- earliest_obs %>%
  mutate(
    regenddate = ifelse(is.na(regenddate), as.Date("2021-06-01"), regenddate),
    diagnosedbefore = ifelse(obsdate < regstartdate, 0, 1),
    died = ifelse(is.na(cprd_ddate), 0, 1),
    gender_decode = case_when(
      gender == 1 ~ 'M',
      gender == 2 ~ 'F',
      gender == 3 ~ 'I',
      TRUE ~ 'U'
    ),
    dob = ifelse(!is.na(yob) & !is.na(mob), 15,
                 ifelse(!is.na(yob) & is.na(mob), 1, NA_integer_)),
    mob = ifelse(!is.na(yob) & is.na(mob), 7, mob),
    date_of_birth = if_else(
      !is.na(yob) & !is.na(mob) & !is.na(dob),
      as.Date(paste(yob, ifelse(mob < 10, paste0("0", mob), as.character(mob)),
                    ifelse(dob < 10, paste0("0", dob), as.character(dob)),
                    sep = "-")),
      NA_real_
    ),
    regstartdate = ifelse(regstartdate < date_of_birth, NA, regstartdate)
  ) %>%collect() %>%
  mutate(
    age_diagnosis = floor(as.numeric(difftime(obsdate, date_of_birth))/365.25),
    Diff_start_endOfFollowup = as.numeric((as.Date(pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE)) - as.Date(pmax(obsdate, regstartdate, na.rm = TRUE)))/365.25),
    endoffollowup = pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE),
    age_category = cut(
      age_diagnosis,
      breaks = c(65, 75, 85, 95, Inf),
      labels = c("65-74", "75-84", "85-94", "95+"),
      right = FALSE
    ),
    year_of_diagnosis = year(obsdate),
    YrOfDiag_cat = cut(
      year_of_diagnosis,
      breaks = c(1989, 1995, 2000, 2005, 2010, 2015, 2020, Inf),
      labels = c(1, 2, 3, 4, 5, 6, 7)
    )
  )


Over65 <- earliest_observation_data %>%
  filter(age_diagnosis >= 65)
Over65 %>% count() ### n = 321375


diedB42004 <- Over65 %>%
  filter(cprd_ddate < as.Date("2004-01-01"))
diedB42004 %>% count()   ### n = 19970


Over65_final <- Over65 %>%
  filter(!(patid %in% diedB42004$patid))
Over65_final %>% count()  #### n = 301405





##################################################################################################################


risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("Risperidone_Prescriptions") 

earliest_obs_risperidone_prescription <- risperidone_prescriptions %>%
  filter(!is.na(issuedate)) %>%
  group_by(patid) %>%
  filter(issuedate == min(issuedate, na.rm = TRUE)) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) 

earliest_obs_risperidone_prescription %>% count()


final_risperidone_cohort <- inner_join(
  earliest_obs_risperidone_prescription %>% collect,
  Over65_final,
  by = "patid"
) %>%
  mutate(
    pracid = coalesce(pracid.x, pracid.y),
    probobsid = coalesce(probobsid.x, probobsid.y),
    enterdate = coalesce(enterdate.x, enterdate.y),
    staffid = coalesce(staffid.x, staffid.y),
    months_difference = as.numeric(as.numeric(issuedate - obsdate) / (30.44)),  # Convert to months
    lessThanMinus12_months = ifelse(months_difference < -12, 1, 0),
    between0andMinus12_months = ifelse(months_difference <= 0 & months_difference >= -12, 1, 0),
    positive_months = ifelse(months_difference > 0, 1, 0)
  ) %>%
  select(-ends_with(".x"), -ends_with(".y"))

final_risperidone_cohort %>% count()

final_risperidone_cohort <- final_risperidone_cohort %>%
  filter(issuedate >= "2004-01-01")

final_risperidone_cohort %>% count()

View(final_risperidone_cohort %>% select('months_difference', 'lessThanMinus12_months', 'between0andMinus12_months', 'positive_months', 'issuedate', 'obsdate'))

final_risperidone_cohort %>% count()


result_table <- final_risperidone_cohort %>%
  count(lessThanMinus12_months, between0andMinus12_months, positive_months)
print(result_table)