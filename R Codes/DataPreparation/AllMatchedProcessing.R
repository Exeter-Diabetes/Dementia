# Setup
library(aurum)
library(MatchIt)
library(purrr)
library(tidyverse)
library(dplyr)
library(tableone)
library(lubridate)
rm(list=ls())
library(bit64)
library(survival)
library(survminer)
library(ggplot2)
library(cmprsk)

# cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")
# 
# analysis = cprd$analysis("Joshua")

table <- read.table("C:/Users/njc232/OneDrive - University of Exeter/Documents/MatchedResults_6MonthsPrior_2/Joshua_cumulative_matched_data.txt", header = TRUE, sep = "\t") 

table <- as.data.frame(table) %>%
  mutate(
    Stroke__within_year_after_1st_risperidone_presc	 = if_else(!is.na(stroke_compositeDate_post_first_stroke) & !is.na(stroke_compositeDate_post_first_stroke) & (as.numeric(as.Date(stroke_compositeDate_post_first_stroke) - as.Date(issuedate))) >= 0 & (as.numeric(as.Date(stroke_compositeDate_post_first_stroke) - as.Date(issuedate))) <= 365 & (stroke_composite ==1), 1, 0)
    
  )

table%>% count()


summary(table$Survival_time)
table(table$stroke_composite_post_index_date)

table <- table %>% mutate(
  stime=ifelse(is.na(stroke_compositeDate_post_first_stroke),
               (as.numeric(as.Date(pmin(death_composite_date, lcd, regenddate,na.rm = TRUE)) - as.Date(issuedate)) / 365.25),
               (as.numeric(as.Date(stroke_compositeDate_post_first_stroke) - as.Date(issuedate)) / 365.25)))
    
test <- table %>% filter(risperidone==1)
test <- test %>% 
  mutate(
    stroke_time=(as.numeric(as.Date(post_index_date_first_af) - as.Date(issuedate)) / 365.25)
  )
summary(test$stroke_time)

names(table)

table %>% group_by(risperidone) %>% dplyr::summarise(
  n=n(),
  mean_s = mean(Survival_time),
  mean_s2=mean(stime),
  max_s = max(Survival_time),
  n_stroke=sum(stroke_composite_post_index_date),
  pc_stroke=sum(stroke_composite_post_index_date)/n()
)



##############################################################
fit <- survfit(Surv(stime, stroke_composite_post_index_date) ~ risperidone, data = table)# , subset=Prescribed_other_antipsychotic_Prior==1)
# summary(fit)
ggsurv <- ggsurvplot(
  fit,
  data = table,
  fun = function(x) {100 - x * 100},  # Cumulative probability plot
  censor = FALSE,
  size = 1.5,
  pval = TRUE,
  conf.int = TRUE,
  legend.labs = c("Control Group", "Treatment Group"),
  risk.table = TRUE,
  risk.table.title = "Strata",
  xlim = c(0, 1.2),
  ylim = c(0, 6),
  xlab = "Time to event (years)",
  ylab = "Cumulative incidence (%)",
  break.time.by = 0.2,
  risk.table.y.text.col = TRUE,
  fontsize = 5,
  font.x = c(14), font.y = c(14), font.tickslab = c(14),
  axes.offset = TRUE,
  palette = c("#ED0000FF", "#00468BFF"),
  linetype = "strata",
  legend = c(0.18, 0.8),
  risk.table.height = 0.25,
  risk.table.y.text = FALSE,
  ggtheme = theme_light() +
    theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)),  
  tables.theme = theme_cleantable(),
  pval.size = 5,  # Set the size of the p-value text
  pval.coord = c(0.7, 2)  # Adjust the position of the p-value text
)
ggsurv$plot <- ggsurv$plot + ggtitle("No history of antipsychotic 3 months prior: 2004 - 2023")

print(ggsurv)







########################### Under 75

Under75 <- table %>%
  filter(age_risperidone < 75)

fit <- survfit(Surv(Survival_time, stroke_composite_post_index_date) ~ risperidone, data = Under75)
# summary(fit)
ggsurv <- ggsurvplot(
  fit,
  data = Under75,
  fun = function(x) {100 - x * 100},  # Cumulative probability plot
  censor = FALSE,
  size = 1.5,
  pval = TRUE,
  conf.int = TRUE,
  legend.labs = c("Control Group", "Treatment Group"),
  risk.table = TRUE,
  risk.table.title = "Strata",
  xlim = c(0, 1.2),
  ylim = c(0, 6),
  xlab = "Time to event (years)",
  ylab = "Cumulative incidence (%)",
  break.time.by = 0.2,
  risk.table.y.text.col = TRUE,
  fontsize = 5,
  font.x = c(14), font.y = c(14), font.tickslab = c(14),
  axes.offset = TRUE,
  palette = c("#ED0000FF", "#00468BFF"),
  linetype = "strata",
  legend = c(0.2, 0.8),
  risk.table.height = 0.25,
  risk.table.y.text = FALSE,
  ggtheme = theme_light() +
    theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)),  
  tables.theme = theme_cleantable(),
  pval.size = 5,  # Set the size of the p-value text
  pval.coord = c(0.2, 3)  # Adjust the position of the p-value text
)
ggsurv$plot <- ggsurv$plot + ggtitle("No history of antipsychotic 3 months prior, 2004 - 2023: Under 75 Age Group")
print(ggsurv)




