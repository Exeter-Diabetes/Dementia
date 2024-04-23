****The table below shows the number of prescriptions per year for each category*****

![image](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/6542b11d-c5ee-43a4-8f2a-c5b5838a989f)

**This is the distribution of number of diagnosis per year for patients diagnosed after registration**


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/YearOfDiagnosis_AfterReg.png)


**This is the distribution of number of prescriptions per year for patients diagnosed after registration**

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/YearOfPrescription_AfterReg.png)


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/AfterRegistration.png)

**This is the distribution of number of diagnosis per year for patients diagnosed after 2000**

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/YearOfDiagnosis_After2000.png)

**This is the distribution of number of prescriptions per year for patients diagnosed after 2000**


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/YearOfPrescription_After2000.png)


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/After2000.png)


**This is the distribution of number of diagnosis per year for patients diagnosed after 2004**

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/YearOfDiagnosis_After2004.png)


**This is the distribution of number of prescriptions per year for patients diagnosed after 2004**


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/YearOfPrescription_After2004.png)


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/After2004.png)

```mermaid

flowchart TD
    A[New Dementia CPRD Download ] -->|All Observations| B(n = 815,604,368 records)
    B[n = 815,604,368 records] -->|Exlcluding: Schizophrenia and bipolar disorder| BB(n = 776,911,734 records)
    BB[n = 776,911,734 records ] -->| date of birth < obsdate < lcd/ deregistration /death  | C(n = 774,096,832 records)
    C[n = 774,096,832 records ] -->| Diagnosed after registration   | DA(n = 612,316,083 records)
    C[n = 774,096,832 records ] -->| Diagnosed after 2000  | DC(n = 737,363,589 records)
    C[n = 774,096,832 records ] -->| Diagnosed after 2004   | DB(n = 685,734,894 records)

    DA[n = 612,316,083 records ] -->| Unique patid: Earliest observation   | E(n = 663,765 patients)
    DC[n = 737,363,589 records ] -->| Unique patid: Earliest observation   | F(n = 648,096 patients)
    DB[n = 685,734,894 records ] -->| Unique patid: Earliest observation   | G(n = 617,474 patients)

    E[n = 663,765 patients] -->| regend > 2004-01-01 & alive or death > 2004-01-01  | EE(n = 618,760 patients)
    F[n = 648,096 patients] -->| regend > 2004-01-01 & alive or death > 2004-01-01  | FF(n = 619,060 patients)
    G[n = 617,474 patients] -->| regend > 2004-01-01 & alive or death > 2004-01-01  | GG(n = 617,474 patients)

    EE[n = 618,760 patients] -->| Age: 65 or above  | EJ(n = 417,211 records)
    FF[n = 619,060 patients] -->| Age: 65 or above  | FJ(n = 433,027 records)
    GG[n = 617,474 patients] -->| Age: 65 or above  | GJ(n = 497,811 records)


    EJ[n = 401,588 patients] -->| Death  | J(Yes = 222,310 
    No = 179,278)
    EJ[n = 401,588 patients] -->| Gender  | K(Male = 137,409 
    Female = 264178
    Unknown = 1 *to be dropped*)
    EJ[n = 401,588 patients] -->| On Risperidone after 2004-01-01  | JJ(n = 40,022)
    JJ[n = 40,022 patients] -->| After diagnosis | ZA(n = 28,761)
    JJ[n = 40,022 patients] -->| < year prior to diagnosis | ZB(n = 7,886)
    JJ[n = 40,022 patients] -->| > year prior to diagnosis | ZC(n = 3,375)

    ZA[n = 28,761 patients] -->| Death  | XA(Yes = 17,013  
    No = 11,748 )
    ZA[n = 28,761 patients] -->| Gender  | XB(Male = 10,396 
    Female = 18,365  
    )

    


    FJ[n = 433,027 patients] -->| Death  | R(Yes = 248,545 
    No = 184,482  )
    FJ[n = 433,027 patients] -->| Gender  | Q(Male = 144,461 
    Female = 288,565
    Unknown = 1 *to be dropped* )


    FJ[n = 433,027 patients] -->| On Risperidone after 2004-01-01  | KK(n = 35,355)
    KK[n = 35,355 patients] -->| After diagnosis | VA(n = 35,242)
    KK[n = 35,355 patients] -->| < year prior to diagnosis | VB(n = 111)
    KK[n = 35,355 patients] -->| > year prior to diagnosis | VC(n = 2)

    VA[n = 35,242 patients] -->| Death  | YA(Yes = 22,415  
    No = 12,827 )
    VA[n = 35,242 patients] -->| Gender  | YB(Male = 12,271  
    Female = 22,971   
    )


    GJ[n = 497,811 patients] -->| Death  | S(Yes = 272,880 
    No = 224,931  )
    GJ[n = 497,811 patients] -->| Gender  | T(Male = 171,612 
    Female = 326197
    Unknown = 2 *to be dropped*)



    GJ[n = 497,811 patients] -->| On Risperidone after 2004-01-01  | LL(n = 41,945)
    LL[n = 41,945 patients] -->| After diagnosis | AA(n = 41,487)
    LL[n = 41,945 patients] -->| < year prior to diagnosis | AB(n = 455)
    LL[n = 41,945 patients] -->| > year prior to diagnosis | AC(n = 3)

    AA[n = 41,548 patients] -->| Death  | HA(Yes = 25,248    
    No = 16,239  )
    AA[n = 41,548 patients] -->| Gender  | HB(Male = 15,005  
    Female = 26,482    
    )

```






