```mermaid

flowchart TD
    A["New Dementia CPRD Download"] -- All Observations: dementia codelist --> B["n = 3,499,192 records"]
    B -- Exlcluding: Schizophrenia and bipolar disorder --> BB["n = 3,359,895 records"]
    BB -- date of birth &lt; obsdate &lt; lcd/ deregistration /date of death --> C["n = 3,336,261 records"]
    C -- Earliest diagnosis after 1980-01-01 and have a dementia code after registration --> DA["n = 2,865,537 records"]
    C -- Earliest diagnosis after 1980-01-01 and have a dementia code after 2000 --> DC["n = 3,254,768 records"]
    C -- Earliest diagnosis after 1980-01-01 and have a dementia code after 2004 --> DB["n = 3,115,141 records"]
    DA -- Unique patid: Earliest observation --> E["n = 651,863 patients"]
    DC -- Unique patid: Earliest observation --> F["n = 635,404 patients"]
    DB -- Unique patid: Earliest observation --> G["n = 598,807 patients"]
    E -- regend > 2004-01-01 & alive or died > 2004-01-01 --> EE["n = 609,033 patients"]
    F -- regend > 2004-01-01 & alive or died > 2004-01-01 --> FF["n = 613,959 patients"]
    G -- regend > 2004-01-01 & alive or died > 2004-01-01 --> GG["n = 598,808 patients"]
    EE -- Age: 65 or above --> EJ["n = 587,450 patients"]
    FF -- Age: 65 or above --> FJ["n = 592,401 patients"]
    GG -- Age: 65 or above --> GJ["n = 577,941 patients"]
    EJ -- Died --> J("Yes = 290,619   
    No = 296,831")
    EJ -- Gender --> K("Male = 213,215     
    Female = 374235")
    EJ -- On Risperidone after 2004-01-01 --> JJ["n = 51,648 patients"]
    JJ -- After diagnosis --> ZA["n = 29,810 patients"]
    JJ -- &lt; year prior to diagnosis --> ZB("n = 8,218 patients")
    JJ -- > year prior to diagnosis --> ZC("n = 13,620 patients")
    ZA -- Died --> XA("Yes = 15,960  
    No = 13,850 ")
    ZA -- Gender --> XB("Male = 11,403  
    Female = 15,960 ")
    FJ -- Died --> R("Yes = 294,389   
    No = 298,012")
    FJ -- Gender --> Q("Male = 215,375  
    Female = 377,026")
    FJ -- On Risperidone after 2004-01-01 --> KK["n = 52,286 patients"]
    KK -- After diagnosis --> VA["n = 42,433 patients"]
    KK -- &lt; year prior to diagnosis --> VB("n = 4,439 patients")
    KK -- > year prior to diagnosis --> VC("n = 5,414 patients")
    VA -- Died --> YA("Yes = 23,738 
    No = 18,695")
    VA -- Gender --> YB("Male = 16,610    
    Female = 25,823")
    GJ -- Died --> S("Yes = 285,321  
    No = 292,620")
    GJ -- Gender --> T("Male = 211,048 
    Female = 366,893")
    GJ -- On Risperidone after 2004-01-01 --> LL["n = 51,887 patients"]
    LL -- After diagnosis --> AA["n = 42,144 patients"]
    LL -- &lt; year prior to diagnosis --> AB("n = 6,988 patients")
    LL -- > year prior to diagnosis --> AC("n = 2,755 patients")
    AA -- Died --> HA("Yes = 23,568     
    No = 18,576")
    AA -- Gender --> HB("Male = 16,516    
    Female = 25,628")


```

**This is the distribution of number of diagnosis per year for patients diagnosed after registration**


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/AfterRegistrationOverlap.png)




**This is the distribution of number of diagnosis per year for patients diagnosed after 2000**

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/After2000Overlap.png)



**This is the distribution of number of prescriptions per year for patients diagnosed after 2004**


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/After2004Overlap.png)


**BMJ codes vs ours**


```
BMJ codes	279
Our codes	631
Common codes	86
```
**Flow chart of the final cohorts**

![image](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/737f579f-2aaa-4080-b6ce-1c3c6f53e0dc)










**Dementia incident cohort**


```
                                     
                                      Overall       
  n                                   445332        
  diagnosedbeforeRegistration = 1 (%) 351487 (78.9) 
  died = 1 (%)                        223185 (50.1) 
  ONS_died = 1 (%)                    291514 (65.5) 
  death_composite = 1 (%)             325118 (73.0) 
  primary_death_stroke = 1 (%)         14705 ( 3.3) 
  ethnicity (%)                                     
     Black                              8388 ( 1.9) 
     Mixed                              1491 ( 0.3) 
     Other                              2606 ( 0.6) 
     South Asian                        8668 ( 1.9) 
     Unknown                            9353 ( 2.1) 
     White                            414826 (93.1) 
  age_diagnosis (mean (SD))            82.35 (7.02) 
  age_category (%)                                  
     65 - 74                           64311 (14.4) 
     75 - 84                          202073 (45.4) 
     85 - 94                          164303 (36.9) 
     95+                               14645 ( 3.3) 
  HES_stroke = 1 (%)                   56416 (12.7) 
  GP_stroke = 1 (%)                    70378 (15.8) 
  stroke_composite = 1 (%)             86268 (19.4) 
  year_of_diagnosis (%)                             
     2004                              20451 ( 4.6) 
     2005                              17420 ( 3.9) 
     2006                              19704 ( 4.4) 
     2007                              17414 ( 3.9) 
     2008                              17994 ( 4.0) 
     2009                              19944 ( 4.5) 
     2010                              21457 ( 4.8) 
     2011                              22687 ( 5.1) 
     2012                              25236 ( 5.7) 
     2013                              27306 ( 6.1) 
     2014                              29971 ( 6.7) 
     2015                              29769 ( 6.7) 
     2016                              26703 ( 6.0) 
     2017                              26488 ( 5.9) 
     2018                              25311 ( 5.7) 
     2019                              24734 ( 5.6) 
     2020                              19551 ( 4.4) 
     2021                              20462 ( 4.6) 
     2022                              19017 ( 4.3) 
     2023                              13713 ( 3.1) 
  gender_decode = M (%)               162429 (36.5) 
  alcohol_cat (%)                                   
     Excess                            23239 ( 5.2) 
     Harmful                           11657 ( 2.6) 
     None                              41673 ( 9.4) 
     Unknown                          118172 (26.5) 
     Within limits                    250591 (56.3) 
  smoking_cat (%)                                   
     Active smoker                     35954 ( 8.1) 
     Ex-smoker                        185210 (41.6) 
     Non-smoker                       142187 (31.9) 
     Unknown                           81981 (18.4) 
  qrisk2_smoking_cat (%)                            
     0                                191562 (43.0) 
     1                                116583 (26.2) 
     2                                 34441 ( 7.7) 
     3                                  1163 ( 0.3) 
     4                                   876 ( 0.2) 
     Unknown                          100707 (22.6) 
  qrisk2_smoking_cat_uncoded (%)                    
     Ex-smoker                        116583 (26.2) 
     Heavy smoker                        876 ( 0.2) 
     Light smoker                      34441 ( 7.7) 
     Moderate smoker                    1163 ( 0.3) 
     Non-smoker                       191562 (43.0) 
     Unknown                          100707 (22.6) 
  gp_qrisk2_ethnicity (%)                           
     Bangladeshi                         716 ( 0.2) 
     Black African                      1358 ( 0.3) 
     Black Caribbean                    5553 ( 1.2) 
     Chinese                             449 ( 0.1) 
     Indian                             4048 ( 0.9) 
     Other                              3587 ( 0.8) 
     Other Asian                        1575 ( 0.4) 
     Pakistani                          1651 ( 0.4) 
     Unknown                          112463 (25.3) 
     White                            313932 (70.5) 
  hes_qrisk2_ethnicity (%)                          
     Bangladeshi                         616 ( 0.1) 
     Black African                      1304 ( 0.3) 
     Black Caribbean                    5520 ( 1.2) 
     Chinese                             514 ( 0.1) 
     Indian                             3784 ( 0.8) 
     Other                              4954 ( 1.1) 
     Other Asian                        1600 ( 0.4) 
     Pakistani                          1516 ( 0.3) 
     Unknown                           32537 ( 7.3) 
     White                            392987 (88.2) 
  gp_5cat_ethnicity (%)                             
     Black                              7622 ( 1.7) 
     Mixed                              1302 ( 0.3) 
     Other                              2023 ( 0.5) 
     South Asian                        8064 ( 1.8) 
     Unknown                          112373 (25.2) 
     White                            313948 (70.5) 
  hes_5cat_ethnicity (%)                            
     Black                              7829 ( 1.8) 
     Mixed                              1031 ( 0.2) 
     Other                              3432 ( 0.8) 
     South Asian                        7516 ( 1.7) 
     Unknown                           32537 ( 7.3) 
     White                            392987 (88.2) 
  gp_16cat_ethnicity (%)                            
     African                            1371 ( 0.3) 
     Bangladeshi                         716 ( 0.2) 
     Caribbean                          5581 ( 1.3) 
     Chinese                             451 ( 0.1) 
     Indian                             4052 ( 0.9) 
     Other                              1590 ( 0.4) 
     Other Asian                        1585 ( 0.4) 
     Other Black                         598 ( 0.1) 
     Other Mixed                         341 ( 0.1) 
     Other White                        9380 ( 2.1) 
     Pakistani                          1652 ( 0.4) 
     Unknown                          112728 (25.3) 
     White and Asian                     165 ( 0.0) 
     White and Black African             200 ( 0.0) 
     White and Black Caribbean           612 ( 0.1) 
     White British                    299235 (67.2) 
     White Irish                        5075 ( 1.1) 
  hes_16cat_ethnicity (%)                           
     African                            1304 ( 0.3) 
     Bangladeshi                         616 ( 0.1) 
     Caribbean                          5520 ( 1.2) 
     Chinese                             514 ( 0.1) 
     Indian                             3784 ( 0.8) 
     Other                              2918 ( 0.7) 
     Other Asian                        1600 ( 0.4) 
     Other Black                        1005 ( 0.2) 
     Other Mixed                        1031 ( 0.2) 
     Pakistani                          1516 ( 0.3) 
     Unknown                           32537 ( 7.3) 
     White British                    392987 (88.2) 
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/MatchingDeathDates.png)


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/ConfusionMatrix_Died.png)

```
        0      1
  0 120214 101933
  1  33604 189581
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/ConfusionMatrix_Stroke.png)

```
        0      1
  0 359064  15890
  1  29852  40526

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/ConfusionMatrix_Ethnicity.png)

```
              Black  Mixed  Other South Asian Unknown  White
  Black         6025    248    256         108     562    423
  Mixed          537     93    123         102     113    334
  Other           48     34    528         155     210   1048
  South Asian    113     99    491        6331     661    369
  Unknown        766    189    583         604    9353 100878
  White          340    368   1451         216   21638 289935
```



![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death.png)

```
           strata   median    lower    upper
1 gender_decode=F 3.400411 3.383984 3.419576
2 gender_decode=M 2.956879 2.937714 2.978782
```




![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_ageCat.png)

```
                strata   median    lower    upper
