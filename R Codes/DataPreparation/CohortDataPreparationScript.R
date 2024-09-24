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

cprd = CPRDData$new(cprdEnv = "test-remote", cprdConf = "~/.aurum.yaml")

codesets = cprd$codesets()
codes = codesets$getAllCodeSetVersion(v = "31/10/2021")

analysis = cprd$analysis("Joshua")


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

#    analysis$cached(name = "all_dementia_patient", indexes = "patid")

table %>% count() ### 3,499,192

bipolar_disorder<- bipolar_disorder %>% analysis$cached("raw_bipolar_disorder_medcodes")
schizophrenia<- schizophrenia %>% analysis$cached("raw_schizophrenia_medcodes")

# view(earliest_obs %>% collect())
ExcludingSchizophreniaBipolar <- table %>%
  anti_join(bipolar_disorder, by = "patid") %>%
  anti_join(schizophrenia, by = "patid") %>%
  analysis$cached(name = "all_clean_Obs_withoutSchizo_Bipolar_final", indexes = "patid")

ExcludingSchizophreniaBipolar %>% count() ### 3,359,895

observation_data <- ExcludingSchizophreniaBipolar %>%
  mutate(
    regenddate = ifelse(is.na(regenddate), as.Date("2023-11-30"), regenddate),
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
    cprd_ddate = ifelse(is.na(cprd_ddate),as.Date("3999-01-01"),cprd_ddate),
    # regstartdate = ifelse(regstartdate < date_of_birth, NA, regstartdate)
  ) %>%
  # filter((obsdate > date_of_birth) & ((obsdate < lcd) | (obsdate < regenddate) | (obsdate < cprd_ddate))) %>%
  filter((obsdate > date_of_birth) & (obsdate < regenddate) & (obsdate < lcd) & (obsdate < cprd_ddate)) %>%
  # filter((obsdate > date_of_birth) & (obsdate < pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE))) %>%
  # filter((obsdate > date_of_birth) | (obsdate < pmin(regenddate, cprd_ddate, lcd, na.rm = TRUE))) %>%
  analysis$cached(name = "all_clean_dementia_observations_final", indexes = "patid")


# table((observation_data %>% collect())$year(obsdate))

observation_data %>% count() ### 3,336,262

intermediate <- observation_data %>%
  group_by(patid) %>%
  mutate(earliest_obsdate = min(obsdate)) %>%
  ungroup()%>%
  analysis$cached(name = "all_clean_dementia_obs_intermediate", indexes = "patid")
intermediate %>% count()


# # 
# CleanData <- observation_data %>%
#   group_by(patid) %>%
#   mutate(earliest_obsdate = min(obsdate)) %>%
#   ungroup() %>%
#   filter(earliest_obsdate >= as.Date('1980-01-01'), obsdate > as.Date('2000-01-01')) %>%
#   analysis$cached(name = "all_clean_dementia_obs_After2000_final2", indexes = "patid")


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

earliest_obs %>% count() ### 598,807