Vars <- c("sex","risperidone", "age_diagnosis", "Stroke__within_year_after_1st_risperidone_presc","stroke_composite_pre_index_date", "pre_index_date_angina" , "pre_index_date_heartfailure", "BMI", "Prescribed_other_antipsychotic_Prior", "period_before_prescription",
          "comorbidity_myocardialinfarction" , "pre_index_date_stroke" ,"pre_index_date_tia" , "pre_index_date_falls" , "pre_index_date_lowerlimbfracture" , "pre_index_date_ihd" ,
          "pre_index_date_pad" , "pre_index_date_af" , "pre_index_date_revasc" , "pre_index_date_qof_diabetes" , "pre_index_date_anxiety_disorders", "pre_index_date_fh_diabetes" ,
          "pre_index_date_fh_premature_cvd" , "pre_index_date_pulmonary_embolism" , "pre_index_date_deep_vein_thrombosis" ,
          "pre_index_date_hearing_loss" , "VTE" , "gp_5cat_ethnicity" , "comorbidity_hypertension" , "Survival_time")


binary_vars <- c("sex","risperidone", "Stroke__within_year_after_1st_risperidone_presc","stroke_composite_pre_index_date", "pre_index_date_angina" , "pre_index_date_heartfailure", "Prescribed_other_antipsychotic_Prior",
                 "comorbidity_myocardialinfarction" , "pre_index_date_stroke" ,"pre_index_date_tia" , "pre_index_date_falls" , "pre_index_date_lowerlimbfracture" , "pre_index_date_ihd" ,
                 "pre_index_date_pad" , "pre_index_date_af" , "pre_index_date_revasc" , "pre_index_date_qof_diabetes" , "pre_index_date_anxiety_disorders", "pre_index_date_fh_diabetes" ,
                 "pre_index_date_fh_premature_cvd" , "pre_index_date_pulmonary_embolism" , "pre_index_date_deep_vein_thrombosis" ,
                 "pre_index_date_hearing_loss" , "VTE" , "gp_5cat_ethnicity" , "comorbidity_hypertension" )


FullData <- table %>%
  select(all_of(Vars)) 


FullData[binary_vars] <- lapply(FullData[binary_vars], as.factor)




TreatmentGroup <- FullData %>%
  filter(risperidone==1) 

ControlGroup <- FullData %>%
  filter(risperidone==0)


# Create TableOne

my_tableone <- CreateTableOne(vars = Vars, data = TreatmentGroup, smd = TRUE)
print(my_tableone)



my_tableone <- CreateTableOne(vars = Vars, data = ControlGroup, smd = TRUE)
print(my_tableone)


categorical_variables <- c("sex", "pre_index_date_angina" , "pre_index_date_heartfailure", "Prescribed_other_antipsychotic_Prior",
                           "comorbidity_myocardialinfarction" , "pre_index_date_stroke" ,"pre_index_date_tia" , "pre_index_date_falls" , "pre_index_date_lowerlimbfracture" , "pre_index_date_ihd" ,
                           "pre_index_date_pad" , "pre_index_date_af" , "pre_index_date_revasc" , "pre_index_date_qof_diabetes" , "pre_index_date_anxiety_disorders", "pre_index_date_fh_diabetes" ,
                           "pre_index_date_fh_premature_cvd" , "pre_index_date_pulmonary_embolism" , "pre_index_date_deep_vein_thrombosis" ,
                           "pre_index_date_hearing_loss" , "VTE" , "gp_5cat_ethnicity" , "comorbidity_hypertension", "BMI" )


# for (variable in categorical_variables) {
#   table_result <- table(FullData$risperidone, FullData[[variable]])
#   chi_squared <- chisq.test(table_result)
#   print(paste("Variable:", variable))
#   print(chi_squared)
# }
# 
# 
# 
# # t-test for continuous variables
# continuous_variables <- c("age_diagnosis", "period_before_prescription")
# for (variable in continuous_variables) {
#   t_test_result <- t.test(FullData[[variable]] ~ FullData$risperidone)
#   print(paste("Variable:", variable))
#   print(t_test_result)
# }
# 

my_table <- CreateTableOne(
  vars = Vars,  
  strata = "risperidone",                 
  data = rbind(ControlGroup, TreatmentGroup),  # Combined data frame of Control and Treatment groups
  testExact = c(FALSE, FALSE, FALSE) 
)

# Print the table with SMD and p-values
print(my_table, smd = TRUE)