```
                                             Overall       
  n                                           497809        
  diagnosedbefore = 1 (%)                     270347 (54.3) 
  died = 1 (%)                                272879 (54.8) 
  age_diagnosis (mean (SD))                    76.02 (6.98) 
  age_category (%)                                          
     65-74                                    227291 (45.7) 
     75-84                                    208954 (42.0) 
     85-94                                     58220 (11.7) 
     95+                                        3344 ( 0.7) 
  year_of_diagnosis (%)                                     
     2004                                     397444 (79.8) 
     2005                                      40165 ( 8.1) 
     2006                                      16544 ( 3.3) 
     2007                                       9518 ( 1.9) 
     2008                                       6111 ( 1.2) 
     2009                                       4564 ( 0.9) 
     2010                                       3888 ( 0.8) 
     2011                                       2880 ( 0.6) 
     2012                                       2654 ( 0.5) 
     2013                                       2408 ( 0.5) 
     2014                                       2186 ( 0.4) 
     2015                                       2070 ( 0.4) 
     2016                                       1592 ( 0.3) 
     2017                                       1095 ( 0.2) 
     2018                                       1019 ( 0.2) 
     2019                                       1022 ( 0.2) 
     2020                                       1007 ( 0.2) 
     2021                                       1100 ( 0.2) 
     2022                                        423 ( 0.1) 
     2023                                        119 ( 0.0) 
  gender_decode = M (%)                       171612 (34.5) 
  pre_diagnoses_af = 1 (%)                     24083 (22.4) 
  post_diagnoses_af = 1 (%)                    81391 (75.8) 
  af_ever = 1 (%)                             107407 (21.6) 
  pre_diagnoses_angina = 1 (%)                 44123 (68.3) 
  post_diagnoses_angina = 1 (%)                19802 (30.7) 
  angina_ever = 1 (%)                          64583 (13.0) 
  pre_diagnoses_anxiety_disorders = 1 (%)      40524 (51.3) 
  post_diagnoses_anxiety_disorders = 1 (%)     37464 (47.5) 
  anxiety_disorders_ever = 1 (%)               78935 (15.9) 
  pre_diagnoses_falls = 1 (%)                  31217 (11.5) 
  post_diagnoses_falls = 1 (%)                237264 (87.7) 
  falls_ever = 1 (%)                          270603 (54.4) 
  pre_diagnoses_fh_diabetes = 1 (%)            49427 (52.3) 
  post_diagnoses_fh_diabetes = 1 (%)           42223 (44.7) 
  fh_diabetes_ever = 1 (%)                     94530 (19.0) 
  heartfailure_ever = 1 (%)                    62516 (12.6) 
  pre_diagnoses_hypertension = 1 (%)          188308 (65.8) 
  post_diagnoses_hypertension = 1 (%)          90149 (31.5) 
  hypertension_ever = 1 (%)                   286031 (57.5) 
  pre_diagnoses_lowerlimbfracture = 1 (%)      30488 (29.6) 
  post_diagnoses_lowerlimbfracture = 1 (%)     70660 (68.7) 
  lowerlimbfracture_ever = 1 (%)              102876 (20.7) 
  pre_diagnoses_myocardialinfarction = 1 (%)   24463 (51.6) 
  post_diagnoses_myocardialinfarction = 1 (%)  22197 (46.8) 
  myocardialinfarction_ever = 1 (%)            47432 ( 9.5) 
  pre_diagnoses_qof_diabetes = 1 (%)           41019 (45.7) 
  post_diagnoses_qof_diabetes = 1 (%)          46459 (51.7) 
  qof_diabetes_ever = 1 (%)                    89852 (18.0) 
  pre_diagnoses_revasc = 1 (%)                 12882 (49.8) 
  post_diagnoses_revasc = 1 (%)                12574 (48.6) 
  revasc_ever = 1 (%)                          25849 ( 5.2) 
  pre_diagnoses_stroke = 1 (%)                 23176 (29.3) 
  post_diagnoses_stroke = 1 (%)                54000 (68.2) 
  stroke_ever = 1 (%)                          79182 (15.9) 
  pre_diagnoses_tia = 1 (%)                    21480 (36.1) 
  post_diagnoses_tia = 1 (%)                   36964 (62.1) 
  tia_ever = 1 (%)                             59571 (12.0) 
  alcohol_cat (%)                                           
     Excess                                    18786 ( 8.2) 
     Harmful                                    5444 ( 2.4) 
     None                                      32989 (14.4) 
     Within limits                            172237 (75.1) 
  smoking_cat (%)                                           
     Active smoker                             42754 (14.8) 
     Ex-smoker                                102892 (35.7) 
     Non-smoker                               142716 (49.5) 
  qrisk2_smoking_cat (mean (SD))                0.66 (0.84) 
  qrisk2_smoking_cat_uncoded (%)                            
     Ex-smoker                                 56208 (26.0) 
     Heavy smoker                               1245 ( 0.6) 
     Light smoker                              37055 (17.1) 
     Moderate smoker                            2260 ( 1.0) 
     Non-smoker                               119446 (55.2) 
  gp_5cat_ethnicity (%)                                     
     White                                    331505 (94.9) 
     South Asian                                7422 ( 2.1) 
     Black                                      7163 ( 2.1) 
     Other                                      2005 ( 0.6) 
     Mixed                                      1226 ( 0.4) 
  gp_16cat_ethnicity (%)                                    
     White British                            316280 (90.6) 
     White Irish                                5219 ( 1.5) 
     Other White                                9711 ( 2.8) 
     White and Black Caribbean                   598 ( 0.2) 
     White and Black African                     169 ( 0.0) 
     White and Asian                             162 ( 0.0) 
     Other Mixed                                 313 ( 0.1) 
     Indian                                     3808 ( 1.1) 
     Pakistani                                  1576 ( 0.5) 
     Bangladeshi                                 561 ( 0.2) 
     Other Asian                                1422 ( 0.4) 
     Caribbean                                  5457 ( 1.6) 
     African                                    1051 ( 0.3) 
     Other Black                                 587 ( 0.2) 
     Chinese                                     475 ( 0.1) 
     Other                                      1547 ( 0.4) 
  gp_qrisk2_ethnicity (%)                                   
     missing                                       0 ( 0.0) 
     White                                    331493 (94.9) 
     Indian                                     3804 ( 1.1) 
     Pakistani                                  1575 ( 0.5) 
     Bangladeshi                                 561 ( 0.2) 
     Other Asian                                1414 ( 0.4) 
     Black Caribbean                            5424 ( 1.6) 
     Black African                              1042 ( 0.3) 
     Chinese                                     473 ( 0.1) 
     Other                                      3449 ( 1.0) 
  missing_ethnicity = 1 (%)                   148476 (29.8) 


```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_ageCat.png)

