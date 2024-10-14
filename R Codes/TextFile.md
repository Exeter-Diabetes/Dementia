#### This file contains all the codes used in the study, from cohort preparation all the way to analysis
**Data Preparation**

1. ***CohortDataPreparationScript.R***
   This script interacts with the data on the server using the Aurum package. We used the script to create both the dementia and risperidone cohorts. 
- **Final dementia incident cohort**
   * This script reads information from the observation table using the dementia codelist and links patient and practice information, creating a table called **all_raw_dementia_patients**.
   * The next step is dropping all patients who have bipolar disorder and schizophrenia, caching the table as **all_clean_Obs_withoutSchizo_Bipolar_final**.
   * Mark the deregistration date as 30-11-2023 for records where it is null, and create a "died" binary variable to mark those with `cprd_ddate` as dead. Keep all patients diagnosed after their date of birth and before the date of deregistration, last date of collection, and `cprd_ddate`. Cache this in **all_clean_dementia_observations_final**.
   * Create a variable marking the earliest date of diagnosis and a binary variable for diagnosis before registration. Use the earliest date of diagnosis to filter out patients diagnosed before 1980-01-01 (to remove old codes). The resulting table, **all_dementia_observation_after_2004**, contains patients with a dementia code after 2004-01-01 (the study period).
   * Select patients who were active after 2004-01-01; the deregistration date and `cprd_ddate` (if not null) must be after 2004-01-01.
   * Select only patients diagnosed at age 65 and above, and cache the table as **final_dementia_after2004**. This table is linked to the following tables:
      - Alcohol level at diagnosis (**alcohol**)
      - Smoking status at diagnosis (**smoking**)
      - GP ethnicity (**gp_ethnicity**)
      - HES ethnicity (**hes_ethnicity**)
      - Stroke (**clean_stroke_medcodes** and **clean_stroke_icd10**)
      - ONS death (**onsDeath**)
      - Stroke as primary cause of death (**death_stroke_primary**)
   * The final dementia cohort, containing patients with HES-linked data, was then created and linked with the deprivation table. The final table is named **final_dementia_cohortLinkedData**.

- **Final risperidone cohort**
   * This part of the code starts by reading in the prescription data (**clean_risperidone_prescriptions**) and select the earliest data of prescription which is then joined to the final dementia cohort to select patients with risperidone prescription and keeping those prescribed after 2004-01-01 (**final_risperidone_After2004**). We then identity patients who were prescribed: after diagnosis, within a year prior to diagnosis and more than a year before diagnosis
   * The final cohort if defined from **final_risperidone_afterdiagnosis_cohort_2004** by selecting only patients with a linked data and the cohort is cached as **final_risperidone_cohortLinkedData**

   