1 age_category=65 - 74 5.448323 5.388090 5.505818
2 age_category=75 - 84 3.780972 3.759069 3.802875
3 age_category=85 - 94 2.299795 2.283368 2.316222
4 age_category=95+ 1.237509 1.199179 1.275838
```

**Risperidone incident cohort**
```
                                                        
  n                                                        30060        
  diagnosedbeforeRegistration = 1 (%)                      17005 (56.6) 
  died = 1 (%)                                             17390 (57.9) 
  death_composite = 1 (%)                                  23726 (78.9) 
  ONS_died = 1 (%)                                         20695 (68.8) 
  age_diagnosis (mean (SD))                                80.44 (7.13) 
  age_risperidone (mean (SD))                              82.99 (6.87) 
  gender_decode = M (%)                                    11635 (38.7) 
  GP_stroke = 1 (%)                                         4214 (14.0) 
  HES_stroke = 1 (%)                                        3204 (10.7) 
  stroke_composite = 1 (%)                                  5161 (17.2) 
  primary_death_stroke = 1 (%)                               785 ( 2.6) 
  Composite_pre_stroke = 1 (%)                              4237 (14.1) 
  Composite_post_stroke = 1 (%)                             1695 ( 5.6) 
  comorbidity_stroke = 1 (%)                                4214 (14.0) 
  pre_index_date_stroke = 1 (%)                             3609 (12.0) 
  post_index_date_stroke = 1 (%)                            1061 ( 3.5) 
  Stroke_prior_to_risperidone = 1 (%)                       4237 (14.1) 
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   1038 ( 3.5) 
  death_in_a_year_after_risperidone = 1 (%)                 8585 (28.6) 
  sex = 1 (%)                                              11635 (38.7) 
  ethnicity (%)                                                         
     Black                                                   504 ( 1.7) 
     Mixed                                                   107 ( 0.4) 
     Other                                                   171 ( 0.6) 
     South Asian                                             490 ( 1.6) 
     Unknown                                                 512 ( 1.7) 
     White                                                 28276 (94.1) 
  age_category (%)                                                      
     65 - 74                                                6544 (21.8) 
     75 - 84                                               14552 (48.4) 
     85+                                                    8964 (29.8) 
  year_of_diagnosis (%)                                                 
     2004                                                   1192 ( 4.0) 
     2005                                                   1008 ( 3.4) 
     2006                                                   1068 ( 3.6) 
     2007                                                   1063 ( 3.5) 
     2008                                                   1191 ( 4.0) 
     2009                                                   1532 ( 5.1) 
     2010                                                   1922 ( 6.4) 
     2011                                                   2071 ( 6.9) 
     2012                                                   2258 ( 7.5) 
     2013                                                   2462 ( 8.2) 
     2014                                                   2540 ( 8.4) 
     2015                                                   2284 ( 7.6) 
     2016                                                   2048 ( 6.8) 
     2017                                                   1986 ( 6.6) 
     2018                                                   1709 ( 5.7) 
     2019                                                   1412 ( 4.7) 
     2020                                                   1089 ( 3.6) 
     2021                                                    678 ( 2.3) 
     2022                                                    436 ( 1.5) 
     2023                                                    111 ( 0.4) 
  year_of_prescription (%)                                              
     2004                                                    661 ( 2.2) 
     2005                                                    444 ( 1.5) 
     2006                                                    567 ( 1.9) 
     2007                                                    628 ( 2.1) 
     2008                                                    510 ( 1.7) 
     2009                                                    613 ( 2.0) 
     2010                                                   1163 ( 3.9) 
     2011                                                   1417 ( 4.7) 
     2012                                                   1632 ( 5.4) 
     2013                                                   1910 ( 6.4) 
     2014                                                   2201 ( 7.3) 
     2015                                                   2452 ( 8.2) 
     2016                                                   2549 ( 8.5) 
     2017                                                   2583 ( 8.6) 
     2018                                                   2389 ( 7.9) 
     2019                                                   2326 ( 7.7) 
     2020                                                   2436 ( 8.1) 
     2021                                                   1598 ( 5.3) 
     2022                                                   1195 ( 4.0) 
     2023                                                    786 ( 2.6) 
  stroke_3_months_prior = 1 (%)                              155 ( 0.5) 
  stroke_6_months_prior = 1 (%)                              232 ( 0.8) 
  stroke_12_months_prior = 1 (%)                             368 ( 1.2) 
  prescribed_BMJ_antipsyc_drug = 1 (%)                     25732 (85.6) 
  stroke_recency_cat (%)                                                
      <= 1                                                   368 (10.2) 
      > 7                                                   3042 (84.3) 
     1 - 2                                                   146 ( 4.0) 
     2 - 3                                                    49 ( 1.4) 
     3 - 4                                                     4 ( 0.1) 
  dementia_duration_prior_risperidone (mean (SD))           2.11 (2.35) 
  Survival_time (mean (SD))                                 1.74 (1.90) 
  comorbidity_af = 1 (%)                                    5331 (17.7) 
  pre_index_date_af = 1 (%)                                 4765 (15.9) 
  post_index_date_af = 1 (%)                                1791 ( 6.0) 
  comorbidity_angina = 1 (%)                                3625 (12.1) 
  pre_index_date_angina = 1 (%)                             3536 (11.8) 
  post_index_date_angina = 1 (%)                             343 ( 1.1) 
  comorbidity_anxiety_disorders = 1 (%)                     6185 (20.6) 
  pre_index_date_anxiety_disorders = 1 (%)                  5937 (19.8) 
  post_index_date_anxiety_disorders = 1 (%)                  674 ( 2.2) 
  comorbidity_falls = 1 (%)                                16777 (55.8) 
  pre_index_date_falls = 1 (%)                             12080 (40.2) 
  post_index_date_falls = 1 (%)                             8833 (29.4) 
  comorbidity_fh_diabetes = 1 (%)                           6018 (20.0) 
  pre_index_date_fh_diabetes = 1 (%)                        5927 (19.7) 
  post_index_date_fh_diabetes = 1 (%)                        130 ( 0.4) 
  comorbidity_fh_premature_cvd = 1 (%)                      2311 ( 7.7) 
  pre_index_date_fh_premature_cvd = 1 (%)                   2279 ( 7.6) 
  post_index_date_fh_premature_cvd = 1 (%)                    46 ( 0.2) 
  comorbidity_heartfailure = 1 (%)                          2683 ( 8.9) 
  pre_index_date_heartfailure = 1 (%)                       2276 ( 7.6) 
  post_index_date_heartfailure = 1 (%)                       906 ( 3.0) 
  comorbidity_lowerlimbfracture = 1 (%)                     6301 (21.0) 
  pre_index_date_lowerlimbfracture = 1 (%)                  4757 (15.8) 
  post_index_date_lowerlimbfracture = 1 (%)                 1943 ( 6.5) 
  comorbidity_myocardialinfarction = 1 (%)                  2602 ( 8.7) 
  pre_index_date_myocardialinfarction = 1 (%)               2450 ( 8.2) 
  post_index_date_myocardialinfarction = 1 (%)               279 ( 0.9) 
  comorbidity_qof_diabetes = 1 (%)                          5484 (18.2) 
  pre_index_date_qof_diabetes = 1 (%)                       5167 (17.2) 
  post_index_date_qof_diabetes = 1 (%)                      2386 ( 7.9) 
  comorbidity_revasc = 1 (%)                                1608 ( 5.3) 
  pre_index_date_revasc = 1 (%)                             1599 ( 5.3) 
  post_index_date_revasc = 1 (%)                              24 ( 0.1) 
  stroke_cat = ischaemic (%)                                3612 (85.7) 
  comorbidity_tia = 1 (%)                                   3250 (10.8) 
  pre_index_date_tia = 1 (%)                                2791 ( 9.3) 
  post_index_date_tia = 1 (%)                                701 ( 2.3) 
  comorbidity_deep_vein_thrombosis = 1 (%)                  1989 ( 6.6) 
  pre_index_date_deep_vein_thrombosis = 1 (%)               1528 ( 5.1) 
  post_index_date_deep_vein_thrombosis = 1 (%)               549 ( 1.8) 
  comorbidity_haem_cancer = 1 (%)                            665 ( 2.2) 
  pre_index_date_haem_cancer = 1 (%)                         573 ( 1.9) 
  post_index_date_haem_cancer = 1 (%)                        186 ( 0.6) 
  comorbidity_pulmonary_embolism = 1 (%)                     978 ( 3.3) 
  pre_index_date_pulmonary_embolism = 1 (%)                  752 ( 2.5) 
  post_index_date_pulmonary_embolism = 1 (%)                 271 ( 0.9) 
  comorbidity_solid_cancer = 1 (%)                          5148 (17.1) 
  pre_index_date_solid_cancer = 1 (%)                       4708 (15.7) 
  post_index_date_solid_cancer = 1 (%)                      1065 ( 3.5) 
  VTE = 1 (%)                                               2743 ( 9.1) 
  BMI (%)                                                               
     Normal                                                10802 (35.9) 
     Obesity                                                3879 (12.9) 
     Overweight                                             8591 (28.6) 
     Severely Obese                                          278 ( 0.9) 
     Underweight                                            1303 ( 4.3) 
     Unknown                                                5207 (17.3) 
  totalcholesterol (%)                                                  
     < 160 mg/dl                                            6657 (22.1) 
     > 280 mg/dl                                            1042 ( 3.5) 
     199 mg/dl                                              7480 (24.9) 
     200 - 239 mg/dl                                        6438 (21.4) 
     240 - 279 mg/dl                                        2810 ( 9.3) 
     Unknown                                                5633 (18.7) 
  testvalue_dbp (mean (SD))                                76.41 (11.77)
  testvalue_sbp (mean (SD))                               135.80 (20.25)
  testvalue_totalcholesterol (mean (SD))                    4.98 (1.24) 
  gp_5cat_ethnicity (%)                                                 
     Black                                                   444 ( 1.5) 
     Mixed                                                    90 ( 0.3) 
     Other                                                   147 ( 0.5) 
     South Asian                                             449 ( 1.5) 
     Unknown                                                7311 (24.3) 
     White                                                 21619 (71.9) 
  gp_16cat_ethnicity (%)                                                
     African                                                  75 ( 0.2) 
     Bangladeshi                                              33 ( 0.1) 
     Caribbean                                               321 ( 1.1) 
     Chinese                                                  21 ( 0.1) 
     Indian                                                  227 ( 0.8) 
     Other                                                   128 ( 0.4) 
     Other Asian                                              83 ( 0.3) 
     Other Black                                              47 ( 0.2) 
     Other Mixed                                              21 ( 0.1) 
     Other White                                             665 ( 2.2) 
     Pakistani                                               101 ( 0.3) 
     Unknown                                                7332 (24.4) 
     White and Asian                                          16 ( 0.1) 
     White and Black African                                  11 ( 0.0) 
     White and Black Caribbean                                40 ( 0.1) 
     White British                                         20623 (68.6) 
     White Irish                                             316 ( 1.1) 
  gp_qrisk2_ethnicity (%)                                               
     Bangladeshi                                              33 ( 0.1) 
     Black African                                            75 ( 0.2) 
     Black Caribbean                                         319 ( 1.1) 
     Chinese                                                  21 ( 0.1) 
     Indian                                                  227 ( 0.8) 
     Other                                                   265 ( 0.9) 
     Other Asian                                              82 ( 0.3) 
     Pakistani                                               101 ( 0.3) 
     Unknown                                                7318 (24.3) 
     White                                                 21619 (71.9) 
  alcohol_cat (%)                                                       
     Excess                                                 1467 ( 4.9) 
     Harmful                                                 818 ( 2.7) 
     None                                                   2220 ( 7.4) 
     Unknown                                               10576 (35.2) 
     Within limits                                         14979 (49.8) 
  smoking_cat (%)                                                       
     Active smoker                                          2069 ( 6.9) 
     Ex-smoker                                             11224 (37.3) 
     Non-smoker                                             8404 (28.0) 
     Unknown                                                8363 (27.8) 
  qrisk2_smoking_cat (%)                                                
     0                                                     11101 (36.9) 
     1                                                      7373 (24.5) 
     2                                                      2037 ( 6.8) 
     3                                                        75 ( 0.2) 
     4                                                        40 ( 0.1) 
     Unknown                                                9434 (31.4) 
  qrisk2_smoking_cat_uncoded (%)                                        
     Ex-smoker                                              7373 (24.5) 
     Heavy smoker                                             40 ( 0.1) 
     Light smoker                                           2037 ( 6.8) 
     Moderate smoker                                          75 ( 0.2) 
     Non-smoker                                            11101 (36.9) 
     Unknown                                                9434 (31.4) 
  drug_name (%)                                                         
     amisulpride                                             488 ( 3.2) 
     aripiprazole                                            198 ( 1.3) 
     benperidol                                               20 ( 0.1) 
     chlorpromazine                                          230 ( 1.5) 
     clozapine                                                 1 ( 0.0) 
     flupentixol                                             165 ( 1.1) 
     fluphenazine                                             12 ( 0.1) 
     haloperidol                                            2714 (17.8) 
     levomepromazine                                        1697 (11.1) 
     olanzapine                                             1106 ( 7.2) 
     pericyazine                                              31 ( 0.2) 
     perphenazine                                             11 ( 0.1) 
     pimozide                                                128 ( 0.8) 
     prochlorperazine                                       6004 (39.3) 
     promazine                                               517 ( 3.4) 
     quetiapine                                             1798 (11.8) 
     sulpiride                                                38 ( 0.2) 
     thioridazine                                             34 ( 0.2) 
     trifluoperazine                                          78 ( 0.5) 
     zuclopenthixol                                           14 ( 0.1) 
  frailty (%)                                                           
     Mild                                                   1358 ( 4.5) 
     Moderate                                               3435 (11.4) 
     Severe                                                 5376 (17.9) 
     Unknown                                               19891 (66.2) 
  year_diagnosis_cat (%)                                                
     > 2020                                                 1225 ( 4.1) 
     2004 - 2008                                            5522 (18.4) 
     2009 - 2012                                            7783 (25.9) 
     2013 - 2016                                            9334 (31.1) 
     2017 - 2020                                            6196 (20.6) 
  prescribed_other_antipsyc_drug = 1 (%)                   15284 (50.8) 
  pre_indexdate_antipysch_prescr = 1 (%)                   10105 (66.1) 
  post_indexdate_antipysch_prescr = 1 (%)                   5088 (33.3) 
  same_indexdate_antipysch_prescr = 1 (%)                     91 ( 0.6) 
  pre_indexdate_drug_name (%)                                           
     amisulpride                                             184 ( 1.8) 
     aripiprazole                                             76 ( 0.8) 
     benperidol                                                7 ( 0.1) 
     chlorpromazine                                          123 ( 1.2) 
     clozapine                                                 1 ( 0.0) 
     flupentixol                                             196 ( 1.9) 
     fluphenazine                                             11 ( 0.1) 
     haloperidol                                             915 ( 9.1) 
     levomepromazine                                          91 ( 0.9) 
     olanzapine                                              584 ( 5.8) 
     pericyazine                                              19 ( 0.2) 
     perphenazine                                              7 ( 0.1) 
     pimozide                                                118 ( 1.2) 
     prochlorperazine                                       6005 (59.4) 
     promazine                                               316 ( 3.1) 
     quetiapine                                             1179 (11.7) 
     sulpiride                                                42 ( 0.4) 
     thioridazine                                            105 ( 1.0) 
     trifluoperazine                                         119 ( 1.2) 
     zuclopenthixol                                            7 ( 0.1) 
  same_indexdate_drug_name (%)                                          
     amisulpride                                               2 ( 2.2) 
     aripiprazole                                              8 ( 8.8) 
     chlorpromazine                                            5 ( 5.5) 
     flupentixol                                               2 ( 2.2) 
     haloperidol                                              21 (23.1) 
     levomepromazine                                           1 ( 1.1) 
     olanzapine                                                3 ( 3.3) 
     pimozide                                                  8 ( 8.8) 
     prochlorperazine                                          6 ( 6.6) 
     promazine                                                15 (16.5) 
     quetiapine                                               17 (18.7) 
     trifluoperazine                                           3 ( 3.3) 
  post_indexdate_drug_name (%)                                          
     amisulpride                                             118 ( 2.3) 
     aripiprazole                                            174 ( 3.4) 
     benperidol                                                3 ( 0.1) 
     chlorpromazine                                           30 ( 0.6) 
     flupentixol                                              12 ( 0.2) 
     haloperidol                                            1422 (27.9) 
     levomepromazine                                        1562 (30.7) 
     olanzapine                                              460 ( 9.0) 
     pericyazine                                               5 ( 0.1) 
     pimozide                                                 35 ( 0.7) 
     prochlorperazine                                        327 ( 6.4) 
     promazine                                               136 ( 2.7) 
     quetiapine                                              762 (15.0) 
     sulpiride                                                16 ( 0.3) 
     trifluoperazine                                          20 ( 0.4) 
     zuclopenthixol                                            6 ( 0.1) 
  care_home = 1 (%)                                        12371 (41.2) 
  care_home_before_indexdate = 1 (%)                        3977 (32.1) 
  care_home_at_indexdate = 1 (%)                             127 ( 1.0) 
  care_home_90_days_after_indexdate = 1 (%)                 2683 (21.7) 
  TimeSinceFirstPrescription (mean (SD))                    0.49 (0.93) 
  Prescription_ever_cat (%)                                             
     >100                                                    555 ( 1.8) 
     1                                                      5163 (17.2) 
     10                                                      781 ( 2.6) 
     11 - 20                                                5103 (17.0) 
     2                                                      2655 ( 8.8) 
     21 - 30                                                2757 ( 9.2) 
     3                                                      1930 ( 6.4) 
     31 - 40                                                1618 ( 5.4) 
     4                                                      1582 ( 5.3) 
     41 - 50                                                1002 ( 3.3) 
     5                                                      1303 ( 4.3) 
     51 - 100                                               1653 ( 5.5) 
     6                                                      1111 ( 3.7) 
     7                                                      1051 ( 3.5) 
     8                                                       926 ( 3.1) 
     9                                                       870 ( 2.9) 
  Prescriptions_after_a_year_cat (%)                                    
     >100                                                    301 ( 3.0) 
     1                                                       699 ( 7.0) 
     10                                                      288 ( 2.9) 
     11 - 20                                                2119 (21.3) 
     2                                                       610 ( 6.1) 
     21 - 30                                                1193 (12.0) 
     3                                                       520 ( 5.2) 
     31 - 40                                                 759 ( 7.6) 
     4                                                       455 ( 4.6) 
     41 - 50                                                 469 ( 4.7) 
     5                                                       413 ( 4.2) 
     51 - 100                                                723 ( 7.3) 
     6                                                       372 ( 3.7) 
     7                                                       373 ( 3.8) 
     8                                                       328 ( 3.3) 
     9                                                       311 ( 3.1) 
  Prescriptions_within_a_year_cat (%)                                   
     >100                                                     16 ( 0.1) 
     1                                                      5382 (17.9) 
     10                                                      953 ( 3.2) 
     11 - 20                                                9427 (31.4) 
     2                                                      2739 ( 9.1) 
     21 - 30                                                 850 ( 2.8) 
     3                                                      2004 ( 6.7) 
     31 - 40                                                 310 ( 1.0) 
     4                                                      1651 ( 5.5) 
     41 - 50                                                 298 ( 1.0) 
     5                                                      1392 ( 4.6) 
     51 - 100                                                517 ( 1.7) 
     6                                                      1232 ( 4.1) 
     7                                                      1224 ( 4.1) 
     8                                                      1064 ( 3.5) 
     9                                                      1001 ( 3.3) 
  consultation_counts_Cat (%)                                           
     0 - 50                                                10847 (36.7) 
     101 - 150                                              5102 (17.2) 
     151 - 200                                              1936 ( 6.5) 
     201 - 250                                               732 ( 2.5) 
     251 - 300                                               302 ( 1.0) 
     301 - 350                                               123 ( 0.4) 
     351 - 400                                                50 ( 0.2) 
     401 - 450                                                34 ( 0.1) 
     451 - 500                                                28 ( 0.1) 
     501 - 800                                                30 ( 0.1) 
     51 - 100                                              10391 (35.1) 
     801 - 1000                                                3 ( 0.0) 
  pre_BMJ_indexdate_drug_name (%)                                       
     amisulpride                                             169 ( 8.7) 
     aripiprazole                                             15 ( 0.8) 
     benperidol                                                7 ( 0.4) 
     chlorpromazine                                          122 ( 6.3) 
     clozapine                                                 1 ( 0.1) 
     flupentixol                                             122 ( 6.3) 
     fluphenazine                                             10 ( 0.5) 
     haloperidol                                             852 (43.7) 
     levomepromazine                                          10 ( 0.5) 
     olanzapine                                               49 ( 2.5) 
     pericyazine                                              19 ( 1.0) 
     perphenazine                                              2 ( 0.1) 
     pimozide                                                  5 ( 0.3) 
     prochlorperazine                                        368 (18.9) 
     promazine                                                46 ( 2.4) 
     quetiapine                                               67 ( 3.4) 
     sulpiride                                                16 ( 0.8) 
     thioridazine                                             33 ( 1.7) 
     trifluoperazine                                          34 ( 1.7) 
     zuclopenthixol                                            2 ( 0.1) 
  same_BMJ_indexdate_drug_name (%)                                      
     amisulpride                                              93 ( 0.9) 
     aripiprazole                                            186 ( 1.8) 
     benperidol                                                3 ( 0.0) 
     chlorpromazine                                           30 ( 0.3) 
     flupentixol                                              64 ( 0.6) 
     fluphenazine                                              1 ( 0.0) 
     haloperidol                                            1187 (11.4) 
     levomepromazine                                        1289 (12.3) 
     olanzapine                                              770 ( 7.4) 
     pericyazine                                               5 ( 0.0) 
     perphenazine                                              5 ( 0.0) 
     pimozide                                                128 ( 1.2) 
     prochlorperazine                                       4808 (46.0) 
     promazine                                               309 ( 3.0) 
     quetiapine                                             1400 (13.4) 
     sulpiride                                                29 ( 0.3) 
     thioridazine                                             59 ( 0.6) 
     trifluoperazine                                          75 ( 0.7) 
     zuclopenthixol                                            6 ( 0.1) 
  post_BMJ_indexdate_drug_name (%)                                      
     amisulpride                                              34 ( 3.8) 
     aripiprazole                                             28 ( 3.1) 
     chlorpromazine                                            5 ( 0.6) 
     flupentixol                                               9 ( 1.0) 
     haloperidol                                             150 (16.8) 
     levomepromazine                                          89 (10.0) 
     olanzapine                                               66 ( 7.4) 
     pimozide                                                  7 ( 0.8) 
     prochlorperazine                                        320 (35.9) 
     promazine                                                26 ( 2.9) 
     quetiapine                                              135 (15.2) 
     sulpiride                                                 5 ( 0.6) 
     thioridazine                                              2 ( 0.2) 
     trifluoperazine                                          12 ( 1.3) 
     zuclopenthixol                                            3 ( 0.3) 
  comorbidity_hypertension (%)                                          
     Elevated                                               3327 (11.1) 
     Normal                                                 4156 (13.8) 
     Stage 1                                               13285 (44.2) 
     Stage 2                                                8633 (28.7) 
     Stage 3 (severe)                                        191 ( 0.6) 
     Unknown                                                 468 ( 1.6) 
  pre_index_date_hypertension = 1 (%)                      24666 (83.3) 
  comorbidity_hearing_loss = 1 (%)                          8411 (28.0) 
  pre_index_date_hearing_loss = 1 (%)                       7900 (26.3) 
  post_index_date_hearing_loss = 1 (%)                      1127 ( 3.7) 
  pre_indexdate_BMJ_antipysch_prescr = 1 (%)                1961 ( 7.6) 
  post_indexdate_BMJ_antipysch_prescr = 1 (%)               1756 ( 6.8) 
  same_indexdate_BMJ_antipysch_prescr = 1 (%)              22015 (85.6) 
  HES_comorbidity_stroke = 1 (%)                            3204 (10.7) 
  HES_pre_index_date_stroke = 1 (%)                         2568 ( 8.5) 
  HES_post_index_date_stroke = 1 (%)                         964 ( 3.2) 
  hes_5cat_ethnicity (%)                                                
     Black                                                   474 ( 1.6) 
     Mixed                                                    70 ( 0.2) 
     Other                                                   189 ( 0.6) 
     South Asian                                             440 ( 1.5) 
     Unknown                                                2169 ( 7.2) 
     White                                                 26718 (88.9) 
  hes_16cat_ethnicity (%)                                               
     African                                                  78 ( 0.3) 
     Bangladeshi                                              30 ( 0.1) 
     Caribbean                                               341 ( 1.1) 
     Chinese                                                  20 ( 0.1) 
     Indian                                                  202 ( 0.7) 
     Other                                                   169 ( 0.6) 
     Other Asian                                             106 ( 0.4) 
     Other Black                                              55 ( 0.2) 
     Other Mixed                                              70 ( 0.2) 
     Pakistani                                               102 ( 0.3) 
     Unknown                                                2169 ( 7.2) 
     White British                                         26718 (88.9) 
  hes_qrisk2_ethnicity (%)                                              
     Bangladeshi                                              30 ( 0.1) 
     Black African                                            78 ( 0.3) 
     Black Caribbean                                         341 ( 1.1) 
     Chinese                                                  20 ( 0.1) 
     Indian                                                  202 ( 0.7) 
     Other                                                   294 ( 1.0) 
     Other Asian                                             106 ( 0.4) 
     Pakistani                                               102 ( 0.3) 
     Unknown                                                2169 ( 7.2) 
     White                                                 26718 (88.9) 