```
                                                              Overall        
  n                                                            41487         
  diagnosedbeforeRegistration = 1 (%)                          16207 ( 39.1) 
  died = 1 (%)                                                 25248 ( 60.9) 
  age_diagnosis (mean (SD))                                    75.06 (6.72)  
  age_category (%)                                                           
     65-74                                                     21355 ( 51.5) 
     75-84                                                     16176 ( 39.0) 
     85-94                                                      3779 (  9.1) 
     95+                                                         177 (  0.4) 
  DifferenceBetween_PrescriptionAndDiagnosis (mean (SD))      116.70 (63.62) 
  comorbidity_af = 1 (%)                                        8047 ( 19.4) 
  pre_index_date_af = 1 (%)                                     6986 ( 16.8) 
  post_index_date_af = 1 (%)                                    3006 (  7.2) 
  comorbidity_angina = 1 (%)                                    5277 ( 12.7) 
  pre_index_date_angina = 1 (%)                                 5099 ( 12.3) 
  post_index_date_angina = 1 (%)                                 659 (  1.6) 
  comorbidity_anxiety_disorders = 1 (%)                         8027 ( 19.3) 
  pre_index_date_anxiety_disorders = 1 (%)                      7534 ( 18.2) 
  post_index_date_anxiety_disorders = 1 (%)                     1346 (  3.2) 
  comorbidity_falls = 1 (%)                                    23531 ( 56.7) 
  pre_index_date_falls = 1 (%)                                 16579 ( 40.0) 
  post_index_date_falls = 1 (%)                                12942 ( 31.2) 
  comorbidity_fh_diabetes = 1 (%)                               7343 ( 17.7) 
  pre_index_date_fh_diabetes = 1 (%)                            7187 ( 17.3) 
  post_index_date_fh_diabetes = 1 (%)                            247 (  0.6) 
  comorbidity_fh_premature_cvd = 1 (%)                          2507 (  6.0) 
  pre_index_date_fh_premature_cvd = 1 (%)                       2466 (  5.9) 
  post_index_date_fh_premature_cvd = 1 (%)                        62 (  0.1) 
  comorbidity_heartfailure = 1 (%)                              4236 ( 10.2) 
  pre_index_date_heartfailure = 1 (%)                           3378 (  8.1) 
  post_index_date_heartfailure = 1 (%)                          1635 (  3.9) 
  comorbidity_hypertension = 1 (%)                             23044 ( 55.5) 
  pre_index_date_hypertension = 1 (%)                          22573 ( 54.4) 
  post_index_date_hypertension = 1 (%)                          4414 ( 10.6) 
  comorbidity_lowerlimbfracture = 1 (%)                         9020 ( 21.7) 
  pre_index_date_lowerlimbfracture = 1 (%)                      6697 ( 16.1) 
  post_index_date_lowerlimbfracture = 1 (%)                     2947 (  7.1) 
  comorbidity_myocardialinfarction = 1 (%)                      3750 (  9.0) 
  pre_index_date_myocardialinfarction = 1 (%)                   3465 (  8.4) 
  post_index_date_myocardialinfarction = 1 (%)                   511 (  1.2) 
  comorbidity_qof_diabetes = 1 (%)                              7442 ( 17.9) 
  pre_index_date_qof_diabetes = 1 (%)                           6859 ( 16.5) 
  post_index_date_qof_diabetes = 1 (%)                          3395 (  8.2) 
  comorbidity_revasc = 1 (%)                                    2138 (  5.2) 
  pre_index_date_revasc = 1 (%)                                 2110 (  5.1) 
  post_index_date_revasc = 1 (%)                                  65 (  0.2) 
  comorbidity_stroke = 1 (%)                                    6147 ( 14.8) 
  pre_index_date_stroke = 1 (%)                                 5115 ( 12.3) 
  post_index_date_stroke = 1 (%)                                1845 (  4.4) 
  stroke_cat = ischaemic (%)                                    5358 ( 87.2) 
  comorbidity_tia = 1 (%)                                       4760 ( 11.5) 
  pre_index_date_tia = 1 (%)                                    4007 (  9.7) 
  post_index_date_tia = 1 (%)                                   1141 (  2.8) 
  BMI (%)                                                                    
     Missing                                                   11859 ( 28.6) 
     Normal                                                    14218 ( 34.3) 
     Obesity                                                    3809 (  9.2) 
     Overweight                                                 9449 ( 22.8) 
     Severely Obese                                              213 (  0.5) 
     Underweight                                                1939 (  4.7) 
  testvalue_dbp (mean (SD))                                    73.03 (10.52) 
  testvalue_height (mean (SD))                                162.64 (10.23) 
  testvalue_sbp (mean (SD))                                   130.82 (17.94) 
  testvalue_totalcholesterol (mean (SD))                        4.78 (1.20)  
  testvalue_weight (mean (SD))                                 65.62 (14.54) 
  gp_5cat_ethnicity (%)                                                      
     White                                                     28487 ( 94.9) 
     South Asian                                                 650 (  2.2) 
     Black                                                       584 (  1.9) 
     Other                                                       198 (  0.7) 
     Mixed                                                       106 (  0.4) 
  gp_16cat_ethnicity (%)                                                     
     White British                                             27177 ( 90.6) 
     White Irish                                                 446 (  1.5) 
     Other White                                                 845 (  2.8) 
     White and Black Caribbean                                    48 (  0.2) 
     White and Black African                                       9 (  0.0) 
     White and Asian                                              20 (  0.1) 
     Other Mixed                                                  28 (  0.1) 
     Indian                                                      295 (  1.0) 
     Pakistani                                                   179 (  0.6) 
     Bangladeshi                                                  50 (  0.2) 
     Other Asian                                                 120 (  0.4) 
     Caribbean                                                   444 (  1.5) 
     African                                                      81 (  0.3) 
     Other Black                                                  55 (  0.2) 
     Chinese                                                      32 (  0.1) 
     Other                                                       168 (  0.6) 
  gp_qrisk2_ethnicity (%)                                                    
     missing                                                       0 (  0.0) 
     White                                                     28487 ( 94.9) 
     Indian                                                      295 (  1.0) 
     Pakistani                                                   179 (  0.6) 
     Bangladeshi                                                  50 (  0.2) 
     Other Asian                                                 120 (  0.4) 
     Black Caribbean                                             439 (  1.5) 
     Black African                                                81 (  0.3) 
     Chinese                                                      32 (  0.1) 
     Other                                                       333 (  1.1) 
  alcohol_cat (%)                                                            
     Excess                                                     1507 (  8.8) 
     Harmful                                                     434 (  2.5) 
     None                                                       2434 ( 14.3) 
     Within limits                                             12698 ( 74.4) 
  smoking_cat (%)                                                            
     Active smoker                                              3124 ( 14.8) 
     Ex-smoker                                                  7829 ( 37.1) 
     Non-smoker                                                10150 ( 48.1) 
  qrisk2_smoking_cat (%)                                                     
     0                                                          8582 ( 54.5) 
     1                                                          4243 ( 26.9) 
     2                                                          2654 ( 16.9) 
     3                                                           165 (  1.0) 
     4                                                           105 (  0.7) 
  qrisk2_smoking_cat_uncoded (%)                                             
     Ex-smoker                                                  4243 ( 26.9) 
     Heavy smoker                                                105 (  0.7) 
     Light smoker                                               2654 ( 16.9) 
     Moderate smoker                                             165 (  1.0) 
     Non-smoker                                                 8582 ( 54.5) 
  drug_name (%)                                                              
     amisulpride                                                 512 (  2.3) 
     aripiprazole                                                348 (  1.6) 
     benperidol                                                   14 (  0.1) 
     chlorpromazine                                              290 (  1.3) 
     clozapine                                                     1 (  0.0) 
     flupentixol                                                 302 (  1.4) 
     fluphenazine                                                 21 (  0.1) 
     haloperidol                                                3554 ( 16.2) 
     levomepromazine                                            2308 ( 10.5) 
     olanzapine                                                 1495 (  6.8) 
     pericyazine                                                  43 (  0.2) 
     perphenazine                                                 18 (  0.1) 
     pimozide                                                    176 (  0.8) 
     prochlorperazine                                           8400 ( 38.4) 
     promazine                                                   893 (  4.1) 
     quetiapine                                                 2955 ( 13.5) 
     sulpiride                                                    94 (  0.4) 
     thioridazine                                                180 (  0.8) 
     trifluoperazine                                             270 (  1.2) 
     zuclopenthixol                                               17 (  0.1) 
  frailty (%)                                                                
     Mild                                                       1438 ( 10.9) 
     Moderate                                                   4345 ( 33.0) 
     Severe                                                     7387 ( 56.1) 
  sex = 1 (%)                                                  15005 ( 36.2) 
  dementia_duration_prior_risperidone (mean (SD))               9.25 (5.28)  
  Survival_time (mean (SD))                                     1.94 (2.21)  
  year_diagnosis_cat (%)                                                     
     > 2020                                                      198 (  0.5) 
     2004 - 2008                                               38069 ( 91.8) 
     2009 - 2012                                                1640 (  4.0) 
     2013 - 2016                                                1048 (  2.5) 
     2017 - 2020                                                 532 (  1.3) 
  Stroke_prior_to_risperidone = 1 (%)                           4756 ( 11.5) 
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)        694 (  1.7) 
  death_in_a_year_after_risperidone = 1 (%)                     1675 (  4.0) 
  age_risperidone (mean (SD))                                  84.83 (5.97)  
  prescribed_other_antipsyc_drug = 1 (%)                       21891 ( 52.8) 
  pre_indexdate_antipysch_prescr = 1 (%)                       14242 ( 65.1) 
  post_indexdate_antipysch_prescr = 1 (%)                       7431 ( 33.9) 
  same_indexdate_antipysch_prescr = 1 (%)                        218 (  1.0) 
  time_between_pre_antipyscho_drug_n_risperidone (mean (SD))    7.94 (8.18)  
  time_between_post_antipyscho_drug_n_risperidone (mean (SD))   1.51 (1.88)  
  pre_indexdate_drug_name (%)                                                
     amisulpride                                                 271 (  1.9) 
     aripiprazole                                                 90 (  0.6) 
     benperidol                                                   10 (  0.1) 
     chlorpromazine                                              224 (  1.6) 
     clozapine                                                     1 (  0.0) 
     flupentixol                                                 278 (  2.0) 
     fluphenazine                                                 21 (  0.1) 
     haloperidol                                                1458 ( 10.2) 
     levomepromazine                                             169 (  1.2) 
     olanzapine                                                  862 (  6.1) 
     pericyazine                                                  33 (  0.2) 
     perphenazine                                                 17 (  0.1) 
     pimozide                                                    122 (  0.9) 
     prochlorperazine                                           7880 ( 55.3) 
     promazine                                                   589 (  4.1) 
     quetiapine                                                 1746 ( 12.3) 
     sulpiride                                                    54 (  0.4) 
     thioridazine                                                180 (  1.3) 
     trifluoperazine                                             229 (  1.6) 
     zuclopenthixol                                                8 (  0.1) 
  same_indexdate_drug_name (%)                                               
     amisulpride                                                   5 (  2.3) 
     aripiprazole                                                  6 (  2.8) 
     chlorpromazine                                                8 (  3.7) 
     flupentixol                                                   1 (  0.5) 
     haloperidol                                                  56 ( 25.7) 
     levomepromazine                                              12 (  5.5) 
     olanzapine                                                   13 (  6.0) 
     pericyazine                                                   1 (  0.5) 
     pimozide                                                      9 (  4.1) 
     prochlorperazine                                             13 (  6.0) 
     promazine                                                    48 ( 22.0) 
     quetiapine                                                   35 ( 16.1) 
     sulpiride                                                     2 (  0.9) 
     trifluoperazine                                               8 (  3.7) 
     zuclopenthixol                                                1 (  0.5) 
  post_indexdate_drug_name (%)                                               
     amisulpride                                                 236 (  3.2) 
     aripiprazole                                                252 (  3.4) 
     benperidol                                                    4 (  0.1) 
     chlorpromazine                                               58 (  0.8) 
     flupentixol                                                  23 (  0.3) 
     haloperidol                                                2040 ( 27.5) 
     levomepromazine                                            2127 ( 28.6) 
     olanzapine                                                  620 (  8.3) 
     pericyazine                                                   9 (  0.1) 
     perphenazine                                                  1 (  0.0) 
     pimozide                                                     45 (  0.6) 
     prochlorperazine                                            507 (  6.8) 
     promazine                                                   256 (  3.4) 
     quetiapine                                                 1174 ( 15.8) 
     sulpiride                                                    38 (  0.5) 
     trifluoperazine                                              33 (  0.4) 
     zuclopenthixol                                                8 (  0.1) 
  stroke_recency (mean (SD))                                    5.59 (7.47)  
  stroke_recency_cat (%)                                                     
      <= 1                                                      1412 ( 27.6) 
      > 7                                                       1417 ( 27.7) 
     1 - 2                                                       652 ( 12.7) 
     2 - 3                                                       456 (  8.9) 
     3 - 4                                                       366 (  7.2) 
     4 - 5                                                       328 (  6.4) 
     5 - 6                                                       273 (  5.3) 
     6 - 7                                                       211 (  4.1) 
  care_home = 1 (%)                                            17728 (100.0) 
  care_home_before_indexdate = 1 (%)                            5658 ( 31.9) 
  care_home_at_indexdate = 1 (%)                                 208 (  1.2) 
  care_home_90_days_after_indexdate = 1 (%)                     9799 ( 55.3) 
  Prescriptions_ever (mean (SD))                               17.90 (32.53) 
  TimeSinceFirstPrescription (mean (SD))                        0.49 (1.01)  
  Prescription_ever_cat (%)                                                  
     >100                                                        876 (  2.1) 
     1                                                          7060 ( 17.0) 
     10                                                         1037 (  2.5) 
     11 - 20                                                    7066 ( 17.0) 
     2                                                          3661 (  8.8) 
     21 - 30                                                    3759 (  9.1) 
     3                                                          2708 (  6.5) 
     31 - 40                                                    2205 (  5.3) 
     4                                                          2193 (  5.3) 
     41 - 50                                                    1361 (  3.3) 
     5                                                          1774 (  4.3) 
     51 - 100                                                   2294 (  5.5) 
     6                                                          1539 (  3.7) 
     7                                                          1437 (  3.5) 
     8                                                          1321 (  3.2) 
     9                                                          1196 (  2.9) 
  Prescriptions_after_a_year_cat (%)                                         
     >100                                                        528 (  3.8) 
     1                                                          1034 (  7.4) 
     10                                                          386 (  2.8) 
     11 - 20                                                    2860 ( 20.5) 
     2                                                           824 (  5.9) 
     21 - 30                                                    1678 ( 12.0) 
     3                                                           710 (  5.1) 
     31 - 40                                                    1053 (  7.5) 
     4                                                           624 (  4.5) 
     41 - 50                                                     668 (  4.8) 
     5                                                           574 (  4.1) 
     51 - 100                                                   1068 (  7.7) 
     6                                                           532 (  3.8) 
     7                                                           497 (  3.6) 
     8                                                           492 (  3.5) 
     9                                                           428 (  3.1) 
  Prescriptions_within_a_year_cat (%)                                        
     >100                                                         23 (  0.1) 
     1                                                          7434 ( 17.9) 
     10                                                         1316 (  3.2) 
     11 - 20                                                   13051 ( 31.5) 
     2                                                          3800 (  9.2) 
     21 - 30                                                    1182 (  2.8) 
     3                                                          2810 (  6.8) 
     31 - 40                                                     385 (  0.9) 
     4                                                          2300 (  5.5) 
     41 - 50                                                     374 (  0.9) 
     5                                                          1877 (  4.5) 
     51 - 100                                                    655 (  1.6) 
     6                                                          1702 (  4.1) 
     7                                                          1662 (  4.0) 
     8                                                          1518 (  3.7) 
     9                                                          1398 (  3.4) 
  missing_ethnicity = 1 (%)                                    11462 ( 27.6) 
  consultation_counts_Cat (%)                                                
     > 2000                                                        1 (  0.0) 
     0 - 50                                                    16342 ( 40.2) 
     1001 - 1500                                                   1 (  0.0) 
     101 - 150                                                  6653 ( 16.4) 
     1501 - 2000                                                   1 (  0.0) 
     151 - 200                                                  2648 (  6.5) 
     201 - 250                                                  1008 (  2.5) 
     251 - 300                                                   429 (  1.1) 
     301 - 350                                                   189 (  0.5) 
     351 - 400                                                    76 (  0.2) 
     401 - 450                                                    41 (  0.1) 
     451 - 500                                                    42 (  0.1) 
     501 - 800                                                    43 (  0.1) 
     51 - 100                                                  13208 ( 32.5) 
     801 - 1000                                                    6 (  0.0)
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_by_stroke_history.png)


**





```
matchit(formula = risperidone ~ +sex + age_diagnosis + comorbidity_angina + 
    comorbidity_heartfailure + BMI + Prescribed_other_antipsychotic_Prior + 
    period_before_prescription + comorbidity_hypertension + comorbidity_myocardialinfarction + 
    comorbidity_stroke + comorbidity_tia + comorbidity_falls + 
    comorbidity_lowerlimbfracture + comorbidity_ihd + comorbidity_pad + 
    comorbidity_af + comorbidity_revasc + comorbidity_qof_diabetes + 
    comorbidity_anxiety_disorders + comorbidity_fh_diabetes + 
    comorbidity_fh_premature_cvd, data = FullData, method = "nearest", 
    distance = "glm", link = "logit", replace = TRUE, caliper = 0.05, 
    ratio = 5)