completeData <- earliest_obs %>%
  collect() %>%
  mutate(
    age_diagnosis = floor(as.numeric(as.Date(earliest_obsdate) - as.Date(date_of_birth))/365.25),
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

ActiveAfter2004 <- completeData %>%
  filter((regenddate > as.Date('2004-01-01')) &
           (is.na(cprd_ddate) | cprd_ddate > as.Date('2004-01-01')))

ActiveAfter2004 %>% count() #### 598,807
View(ActiveAfter2004)

Over65 <- ActiveAfter2004 %>%
  filter(age_diagnosis >= 65)
Over65 %>% count() ### n = 577,960
View(Over65)

IDs <- Over65 %>%
  select(patid)
write.table(IDs, "FixedData2004.txt", sep = "\t", quote = FALSE, row.names = FALSE)

afterRegistration <- Over65 %>%
  filter(obsdate > regstartdate)

beforeRegistration <- Over65 %>%
  filter(obsdate < regstartdate)


# Create a histogram for the year of diagnosis
# hist(afterRegistration$year_of_diagnosis,
#      breaks = 20,  # You can adjust the number of breaks as needed
#      xlab = "Year", 
#      ylab = "Density", 
#      main = "Year of Diagnosis and Prescription Distribution: diagnosed after 2000", 
#      col = rgb(0, 0, 1, alpha = 0.5),  # Blue with transparency
#      border = "black",
#      freq = TRUE,  # Normalize the data
#      cex.main = 1
# )
# 
# # Add histogram for the year of prescription
# hist(beforeRegistration$year_of_diagnosis,
#      breaks = 20,  # You can adjust the number of breaks as needed
#      xlab = "Year", 
#      ylab = "Density", 
#      main = "", 
#      col = rgb(1, 0, 0, alpha = 0.5),  # Red with transparency
#      border = "black",
#      freq = TRUE,  # Normalize the data
#      add = TRUE  # Add histogram to existing plot
# )
# 
# # Add legend
# legend("topright", 
#        legend = c("Diagnosed after reg", "Diagnosed before reg"), 
#        fill = c(rgb(0, 0, 1, alpha = 0.5), rgb(1, 0, 0, alpha = 0.5))
# )






table(Over65$died)

table(Over65$gender)

write.table(Over65, "Joshua_final_dementia_after2004.txt", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(ActiveAfter2004, "ActiveAfter2004.txt", sep = "\t", quote = FALSE, row.names = FALSE)


hist(Over65$age_diagnosis, 
     breaks = seq(0, 120, by = 5),  # Adjust breaks for the range 0 to 120
     xlab = "Age_diagnosis", 
     ylab = "Frequency", 
     main = "Age_diagnosis Distribution", 
     col = "lightblue",
     border = "black"
)

# view(bipolar_disorder %>% collect())
# view(observation_data %>% collect())
# Create a histogram for the year of diagnosis
# Trial <- Trial %>% CleanData %>% collect()
# observation_data
# hist((CleanData %>% collect())$year_of_diagnosis,
#      breaks = 20,  # You can adjust the number of breaks as needed
#      xlab = "Year of Diagnosis",
#      ylab = "Frequency",
#      main = "Year of Diagnosis: After 2000",
#      col = "lightblue",
#      border = "black"
# )


# CleanData %>% count()

##################################################################################################################################################

risperidone_prescriptions <- risperidone_prescriptions %>% analysis$cached("clean_risperidone_prescriptions") 

risperidone_prescriptions %>% count() ### 1,643,412

earliest_obs_risperidone_prescription <- risperidone_prescriptions %>%
  filter(!is.na(issuedate)) %>%
  group_by(patid) %>%
  filter(issuedate == min(issuedate, na.rm = TRUE)) %>%
  ungroup() %>%
  distinct(patid, .keep_all = TRUE) 

earliest_obs_risperidone_prescription %>% count() ### 77,185


final_risperidone_cohort <- inner_join(
  earliest_obs_risperidone_prescription %>% collect,
  Over65,
  by = "patid"
) %>%
  mutate(
    pracid = coalesce(pracid.x, pracid.y),
    probobsid = coalesce(probobsid.x, probobsid.y),
    enterdate = coalesce(enterdate.x, enterdate.y),
    staffid = coalesce(staffid.x, staffid.y),
    DifferenceBetween_PrescriptionAndDiagnosis = as.numeric(as.numeric(issuedate - obsdate) / (30.44)),  # Convert to months
    Prescription_moreThan_Year_prior = ifelse(DifferenceBetween_PrescriptionAndDiagnosis < -12, 1, 0),
    Prescription_Within_Year_prior = ifelse(DifferenceBetween_PrescriptionAndDiagnosis <= 0 & DifferenceBetween_PrescriptionAndDiagnosis >= -12, 1, 0),
    PrescriptionAfterDiagnosis = ifelse(DifferenceBetween_PrescriptionAndDiagnosis > 0, 1, 0),
    year_of_prescription = year(issuedate)
  ) %>%
  select(-ends_with(".x"), -ends_with(".y"))

final_risperidone_cohort %>% count() ### 56,663
# hist(final_risperidone_cohort$year_of_prescription,
#      breaks = 20,  # You can adjust the number of breaks as needed
#      xlab = "Year of Diagnosis", 
#      ylab = "Frequency", 
#      main = "Year of Diagnosis Distribution", 
#      col = "lightblue",
#      border = "black"
# )


table(final_risperidone_cohort$year_of_prescription)

final_risperidone_cohort <- final_risperidone_cohort %>%
  filter(issuedate >= "2004-01-01")



Over65 <- Over65 %>%
  mutate(FirstYeaOfDiagnosis = year(earliest_obsdate))


# Determine the range of years for all histograms
year_range <- range(c(Over65$FirstYeaOfDiagnosis, final_risperidone_cohort$year_of_prescription, Over65$year_of_diagnosis))

# Create histograms with consistent bin size
hist(Over65$FirstYeaOfDiagnosis,
     breaks = seq(year_range[1], year_range[2], length.out = 20),  # Set breaks to ensure consistent bin size
     xlab = "Year", 
     ylab = "Frequency", 
     main = "Year of Diagnosis, Prescription, and First Year of Diagnosis Distribution: diagnosed after 2004", 
     col = rgb(0, 1, 0, alpha = 0.3),  # Green with transparency
     border = "black",
     freq = TRUE,  # Normalize the data
     cex.main = 1
)

hist(final_risperidone_cohort$year_of_prescription,
     breaks = seq(year_range[1], year_range[2], length.out = 20),  # Set breaks to ensure consistent bin size
     xlab = "Year", 
     ylab = "Frequency", 
     main = "", 
     col = rgb(1, 0, 0, alpha = 0.3),  # Red with transparency
     border = "black",
     freq = TRUE,  # Normalize the data
     add = TRUE  # Add histogram to existing plot
)

hist(Over65$year_of_diagnosis,
     breaks = seq(year_range[1], year_range[2], length.out = 20),  # Set breaks to ensure consistent bin size
     xlab = "Year", 
     ylab = "Frequency", 
     main = "", 
     col = rgb(0, 0, 1, alpha = 0.3),  # Blue with transparency
     border = "black",
     freq = TRUE,  # Normalize the data
     add = TRUE  # Add histogram to existing plot
)

# Add legend
legend("top", 
       legend = c("First Year of Diagnosis after 1980", "Year of Prescription after 2004", "Year of Diagnosis after 2004"), 
       fill = c(rgb(0, 1, 0, alpha = 0.3), rgb(1, 0, 0, alpha = 0.3), rgb(0, 0, 1, alpha = 0.3))
)




hist(Over65$year_of_diagnosis,
     breaks = 20,  # You can adjust the number of breaks as needed
     xlab = "Year", 
     ylab = "frequency", 
     main = "Year of Diagnosis and Prescription Distribution: diagnosed after 2004", 
     col = rgb(0, 0, 1, alpha = 0.5),  # Blue with transparency
     border = "black",
     freq = TRUE,  # Normalize the data
     cex.main = 1
)

# Add histogram for the year of prescription
hist(final_risperidone_cohort$year_of_prescription,
     breaks = 20,  # You can adjust the number of breaks as needed
     xlab = "Year", 
     ylab = "frequency", 
     main = "", 
     col = rgb(1, 0, 0, alpha = 0.5),  # Red with transparency
     border = "black",
     freq = TRUE,  # Normalize the data
     add = TRUE  # Add histogram to existing plot
)

# Add legend
legend("top", 
       legend = c("Year of Diagnosis", "Year of Prescription"), 
       fill = c(rgb(0, 0, 1, alpha = 0.5), rgb(1, 0, 0, alpha = 0.5))
)

final_risperidone_cohort %>% count() ### 51,892

View(final_risperidone_cohort %>% select('DifferenceBetween_PrescriptionAndDiagnosis', 'Prescription_moreThan_Year_prior', 'Prescription_Within_Year_prior', 'PrescriptionAfterDiagnosis', 'issuedate', 'obsdate'))

final_risperidone_cohort %>% count() ### 51,892
 

result_table <- final_risperidone_cohort %>%
  count(Prescription_moreThan_Year_prior, Prescription_Within_Year_prior, PrescriptionAfterDiagnosis)
print(result_table)

R_cohort <- final_risperidone_cohort %>%
  filter(PrescriptionAfterDiagnosis==1)

table(R_cohort$gender)

table(R_cohort$died)



write.table(final_risperidone_cohort, "Joshua_final_risperidone_After2004.txt", sep = "\t", quote = FALSE, row.names = FALSE)


# hist(final_risperidone_cohort$year_of_prescription,
#      breaks = 20,  # You can adjust the number of breaks as needed
#      xlab = "Year of prescription", 
#      ylab = "Frequency", 
#      main = "Year of prescription: Diagnosed after 2000", 
#      col = "lightblue",
#      border = "black"
# )
table(final_risperidone_cohort$year_of_prescription)


colnames(final_risperidone_cohort)

# Assuming Over65 is your dataset and it contains a column 'year_of_diagnosis'
############################################################
Over65_final <- Over65 %>%
  filter(gender_decode != "I") %>%
  mutate(diagnosedbeforeRegistration = ifelse(earliest_obsdate < regstartdate, 1, 0))

# Create a histogram of diagnosis years
hist(Over65_final$year_of_diagnosis,
     breaks = 10,  # Number of bins
     xlab = "Year",
     ylab = "Frequency",
     main = "Distribution of Diagnosis Years",
     col = "skyblue",  # Fill color for bars
     border = "black"  # Border color for bars
)


variables_of_interest <- c("diagnosedbeforeRegistration", "died", "age_diagnosis", "age_category", "year_of_diagnosis", "gender_decode" )       


# View(FullData %>% select(variables_of_interest))


binary_vars <- c("diagnosedbeforeRegistration", "died", "age_category", "year_of_diagnosis")   

# View(FullData %>% select(binary_vars))

Over65_final[binary_vars] <- lapply(Over65_final[binary_vars], as.factor)


my_tableone <- CreateTableOne(vars = variables_of_interest, data = Over65_final)

# Print the table

print(my_tableone)





final_risperidone_cohort_final <- final_risperidone_cohort %>%
  filter((gender_decode != "I") & (PrescriptionAfterDiagnosis ==1)) %>%
  mutate(diagnosedbeforeRegistration = ifelse(earliest_obsdate < regstartdate, 1, 0),
         age_prescription = floor(as.numeric(as.Date(issuedate) - as.Date(date_of_birth))/365.25),
         duration_before_prescription = DifferenceBetween_PrescriptionAndDiagnosis/12)


variables_of_interest <- c("diagnosedbeforeRegistration","duration_before_prescription","age_prescription", "died", "age_diagnosis", "age_category", "year_of_diagnosis", "gender_decode" )       


# View(FullData %>% select(variables_of_interest))


binary_vars <- c("diagnosedbeforeRegistration", "died", "age_category", "year_of_diagnosis")   

# View(FullData %>% select(binary_vars))

final_risperidone_cohort_final[binary_vars] <- lapply(final_risperidone_cohort_final[binary_vars], as.factor)


my_tableone <- CreateTableOne(vars = variables_of_interest, data = final_risperidone_cohort_final)


print(my_tableone)

# Create a histogram of diagnosis years
hist(final_risperidone_cohort_final$year_of_diagnosis,
     breaks = 10,  # Number of bins
     xlab = "Year",
     ylab = "Frequency",
     main = "Distribution of Diagnosis Years",
     col = "skyblue",  # Fill color for bars
     border = "black"  # Border color for bars
)



Over65_final$died <- as.numeric(as.character(Over65_final$died))

library(survminer)
# fit <- survfit(Surv(time, status) ~ sex, data = lung)
fit <- survfit(Surv(Diff_start_endOfFollowup,died) ~ gender_decode,data=Over65_final)
ggsurv <- ggsurvplot(
  fit,                     # survfit object with calculated statistics.
  data = Over65_final,             # data used to fit survival curves.
  risk.table = TRUE,       # show risk table.
  pval = TRUE,             # show p-value of log-rank test.
  conf.int = TRUE,         # show confidence intervals for 
  # point estimates of survival curves.
  palette = c("#E7B800", "#2E9FDF"),
  xlim = c(0,22),         # present narrower X axis, but not affect
  # survival estimates.
  xlab = "Time in years",   # customize X axis label.
  break.time.by = 3,     # break X axis in time intervals by 500.
  ggtheme = theme_light(), # customize plot and risk table with a theme.
  risk.table.y.text.col = T,# colour risk table text annotations.
  risk.table.height = 0.25, # the height of the risk table
  risk.table.y.text = FALSE,# show bars instead of names in text annotations
  # in legend of risk table.
  # ncensor.plot = TRUE,      # plot the number of censored subjects at time t
  # ncensor.plot.height = 0.25,
  conf.int.style = "step",  # customize style of confidence intervals
  surv.median.line = "hv",  # add the median survival pointer.
  legend.labs =
    c("Female", "Male")    # change legend labels.
)
ggsurv


median_times <- surv_median(fit)

# Print the median survival times
print(median_times)





unique_age_categories <- levels(Over65_final$age_category)

fit <- survfit(Surv(Diff_start_endOfFollowup, died) ~ age_category, data = Over65_final)

ggsurv <- ggsurvplot(
  fit,
  data = Over65_final,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = TRUE,
  palette = c("#E7B800", "#2E9FDF", "#55CC00", "#FF0000"),
  xlim = c(0, 22),
  xlab = "Time in years",
  break.time.by = 3,
  ggtheme = theme_light(),
  risk.table.y.text.col = TRUE,
  risk.table.height = 0.35,
  risk.table.y.text = FALSE,
  conf.int.style = "step",
  surv.median.line = "hv",
  legend.labs = unique_age_categories,
  risk.table.y.text.size = 3,          # Adjust the size of the risk table numbers
  risk.table.y.text.fontsize = 3,      # Adjust the font size of the risk table numbers
  size = 1  # Adjust the size of the plot
)

# Explicitly print the plot before saving
print(ggsurv)

median_times <- surv_median(fit)

# Print the median survival times
print(median_times)