```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_risperidone.png)

```
           strata   median    lower    upper
1 gender_decode=F 4.654346 4.591376 4.717317
2 gender_decode=M 4.101300 4.035592 4.175222
```





![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_ageCat_risperidone.png)

```
                strata   median    lower    upper
1 age_category=65 - 74 6.308008 6.179329 6.461328
2 age_category=75 - 84 4.692676 4.624230 4.761123
3     age_category=85+ 3.063655 2.997947 3.126626

```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_by_stroke_history.png)

**COX model**
```
Call:
coxph(formula = Surv(Survival_time, Composite_post_stroke) ~ 
    age_diagnosis + Composite_pre_stroke + sex, data = CompleteData)

  n= 30060, number of events= 1695 

                          coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis         0.006682  1.006704 0.003562  1.876   0.0607 .  
Composite_pre_stroke1 1.825286  6.204567 0.049282 37.038   <2e-16 ***
sex1                  0.119763  1.127229 0.051070  2.345   0.0190 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                      exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis             1.007     0.9933    0.9997     1.014
Composite_pre_stroke1     6.205     0.1612    5.6333     6.834
sex1                      1.127     0.8871    1.0199     1.246

Concordance= 0.713  (se = 0.008 )
Likelihood ratio test= 1204  on 3 df,   p=<2e-16
Wald test            = 1419  on 3 df,   p=<2e-16
Score (logrank) test = 1860  on 3 df,   p=<2e-16


```



**One year censoring**
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_by_stroke_history_censoring.png)

```
Call:
coxph(formula = Surv(Survival_time, Composite_post_stroke) ~ 
    age_diagnosis + Composite_pre_stroke + sex, data = CensoringData_1year)

  n= 30040, number of events= 1037 
   (20 observations deleted due to missingness)

                          coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis         0.003332  1.003337 0.004501  0.740   0.4592    
Composite_pre_stroke1 2.076755  7.978539 0.062823 33.057   <2e-16 ***
sex1                  0.124871  1.133003 0.064246  1.944   0.0519 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                      exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis             1.003     0.9967    0.9945     1.012
Composite_pre_stroke1     7.979     0.1253    7.0542     9.024
sex1                      1.133     0.8826    0.9990     1.285

Concordance= 0.726  (se = 0.009 )
Likelihood ratio test= 1019  on 3 df,   p=<2e-16
Wald test            = 1126  on 3 df,   p=<2e-16
Score (logrank) test = 1597  on 3 df,   p=<2e-16
```

**Excluding stroke 3 months prior**
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_by_stroke_history_Adjusted_ST_3months.png)

```
Call:
coxph(formula = Surv(Survival_time, Composite_post_stroke) ~ 
    age_diagnosis + Composite_pre_stroke + sex, data = Excluding_3_monthsPriorStroke)

  n= 29905, number of events= 1615 

                          coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis         0.007775  1.007806 0.003646  2.133   0.0330 *  
Composite_pre_stroke1 1.743310  5.716231 0.050815 34.307   <2e-16 ***
sex1                  0.121428  1.129108 0.052390  2.318   0.0205 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                      exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis             1.008     0.9923     1.001     1.015
Composite_pre_stroke1     5.716     0.1749     5.174     6.315
sex1                      1.129     0.8857     1.019     1.251

Concordance= 0.701  (se = 0.008 )
Likelihood ratio test= 1023  on 3 df,   p=<2e-16
Wald test            = 1223  on 3 df,   p=<2e-16
Score (logrank) test = 1566  on 3 df,   p=<2e-16

```






**Excluding stroke 12 months prior**
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_by_stroke_history_Adjusted_ST_12months.png)

```
Call:
coxph(formula = Surv(Survival_time, Composite_post_stroke) ~ 
    age_diagnosis + Composite_pre_stroke + sex, data = Excluding_12_monthsPriorStroke)

  n= 29692, number of events= 1546 

                          coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis         0.008703  1.008741 0.003734  2.331   0.0198 *  
Composite_pre_stroke1 1.679211  5.361324 0.052382 32.057   <2e-16 ***
sex1                  0.136316  1.146044 0.053538  2.546   0.0109 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                      exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis             1.009     0.9913     1.001     1.016
Composite_pre_stroke1     5.361     0.1865     4.838     5.941
sex1                      1.146     0.8726     1.032     1.273

Concordance= 0.689  (se = 0.008 )
Likelihood ratio test= 886  on 3 df,   p=<2e-16
Wald test            = 1073  on 3 df,   p=<2e-16
Score (logrank) test = 1352  on 3 df,   p=<2e-16