Summary of Balance for Matched Data:
                                     Means Treated Means Control Std. Mean Diff.
distance                                    0.3484        0.3484         -0.0001
sex                                         0.2907        0.2506          0.0893
age_diagnosis                              81.7053       83.1518         -0.2012
comorbidity_angina                          0.0813        0.1139         -0.1064
comorbidity_heartfailure                    0.0752        0.0759         -0.0024
BMIMissing                                  0.5610        0.6276         -0.1351
BMINormal                                   0.2195        0.1783          0.1009
BMIObesity                                  0.0467        0.0371          0.0486
BMIOverweight                               0.1484        0.1292          0.0544
BMISeverely Obese                           0.0061        0.0051          0.0159
BMIUnderweight                              0.0183        0.0226         -0.0329
Prescribed_other_antipsychotic_Prior        0.3130        0.4120         -0.2145
period_before_prescription                  0.2938        0.3312         -0.1525
comorbidity_hypertension                    0.3089        0.3455         -0.0768
comorbidity_myocardialinfarction            0.0488        0.0474          0.0055
comorbidity_stroke                          0.1321        0.1598         -0.0749
comorbidity_tia                             0.0976        0.1031         -0.0177
comorbidity_falls                           0.2439        0.3525         -0.2310
comorbidity_lowerlimbfracture               0.1301        0.1962         -0.1851
comorbidity_ihd                             0.1463        0.1716         -0.0664
comorbidity_pad                             0.0569        0.0883         -0.1183
comorbidity_af                              0.0915        0.1149         -0.0714
comorbidity_revasc                          0.0142        0.0081          0.0465
comorbidity_qof_diabetes                    0.0915        0.0885          0.0091
comorbidity_anxiety_disorders               0.1179        0.1202         -0.0068
comorbidity_fh_diabetes                     0.0955        0.0813          0.0516
comorbidity_fh_premature_cvd                0.0183        0.0194         -0.0082
                                     Var. Ratio eCDF Mean eCDF Max Std. Pair Dist.
