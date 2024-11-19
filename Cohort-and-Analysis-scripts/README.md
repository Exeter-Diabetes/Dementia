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
      - [Alcohol level at diagnosis](https://github.com/Exeter-Diabetes/Dementia/blob/main/Cohort-and-Analysis-scripts/DataPreparation/At_diag_alcohol.R)
        - Implemented [diabetes alcohol algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#alcohol-consumption)
      - [Smoking status at diagnosis](https://github.com/Exeter-Diabetes/Dementia/blob/main/Cohort-and-Analysis-scripts/DataPreparation/At_diag_smoking.R)
         - Implemented [diabetes smoking algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#smoking) 
      - [GP ethnicity](https://github.com/Exeter-Diabetes/Dementia/blob/main/Cohort-and-Analysis-scripts/DataPreparation/All_patid_ethnicity.R)
        - Implemented [diabetes ethnicity algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists?tab=readme-ov-file#sociodemographics-algorithms)
      - HES ethnicity (**hes_ethnicity**)
      - Stroke (**clean_stroke_medcodes** and **clean_stroke_icd10**)
      - ONS death (**onsDeath**)
      - Stroke as primary cause of death (**death_stroke_primary**)
   * The final dementia cohort, containing patients with HES-linked data, was then created and linked with the deprivation table. The final table is named **final_dementia_cohortLinkedData**.                

         ```
             [1] "patid"                        "consid"                       "pracid"                       "obsid"                       
             [5] "obsdate"                      "enterdate"                    "staffid"                      "parentsobsid"                
             [9] "medcodeid"                    "testvalue"                    "numunitid"                    "obstypeid"                   
            [13] "numrangelow"                  "numrangehigh"                 "probobsid"                    "dementiadementiacodelist_cat"
            [17] "usualgpstaffid"               "gender"                       "yob"                          "mob"                         
            [21] "emis_ddate"                   "regstartdate"                 "patienttypeid"                "regenddate"                  
            [25] "acceptable"                   "cprd_ddate"                   "lcd"                          "uts"                         
            [29] "region"                       "died"                         "gender_decode"                "date_of_birth"               
            [33] "earliest_obsdate"             "diagnosedbeforeRegistration"  "age_diagnosis"                "age_category"                
            [37] "year_of_diagnosis"            "alcohol_cat"                  "smoking_cat"                  "qrisk2_smoking_cat"          
            [41] "qrisk2_smoking_cat_uncoded"   "gp_5cat_ethnicity"            "gp_16cat_ethnicity"           "gp_qrisk2_ethnicity"         
            [45] "hes_5cat_ethnicity"           "hes_16cat_ethnicity"          "hes_qrisk2_ethnicity"         "epistart"                    
            [49] "epiend"                       "ICD"                          "stroke_earliest_gp_obsdate"   "stroke_cat"                  
            [53] "ONS_date_of_death"            "ONS_died"                     "HES_stroke"                   "GP_stroke"                   
            [57] "stroke_composite"             "death_composite"              "death_composite_date"         "endoffollowup"               
            [61] "Diff_start_endOfFollowup"     "stroke_compositeDate"         "stroke_date_of_death"         "primary_death_cause"         
            [65] "primary_death_stroke"         "cause_of_death_stroke_type"   "ethnicity"                    "FollowUp"                    
            [69] "DiagnosedAfterCompositeDeath" "deprivation"                 
         ```
- #### Final risperidone cohort
   * This part of the code starts by reading in the prescription data (**clean_risperidone_prescriptions**) and select the earliest data of prescription which is then joined to the final dementia cohort to select patients with risperidone prescription and keeping those prescribed after 2004-01-01 (**final_risperidone_After2004**). We then identity patients who were prescribed: after diagnosis, within a year prior to diagnosis and more than a year before diagnosis
   * The final cohort if defined from **final_risperidone_afterdiagnosis_cohort_2004** by selecting only patients with a linked data and the cohort is cached as **final_risperidone_cohortLinkedData**
    
         ```

             [1] "patid"                                      "issueid"                                    "drugrecid"                                 
             [4] "issuedate"                                  "prodcodeid"                                 "dosageid"                                  
             [7] "quantity"                                   "quantunitid"                                "duration"                                  
            [10] "estnhscost"                                 "min_dob"                                    "gp_end_date"                               
            [13] "consid"                                     "obsid"                                      "obsdate"                                   
            [16] "parentsobsid"                               "medcodeid"                                  "testvalue"                                 
            [19] "numunitid"                                  "obstypeid"                                  "numrangelow"                               
            [22] "numrangehigh"                               "dementiadementiacodelist_cat"               "usualgpstaffid"                            
            [25] "gender"                                     "yob"                                        "mob"                                       
            [28] "emis_ddate"                                 "regstartdate"                               "patienttypeid"                             
            [31] "regenddate"                                 "acceptable"                                 "cprd_ddate"                                
            [34] "lcd"                                        "uts"                                        "region"                                    
            [37] "died"                                       "gender_decode"                              "date_of_birth"                             
            [40] "earliest_obsdate"                           "diagnosedbeforeRegistration"                "age_diagnosis"                             
            [43] "age_category"                               "year_of_diagnosis"                          "alcohol_cat"                               
            [46] "smoking_cat"                                "qrisk2_smoking_cat"                         "qrisk2_smoking_cat_uncoded"                
            [49] "gp_5cat_ethnicity"                          "gp_16cat_ethnicity"                         "gp_qrisk2_ethnicity"                       
            [52] "hes_5cat_ethnicity"                         "hes_16cat_ethnicity"                        "hes_qrisk2_ethnicity"                      
            [55] "epistart"                                   "epiend"                                     "ICD"                                       
            [58] "stroke_earliest_gp_obsdate"                 "stroke_cat"                                 "ONS_date_of_death"                         
            [61] "ONS_died"                                   "HES_stroke"                                 "GP_stroke"                                 
            [64] "stroke_composite"                           "death_composite"                            "death_composite_date"                      
            [67] "endoffollowup"                              "Diff_start_endOfFollowup"                   "stroke_compositeDate"                      
            [70] "stroke_date_of_death"                       "primary_death_cause"                        "primary_death_stroke"                      
            [73] "cause_of_death_stroke_type"                 "ethnicity"                                  "FollowUp"                                  
            [76] "DiagnosedAfterCompositeDeath"               "pracid"                                     "probobsid"                                 
            [79] "enterdate"                                  "staffid"                                    "DifferenceBetween_PrescriptionAndDiagnosis"
            [82] "age_risperidone"                            "Prescription_moreThan_Year_prior"           "Prescription_Within_Year_prior"            
            [85] "PrescriptionAfterDiagnosis"                 "year_of_prescription"                       "HES_pre_stroke"                            
            [88] "HES_post_stroke"                            "deprivation"

         ```
   
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
- Matching variables
  - Exact matching
    - Sex
    - History of stroke
    - History of CVD
    - Current age categorised (65 - 74, 75 - 84 and 85+ years)
 
  - Nearest neighbour matching
     - Care home status before index date,
     - deprivation,
     - age at risperidone prescription,
     - Angina,
     - Cardiovascular disease (CVD),
     - Venous thromboembolism (VTE),
     - Heart failure,
     - Body mass index (BMI),
     - Prescribed other antipsychotic prior to index date,
     - Disease duration before prescription,
     - Myocardial infarction,
     - Stroke,
     - Transient ischemic attack (TIA),
     - Falls,
     - Lower limb fracture,
     - Ischemic heart disease (IHD),
     - Peripheral arterial disease (PAD),
     - Atrial fibrillation (AF),
     - Revascularization,
     - Diabetes,
     - Anxiety disorders,
     - Family history of diabetes,
     - Family history of premature cardiovascular disease (CVD),
     - Pulmonary embolism,
     - Deep vein thrombosis (DVT),
     - Hematologic cancer,
     - Solid cancer,
     - Hearing loss,
     - Ethnicity,
     - Hypertension,
     - Total cholesterol
- The matching uses 1:5 (each risperidone user was matched with up to five people with dementia not prescribed risperidone ) ratio and it is done with replacement
- Finally ran the matching algorithm to create the matched controls then move to the following calendar year





## Analysis 

1. ### FinalAnalysisScript.R

   This script performs the analysis for both one year (top part of the script) and 12 weeks (bottom part of the script) follow-up. The details of how it works are outlined below
   - In this script we analyse the matched data. 
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
2. ### Discontinuation: RisperidoneDiscontinuationData_SensetivityAnalysis.R
    This script forms part of the senstivity analysis, focusing on discontinuation. The script is the same as the one used above, besides that it censors patients who stopped taking risperidone. For this reason,      the script starts by reading the prescription data and identify discontinuation by 90 days or more gaps in between prescription dates. We then infer the stop date as the last date of prescription plus 30 days.
   





## Data Preparation
This section links and explain how the other parts of the raw data was built.
1. [Comorbidities](https://github.com/Exeter-Diabetes/Dementia/blob/main/Cohort-and-Analysis-scripts/DataPreparation/Comorbidities.R)
   This processes the comorbidities of interest by using medcodes and ICD10, and linking this to the observation table. The output of this script is both the raw and cleaned up tables in the server, named according to their respective comorbidity. The last part of the script defines and prepares data for comorbidity as a primary cause of death.

2. [Alcohol at diagnosis](https://github.com/Exeter-Diabetes/Dementia/blob/main/Cohort-and-Analysis-scripts/DataPreparation/At_diag_alcohol.R)
   This processes the alcohol level at diagnosis using medcodes and linking this to the observation table. The output of this script is both the raw and cleaned up tables. The last part of the script processes the consultation table for everyone who has ever taken a risperidone prescription. This was used to workout how many time the patients have consulted during the follow-up period.

3. [Smoking at diagnosis](https://github.com/Exeter-Diabetes/Dementia/blob/main/Cohort-and-Analysis-scripts/DataPreparation/At_diag_smoking.R)
   This process smoking status at index date and it implements the algorithm developed in the diabetes study

4. [Ethnicity](https://github.com/Exeter-Diabetes/Dementia/edit/main/Cohort-and-Analysis-scripts/DataPreparation/All_patid_ethnicity.R)
   This processes the ethnicities for the population.