```





**Matching**

***Updated Algorithm - exact match on: Sex, stroke history, cvd and risperidone age category (65-74, 75-84, 85+)***

```
                                                         Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       137073         28449                            
  sex = 1 (%)                                              51831 (37.8)  10835 ( 38.1)   0.391       0.006
  risperidone = 1 (%)                                          0 ( 0.0)  28449 (100.0)  <0.001         NaN
  age_risperidone (mean (SD))                              83.18 (6.79)  83.12 (6.83)    0.193       0.008
  age_diagnosis (mean (SD))                                80.47 (6.87)  80.51 (7.10)    0.467       0.005
  age_risperidone_cat (%)                                                                0.181       0.012
     65 - 74                                               15262 (11.1)   3274 ( 11.5)                    
     75 - 84                                               61964 (45.2)  12834 ( 45.1)                    
     85+                                                   59847 (43.7)  12341 ( 43.4)                    
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   4691 ( 3.4)   1103 (  3.9)  <0.001       0.024
  stroke_composite_pre_index_date = 1 (%)                  17956 (13.1)   3875 ( 13.6)   0.019       0.015
  pre_index_date_angina = 1 (%)                            15968 (11.6)   3346 ( 11.8)   0.599       0.003
  pre_index_date_heartfailure = 1 (%)                      10494 ( 7.7)   2196 (  7.7)   0.724       0.002
  BMI (%)                                                                                0.086       0.020
     Missing                                               25364 (18.5)   5474 ( 19.2)                    
     Normal                                                53306 (38.9)  11023 ( 38.7)                    
     Obesity                                               14436 (10.5)   2988 ( 10.5)                    
     Overweight                                            35140 (25.6)   7182 ( 25.2)                    
     Severely Obese                                          945 ( 0.7)    187 (  0.7)                    
     Underweight                                            7882 ( 5.8)   1595 (  5.6)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             37065 (27.0)   7372 ( 25.9)  <0.001       0.026
  period_before_prescription (mean (SD))                    2.74 (2.19)   2.62 (2.40)   <0.001       0.051
  comorbidity_myocardialinfarction = 1 (%)                 12292 ( 9.0)   2475 (  8.7)   0.153       0.009
  pre_index_date_stroke = 1 (%)                            16065 (11.7)   3390 ( 11.9)   0.355       0.006
  pre_index_date_tia = 1 (%)                               12943 ( 9.4)   2660 (  9.4)   0.636       0.003
  pre_index_date_falls = 1 (%)                             57341 (41.8)  11758 ( 41.3)   0.119       0.010
  pre_index_date_lowerlimbfracture = 1 (%)                 22268 (16.2)   4522 ( 15.9)   0.147       0.010
  pre_index_date_ihd = 1 (%)                               22614 (16.5)   4717 ( 16.6)   0.739       0.002
  pre_index_date_pad = 1 (%)                               10671 ( 7.8)   2208 (  7.8)   0.902       0.001
  pre_index_date_af = 1 (%)                                22022 (16.1)   4567 ( 16.1)   0.965      <0.001
  pre_index_date_revasc = 1 (%)                             7367 ( 5.4)   1522 (  5.3)   0.878       0.001
  pre_index_date_qof_diabetes = 1 (%)                      24322 (17.7)   4970 ( 17.5)   0.274       0.007
  pre_index_date_anxiety_disorders = 1 (%)                 27312 (19.9)   5639 ( 19.8)   0.696       0.003
  pre_index_date_fh_diabetes = 1 (%)                       28411 (20.7)   5827 ( 20.5)   0.358       0.006
  pre_index_date_fh_premature_cvd = 1 (%)                  10891 ( 7.9)   2234 (  7.9)   0.607       0.003
  pre_index_date_pulmonary_embolism = 1 (%)                 3501 ( 2.6)    727 (  2.6)   1.000      <0.001
  pre_index_date_deep_vein_thrombosis = 1 (%)               7233 ( 5.3)   1481 (  5.2)   0.636       0.003
  pre_index_date_hearing_loss = 1 (%)                      36815 (26.9)   7634 ( 26.8)   0.940       0.001
  VTE = 1 (%)                                              12376 ( 9.0)   2639 (  9.3)   0.190       0.009
  comorbidity_hypertension (%)                                                          <0.001       0.047
     Elevated                                              23935 (17.5)   4972 ( 17.5)                    
     Normal                                                35061 (25.6)   7206 ( 25.3)                    
     Stage 1                                               54059 (39.4)  11184 ( 39.3)                    
     Stage 2                                               22565 (16.5)   4637 ( 16.3)                    
     Stage 3 (severe)                                        163 ( 0.1)     38 (  0.1)                    
     Unknown                                                1290 ( 0.9)    412 (  1.4)                    
  Survival_time (mean (SD))                                 2.18 (2.02)   1.60 (1.81)   <0.001       0.306

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_censored.png)




![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_censored_under75.png)


```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    risperidone, data = table)

  n= 165522, number of events= 10274 

              coef exp(coef) se(coef)     z Pr(>|z|)    
risperidone 0.1223    1.1300   0.0275 4.446 8.75e-06 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

            exp(coef) exp(-coef) lower .95 upper .95
risperidone      1.13     0.8849     1.071     1.193

Concordance= 0.512  (se = 0.002 )
Likelihood ratio test= 19.22  on 1 df,   p=1e-05
Wald test            = 19.77  on 1 df,   p=9e-06
Score (logrank) test = 19.79  on 1 df,   p=9e-06

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored.png)
```
         strata   median    lower    upper
1 risperidone=0 5.519507 5.489391 5.544148
2 risperidone=1 3.972621 3.915127 4.046543
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_under75.png)
```
         strata   median    lower    upper
1 risperidone=0 6.784394 6.652977 6.904860
2 risperidone=1 4.377823 4.156057 4.607803
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_death_1st_year.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_ControlGroup_censored.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_TreatmentGroup_censored.png)

***Updated Algorithm - without exact match***

```
                                                        Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       146295         29717                            
  sex = 1 (%)                                              56356 (38.5)  11464 ( 38.6)   0.864       0.001
  risperidone = 1 (%)                                          0 ( 0.0)  29717 (100.0)  <0.001         NaN
  age_risperidone (mean (SD))                              83.07 (6.89)  83.02 (6.86)    0.232       0.008
  age_diagnosis (mean (SD))                                80.45 (6.94)  80.45 (7.12)    0.933       0.001
  age_risperidone_cat (%)                                                                0.784       0.004
     65 - 74                                               17664 (12.1)   3580 ( 12.0)                    
     75 - 84                                               65579 (44.8)  13386 ( 45.0)                    
     85+                                                   63052 (43.1)  12751 ( 42.9)                    
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   5370 ( 3.7)   1190 (  4.0)   0.006       0.017
  stroke_composite_pre_index_date = 1 (%)                  20884 (14.3)   4202 ( 14.1)   0.549       0.004
  pre_index_date_angina = 1 (%)                            17416 (11.9)   3517 ( 11.8)   0.742       0.002
  pre_index_date_heartfailure = 1 (%)                      11141 ( 7.6)   2267 (  7.6)   0.947      <0.001
  BMI (%)                                                                                0.995       0.004
     Missing                                               31359 (21.4)   6383 ( 21.5)                    
     Normal                                                55341 (37.8)  11229 ( 37.8)                    
     Obesity                                               14838 (10.1)   3011 ( 10.1)                    
     Overweight                                            35744 (24.4)   7274 ( 24.5)                    
     Severely Obese                                          996 ( 0.7)    193 (  0.6)                    
     Underweight                                            8017 ( 5.5)   1627 (  5.5)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             37707 (25.8)   7446 ( 25.1)   0.010       0.016
  period_before_prescription (mean (SD))                    2.66 (2.15)   2.57 (2.39)   <0.001       0.039
  comorbidity_myocardialinfarction = 1 (%)                 13294 ( 9.1)   2581 (  8.7)   0.028       0.014
  pre_index_date_stroke = 1 (%)                            18091 (12.4)   3584 ( 12.1)   0.146       0.009
  pre_index_date_tia = 1 (%)                               13829 ( 9.5)   2767 (  9.3)   0.453       0.005
  pre_index_date_falls = 1 (%)                             59779 (40.9)  12027 ( 40.5)   0.215       0.008
  pre_index_date_lowerlimbfracture = 1 (%)                 23657 (16.2)   4702 ( 15.8)   0.139       0.009
  pre_index_date_ihd = 1 (%)                               24555 (16.8)   4953 ( 16.7)   0.628       0.003
  pre_index_date_pad = 1 (%)                               11174 ( 7.6)   2290 (  7.7)   0.696       0.003
  pre_index_date_af = 1 (%)                                23389 (16.0)   4733 ( 15.9)   0.801       0.002
  pre_index_date_revasc = 1 (%)                             7791 ( 5.3)   1586 (  5.3)   0.947       0.001
  pre_index_date_qof_diabetes = 1 (%)                      25104 (17.2)   5129 ( 17.3)   0.684       0.003
  pre_index_date_anxiety_disorders = 1 (%)                 29666 (20.3)   5880 ( 19.8)   0.055       0.012
  pre_index_date_fh_diabetes = 1 (%)                       29084 (19.9)   5911 ( 19.9)   0.973      <0.001
  pre_index_date_fh_premature_cvd = 1 (%)                  11285 ( 7.7)   2274 (  7.7)   0.725       0.002
  pre_index_date_pulmonary_embolism = 1 (%)                 3815 ( 2.6)    746 (  2.5)   0.345       0.006
  pre_index_date_deep_vein_thrombosis = 1 (%)               7563 ( 5.2)   1520 (  5.1)   0.708       0.002
  pre_index_date_hearing_loss = 1 (%)                      38766 (26.5)   7859 ( 26.4)   0.858       0.001
  VTE = 1 (%)                                              13120 ( 9.0)   2716 (  9.1)   0.352       0.006
  comorbidity_hypertension (%)                                                          <0.001       0.047
     Elevated                                              25050 (17.1)   5080 ( 17.1)                    
     Normal                                                37577 (25.7)   7492 ( 25.2)                    
     Stage 1                                               56147 (38.4)  11374 ( 38.3)                    
     Stage 2                                               23324 (15.9)   4681 ( 15.8)                    
     Stage 3 (severe)                                        207 ( 0.1)     40 (  0.1)                    
     Unknown                                                3990 ( 2.7)   1050 (  3.5)                    
  Survival_time (mean (SD))                                 2.18 (2.02)   1.61 (1.83)   <0.001       0.291

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_censored_noExact.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_censored_under75_noExact.png)
```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    risperidone, data = table)

  n= 176012, number of events= 11632 

               coef exp(coef) se(coef)     z Pr(>|z|)  
risperidone 0.06783   1.07018  0.02643 2.567   0.0103 *
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

            exp(coef) exp(-coef) lower .95 upper .95
risperidone      1.07     0.9344     1.016     1.127

Concordance= 0.509  (se = 0.002 )
Likelihood ratio test= 6.48  on 1 df,   p=0.01
Wald test            = 6.59  on 1 df,   p=0.01
Score (logrank) test = 6.59  on 1 df,   p=0.01

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_noExact.png)
```
         strata   median    lower    upper
1 risperidone=0 5.366188 5.341547 5.390828
2 risperidone=1 3.935661 3.879535 4.002738
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_under75_noExact.png)
```
         strata   median    lower    upper
1 risperidone=0 6.521561 6.420260 6.603696
2 risperidone=1 4.328542 4.123203 4.520192
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_death_1st_year_noExact.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_ControlGroup_censored_noExact.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_TreatmentGroup_censored_noExact.png)



***Death***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/DeathCOX.png)

```
Call: survfit(formula = Surv(stime, fail) ~ risperidone, data = data)

                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.487239 1.444572 1.531166
```
***Primary care stroke***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/PC_stroke.png)

```

                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.218886 1.113119 1.334704
```

***HES stroke***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/HES_stroke.png)

```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.196758 1.090976 1.312797
```


***Composite stroke***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Composite_stroke.png)

```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.239755 1.158657 1.326529
```

***Stroke composite - include only those without a history of stroke***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Composite_stroke_noHistory.png)


```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.337269 1.212788 1.474527
```

***Stroke composite - include only WITH a history of stroke***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Composite_stroke_OnlyHistory.png)


```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.19713 1.087565 1.317734
```

***Stroke composite - include only over 75s***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Composite_stroke_onlyOver75.png)

```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.215812 1.131883 1.305965
```


***Stroke composite - include only under 75s***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Composite_stroke_onlyUnder75.png)

```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.504179 1.217258 1.85873
```

***No other drugs***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Composite_stroke_noOtherDrugs.png)

```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.327142 1.194215 1.474865
```

***CVD composite:***
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/CvdCOX.png)

```
                  model       hr     ci.l     ci.u
risperidone1 unadjusted 1.063408 1.016238 1.112767
```


***Analysis***

```
                                                     scenario              outcome      model        hr      ci.l      ci.u