distance                                 0.9983    0.0000   0.0142          0.0013
sex                                           .    0.0401   0.0401          0.8671
age_diagnosis                            0.8346    0.0367   0.1220          1.1866
comorbidity_angina                            .    0.0326   0.0326          0.4945
comorbidity_heartfailure                      .    0.0007   0.0007          0.4104
BMIMissing                                    .    0.0666   0.0666          0.9767
BMINormal                                     .    0.0412   0.0412          0.8238
BMIObesity                                    .    0.0096   0.0096          0.4865
BMIOverweight                                 .    0.0191   0.0191          0.7366
BMISeverely Obese                             .    0.0010   0.0010          0.2500
BMIUnderweight                                .    0.0043   0.0043          0.2698
Prescribed_other_antipsychotic_Prior          .    0.0989   0.0989          0.9037
period_before_prescription               1.3306    0.0324   0.2363          0.5822
comorbidity_hypertension                      .    0.0365   0.0365          0.9413
comorbidity_myocardialinfarction              .    0.0014   0.0014          0.3709
comorbidity_stroke                            .    0.0277   0.0277          0.6387
comorbidity_tia                               .    0.0056   0.0056          0.5267
comorbidity_falls                             .    0.1086   0.1086          0.7963
comorbidity_lowerlimbfracture                 .    0.0661   0.0661          0.6772
comorbidity_ihd                               .    0.0253   0.0253          0.6255
comorbidity_pad                               .    0.0314   0.0314          0.4044
comorbidity_af                                .    0.0234   0.0234          0.4957
comorbidity_revasc                            .    0.0061   0.0061          0.1721
comorbidity_qof_diabetes                      .    0.0029   0.0029          0.4476
comorbidity_anxiety_disorders                 .    0.0023   0.0023          0.6077
comorbidity_fh_diabetes                       .    0.0143   0.0143          0.6823
comorbidity_fh_premature_cvd                  .    0.0011   0.0011          0.3319

Sample Sizes:
                Control Treated
All           203994.       733
Matched (ESS)    299.23     492
Matched         1165.       492
Unmatched     202829.       241
Discarded          0.         0

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Matching.png)