res.cox <- coxph(Surv(Survival_time, stroke_composite_post_index_date) ~ age_diagnosis  + sex + stroke_composite_pre_index_date, data = table)
summary(res.cox)

res.cox <- coxph(Surv(Survival_time, stroke_composite_post_index_date) ~ risperidone, data = table)
summary(res.cox)




FinalData <- table %>%
  mutate(
    FollowUp =  as.numeric((as.Date(pmin(regenddate, death_composite_date, lcd, na.rm = TRUE)) - as.Date(earliest_obsdate))/365.25)
  )



FinalData$death_composite <- as.numeric(as.character(FinalData$death_composite))

FinalData %>% group_by(risperidone) %>% dplyr::summarise(
  n=n(),
  mean_s = mean(FollowUp),
  max_s = max(FollowUp),
  n_stroke=sum(death_composite),
  pc_stroke=sum(death_composite)/n()
)

library(survminer)
fit <- survfit(Surv(FollowUp,death_composite) ~ risperidone,data=FinalData)
ggsurv <- ggsurvplot(
  fit,                     # survfit object with calculated statistics.
  data = FinalData,             # data used to fit survival curves.
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
    c("Control", "Treatment"),   # change legend labels.
  lwd = 2.0                 # Adjust line thickness here
)
ggsurv$plot <- ggsurv$plot + ggtitle("No history of antipsychotic 3 months prior: 2004 - 2023")

ggsurv


median_times <- surv_median(fit)

# Print the median survival times
print(median_times)



############# Under 75 KM

AllDeathUnder75 <- FinalData %>%
  filter(age_risperidone < 75)

library(survminer)
# fit <- survfit(Surv(time, status) ~ sex, data = lung)
fit <- survfit(Surv(FollowUp,death_composite) ~ risperidone,data=AllDeathUnder75)
ggsurv <- ggsurvplot(
  fit,                     # survfit object with calculated statistics.
  data = AllDeathUnder75,             # data used to fit survival curves.
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
    c("Control", "Treatment") ,   # change legend labels.
  lwd = 2.0                 # Adjust line thickness here
  
)
ggsurv$plot <- ggsurv$plot + ggtitle("No history of antipsychotic 3 months prior, 2004 - 2023: Under 75 Age Group")

ggsurv


median_times <- surv_median(fit)

# Print the median survival times
print(median_times)




######


FinalData_year1 <- FinalData %>%
  filter(
    FollowUp <= 1
  )

FinalData_year1 <- FinalData %>%
  mutate(
    death_composite1 = ifelse(death_composite==1 & FollowUp <=1,death_composite,0),
    fu1 = ifelse(FollowUp > 1, 1, FollowUp)
  )

FinalData_year1 %>% group_by(risperidone) %>% dplyr::summarise(
  death_composite=sum(death_composite),
  death_composite1=sum(death_composite1),
  fu1.max = max(fu1)
)

# FinalData$death_composite <- as.numeric(as.character(FinalData$death_composite))

library(survminer)
# fit <- survfit(Surv(time, status) ~ sex, data = lung)
fit <- survfit(Surv(fu1,death_composite1) ~ risperidone,data=FinalData_year1)
ggsurv <- ggsurvplot(
  fit,                     # survfit object with calculated statistics.
  data = FinalData_year1,             # data used to fit survival curves.
  risk.table = TRUE,       # show risk table.
  pval = TRUE,             # show p-value of log-rank test.
  conf.int = TRUE,         # show confidence intervals for 
  # point estimates of survival curves.
  palette = c("#E7B800", "#2E9FDF"),
  xlim = c(0,1),         # present narrower X axis, but not affect
  ylim=c(0.9,1),
  # survival estimates.
  xlab = "Time in years",   # customize X axis label.
  break.time.by = .1,     # break X axis in time intervals by 500.
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
    c("Control", "Treatment") ,   # change legend labels.
  lwd = 2.0                 # Adjust line thickness here
  
)
ggsurv$plot <- ggsurv$plot + ggtitle("No history of antipsychotic 3 months prior: Death in first year")

ggsurv


median_times <- surv_median(fit)

# Print the median survival times
print(median_times)



###### 


### competing risk

  #### Competing risks ####
library(tidycmprsk)
library(tidyverse)
library(rms)
library(survminer)
library(ggsurvfit)




FinalData <- FinalData %>%
  mutate(competing_death = ifelse(death_composite == 1, 2, 0))

FinalData$competing_death[is.na(FinalData$competing_death)] <- 0

FinalData$competing_death <- factor(FinalData$competing_death)

# # Fit the competing risks regression model
 # crr_mod <- crr(Surv(FollowUp, competing_death) ~  risperidone, data = FinalData)
 # 
 # summary(crr_mod)

# Plot cumulative incidence curves adjusted for competing risk of death
cuminc(Surv(FollowUp, competing_death) ~ risperidone, data = FinalData) %>%
  ggcuminc() +
  labs(
    x = "Years"
  ) + 
  add_confidence_interval() +
  add_risktable()






