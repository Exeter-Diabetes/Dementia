# This file contains all the codes used in the study, from cohort preparation all the way to analysis
## Data Preparation

1. ### CohortDataPreparationScript.R
   
   This script interacts with the data on the server using the Aurum package. We used the script to create both the dementia and risperidone cohorts. 
- #### Final dementia incident cohort
   * This script reads information from the observation table using the dementia codelist and links patient and practice information, creating a table called **all_raw_dementia_patients**.
   * The next step is dropping all patients who have bipolar disorder and schizophrenia, caching the table as **all_clean_Obs_withoutSchizo_Bipolar_final**.
   * Mark the deregistration date as 30-11-2023 for records where it is null, and create a "died" binary variable to mark those with `cprd_ddate` as dead. Keep all patients diagnosed after their date of birth and before the date of deregistration, last date of collection, and `cprd_ddate`. Cache this in **all_clean_dementia_observations_final**.
   * Create a variable marking the earliest date of diagnosis and a binary variable for diagnosis before registration. Use the earliest date of diagnosis to filter out patients diagnosed before 1980-01-01 (to remove old codes). The resulting table, **all_dementia_observation_after_2004**, contains patients with a dementia code after 2004-01-01 (the study period).
   * Select patients who were active after 2004-01-01; the deregistration date and `cprd_ddate` (if not null) must be after 2004-01-01.
   * Select only patients diagnosed at age 65 and above, and cache the table as **final_dementia_after2004**. This table is linked to the following tables:
      - [Alcohol level at diagnosis](https://github.com/Exeter-Diabetes/Dementia/blob/main/R%20Codes/DataPreparation/At_diag_alcohol.R)
        - Implemented [diabetes alcohol algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#alcohol-consumption)
      - [Smoking status at diagnosis](https://github.com/Exeter-Diabetes/Dementia/blob/main/R%20Codes/DataPreparation/At_diag_smoking.R)
         - Implemented [diabetes smoking algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#smoking) 
      - [GP ethnicity](https://github.com/Exeter-Diabetes/Dementia/blob/main/R%20Codes/DataPreparation/All_patid_ethnicity.R)
        - Implemented [diabetes ethnicity algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#sociodemographics-algorithms)
      - HES ethnicity (**hes_ethnicity**)
      - Stroke (**clean_stroke_medcodes** and **clean_stroke_icd10**)
      - ONS death (**onsDeath**)
      - Stroke as primary cause of death (**death_stroke_primary**)
   * The final dementia cohort, containing patients with HES-linked data, was then created and linked with the deprivation table. The final table is named **final_dementia_cohortLinkedData**.

- #### Final risperidone cohort
   * This part of the code starts by reading in the prescription data (**clean_risperidone_prescriptions**) and select the earliest data of prescription which is then joined to the final dementia cohort to select patients with risperidone prescription and keeping those prescribed after 2004-01-01 (**final_risperidone_After2004**). We then identity patients who were prescribed: after diagnosis, within a year prior to diagnosis and more than a year before diagnosis
   * The final cohort if defined from **final_risperidone_afterdiagnosis_cohort_2004** by selecting only patients with a linked data and the cohort is cached as **final_risperidone_cohortLinkedData**

   
2. ### Matching_YearPartitions_Final.R 

   This is the script we used to create the matched control

- The script reads data from the following tables:
   * Final dementia incident cohort (**final_dementia_cohortLinkedData**) this will be used to create the matched control patients
   * Risperidone prescriptions (**risperidone_prescriptions**)
   * Other antipsychotic prescriptions (**Other_Antipsychotic_Prescriptions**)
   * Final risperidone cohort (**final_risperidone_cohortLinkedData**)
- Since the matching is done by calender year. We have partitioned the script to loop through the years, starting from 2004 upto 2023.
  - #### Treatment Group:
     - Select patients prescribed risperidone in the current calendar year
     - Remove anyone who was prescribed any other antipsychotic other than prochlorperazine three months prior to risperidone prescription
     - Censor any patient in the treatment group that gets prescribed other antipsychotic within a year of follow up after risperidone prescription
       
  - #### Control Group:
     - Select patients who were first diagnosed (earliest date of diagnosis) and registered before the begining of the current calendar year
     - The patients in this group must not have had risperidone prescription before the end of the current calendar year. (**NB: patients in the control group might be prescribed risperidone at some later stage**)
     - Randomly generate index dates for this group since they don't have a prescription date
     - Remove those who were prescribed other antipsychotics other than prochlorperazine three months before the generated date
     - If these patients get prescribed risperidone within a year of follow up, mark their prescription date as their end of follow up. Suppose we are in 2004 and our follow up starts on September 24 and this patient gets prescribed risperidone in March of 2005. We then censor this patient
     - Also censor those prescrbed any other antipsychotic within the follow up period
       
- Then the two groups are combined to form one table which is used to process:
   - CPRD Comorbidities (**pre index and post index**)
   - HES stroke data (**pre index and post index**)
   - ONS stroke data (**stroke being primary cause of death**)
   - Create a composite stroke variable
   - Defined VTE from pulmonary_embolism or deep_vein_thrombosis)
   - Processed the biomarkers
     
- Finally ran the matching algorithm to create the matched controls then move to the following calendar year




## Analysis 

1. ### AllMatchedAnalysis_Final_IR_OneYearFollowUp.R

   This script performs the analysis. The details of how it works are outlined below
   - In this script we analyse the matched data. However, during this period we had to censor patients who stopped taking risperidone. For this reason, the script starts by reading the prescription data and identify discontinuation by 90 days or more gaps in between prescription dates. We then infer the stop date as the last date of prescription plus 30 days.
   - Censoring date is defined as the minimum of the following: inferred last date of prescription, deregistration date, death, last day of collection and one year follow up
   - Defined all the subgroups
   - Plot a Kaplan-meier survival plot for each subgroup and showing the absolute risk difference between the matched control and treatment group at 12 weeks and one year follow up period
   - Fit a Cox model, both adjusted and undjusted
   - Computed metrics:
     - Hazard ratio 
     - Absolute risk difference
     - Numbers needed to harm
     - Incidence rate per 1000 person-year
   - Competing risk
   