stroke.pc_unadjusted_all                                  all            stroke.pc unadjusted 1.1724632 1.0715371 1.2828953
stroke.pc_adjusted_all                                    all            stroke.pc   adjusted 1.1789811 1.0748061 1.2932531
stroke.hes_unadjusted_all                                 all           stroke.hes unadjusted 1.1511164 1.0490279 1.2631400
stroke.hes_adjusted_all                                   all           stroke.hes   adjusted 1.1780394 1.0723945 1.2940916
stroke.c_unadjusted_all                                   all             stroke.c unadjusted 1.2055865 1.1252135 1.2917005
stroke.c_adjusted_all                                     all             stroke.c   adjusted 1.2254061 1.1411560 1.3158763
death_unadjusted_all                                      all                death unadjusted 1.5010777 1.4583841 1.5450211
death_adjusted_all                                        all                death   adjusted 1.5547782 1.5092843 1.6016433
cvd_unadjusted_all                                        all                  cvd unadjusted 1.0272837 0.9835359 1.0729775
cvd_adjusted_all                                          all                  cvd   adjusted 1.0256025 0.9801198 1.0731959
tia_unadjusted_all                                        all                  tia unadjusted 1.2282083 1.0965071 1.3757281
tia_adjusted_all                                          all                  tia   adjusted 1.2029931 1.0733609 1.3482812
heartfailure_unadjusted_all                               all         heartfailure unadjusted 0.9934966 0.9092002 1.0856086
heartfailure_adjusted_all                                 all         heartfailure   adjusted 1.0133604 0.9255762 1.1094704
myocardialinfarction_unadjusted_all                       all myocardialinfarction unadjusted 0.8491504 0.7187385 1.0032249
myocardialinfarction_adjusted_all                         all myocardialinfarction   adjusted 0.8404123 0.7093292 0.9957194
angina_unadjusted_all                                     all               angina unadjusted 0.8155408 0.7049223 0.9435180
angina_adjusted_all                                       all               angina   adjusted 0.8177178 0.7052894 0.9480680
pad_unadjusted_all                                        all                  pad unadjusted 1.0382176 0.9257707 1.1643225
pad_adjusted_all                                          all                  pad   adjusted 1.0322201 0.9193608 1.1589340
falls_unadjusted_all                                      all                falls unadjusted 1.4435577 1.4002443 1.4882110
falls_adjusted_all                                        all                falls   adjusted 1.4288421 1.3854841 1.4735570
lowerlimbfracture_unadjusted_all                          all    lowerlimbfracture unadjusted 1.5612172 1.4499542 1.6810179
lowerlimbfracture_adjusted_all                            all    lowerlimbfracture   adjusted 1.5408410 1.4299908 1.6602841
stroke.pc_unadjusted_no_stroke                      no_stroke            stroke.pc unadjusted 1.2531155 1.0947231 1.4344252
stroke.pc_adjusted_no_stroke                        no_stroke            stroke.pc   adjusted 1.2386180 1.0799665 1.4205760
stroke.hes_unadjusted_no_stroke                     no_stroke           stroke.hes unadjusted 1.1484662 1.0102992 1.3055288
stroke.hes_adjusted_no_stroke                       no_stroke           stroke.hes   adjusted 1.1739954 1.0320737 1.3354328
stroke.c_unadjusted_no_stroke                       no_stroke             stroke.c unadjusted 1.2597042 1.1359173 1.3969808
stroke.c_adjusted_no_stroke                         no_stroke             stroke.c   adjusted 1.2682798 1.1425675 1.4078238
death_unadjusted_no_stroke                          no_stroke                death unadjusted 1.5087518 1.4617026 1.5573156
death_adjusted_no_stroke                            no_stroke                death   adjusted 1.5617531 1.5117056 1.6134575
cvd_unadjusted_no_stroke                            no_stroke                  cvd unadjusted 1.0313510 0.9810266 1.0842570
cvd_adjusted_no_stroke                              no_stroke                  cvd   adjusted 1.0225684 0.9704132 1.0775267
tia_unadjusted_no_stroke                            no_stroke                  tia unadjusted 1.2528906 1.1018284 1.4246636
tia_adjusted_no_stroke                              no_stroke                  tia   adjusted 1.2152776 1.0676340 1.3833389
heartfailure_unadjusted_no_stroke                   no_stroke         heartfailure unadjusted 1.0090905 0.9150739 1.1127665
heartfailure_adjusted_no_stroke                     no_stroke         heartfailure   adjusted 1.0176979 0.9206543 1.1249705
myocardialinfarction_unadjusted_no_stroke           no_stroke myocardialinfarction unadjusted 0.8453232 0.7049052 1.0137127
myocardialinfarction_adjusted_no_stroke             no_stroke myocardialinfarction   adjusted 0.8383148 0.6966895 1.0087301
angina_unadjusted_no_stroke                         no_stroke               angina unadjusted 0.8014877 0.6831238 0.9403604
angina_adjusted_no_stroke                           no_stroke               angina   adjusted 0.8021824 0.6823084 0.9431169
pad_unadjusted_no_stroke                            no_stroke                  pad unadjusted 1.0732728 0.9477110 1.2154704
pad_adjusted_no_stroke                              no_stroke                  pad   adjusted 1.0619790 0.9364429 1.2043440
falls_unadjusted_no_stroke                          no_stroke                falls unadjusted 1.4492402 1.4022982 1.4977536
falls_adjusted_no_stroke                            no_stroke                falls   adjusted 1.4323678 1.3854800 1.4808424
lowerlimbfracture_unadjusted_no_stroke              no_stroke    lowerlimbfracture unadjusted 1.5772479 1.4577744 1.7065130
lowerlimbfracture_adjusted_no_stroke                no_stroke    lowerlimbfracture   adjusted 1.5520216 1.4332786 1.6806020
stroke.pc_unadjusted_with_stroke                  with_stroke            stroke.pc unadjusted 1.1241356 0.9929225 1.2726882
stroke.pc_adjusted_with_stroke                    with_stroke            stroke.pc   adjusted 1.1302493 0.9972346 1.2810059
stroke.hes_unadjusted_with_stroke                 with_stroke           stroke.hes unadjusted 1.1621682 1.0125945 1.3338359
stroke.hes_adjusted_with_stroke                   with_stroke           stroke.hes   adjusted 1.1685678 1.0181898 1.3411553
stroke.c_unadjusted_with_stroke                   with_stroke             stroke.c unadjusted 1.1752990 1.0665655 1.2951176
stroke.c_adjusted_with_stroke                     with_stroke             stroke.c   adjusted 1.1846344 1.0746029 1.3059323
death_unadjusted_with_stroke                      with_stroke                death unadjusted 1.4691452 1.3690384 1.5765720
death_adjusted_with_stroke                        with_stroke                death   adjusted 1.5209804 1.4148543 1.6350668
cvd_unadjusted_with_stroke                        with_stroke                  cvd unadjusted 1.0187306 0.9306813 1.1151099
cvd_adjusted_with_stroke                          with_stroke                  cvd   adjusted 1.0311419 0.9416653 1.1291205
tia_unadjusted_with_stroke                        with_stroke                  tia unadjusted 1.1537415 0.9062250 1.4688621
tia_adjusted_with_stroke                          with_stroke                  tia   adjusted 1.1601655 0.9119328 1.4759682
heartfailure_unadjusted_with_stroke               with_stroke         heartfailure unadjusted 0.9330765 0.7566212 1.1506838
heartfailure_adjusted_with_stroke                 with_stroke         heartfailure   adjusted 0.9973724 0.8064496 1.2334951
myocardialinfarction_unadjusted_with_stroke       with_stroke myocardialinfarction unadjusted 0.8701836 0.5716873 1.3245342
myocardialinfarction_adjusted_with_stroke         with_stroke myocardialinfarction   adjusted 0.8312901 0.5454233 1.2669851
angina_unadjusted_with_stroke                     with_stroke               angina unadjusted 0.8931210 0.6258900 1.2744492
angina_adjusted_with_stroke                       with_stroke               angina   adjusted 0.9027912 0.6294369 1.2948587
pad_unadjusted_with_stroke                        with_stroke                  pad unadjusted 0.8782864 0.6544513 1.1786775
pad_adjusted_with_stroke                          with_stroke                  pad   adjusted 0.8843177 0.6585849 1.1874212
falls_unadjusted_with_stroke                      with_stroke                falls unadjusted 1.4133380 1.3041932 1.5316168
falls_adjusted_with_stroke                        with_stroke                falls   adjusted 1.4108063 1.3003207 1.5306797
lowerlimbfracture_unadjusted_with_stroke          with_stroke    lowerlimbfracture unadjusted 1.4520096 1.1720108 1.7989015
lowerlimbfracture_adjusted_with_stroke            with_stroke    lowerlimbfracture   adjusted 1.4626056 1.1788145 1.8147174
stroke.pc_unadjusted_over_75                          over_75            stroke.pc unadjusted 1.1459433 1.0413259 1.2610712
stroke.pc_adjusted_over_75                            over_75            stroke.pc   adjusted 1.1477221 1.0402824 1.2662581
stroke.hes_unadjusted_over_75                         over_75           stroke.hes unadjusted 1.1224208 1.0170914 1.2386580
stroke.hes_adjusted_over_75                           over_75           stroke.hes   adjusted 1.1492493 1.0403517 1.2695457
stroke.c_unadjusted_over_75                           over_75             stroke.c unadjusted 1.1767430 1.0932000 1.2666704
stroke.c_adjusted_over_75                             over_75             stroke.c   adjusted 1.1925592 1.1054309 1.2865549
death_unadjusted_over_75                              over_75                death unadjusted 1.5022735 1.4582118 1.5476667
death_adjusted_over_75                                over_75                death   adjusted 1.5562115 1.5094020 1.6044726
cvd_unadjusted_over_75                                over_75                  cvd unadjusted 1.0331774 0.9869508 1.0815691
cvd_adjusted_over_75                                  over_75                  cvd   adjusted 1.0267672 0.9790138 1.0768499
tia_unadjusted_over_75                                over_75                  tia unadjusted 1.2625494 1.1227623 1.4197404
tia_adjusted_over_75                                  over_75                  tia   adjusted 1.2369168 1.0994662 1.3915510
heartfailure_unadjusted_over_75                       over_75         heartfailure unadjusted 0.9889361 0.9017127 1.0845968
heartfailure_adjusted_over_75                         over_75         heartfailure   adjusted 1.0070123 0.9163282 1.1066709
myocardialinfarction_unadjusted_over_75               over_75 myocardialinfarction unadjusted 0.8678844 0.7286989 1.0336551
myocardialinfarction_adjusted_over_75                 over_75 myocardialinfarction   adjusted 0.8566127 0.7171373 1.0232146
angina_unadjusted_over_75                             over_75               angina unadjusted 0.8307427 0.7126051 0.9684655
angina_adjusted_over_75                               over_75               angina   adjusted 0.8211562 0.7027624 0.9594957
pad_unadjusted_over_75                                over_75                  pad unadjusted 1.0401527 0.9214923 1.1740930
pad_adjusted_over_75                                  over_75                  pad   adjusted 1.0289338 0.9102813 1.1630522
falls_unadjusted_over_75                              over_75                falls unadjusted 1.4372192 1.3921501 1.4837474
falls_adjusted_over_75                                over_75                falls   adjusted 1.4194566 1.3744836 1.4659012
lowerlimbfracture_unadjusted_over_75                  over_75    lowerlimbfracture unadjusted 1.5644713 1.4486748 1.6895237
lowerlimbfracture_adjusted_over_75                    over_75    lowerlimbfracture   adjusted 1.5444944 1.4290764 1.6692340
stroke.pc_unadjusted_under_75                        under_75            stroke.pc unadjusted 1.4298342 1.0942799 1.8682841
stroke.pc_adjusted_under_75                          under_75            stroke.pc   adjusted 1.4629920 1.1097945 1.9285964
stroke.hes_unadjusted_under_75                       under_75           stroke.hes unadjusted 1.4137431 1.0670754 1.8730348
stroke.hes_adjusted_under_75                         under_75           stroke.hes   adjusted 1.4300453 1.0714179 1.9087132
stroke.c_unadjusted_under_75                         under_75             stroke.c unadjusted 1.4698184 1.2047303 1.7932363
stroke.c_adjusted_under_75                           under_75             stroke.c   adjusted 1.5293597 1.2400427 1.8861780
death_unadjusted_under_75                            under_75                death unadjusted 1.5250784 1.3440002 1.7305534
death_adjusted_under_75                              under_75                death   adjusted 1.5328623 1.3492393 1.7414752
cvd_unadjusted_under_75                              under_75                  cvd unadjusted 0.9782961 0.8497579 1.1262775
cvd_adjusted_under_75                                under_75                  cvd   adjusted 1.0108799 0.8709065 1.1733500
tia_unadjusted_under_75                              under_75                  tia unadjusted 0.9100157 0.5898121 1.4040549
tia_adjusted_under_75                                under_75                  tia   adjusted 0.8819050 0.5693209 1.3661125
heartfailure_unadjusted_under_75                     under_75         heartfailure unadjusted 1.0597897 0.7700109 1.4586211
heartfailure_adjusted_under_75                       under_75         heartfailure   adjusted 1.0992220 0.7906369 1.5282477
myocardialinfarction_unadjusted_under_75             under_75 myocardialinfarction unadjusted 0.6949382 0.3985275 1.2118085
myocardialinfarction_adjusted_under_75               under_75 myocardialinfarction   adjusted 0.6972949 0.3934308 1.2358468
angina_unadjusted_under_75                           under_75               angina unadjusted 0.6963459 0.4361675 1.1117234
angina_adjusted_under_75                             under_75               angina   adjusted 0.7499767 0.4665570 1.2055657
pad_unadjusted_under_75                              under_75                  pad unadjusted 1.0242673 0.7185610 1.4600340
pad_adjusted_under_75                                under_75                  pad   adjusted 1.0593217 0.7428499 1.5106181
falls_unadjusted_under_75                            under_75                falls unadjusted 1.5425674 1.3874069 1.7150801
falls_adjusted_under_75                              under_75                falls   adjusted 1.5431541 1.3869477 1.7169534
lowerlimbfracture_unadjusted_under_75                under_75    lowerlimbfracture unadjusted 1.5487527 1.1821488 2.0290465
lowerlimbfracture_adjusted_under_75                  under_75    lowerlimbfracture   adjusted 1.5362783 1.1674035 2.0217097
stroke.pc_unadjusted_no_other_drugs            no_other_drugs            stroke.pc unadjusted 1.2920079 1.1288993 1.4786832
stroke.pc_adjusted_no_other_drugs              no_other_drugs            stroke.pc   adjusted 1.2782286 1.1116008 1.4698337
stroke.hes_unadjusted_no_other_drugs           no_other_drugs           stroke.hes unadjusted 1.2182550 1.0567579 1.4044326
stroke.hes_adjusted_no_other_drugs             no_other_drugs           stroke.hes   adjusted 1.2355724 1.0694667 1.4274770
stroke.c_unadjusted_no_other_drugs             no_other_drugs             stroke.c unadjusted 1.2892554 1.1612589 1.4313600
stroke.c_adjusted_no_other_drugs               no_other_drugs             stroke.c   adjusted 1.2993858 1.1655174 1.4486301
death_unadjusted_no_other_drugs                no_other_drugs                death unadjusted 1.5669285 1.4997380 1.6371293
death_adjusted_no_other_drugs                  no_other_drugs                death   adjusted 1.6189664 1.5473696 1.6938759
cvd_unadjusted_no_other_drugs                  no_other_drugs                  cvd unadjusted 1.0465874 0.9776491 1.1203868
cvd_adjusted_no_other_drugs                    no_other_drugs                  cvd   adjusted 1.0366421 0.9658721 1.1125974
tia_unadjusted_no_other_drugs                  no_other_drugs                  tia unadjusted 1.1578795 0.9658040 1.3881544
tia_adjusted_no_other_drugs                    no_other_drugs                  tia   adjusted 1.1522660 0.9605893 1.3821900
heartfailure_unadjusted_no_other_drugs         no_other_drugs         heartfailure unadjusted 1.0343027 0.8994810 1.1893325
heartfailure_adjusted_no_other_drugs           no_other_drugs         heartfailure   adjusted 0.9962893 0.8644494 1.1482366
myocardialinfarction_unadjusted_no_other_drugs no_other_drugs myocardialinfarction unadjusted 0.8208444 0.6289466 1.0712920
myocardialinfarction_adjusted_no_other_drugs   no_other_drugs myocardialinfarction   adjusted 0.8172636 0.6223590 1.0732065
angina_unadjusted_no_other_drugs               no_other_drugs               angina unadjusted 0.8190729 0.6510141 1.0305160
angina_adjusted_no_other_drugs                 no_other_drugs               angina   adjusted 0.8193479 0.6484396 1.0353023
pad_unadjusted_no_other_drugs                  no_other_drugs                  pad unadjusted 0.9788491 0.8165955 1.1733416
pad_adjusted_no_other_drugs                    no_other_drugs                  pad   adjusted 0.9774580 0.8140718 1.1736362
falls_unadjusted_no_other_drugs                no_other_drugs                falls unadjusted 1.4378288 1.3720434 1.5067684
falls_adjusted_no_other_drugs                  no_other_drugs                falls   adjusted 1.4130648 1.3476073 1.4817017
lowerlimbfracture_unadjusted_no_other_drugs    no_other_drugs    lowerlimbfracture unadjusted 1.6684795 1.4919210 1.8659324
lowerlimbfracture_adjusted_no_other_drugs      no_other_drugs    lowerlimbfracture   adjusted 1.6168120 1.4441948 1.8100612

```


***CVD vs No CVD***

```
                                       subgroup              outcome      model        hr      ci.l      ci.u
stroke.pc_unadjusted_CVD                    CVD            stroke.pc unadjusted 1.1411007 1.0256786 1.2695115
stroke.pc_adjusted_CVD                      CVD            stroke.pc   adjusted 1.1435418 1.0250747 1.2757000
stroke.hes_unadjusted_CVD                   CVD           stroke.hes unadjusted 1.1130075 0.9910077 1.2500263
stroke.hes_adjusted_CVD                     CVD           stroke.hes   adjusted 1.1241512 0.9997708 1.2640058
stroke.c_unadjusted_CVD                     CVD             stroke.c unadjusted 1.1565327 1.0644811 1.2565446
stroke.c_adjusted_CVD                       CVD             stroke.c   adjusted 1.1654378 1.0698007 1.2696245
death_unadjusted_CVD                        CVD                death unadjusted 1.5110594 1.4491370 1.5756279
death_adjusted_CVD                          CVD                death   adjusted 1.5402087 1.4757856 1.6074442
cvd_unadjusted_CVD                          CVD                  cvd unadjusted 0.9844534 0.9351035 1.0364076
cvd_adjusted_CVD                            CVD                  cvd   adjusted 0.9845369 0.9349751 1.0367259
tia_unadjusted_CVD                          CVD                  tia unadjusted 1.0804697 0.9381521 1.2443768
tia_adjusted_CVD                            CVD                  tia   adjusted 1.0781944 0.9367549 1.2409897
heartfailure_unadjusted_CVD                 CVD         heartfailure unadjusted 0.9989102 0.9046899 1.1029432
heartfailure_adjusted_CVD                   CVD         heartfailure   adjusted 1.0143151 0.9177018 1.1210996
myocardialinfarction_unadjusted_CVD         CVD myocardialinfarction unadjusted 0.8812516 0.7289031 1.0654425
myocardialinfarction_adjusted_CVD           CVD myocardialinfarction   adjusted 0.8761615 0.7233835 1.0612060
angina_unadjusted_CVD                       CVD               angina unadjusted 0.8186603 0.7028969 0.9534894
angina_adjusted_CVD                         CVD               angina   adjusted 0.8115676 0.6956850 0.9467532
pad_unadjusted_CVD                          CVD                  pad unadjusted 0.9856766 0.8544453 1.1370633
pad_adjusted_CVD                            CVD                  pad   adjusted 0.9870526 0.8552531 1.1391630
falls_unadjusted_CVD                        CVD                falls unadjusted 1.4085131 1.3449722 1.4750559
falls_adjusted_CVD                          CVD                falls   adjusted 1.4073131 1.3432667 1.4744132
lowerlimbfracture_unadjusted_CVD            CVD    lowerlimbfracture unadjusted 1.4803104 1.3120188 1.6701885
lowerlimbfracture_adjusted_CVD              CVD    lowerlimbfracture   adjusted 1.4741369 1.3058243 1.6641439
stroke.pc_unadjusted_No_CVD              No_CVD            stroke.pc unadjusted 1.2987015 1.0954175 1.5397103
stroke.pc_adjusted_No_CVD                No_CVD            stroke.pc   adjusted 1.2714424 1.0700843 1.5106900
stroke.hes_unadjusted_No_CVD             No_CVD           stroke.hes unadjusted 1.2519879 1.0711891 1.4633026
stroke.hes_adjusted_No_CVD               No_CVD           stroke.hes   adjusted 1.2852627 1.0983391 1.5039984
stroke.c_unadjusted_No_CVD               No_CVD             stroke.c unadjusted 1.3667323 1.2039250 1.5515562
stroke.c_adjusted_No_CVD                 No_CVD             stroke.c   adjusted 1.3778973 1.2122841 1.5661354
death_unadjusted_No_CVD                  No_CVD                death unadjusted 1.5001756 1.4411635 1.5616041
death_adjusted_No_CVD                    No_CVD                death   adjusted 1.5661353 1.5027523 1.6321918
cvd_unadjusted_No_CVD                    No_CVD                  cvd unadjusted 1.2322797 1.1253110 1.3494165
cvd_adjusted_No_CVD                      No_CVD                  cvd   adjusted 1.1895389 1.0846804 1.3045344
tia_unadjusted_No_CVD                    No_CVD                  tia unadjusted 1.6367719 1.3503509 1.9839452
tia_adjusted_No_CVD                      No_CVD                  tia   adjusted 1.5481054 1.2719708 1.8841865
heartfailure_unadjusted_No_CVD           No_CVD         heartfailure unadjusted 1.0311314 0.8381007 1.2686207
heartfailure_adjusted_No_CVD             No_CVD         heartfailure   adjusted 1.0045969 0.8155769 1.2374245
myocardialinfarction_unadjusted_No_CVD   No_CVD myocardialinfarction unadjusted 0.7784885 0.5474092 1.1071138
myocardialinfarction_adjusted_No_CVD     No_CVD myocardialinfarction   adjusted 0.7327891 0.5090701 1.0548249
angina_unadjusted_No_CVD                 No_CVD               angina unadjusted 0.9323203 0.5492156 1.5826591
angina_adjusted_No_CVD                   No_CVD               angina   adjusted 0.8796109 0.5233434 1.4784086
pad_unadjusted_No_CVD                    No_CVD                  pad unadjusted 1.1698285 0.9645026 1.4188647
pad_adjusted_No_CVD                      No_CVD                  pad   adjusted 1.1369665 0.9335986 1.3846344
falls_unadjusted_No_CVD                  No_CVD                falls unadjusted 1.4773220 1.4185164 1.5385654
falls_adjusted_No_CVD                    No_CVD                falls   adjusted 1.4457992 1.3876049 1.5064341
lowerlimbfracture_unadjusted_No_CVD      No_CVD    lowerlimbfracture unadjusted 1.6126900 1.4686527 1.7708536
lowerlimbfracture_adjusted_No_CVD        No_CVD    lowerlimbfracture   adjusted 1.5824939 1.4392582 1.7399844

```

<!--
***Matched on Age and Sex***

```
                                                         Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       150245         30050                            
  sex = 1 (%)                                              58138 (38.7)  11630 ( 38.7)   0.988      <0.001
  risperidone = 1 (%)                                          0 ( 0.0)  30050 (100.0)  <0.001         NaN
  age_diagnosis (mean (SD))                                79.83 (6.97)  80.43 (7.13)   <0.001       0.085
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   5408 ( 3.6)   1038 (  3.5)   0.222       0.008
  stroke_composite_pre_index_date = 1 (%)                  26836 (17.9)   4237 ( 14.1)  <0.001       0.103
  pre_index_date_angina = 1 (%)                            18681 (12.4)   3535 ( 11.8)   0.001       0.021
  pre_index_date_heartfailure = 1 (%)                      13907 ( 9.3)   2276 (  7.6)  <0.001       0.061
  BMI (%)                                                                               <0.001       0.275
     Missing                                               18708 (12.5)   6644 ( 22.1)                    
     Normal                                                57845 (38.5)  11265 ( 37.5)                    
     Obesity                                               18128 (12.1)   3019 ( 10.0)                    
     Overweight                                            43173 (28.7)   7292 ( 24.3)                    
     Severely Obese                                          693 ( 0.5)    194 (  0.6)                    
     Underweight                                           11698 ( 7.8)   1636 (  5.4)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             49190 (32.7)   7457 ( 24.8)  <0.001       0.176
  period_before_prescription (mean (SD))                    3.22 (2.70)   2.56 (2.39)   <0.001       0.258
  comorbidity_myocardialinfarction = 1 (%)                 17328 (11.5)   2602 (  8.7)  <0.001       0.096
  pre_index_date_stroke = 1 (%)                            21520 (14.3)   3609 ( 12.0)  <0.001       0.068
  pre_index_date_tia = 1 (%)                               15385 (10.2)   2791 (  9.3)  <0.001       0.032
  pre_index_date_falls = 1 (%)                             76094 (50.6)  12077 ( 40.2)  <0.001       0.211
  pre_index_date_lowerlimbfracture = 1 (%)                 24413 (16.2)   4755 ( 15.8)   0.069       0.012
  pre_index_date_ihd = 1 (%)                               26807 (17.8)   4989 ( 16.6)  <0.001       0.033
  pre_index_date_pad = 1 (%)                               13720 ( 9.1)   2302 (  7.7)  <0.001       0.053
  pre_index_date_af = 1 (%)                                20440 (13.6)   4763 ( 15.9)  <0.001       0.063
  pre_index_date_revasc = 1 (%)                             9408 ( 6.3)   1597 (  5.3)  <0.001       0.041
  pre_index_date_qof_diabetes = 1 (%)                      31834 (21.2)   5166 ( 17.2)  <0.001       0.102
  pre_index_date_anxiety_disorders = 1 (%)                 25593 (17.0)   5937 ( 19.8)  <0.001       0.070
  pre_index_date_fh_diabetes = 1 (%)                       29126 (19.4)   5927 ( 19.7)   0.179       0.009
  pre_index_date_fh_premature_cvd = 1 (%)                  11679 ( 7.8)   2279 (  7.6)   0.267       0.007
  pre_index_date_pulmonary_embolism = 1 (%)                 4848 ( 3.2)    752 (  2.5)  <0.001       0.043
  pre_index_date_deep_vein_thrombosis = 1 (%)               7750 ( 5.2)   1528 (  5.1)   0.609       0.003
  pre_index_date_hearing_loss = 1 (%)                      37702 (25.1)   7898 ( 26.3)  <0.001       0.027
  VTE = 1 (%)                                              13418 ( 8.9)   2743 (  9.1)   0.279       0.007
  gp_5cat_ethnicity (%)                                                                 <0.001       0.170
     Black                                                  1957 ( 1.3)    444 (  1.5)                    
     Mixed                                                   497 ( 0.3)     90 (  0.3)                    
     Other                                                   252 ( 0.2)    147 (  0.5)                    
     South Asian                                            6069 ( 4.0)    449 (  1.5)                    
     Unknown                                               38284 (25.5)   7307 ( 24.3)                    
     White                                                103186 (68.7)  21613 ( 71.9)                    
  comorbidity_hypertension (%)                                                          <0.001       0.236
     Elevated                                              26245 (17.5)   5081 ( 16.9)                    
     Normal                                                38417 (25.6)   7510 ( 25.0)                    
     Stage 1                                               59010 (39.3)  11377 ( 37.9)                    
     Stage 2                                               25270 (16.8)   4681 ( 15.6)                    
     Stage 3 (severe)                                        141 ( 0.1)     40 (  0.1)                    
     Unknown                                                1162 ( 0.8)   1361 (  4.5)                    
  Survival_time (mean (SD))                                 2.34 (2.27)   1.75 (1.90)   <0.001       0.283

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/TreatmentVsControl_AgeVsSex.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/TreatmentVsControl_AgeVsSex_under75.png)


```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 180295, number of events= 13225 

                                    coef exp(coef) se(coef)     z Pr(>|z|)    
age_diagnosis                   0.024051  1.024343 0.001307 18.40   <2e-16 ***
sex                             0.525033  1.690515 0.017956 29.24   <2e-16 ***
stroke_composite_pre_index_date 1.216486  3.375305 0.018007 67.56   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.024     0.9762     1.022     1.027
sex                                 1.691     0.5915     1.632     1.751
stroke_composite_pre_index_date     3.375     0.2963     3.258     3.497

Concordance= 0.691  (se = 0.003 )
Likelihood ratio test= 5314  on 3 df,   p=<2e-16
Wald test            = 5945  on 3 df,   p=<2e-16
Score (logrank) test = 6685  on 3 df,   p=<2e-16

```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_TreatmentVsControl_AgeVsSex.png)

```
         strata   median    lower    upper
1 risperidone=0 5.828884 5.806982 5.856263
2 risperidone=1 4.424367 4.375086 4.470910
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_TreatmentVsControl_AgeVsSex_under75.png)
```
         strata   median    lower    upper
1 risperidone=0 6.970568 6.934976 6.970568
2 risperidone=1 5.111567 4.911704 5.281314

```


***No history of antipsychotic six prior***

```
                                                         Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       146162         29559                            
  sex = 1 (%)                                              56325 (38.5)  11406 ( 38.6)   0.874       0.001
  risperidone = 1 (%)                                          0 ( 0.0)  29559 (100.0)  <0.001         NaN
  age_diagnosis (mean (SD))                                80.45 (7.05)  80.45 (7.12)    0.992      <0.001
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   5674 ( 3.9)   1017 (  3.4)  <0.001       0.024
  stroke_composite_pre_index_date = 1 (%)                  20932 (14.3)   4177 ( 14.1)   0.400       0.005
  pre_index_date_angina = 1 (%)                            17298 (11.8)   3485 ( 11.8)   0.835       0.001
  pre_index_date_heartfailure = 1 (%)                      11098 ( 7.6)   2251 (  7.6)   0.904       0.001
  BMI (%)                                                                                0.921       0.008
     Missing                                               31206 (21.4)   6397 ( 21.6)                    
     Normal                                                55335 (37.9)  11149 ( 37.7)                    
     Obesity                                               14867 (10.2)   2993 ( 10.1)                    
     Overweight                                            35832 (24.5)   7207 ( 24.4)                    
     Severely Obese                                          967 ( 0.7)    193 (  0.7)                    
     Underweight                                            7955 ( 5.4)   1620 (  5.5)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             35263 (24.1)   7071 ( 23.9)   0.458       0.005
  period_before_prescription (mean (SD))                    2.61 (2.16)   2.57 (2.39)    0.002       0.019
  comorbidity_myocardialinfarction = 1 (%)                 13255 ( 9.1)   2559 (  8.7)   0.025       0.014
  pre_index_date_stroke = 1 (%)                            18031 (12.3)   3561 ( 12.0)   0.170       0.009
  pre_index_date_tia = 1 (%)                               13694 ( 9.4)   2750 (  9.3)   0.732       0.002
  pre_index_date_falls = 1 (%)                             59361 (40.6)  11951 ( 40.4)   0.565       0.004
  pre_index_date_lowerlimbfracture = 1 (%)                 23436 (16.0)   4692 ( 15.9)   0.497       0.004
  pre_index_date_ihd = 1 (%)                               24382 (16.7)   4905 ( 16.6)   0.719       0.002
  pre_index_date_pad = 1 (%)                               11453 ( 7.8)   2260 (  7.6)   0.272       0.007
  pre_index_date_af = 1 (%)                                23188 (15.9)   4701 ( 15.9)   0.873       0.001
  pre_index_date_revasc = 1 (%)                             7676 ( 5.3)   1573 (  5.3)   0.634       0.003
  pre_index_date_qof_diabetes = 1 (%)                      25073 (17.2)   5088 ( 17.2)   0.813       0.002
  pre_index_date_anxiety_disorders = 1 (%)                 29183 (20.0)   5842 ( 19.8)   0.432       0.005
  pre_index_date_fh_diabetes = 1 (%)                       29338 (20.1)   5854 ( 19.8)   0.298       0.007
  pre_index_date_fh_premature_cvd = 1 (%)                  11154 ( 7.6)   2256 (  7.6)   1.000      <0.001
  pre_index_date_pulmonary_embolism = 1 (%)                 3621 ( 2.5)    743 (  2.5)   0.730       0.002
  pre_index_date_deep_vein_thrombosis = 1 (%)               7490 ( 5.1)   1515 (  5.1)   1.000      <0.001
  pre_index_date_hearing_loss = 1 (%)                      38666 (26.5)   7800 ( 26.4)   0.819       0.002
  VTE = 1 (%)                                              13379 ( 9.2)   2707 (  9.2)   0.990      <0.001
  gp_5cat_ethnicity (%)                                                                  0.307       0.016
     Black                                                  2245 ( 1.5)    441 (  1.5)                    
     Mixed                                                   426 ( 0.3)     90 (  0.3)                    
     Other                                                   654 ( 0.4)    145 (  0.5)                    
     South Asian                                            2194 ( 1.5)    441 (  1.5)                    
     Unknown                                               36170 (24.7)   7143 ( 24.2)                    
     White                                                104473 (71.5)  21299 ( 72.1)                    
  comorbidity_hypertension (%)                                                          <0.001       0.052
     Elevated                                              24928 (17.1)   5038 ( 17.0)                    
     Normal                                                37305 (25.5)   7441 ( 25.2)                    
     Stage 1                                               56332 (38.5)  11263 ( 38.1)                    
     Stage 2                                               23149 (15.8)   4639 ( 15.7)                    
     Stage 3 (severe)                                        197 ( 0.1)     40 (  0.1)                    
     Unknown                                                4251 ( 2.9)   1138 (  3.8)                    
  Survival_time (mean (SD))                                 1.75 (1.90)   1.75 (1.90)    0.770       0.002
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/TreatmentVsControl_No_Antipsychotic_6MonthsPrior.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/TreatmentVsControl_No_Antipsychotic_6MonthsPrior_under75.png)

```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 175721, number of events= 11913 

                                    coef exp(coef) se(coef)       z Pr(>|z|)    
age_diagnosis                   0.007868  1.007899 0.001357   5.799 6.68e-09 ***
sex                             0.153928  1.166407 0.019004   8.100 5.51e-16 ***
stroke_composite_pre_index_date 1.865296  6.457847 0.018520 100.719  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.008     0.9922     1.005     1.011
sex                                 1.166     0.8573     1.124     1.211
stroke_composite_pre_index_date     6.458     0.1549     6.228     6.697

Concordance= 0.716  (se = 0.003 )
Likelihood ratio test= 8891  on 3 df,   p=<2e-16
Wald test            = 10457  on 3 df,   p=<2e-16
Score (logrank) test = 13849  on 3 df,   p=<2e-16

```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_TreatmentVsControl_NoAntipsychotic_6MonthsPrior.png)

```
         strata   median    lower    upper
1 risperidone=0 4.594114 4.572211 4.618754
2 risperidone=1 4.438056 4.399726 4.495551
```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_TreatmentVsControl_NoAntipsychotic_6MonthsPrior_under75.png)

```
         strata   median    lower   upper
1 risperidone=0 5.207392 5.119781 5.28679
2 risperidone=1 5.136208 4.933607 5.32512
```








***No history of antipsychotic three prior***

```
                                                         Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       147595         29867                            
  sex = 1 (%)                                              56928 (38.6)  11531 ( 38.6)   0.909       0.001
  risperidone = 1 (%)                                          0 ( 0.0)  29867 (100.0)  <0.001         NaN
  age_diagnosis (mean (SD))                                80.45 (7.05)  80.45 (7.12)    0.916       0.001
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   5676 ( 3.8)   1032 (  3.5)   0.001       0.021
  stroke_composite_pre_index_date = 1 (%)                  21030 (14.2)   4223 ( 14.1)   0.629       0.003
  pre_index_date_angina = 1 (%)                            17439 (11.8)   3524 ( 11.8)   0.944       0.001
  pre_index_date_heartfailure = 1 (%)                      11424 ( 7.7)   2271 (  7.6)   0.427       0.005
  BMI (%)                                                                                0.842       0.009
     Missing                                               31706 (21.5)   6509 ( 21.8)                    
     Normal                                                55515 (37.6)  11239 ( 37.6)                    
     Obesity                                               15078 (10.2)   3014 ( 10.1)                    
     Overweight                                            36149 (24.5)   7277 ( 24.4)                    
     Severely Obese                                          999 ( 0.7)    194 (  0.6)                    
     Underweight                                            8148 ( 5.5)   1634 (  5.5)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             37112 (25.1)   7448 ( 24.9)   0.456       0.005
  period_before_prescription (mean (SD))                    2.61 (2.17)   2.57 (2.39)    0.005       0.017
  comorbidity_myocardialinfarction = 1 (%)                 13321 ( 9.0)   2592 (  8.7)   0.057       0.012
  pre_index_date_stroke = 1 (%)                            18063 (12.2)   3600 ( 12.1)   0.379       0.006
  pre_index_date_tia = 1 (%)                               13799 ( 9.3)   2777 (  9.3)   0.789       0.002
  pre_index_date_falls = 1 (%)                             60224 (40.8)  12052 ( 40.4)   0.150       0.009
  pre_index_date_lowerlimbfracture = 1 (%)                 23320 (15.8)   4731 ( 15.8)   0.869       0.001
  pre_index_date_ihd = 1 (%)                               24483 (16.6)   4971 ( 16.6)   0.820       0.001
  pre_index_date_pad = 1 (%)                               11271 ( 7.6)   2296 (  7.7)   0.771       0.002
  pre_index_date_af = 1 (%)                                23397 (15.9)   4748 ( 15.9)   0.853       0.001
  pre_index_date_revasc = 1 (%)                             7822 ( 5.3)   1591 (  5.3)   0.859       0.001
  pre_index_date_qof_diabetes = 1 (%)                      25383 (17.2)   5145 ( 17.2)   0.911       0.001
  pre_index_date_anxiety_disorders = 1 (%)                 29540 (20.0)   5910 ( 19.8)   0.376       0.006
  pre_index_date_fh_diabetes = 1 (%)                       29598 (20.1)   5913 ( 19.8)   0.318       0.006
  pre_index_date_fh_premature_cvd = 1 (%)                  11308 ( 7.7)   2274 (  7.6)   0.786       0.002
  pre_index_date_pulmonary_embolism = 1 (%)                 3830 ( 2.6)    750 (  2.5)   0.416       0.005
  pre_index_date_deep_vein_thrombosis = 1 (%)               7568 ( 5.1)   1523 (  5.1)   0.851       0.001
  pre_index_date_hearing_loss = 1 (%)                      38957 (26.4)   7878 ( 26.4)   0.956      <0.001
  VTE = 1 (%)                                              13653 ( 9.3)   2730 (  9.1)   0.557       0.004
  gp_5cat_ethnicity (%)                                                                  0.130       0.018
     Black                                                  2268 ( 1.5)    443 (  1.5)                    
     Mixed                                                   439 ( 0.3)     90 (  0.3)                    
     Other                                                   612 ( 0.4)    147 (  0.5)                    
     South Asian                                            2327 ( 1.6)    446 (  1.5)                    
     Unknown                                               36506 (24.7)   7241 ( 24.2)                    
     White                                                105443 (71.4)  21500 ( 72.0)                    
  comorbidity_hypertension (%)                                                          <0.001       0.052
     Elevated                                              25344 (17.2)   5081 ( 17.0)                    
     Normal                                                37366 (25.3)   7508 ( 25.1)                    
     Stage 1                                               57016 (38.6)  11376 ( 38.1)                    
     Stage 2                                               23209 (15.7)   4681 ( 15.7)                    
     Stage 3 (severe)                                        216 ( 0.1)     40 (  0.1)                    
     Unknown                                                4444 ( 3.0)   1181 (  4.0)                    
  Survival_time (mean (SD))                                 1.75 (1.91)   1.75 (1.90)    0.503       0.004
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/TreatmentVsControl_No_Antipsychotic_3MonthsPrior.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/TreatmentVsControl_No_Antipsychotic_3MonthsPrior_under75.png)

```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 177462, number of events= 11951 

                                    coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis                   0.007431  1.007459 0.001358  5.473 4.43e-08 ***
sex                             0.161700  1.175508 0.018962  8.528  < 2e-16 ***
stroke_composite_pre_index_date 1.836070  6.271843 0.018515 99.164  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.007     0.9926     1.005     1.010
sex                                 1.176     0.8507     1.133     1.220
stroke_composite_pre_index_date     6.272     0.1594     6.048     6.504

Concordance= 0.712  (se = 0.003 )
Likelihood ratio test= 8629  on 3 df,   p=<2e-16
Wald test            = 10187  on 3 df,   p=<2e-16
Score (logrank) test = 13390  on 3 df,   p=<2e-16

```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_TreatmentVsControl_NoAntipsychotic_3MonthsPrior.png)

```
         strata   median    lower    upper
1 risperidone=0 4.599589 4.580424 4.621492
2 risperidone=1 4.432580 4.386037 4.479124
```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_death_TreatmentVsControl_NoAntipsychotic_3MonthsPrior_under75.png)

```
         strata   median    lower    upper
1 risperidone=0 5.259411 5.196441 5.330595
2 risperidone=1 5.130732 4.933607 5.319644
```


***2004 - 2010***
```
                                                        Stratified by risperidone
                                                          0             1              p      test SMD   
  n                                                       22537          4551                            
  sex = 1 (%)                                              7156 (31.8)   1444 ( 31.7)   0.990      <0.001
  risperidone = 1 (%)                                         0 ( 0.0)   4551 (100.0)  <0.001         NaN
  age_diagnosis (mean (SD))                               81.07 (6.85)  81.00 (6.96)    0.521       0.010
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)  1002 ( 4.4)    231 (  5.1)   0.069       0.030
  stroke_composite_pre_index_date = 1 (%)                  2883 (12.8)    585 ( 12.9)   0.928       0.002
  pre_index_date_angina = 1 (%)                            2608 (11.6)    521 ( 11.4)   0.831       0.004
  pre_index_date_heartfailure = 1 (%)                      1653 ( 7.3)    314 (  6.9)   0.317       0.017
  BMI (%)                                                                               0.983       0.014
     Missing                                               9815 (43.6)   1972 ( 43.3)                    
     Normal                                                6828 (30.3)   1385 ( 30.4)                    
     Obesity                                               1220 ( 5.4)    244 (  5.4)                    
     Overweight                                            3645 (16.2)    749 ( 16.5)                    
     Severely Obese                                          93 ( 0.4)     16 (  0.4)                    
     Underweight                                            936 ( 4.2)    185 (  4.1)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             5912 (26.2)   1159 ( 25.5)   0.292       0.017
  period_before_prescription (mean (SD))                   2.24 (1.95)   2.17 (2.25)    0.052       0.030
  comorbidity_myocardialinfarction = 1 (%)                 1866 ( 8.3)    349 (  7.7)   0.179       0.023
  pre_index_date_stroke = 1 (%)                            2405 (10.7)    491 ( 10.8)   0.835       0.004
  pre_index_date_tia = 1 (%)                               2183 ( 9.7)    424 (  9.3)   0.457       0.013
  pre_index_date_falls = 1 (%)                             5912 (26.2)   1194 ( 26.2)   1.000      <0.001
  pre_index_date_lowerlimbfracture = 1 (%)                 3445 (15.3)    702 ( 15.4)   0.830       0.004
  pre_index_date_ihd = 1 (%)                               3534 (15.7)    705 ( 15.5)   0.765       0.005
  pre_index_date_pad = 1 (%)                               1560 ( 6.9)    314 (  6.9)   0.982       0.001
  pre_index_date_af = 1 (%)                                2680 (11.9)    535 ( 11.8)   0.815       0.004
  pre_index_date_revasc = 1 (%)                             585 ( 2.6)    120 (  2.6)   0.914       0.003
  pre_index_date_qof_diabetes = 1 (%)                      2525 (11.2)    509 ( 11.2)   0.990       0.001
  pre_index_date_anxiety_disorders = 1 (%)                 3000 (13.3)    598 ( 13.1)   0.774       0.005
  pre_index_date_fh_diabetes = 1 (%)                       2455 (10.9)    505 ( 11.1)   0.708       0.006
  pre_index_date_fh_premature_cvd = 1 (%)                   742 ( 3.3)    153 (  3.4)   0.846       0.004
  pre_index_date_pulmonary_embolism = 1 (%)                 372 ( 1.7)     74 (  1.6)   0.956       0.002
  pre_index_date_deep_vein_thrombosis = 1 (%)               776 ( 3.4)    158 (  3.5)   0.959       0.002
  pre_index_date_hearing_loss = 1 (%)                      4147 (18.4)    836 ( 18.4)   0.977       0.001
  VTE = 1 (%)                                              1453 ( 6.4)    296 (  6.5)   0.913       0.002
  gp_5cat_ethnicity (%)                                                                <0.001       0.108
     Black                                                  279 ( 1.2)     55 (  1.2)                    
     Mixed                                                   65 ( 0.3)     12 (  0.3)                    
     Other                                                   44 ( 0.2)     14 (  0.3)                    
     South Asian                                            126 ( 0.6)     28 (  0.6)                    
     Unknown                                              11065 (49.1)   1995 ( 43.8)                    
     White                                                10958 (48.6)   2447 ( 53.8)                    
  comorbidity_hypertension (%)                                                          0.967       0.015
     Elevated                                              3162 (14.0)    627 ( 13.8)                    
     Normal                                                4664 (20.7)    931 ( 20.5)                    
     Stage 1                                               9298 (41.3)   1899 ( 41.7)                    
     Stage 2                                               3647 (16.2)    733 ( 16.1)                    
     Stage 3 (severe)                                        22 ( 0.1)      6 (  0.1)                    
     Unknown                                               1744 ( 7.7)    355 (  7.8)                    
  Survival_time (mean (SD))                                2.22 (2.27)   2.23 (2.45)    0.723       0.006

```



![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_2004_2010.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_2004_2010_under75.png)
```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 27088, number of events= 2579 

                                    coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis                   0.009789  1.009837 0.003007  3.255  0.00113 ** 
sex                             0.137362  1.147243 0.042673  3.219  0.00129 ** 
stroke_composite_pre_index_date 1.774830  5.899277 0.040587 43.729  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.010     0.9903     1.004     1.016
sex                                 1.147     0.8717     1.055     1.247
stroke_composite_pre_index_date     5.899     0.1695     5.448     6.388

Concordance= 0.701  (se = 0.006 )
Likelihood ratio test= 1599  on 3 df,   p=<2e-16
Wald test            = 1971  on 3 df,   p=<2e-16
Score (logrank) test = 2543  on 3 df,   p=<2e-16

```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_2004_2010.png)
```
         strata   median    lower    upper
1 risperidone=0 3.939767 3.893224 3.989049
2 risperidone=1 3.797399 3.704312 3.942505
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_2004_2010_under75.png)

```
         strata   median    lower    upper
1 risperidone=0 4.421629 4.290212 4.594114
2 risperidone=1 4.262834 3.879535 4.599589
```






***2004 - 2014***

```
                                                        Stratified by risperidone
                                                          0             1              p      test SMD   
  n                                                       57335         11642                            
  sex = 1 (%)                                             20445 (35.7)   4134 ( 35.5)   0.767       0.003
  risperidone = 1 (%)                                         0 ( 0.0)  11642 (100.0)  <0.001         NaN
  age_diagnosis (mean (SD))                               80.65 (6.91)  80.59 (7.06)    0.368       0.009
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)  2390 ( 4.2)    503 (  4.3)   0.471       0.008
  stroke_composite_pre_index_date = 1 (%)                  7846 (13.7)   1582 ( 13.6)   0.795       0.003
  pre_index_date_angina = 1 (%)                            6790 (11.8)   1364 ( 11.7)   0.712       0.004
  pre_index_date_heartfailure = 1 (%)                      4050 ( 7.1)    791 (  6.8)   0.309       0.011
  BMI (%)                                                                               0.986       0.008
     Missing                                              20444 (35.7)   4128 ( 35.5)                    
     Normal                                               18522 (32.3)   3792 ( 32.6)                    
     Obesity                                               4184 ( 7.3)    854 (  7.3)                    
     Overweight                                           11060 (19.3)   2248 ( 19.3)                    
     Severely Obese                                         262 ( 0.5)     53 (  0.5)                    
     Underweight                                           2863 ( 5.0)    567 (  4.9)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)            14247 (24.8)   2833 ( 24.3)   0.246       0.012
  period_before_prescription (mean (SD))                   2.45 (2.10)   2.37 (2.30)   <0.001       0.037
  comorbidity_myocardialinfarction = 1 (%)                 5067 ( 8.8)    995 (  8.5)   0.321       0.010
  pre_index_date_stroke = 1 (%)                            6567 (11.5)   1327 ( 11.4)   0.877       0.002
  pre_index_date_tia = 1 (%)                               5381 ( 9.4)   1058 (  9.1)   0.323       0.010
  pre_index_date_falls = 1 (%)                            17077 (29.8)   3407 ( 29.3)   0.268       0.011
  pre_index_date_lowerlimbfracture = 1 (%)                 8700 (15.2)   1757 ( 15.1)   0.833       0.002
  pre_index_date_ihd = 1 (%)                               9511 (16.6)   1909 ( 16.4)   0.623       0.005
  pre_index_date_pad = 1 (%)                               4279 ( 7.5)    844 (  7.2)   0.434       0.008
  pre_index_date_af = 1 (%)                                7750 (13.5)   1540 ( 13.2)   0.413       0.008
  pre_index_date_revasc = 1 (%)                            2175 ( 3.8)    450 (  3.9)   0.732       0.004
  pre_index_date_qof_diabetes = 1 (%)                      7891 (13.8)   1608 ( 13.8)   0.900       0.001
  pre_index_date_anxiety_disorders = 1 (%)                 8843 (15.4)   1809 ( 15.5)   0.765       0.003
  pre_index_date_fh_diabetes = 1 (%)                       7914 (13.8)   1610 ( 13.8)   0.952       0.001
  pre_index_date_fh_premature_cvd = 1 (%)                  2486 ( 4.3)    503 (  4.3)   0.961       0.001
  pre_index_date_pulmonary_embolism = 1 (%)                1092 ( 1.9)    222 (  1.9)   1.000      <0.001
  pre_index_date_deep_vein_thrombosis = 1 (%)              2463 ( 4.3)    492 (  4.2)   0.754       0.003
  pre_index_date_hearing_loss = 1 (%)                     11976 (20.9)   2409 ( 20.7)   0.645       0.005
  VTE = 1 (%)                                              4463 ( 7.8)    901 (  7.7)   0.884       0.002
  gp_5cat_ethnicity (%)                                                                 0.129       0.030
     Black                                                  738 ( 1.3)    141 (  1.2)                    
     Mixed                                                  188 ( 0.3)     35 (  0.3)                    
     Other                                                  223 ( 0.4)     52 (  0.4)                    
     South Asian                                            534 ( 0.9)    104 (  0.9)                    
     Unknown                                              20294 (35.4)   3977 ( 34.2)                    
     White                                                35358 (61.7)   7333 ( 63.0)                    
  comorbidity_hypertension (%)                                                          0.005       0.041
     Elevated                                              9311 (16.2)   1875 ( 16.1)                    
     Normal                                               13119 (22.9)   2592 ( 22.3)                    
     Stage 1                                              22817 (39.8)   4623 ( 39.7)                    
     Stage 2                                               8808 (15.4)   1776 ( 15.3)                    
     Stage 3 (severe)                                        47 ( 0.1)     10 (  0.1)                    
     Unknown                                               3233 ( 5.6)    766 (  6.6)                    
  Survival_time (mean (SD))                                2.12 (2.13)   2.13 (2.29)    0.511       0.007

```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_2004_2014.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_2004_2014_under75.png)
```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 68977, number of events= 5869 

                                    coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis                   0.008525  1.008561 0.001974  4.318 1.58e-05 ***
sex                             0.125250  1.133432 0.027616  4.535 5.75e-06 ***
stroke_composite_pre_index_date 1.803084  6.068332 0.026597 67.793  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.009     0.9915     1.005     1.012
sex                                 1.133     0.8823     1.074     1.196
stroke_composite_pre_index_date     6.068     0.1648     5.760     6.393

Concordance= 0.705  (se = 0.004 )
Likelihood ratio test= 3893  on 3 df,   p=<2e-16
Wald test            = 4706  on 3 df,   p=<2e-16
Score (logrank) test = 6118  on 3 df,   p=<2e-16
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_2004_2014.png)

```
         strata   median    lower    upper
1 risperidone=0 4.128679 4.101300 4.158795
2 risperidone=1 4.032854 3.956194 4.104038
```


![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_2004_2014_under75.png)
```
         strata   median    lower    upper
1 risperidone=0 4.344969 4.257358 4.429843
2 risperidone=1 4.536619 4.344969 4.763860
```




***2004 - 2023***

```

                                                        Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       147023         29774                            
  sex = 1 (%)                                              56901 (38.7)  11497 ( 38.6)   0.781       0.002
  risperidone = 1 (%)                                          0 ( 0.0)  29774 (100.0)  <0.001         NaN
  age_diagnosis (mean (SD))                                80.53 (7.03)  80.48 (7.12)    0.246       0.007
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   5326 ( 3.6)   1032 (  3.5)   0.192       0.008
  stroke_composite_pre_index_date = 1 (%)                  20993 (14.3)   4216 ( 14.2)   0.599       0.003
  pre_index_date_angina = 1 (%)                            17422 (11.8)   3522 ( 11.8)   0.927       0.001
  pre_index_date_heartfailure = 1 (%)                      11476 ( 7.8)   2269 (  7.6)   0.283       0.007
  BMI (%)                                                                                0.982       0.005
     Missing                                               32032 (21.8)   6466 ( 21.7)                    
     Normal                                                55403 (37.7)  11230 ( 37.7)                    
     Obesity                                               14777 (10.1)   2998 ( 10.1)                    
     Overweight                                            35651 (24.2)   7254 ( 24.4)                    
     Severely Obese                                          999 ( 0.7)    194 (  0.7)                    
     Underweight                                            8161 ( 5.6)   1632 (  5.5)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             37368 (25.4)   7441 ( 25.0)   0.126       0.010
  period_before_prescription (mean (SD))                    2.64 (2.20)   2.57 (2.39)   <0.001       0.029
  comorbidity_myocardialinfarction = 1 (%)                 13309 ( 9.1)   2585 (  8.7)   0.043       0.013
  pre_index_date_stroke = 1 (%)                            17958 (12.2)   3594 ( 12.1)   0.496       0.004
  pre_index_date_tia = 1 (%)                               13865 ( 9.4)   2775 (  9.3)   0.560       0.004
  pre_index_date_falls = 1 (%)                             59905 (40.7)  12045 ( 40.5)   0.355       0.006
  pre_index_date_lowerlimbfracture = 1 (%)                 23557 (16.0)   4729 ( 15.9)   0.555       0.004
  pre_index_date_ihd = 1 (%)                               24569 (16.7)   4964 ( 16.7)   0.877       0.001
  pre_index_date_pad = 1 (%)                               11659 ( 7.9)   2297 (  7.7)   0.213       0.008
  pre_index_date_af = 1 (%)                                23728 (16.1)   4736 ( 15.9)   0.324       0.006
  pre_index_date_revasc = 1 (%)                             7735 ( 5.3)   1589 (  5.3)   0.604       0.003
  pre_index_date_qof_diabetes = 1 (%)                      25228 (17.2)   5131 ( 17.2)   0.764       0.002
  pre_index_date_anxiety_disorders = 1 (%)                 29063 (19.8)   5871 ( 19.7)   0.852       0.001
  pre_index_date_fh_diabetes = 1 (%)                       28955 (19.7)   5889 ( 19.8)   0.743       0.002
  pre_index_date_fh_premature_cvd = 1 (%)                  11146 ( 7.6)   2259 (  7.6)   0.981      <0.001
  pre_index_date_pulmonary_embolism = 1 (%)                 3732 ( 2.5)    749 (  2.5)   0.836       0.001
  pre_index_date_deep_vein_thrombosis = 1 (%)               7597 ( 5.2)   1521 (  5.1)   0.687       0.003
  pre_index_date_hearing_loss = 1 (%)                      39116 (26.6)   7866 ( 26.4)   0.511       0.004
  VTE = 1 (%)                                              13503 ( 9.2)   2721 (  9.1)   0.813       0.002
  gp_5cat_ethnicity (%)                                                                 <0.001       0.031
     Black                                                  2275 ( 1.5)    442 (  1.5)                    
     Mixed                                                   437 ( 0.3)     89 (  0.3)                    
     Other                                                   643 ( 0.4)    146 (  0.5)                    
     South Asian                                            2337 ( 1.6)    445 (  1.5)                    
     Unknown                                               37392 (25.4)   7214 ( 24.2)                    
     White                                                103939 (70.7)  21438 ( 72.0)                    
  comorbidity_hypertension (%)                                                          <0.001       0.035
     Elevated                                              25174 (17.1)   5074 ( 17.0)                    
     Normal                                                37544 (25.5)   7504 ( 25.2)                    
     Stage 1                                               56309 (38.3)  11356 ( 38.1)                    
     Stage 2                                               23153 (15.7)   4669 ( 15.7)                    
     Stage 3 (severe)                                        181 ( 0.1)     40 (  0.1)                    
     Unknown                                                4662 ( 3.2)   1131 (  3.8)                    
  Survival_time (mean (SD))                                 1.73 (1.76)   1.74 (1.90)    0.184       0.008
```



![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_2004_2023.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_2004_2023_under75.png)

```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 176797, number of events= 11802 

                                    coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis                   0.005831  1.005848 0.001368  4.263 2.02e-05 ***
sex                             0.122896  1.130766 0.019159  6.415 1.41e-10 ***
stroke_composite_pre_index_date 1.770202  5.872041 0.018677 94.780  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.006     0.9942     1.003     1.009
sex                                 1.131     0.8844     1.089     1.174
stroke_composite_pre_index_date     5.872     0.1703     5.661     6.091

Concordance= 0.7  (se = 0.003 )
Likelihood ratio test= 7745  on 3 df,   p=<2e-16
Wald test            = 9206  on 3 df,   p=<2e-16
Score (logrank) test = 11868  on 3 df,   p=<2e-16
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_2004_2023.png)
```
         strata   median    lower    upper
1 risperidone=0 3.942505 3.926078 3.958932
2 risperidone=1 4.429843 4.383299 4.476386
```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_2004_2023_under75.png)

```
         strata   median    lower    upper
1 risperidone=0 3.887748 3.841205 3.934292
2 risperidone=1 5.117043 4.919918 5.311431
```
-->
