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
  n                                           445332        
  diagnosedbeforeRegistration = 1 (%)         351487 (78.9) 
  gender = 2 (%)                              282903 (63.5) 
  died = 1 (%)                                223185 (50.1) 
  death_composite = 1 (%)                     325118 (73.0) 
  ONS_died = 1 (%)                            291514 (65.5) 
  age_diagnosis (mean (SD))                    82.35 (7.02) 
  age_category (%)                                          
     65 - 74                                   64311 (14.4) 
     75 - 84                                  202073 (45.4) 
     85 - 94                                  164303 (36.9) 
     95+                                       14645 ( 3.3) 
  year_of_diagnosis (%)                                     
     2004                                      20451 ( 4.6) 
     2005                                      17420 ( 3.9) 
     2006                                      19704 ( 4.4) 
     2007                                      17414 ( 3.9) 
     2008                                      17994 ( 4.0) 
     2009                                      19944 ( 4.5) 
     2010                                      21457 ( 4.8) 
     2011                                      22687 ( 5.1) 
     2012                                      25236 ( 5.7) 
     2013                                      27306 ( 6.1) 
     2014                                      29971 ( 6.7) 
     2015                                      29769 ( 6.7) 
     2016                                      26703 ( 6.0) 
     2017                                      26488 ( 5.9) 
     2018                                      25311 ( 5.7) 
     2019                                      24734 ( 5.6) 
     2020                                      19551 ( 4.4) 
     2021                                      20462 ( 4.6) 
     2022                                      19017 ( 4.3) 
     2023                                      13713 ( 3.1) 
  gender_decode = M (%)                       162429 (36.5) 
  GP_stroke = 1 (%)                            70378 (15.8) 
  HES_stroke = 1 (%)                           56416 (12.7) 
  HES_stroke = 1 (%)                           56416 (12.7) 
  stroke_composite = 1 (%)                     86268 (19.4) 
  primary_death_stroke = 1 (%)                 14705 ( 3.3) 
  HES_stroke = 1 (%)                           56416 (12.7) 
  HES_stroke = 1 (%)                           56416 (12.7) 
  ethnicity (%)                                             
     Black                                      8388 ( 1.9) 
     Mixed                                      1491 ( 0.3) 
     Other                                      2606 ( 0.6) 
     South Asian                                8668 ( 1.9) 
     Unknown                                    9353 ( 2.1) 
     White                                    414826 (93.1) 
  pre_diagnoses_af = 1 (%)                     62304 (14.0) 
  post_diagnoses_af = 1 (%)                    28577 ( 6.4) 
  af_ever = 1 (%)                              92662 (20.8) 
  pre_diagnoses_angina = 1 (%)                 50115 (11.3) 
  post_diagnoses_angina = 1 (%)                 6096 ( 1.4) 
  angina_ever = 1 (%)                          56484 (12.7) 
  pre_diagnoses_anxiety_disorders = 1 (%)      67688 (15.2) 
  post_diagnoses_anxiety_disorders = 1 (%)     10556 ( 2.4) 
  anxiety_disorders_ever = 1 (%)               78961 (17.7) 
  pre_diagnoses_falls = 1 (%)                 112934 (25.4) 
  post_diagnoses_falls = 1 (%)                125063 (28.1) 
  falls_ever = 1 (%)                          240530 (54.0) 
  pre_diagnoses_fh_diabetes = 1 (%)            91133 (20.5) 
  post_diagnoses_fh_diabetes = 1 (%)            5686 ( 1.3) 
  fh_diabetes_ever = 1 (%)                     97025 (21.8) 
  heartfailure_ever = 1 (%)                    53881 (12.1) 
  pre_diagnoses_lowerlimbfracture = 1 (%)      54605 (12.3) 
  post_diagnoses_lowerlimbfracture = 1 (%)     32899 ( 7.4) 
  lowerlimbfracture_ever = 1 (%)               88292 (19.8) 
  pre_diagnoses_myocardialinfarction = 1 (%)   34853 ( 7.8) 
  post_diagnoses_myocardialinfarction = 1 (%)   6998 ( 1.6) 
  myocardialinfarction_ever = 1 (%)            42171 ( 9.5) 
  pre_diagnoses_qof_diabetes = 1 (%)           60791 (13.7) 
  post_diagnoses_qof_diabetes = 1 (%)          24661 ( 5.5) 
  qof_diabetes_ever = 1 (%)                    86481 (19.4) 
  pre_diagnoses_revasc = 1 (%)                 24090 ( 5.4) 
  post_diagnoses_revasc = 1 (%)                 1104 ( 0.2) 
  revasc_ever = 1 (%)                          25259 ( 5.7) 
  pre_diagnoses_stroke = 1 (%)                 48354 (10.9) 
  post_diagnoses_stroke = 1 (%)                20314 ( 4.6) 
  stroke_ever = 1 (%)                          70378 (15.8) 
  pre_diagnoses_tia = 1 (%)                    38225 ( 8.6) 
  post_diagnoses_tia = 1 (%)                   12286 ( 2.8) 
  tia_ever = 1 (%)                             51115 (11.5) 
  alcohol_cat (%)                                           
     Excess                                    23239 ( 5.2) 
     Harmful                                   11657 ( 2.6) 
     None                                      41673 ( 9.4) 
     Unknown                                  118172 (26.5) 
     Within limits                            250591 (56.3) 
  smoking_cat (%)                                           
     Active smoker                             35954 ( 8.1) 
     Ex-smoker                                185210 (41.6) 
     Non-smoker                               142187 (31.9) 
     Unknown                                   81981 (18.4) 
  qrisk2_smoking_cat (%)                                    
     0                                        191562 (43.0) 
     1                                        116583 (26.2) 
     2                                         34441 ( 7.7) 
     3                                          1163 ( 0.3) 
     4                                           876 ( 0.2) 
     Unknown                                  100707 (22.6) 
  qrisk2_smoking_cat_uncoded (%)                            
     Ex-smoker                                116583 (26.2) 
     Heavy smoker                                876 ( 0.2) 
     Light smoker                              34441 ( 7.7) 
     Moderate smoker                            1163 ( 0.3) 
     Non-smoker                               191562 (43.0) 
     Unknown                                  100707 (22.6) 
  gp_qrisk2_ethnicity (%)                                   
     Bangladeshi                                 716 ( 0.2) 
     Black African                              1358 ( 0.3) 
     Black Caribbean                            5553 ( 1.2) 
     Chinese                                     449 ( 0.1) 
     Indian                                     4048 ( 0.9) 
     Other                                      3587 ( 0.8) 
     Other Asian                                1575 ( 0.4) 
     Pakistani                                  1651 ( 0.4) 
     Unknown                                  112463 (25.3) 
     White                                    313932 (70.5) 
  hes_qrisk2_ethnicity (%)                                  
     Bangladeshi                                 616 ( 0.1) 
     Black African                              1304 ( 0.3) 
     Black Caribbean                            5520 ( 1.2) 
     Chinese                                     514 ( 0.1) 
     Indian                                     3784 ( 0.8) 
     Other                                      4954 ( 1.1) 
     Other Asian                                1600 ( 0.4) 
     Pakistani                                  1516 ( 0.3) 
     Unknown                                   32537 ( 7.3) 
     White                                    392987 (88.2) 
  gp_5cat_ethnicity (%)                                     
     Black                                      7622 ( 1.7) 
     Mixed                                      1302 ( 0.3) 
     Other                                      2023 ( 0.5) 
     South Asian                                8064 ( 1.8) 
     Unknown                                  112373 (25.2) 
     White                                    313948 (70.5) 
  hes_5cat_ethnicity (%)                                    
     Black                                      7829 ( 1.8) 
     Mixed                                      1031 ( 0.2) 
     Other                                      3432 ( 0.8) 
     South Asian                                7516 ( 1.7) 
     Unknown                                   32537 ( 7.3) 
     White                                    392987 (88.2) 
  gp_16cat_ethnicity (%)                                    
     African                                    1371 ( 0.3) 
     Bangladeshi                                 716 ( 0.2) 
     Caribbean                                  5581 ( 1.3) 
     Chinese                                     451 ( 0.1) 
     Indian                                     4052 ( 0.9) 
     Other                                      1590 ( 0.4) 
     Other Asian                                1585 ( 0.4) 
     Other Black                                 598 ( 0.1) 
     Other Mixed                                 341 ( 0.1) 
     Other White                                9380 ( 2.1) 
     Pakistani                                  1652 ( 0.4) 
     Unknown                                  112728 (25.3) 
     White and Asian                             165 ( 0.0) 
     White and Black African                     200 ( 0.0) 
     White and Black Caribbean                   612 ( 0.1) 
     White British                            299235 (67.2) 
     White Irish                                5075 ( 1.1) 
  hes_16cat_ethnicity (%)                                   
     African                                    1304 ( 0.3) 
     Bangladeshi                                 616 ( 0.1) 
     Caribbean                                  5520 ( 1.2) 
     Chinese                                     514 ( 0.1) 
     Indian                                     3784 ( 0.8) 
     Other                                      2918 ( 0.7) 
     Other Asian                                1600 ( 0.4) 
     Other Black                                1005 ( 0.2) 
     Other Mixed                                1031 ( 0.2) 
     Pakistani                                  1516 ( 0.3) 
     Unknown                                   32537 ( 7.3) 
     White British                            392987 (88.2) 
  pre_diagnoses_deep_vein_thrombosis = 1 (%)   20090 ( 4.5) 
  post_diagnoses_deep_vein_thrombosis = 1 (%)   8514 ( 1.9) 
  deep_vein_thrombosis_ever = 1 (%)            28825 ( 6.5) 
  pre_diagnoses_pulmonary_embolism = 1 (%)     10503 ( 2.4) 
  post_diagnoses_pulmonary_embolism = 1 (%)     4461 ( 1.0) 
  pulmonary_embolism_ever = 1 (%)              15125 ( 3.4) 
  VTE = 1 (%)                                  40338 ( 9.1) 
  Prescribed_3_months_before_obsdate = 1 (%)   88570 (19.9) 
  drug_name_3_months_before (%)                             
     amisulpride                                3714 ( 4.2) 
     aripiprazole                               1447 ( 1.6) 
     benperidol                                  120 ( 0.1) 
     chlorpromazine                              893 ( 1.0) 
     clozapine                                    16 ( 0.0) 
     flupentixol                                 300 ( 0.3) 
     fluphenazine                                 14 ( 0.0) 
     haloperidol                               20194 (22.8) 
     levomepromazine                           16302 (18.4) 
     lurasidone                                    2 ( 0.0) 
     olanzapine                                 5305 ( 6.0) 
     paliperidone                                  1 ( 0.0) 
     pericyazine                                 127 ( 0.1) 
     perphenazine                                 34 ( 0.0) 
     pimozide                                    988 ( 1.1) 
     prochlorperazine                          16259 (18.4) 
     promazine                                  4246 ( 4.8) 
     quetiapine                                17203 (19.4) 
     sulpiride                                   661 ( 0.7) 
     thioridazine                                 11 ( 0.0) 
     trifluoperazine                             639 ( 0.7) 
     zuclopenthixol                               94 ( 0.1) 
  Prescribed_6_months_before_obsdate = 1 (%)   91977 (20.7) 
  drug_name_6_months_before (%)                             
     amisulpride                                4000 ( 3.9) 
     aripiprazole                               1549 ( 1.5) 
     benperidol                                  126 ( 0.1) 
     chlorpromazine                             1095 ( 1.1) 
     clozapine                                    20 ( 0.0) 
     flupentixol                                 470 ( 0.5) 
     fluphenazine                                 21 ( 0.0) 
     haloperidol                               21135 (20.4) 
     levomepromazine                           16407 (15.8) 
     lurasidone                                    2 ( 0.0) 
     olanzapine                                 6522 ( 6.3) 
     paliperidone                                  1 ( 0.0) 
     pericyazine                                 149 ( 0.1) 
     perphenazine                                 46 ( 0.0) 
     pimozide                                   1825 ( 1.8) 
     prochlorperazine                          25309 (24.4) 
     promazine                                  4677 ( 4.5) 
     quetiapine                                18618 (18.0) 
     sulpiride                                   763 ( 0.7) 
     thioridazine                                 23 ( 0.0) 
     trifluoperazine                             803 ( 0.8) 
     zuclopenthixol                              101 ( 0.1) 
  Prescribed_12_months_before_obsdate = 1 (%)  97193 (21.8) 
  drug_name_12_months_before (%)                            
     amisulpride                                3903 ( 4.0) 
     aripiprazole                               1525 ( 1.6) 
     benperidol                                  125 ( 0.1) 
     chlorpromazine                             1033 ( 1.1) 
     clozapine                                    18 ( 0.0) 
     flupentixol                                 379 ( 0.4) 
     fluphenazine                                 17 ( 0.0) 
     haloperidol                               21041 (21.6) 
     levomepromazine                           16428 (16.9) 
     lurasidone                                    2 ( 0.0) 
     olanzapine                                 5884 ( 6.1) 
     paliperidone                                  1 ( 0.0) 
     pericyazine                                 145 ( 0.1) 
     perphenazine                                 43 ( 0.0) 
     pimozide                                   1192 ( 1.2) 
     prochlorperazine                          21088 (21.7) 
     promazine                                  4576 ( 4.7) 
     quetiapine                                18208 (18.7) 
     sulpiride                                   723 ( 0.7) 
     thioridazine                                 16 ( 0.0) 
     trifluoperazine                             748 ( 0.8) 
     zuclopenthixol                               98 ( 0.1) 
  Prescribed_after_obsdate = 1 (%)             81852 (18.4) 
  drug_name_after_obsdate (%)                               
     amisulpride                                3371 ( 4.1) 
     aripiprazole                               1347 ( 1.6) 
     benperidol                                  110 ( 0.1) 
     chlorpromazine                              752 ( 0.9) 
     clozapine                                    13 ( 0.0) 
     flupentixol                                 249 ( 0.3) 
     fluphenazine                                 12 ( 0.0) 
     haloperidol                               18898 (23.1) 
     levomepromazine                           16020 (19.6) 
     lurasidone                                    2 ( 0.0) 
     olanzapine                                 4776 ( 5.8) 
     paliperidone                                  1 ( 0.0) 
     pericyazine                                 111 ( 0.1) 
     perphenazine                                 28 ( 0.0) 
     pimozide                                    907 ( 1.1) 
     prochlorperazine                          14486 (17.7) 
     promazine                                  3776 ( 4.6) 
     quetiapine                                15757 (19.3) 
     sulpiride                                   590 ( 0.7) 
     thioridazine                                  8 ( 0.0) 
     trifluoperazine                             557 ( 0.7) 
     zuclopenthixol                               81 ( 0.1)
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

***Updated Algorithm - exact match on: Sex, stroke history, cvd, deprivation and risperidone age category (65-74, 75-84, 85+)***

```
                                                         Stratified by risperidone
                                                          0              1              p      test SMD   
  n                                                       122911         26793                            
  sex = 1 (%)                                              44809 (36.5)  10059 ( 37.5)   0.001       0.023
  risperidone = 1 (%)                                          0 ( 0.0)  26793 (100.0)  <0.001         NaN
  age_risperidone (mean (SD))                              83.44 (6.68)  83.25 (6.76)   <0.001       0.028
  age_diagnosis (mean (SD))                                80.64 (6.78)  80.57 (7.05)    0.104       0.011
  age_risperidone_cat (%)                                                               <0.001       0.040
     65 - 74                                               11756 ( 9.6)   2885 ( 10.8)                    
     75 - 84                                               56235 (45.8)  12136 ( 45.3)                    
     85+                                                   54920 (44.7)  11772 ( 43.9)                    
  care_home_before_indexdate = 1 (%)                       15414 (12.5)   3457 ( 12.9)   0.108       0.011
  deprivation (%)                                                                        0.053       0.019
     1                                                     28053 (22.8)   6062 ( 22.6)                    
     2                                                     30592 (24.9)   6605 ( 24.7)                    
     3                                                     24786 (20.2)   5440 ( 20.3)                    
     4                                                     20738 (16.9)   4573 ( 17.1)                    
     5                                                     18728 (15.2)   4103 ( 15.3)                    
     Unknown                                                  14 ( 0.0)     10 (  0.0)                    
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   4017 ( 3.3)   1004 (  3.7)  <0.001       0.026
  stroke_composite_pre_index_date = 1 (%)                  14644 (11.9)   3446 ( 12.9)  <0.001       0.029
  pre_index_date_angina = 1 (%)                            13996 (11.4)   3109 ( 11.6)   0.318       0.007
  pre_index_date_heartfailure = 1 (%)                       9374 ( 7.6)   2090 (  7.8)   0.338       0.007
  BMI (%)                                                                               <0.001       0.039
     Missing                                               19047 (15.5)   4530 ( 16.9)                    
     Normal                                                49509 (40.3)  10635 ( 39.7)                    
     Obesity                                               13537 (11.0)   2907 ( 10.8)                    
     Overweight                                            32555 (26.5)   6987 ( 26.1)                    
     Severely Obese                                          877 ( 0.7)    179 (  0.7)                    
     Underweight                                            7386 ( 6.0)   1555 (  5.8)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             35000 (28.5)   7229 ( 27.0)  <0.001       0.033
  period_before_prescription (mean (SD))                    2.83 (2.20)   2.69 (2.42)   <0.001       0.061
  pre_index_date_myocardialinfarction = 1 (%)               9708 ( 7.9)   2158 (  8.1)   0.399       0.006
  pre_index_date_tia = 1 (%)                               11259 ( 9.2)   2478 (  9.2)   0.658       0.003
  pre_index_date_falls = 1 (%)                             52746 (42.9)  11320 ( 42.2)   0.047       0.013
  pre_index_date_lowerlimbfracture = 1 (%)                 19762 (16.1)   4289 ( 16.0)   0.783       0.002
  pre_index_date_ihd = 1 (%)                               19787 (16.1)   4403 ( 16.4)   0.180       0.009
  pre_index_date_pad = 1 (%)                                9612 ( 7.8)   2098 (  7.8)   0.965      <0.001
  pre_index_date_af = 1 (%)                                19551 (15.9)   4314 ( 16.1)   0.436       0.005
  pre_index_date_revasc = 1 (%)                             6529 ( 5.3)   1442 (  5.4)   0.654       0.003
  pre_index_date_qof_diabetes = 1 (%)                      21969 (17.9)   4740 ( 17.7)   0.485       0.005
  pre_index_date_anxiety_disorders = 1 (%)                 23936 (19.5)   5279 ( 19.7)   0.397       0.006
  pre_index_date_fh_diabetes = 1 (%)                       26842 (21.8)   5679 ( 21.2)   0.021       0.016
  pre_index_date_fh_premature_cvd = 1 (%)                   9996 ( 8.1)   2165 (  8.1)   0.786       0.002
  pre_index_date_pulmonary_embolism = 1 (%)                 3186 ( 2.6)    694 (  2.6)   1.000      <0.001
  pre_index_date_deep_vein_thrombosis = 1 (%)               6473 ( 5.3)   1392 (  5.2)   0.648       0.003
  pre_index_date_hearing_loss = 1 (%)                      33804 (27.5)   7319 ( 27.3)   0.542       0.004
  pre_index_date_VTE = 1 (%)                                8824 ( 7.2)   1916 (  7.2)   0.882       0.001
  pre_index_date_haem_cancer = 1 (%)                        2396 ( 1.9)    507 (  1.9)   0.555       0.004
  pre_index_date_solid_cancer = 1 (%)                      19918 (16.2)   4312 ( 16.1)   0.660       0.003
  pre_index_date_cvd = 1 (%)                               47926 (39.0)  10668 ( 39.8)   0.013       0.017
  comorbidity_hypertension (%)                                                          <0.001       0.039
     Elevated                                              21580 (17.6)   4712 ( 17.6)                    
     Normal                                                29915 (24.3)   6693 ( 25.0)                    
     Stage 1                                               49666 (40.4)  10710 ( 40.0)                    
     Stage 2                                               21032 (17.1)   4449 ( 16.6)                    
     Stage 3 (severe)                                        157 ( 0.1)     37 (  0.1)                    
     Unknown                                                 561 ( 0.5)    192 (  0.7)       

```





![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_censored.png)




![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_censored_under75.png)


```
Call:
coxph(formula = Surv(Survival_time, stroke_composite_post_index_date) ~ 
    age_diagnosis + sex + stroke_composite_pre_index_date, data = table)

  n= 149704, number of events= 9103 

                                    coef exp(coef) se(coef)      z Pr(>|z|)    
age_diagnosis                   0.013596  1.013689 0.001622  8.383  < 2e-16 ***
sex                             0.107951  1.113993 0.021935  4.921 8.59e-07 ***
stroke_composite_pre_index_date 1.823485  6.193406 0.021538 84.664  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

                                exp(coef) exp(-coef) lower .95 upper .95
age_diagnosis                       1.014     0.9865     1.010     1.017
sex                                 1.114     0.8977     1.067     1.163
stroke_composite_pre_index_date     6.193     0.1615     5.937     6.460

Concordance= 0.705  (se = 0.003 )
Likelihood ratio test= 6095  on 3 df,   p=<2e-16
Wald test            = 7502  on 3 df,   p=<2e-16
Score (logrank) test = 9837  on 3 df,   p=<2e-16

```

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored.png)
```
         strata   median    lower    upper
1 risperidone=0 5.661875 5.629021 5.697467
2 risperidone=1 4.558522 4.503765 4.613279
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_under75.png)
```
         strata   median    lower    upper
1 risperidone=0 7.093771 6.967830 7.233402
2 risperidone=1 5.314168 5.117043 5.489391
```
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/SA_NewAlgorithm_censored_death_1st_year.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_ControlGroup_censored.png)

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/KM_NewAlgorithm_TreatmentGroup_censored.png)

***Updated Algorithm - without exact match***

```
                                                        Stratified by risperidone
                                                          0               1              p      test SMD   
  n                                                       146209          29691                            
  sex = 1 (%)                                              56211 ( 38.4)  11457 ( 38.6)   0.652       0.003
  risperidone = 1 (%)                                          0 (  0.0)  29691 (100.0)  <0.001         NaN
  age_risperidone (mean (SD))                              83.10 (6.88)   83.02 (6.86)    0.072       0.011
  age_diagnosis (mean (SD))                                80.46 (6.92)   80.45 (7.12)    0.763       0.002
  age_risperidone_cat (%)                                                                 0.320       0.010
     65 - 74                                               17457 ( 11.9)   3578 ( 12.1)                    
     75 - 84                                               65315 ( 44.7)  13372 ( 45.0)                    
     85+                                                   63437 ( 43.4)  12741 ( 42.9)                    
  care_home_before_indexdate = 1 (%)                       20110 ( 13.8)   3926 ( 13.2)   0.015       0.016
  deprivation (%)                                                                         0.874       0.009
     1                                                     32589 ( 22.3)   6648 ( 22.4)                    
     2                                                     36053 ( 24.7)   7285 ( 24.5)                    
     3                                                     29473 ( 20.2)   5987 ( 20.2)                    
     4                                                     24901 ( 17.0)   5124 ( 17.3)                    
     5                                                     23033 ( 15.8)   4617 ( 15.6)                    
     Unknown                                                 160 (  0.1)     30 (  0.1)                    
  Stroke__within_year_after_1st_risperidone_presc = 0 (%) 146209 (100.0)  29691 (100.0)      NA      <0.001
  stroke_composite_pre_index_date = 1 (%)                  20802 ( 14.2)   4199 ( 14.1)   0.708       0.002
  pre_index_date_angina = 1 (%)                            17189 ( 11.8)   3513 ( 11.8)   0.721       0.002
  pre_index_date_heartfailure = 1 (%)                      11468 (  7.8)   2267 (  7.6)   0.227       0.008
  BMI (%)                                                                                 0.957       0.007
     Missing                                               31664 ( 21.7)   6381 ( 21.5)                    
     Normal                                                54821 ( 37.5)  11214 ( 37.8)                    
     Obesity                                               14961 ( 10.2)   3008 ( 10.1)                    
     Overweight                                            35797 ( 24.5)   7267 ( 24.5)                    
     Severely Obese                                          958 (  0.7)    193 (  0.7)                    
     Underweight                                            8008 (  5.5)   1628 (  5.5)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)             37749 ( 25.8)   7442 ( 25.1)   0.007       0.017
  period_before_prescription (mean (SD))                    2.67 (2.15)    2.57 (2.39)   <0.001       0.043
  pre_index_date_myocardialinfarction = 1 (%)              12031 (  8.2)   2425 (  8.2)   0.735       0.002
  pre_index_date_tia = 1 (%)                               13602 (  9.3)   2778 (  9.4)   0.782       0.002
  pre_index_date_falls = 1 (%)                             60023 ( 41.1)  12018 ( 40.5)   0.067       0.012
  pre_index_date_lowerlimbfracture = 1 (%)                 23439 ( 16.0)   4718 ( 15.9)   0.552       0.004
  pre_index_date_ihd = 1 (%)                               24382 ( 16.7)   4941 ( 16.6)   0.890       0.001
  pre_index_date_pad = 1 (%)                               11169 (  7.6)   2287 (  7.7)   0.716       0.002
  pre_index_date_af = 1 (%)                                23246 ( 15.9)   4726 ( 15.9)   0.945      <0.001
  pre_index_date_revasc = 1 (%)                             7879 (  5.4)   1588 (  5.3)   0.789       0.002
  pre_index_date_qof_diabetes = 1 (%)                      25218 ( 17.2)   5127 ( 17.3)   0.941       0.001
  pre_index_date_anxiety_disorders = 1 (%)                 28992 ( 19.8)   5874 ( 19.8)   0.864       0.001
  pre_index_date_fh_diabetes = 1 (%)                       29469 ( 20.2)   5900 ( 19.9)   0.269       0.007
  pre_index_date_fh_premature_cvd = 1 (%)                  11364 (  7.8)   2269 (  7.6)   0.451       0.005
  pre_index_date_pulmonary_embolism = 1 (%)                 3762 (  2.6)    751 (  2.5)   0.679       0.003
  pre_index_date_deep_vein_thrombosis = 1 (%)               7527 (  5.1)   1515 (  5.1)   0.757       0.002
  pre_index_date_hearing_loss = 1 (%)                      38623 ( 26.4)   7856 ( 26.5)   0.884       0.001
  pre_index_date_VTE = 1 (%)                               10399 (  7.1)   2088 (  7.0)   0.633       0.003
  pre_index_date_haem_cancer = 1 (%)                        2787 (  1.9)    567 (  1.9)   0.987      <0.001
  pre_index_date_solid_cancer = 1 (%)                      22971 ( 15.7)   4665 ( 15.7)   1.000      <0.001
  pre_index_date_cvd = 1 (%)                               59298 ( 40.6)  12046 ( 40.6)   0.969      <0.001
  comorbidity_hypertension (%)                                                           <0.001       0.043
     Elevated                                              24970 ( 17.1)   5076 ( 17.1)                    
     Normal                                                37629 ( 25.7)   7494 ( 25.2)                    
     Stage 1                                               56282 ( 38.5)  11372 ( 38.3)                    
     Stage 2                                               23109 ( 15.8)   4678 ( 15.8)                    
     Stage 3 (severe)                                        204 (  0.1)     40 (  0.1)                    
     Unknown                                                4015 (  2.7)   1031 (  3.5) 

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

![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_all_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_all_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_nostroke_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_nostroke_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_withstroke_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_withstroke_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_over75_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_over75_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_under75_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_under75_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_nodrugs_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_nodrugs_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_cvd_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_cvd_adjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_nocvd_unadjusted.png)
![image](https://github.com/Exeter-Diabetes/Dementia/blob/main/images/Stroke_nocvd_adjusted.png)



***All***
```
                                                     outcome                        sugbroup      model   hr ci.l  ci.u event_count person_time incidence_rate_per_1000_PY number_of_patients
stroke.c_unadjusted_all                             stroke.c                             all unadjusted 1.24 1.15  1.32        4890   119903.62                      40.78             149704
stroke.c_adjusted_all                               stroke.c                             all   adjusted 1.25 1.16  1.34        4890   119903.62                      40.78             149704
stroke.c_unadjusted_no_stroke                       stroke.c                       no_stroke unadjusted 1.34 1.21  1.48        2387   106782.25                      22.35             131614
stroke.c_adjusted_no_stroke                         stroke.c                       no_stroke   adjusted 1.35 1.22  1.50        2387   106782.25                      22.35             131614
stroke.c_unadjusted_with_stroke                     stroke.c                     with_stroke unadjusted 1.16 1.05  1.28        2503    13121.37                     190.76              18090
stroke.c_adjusted_with_stroke                       stroke.c                     with_stroke   adjusted 1.16 1.05  1.28        2503    13121.37                     190.76              18090
stroke.c_unadjusted_over_75                         stroke.c                         over_75 unadjusted 1.24 1.15  1.33        4523   107341.25                      42.14             135063
stroke.c_adjusted_over_75                           stroke.c                         over_75   adjusted 1.25 1.16  1.35        4523   107341.25                      42.14             135063
stroke.c_unadjusted_under_75                        stroke.c                        under_75 unadjusted 1.21 0.95  1.54         367    12562.38                      29.21              14641
stroke.c_adjusted_under_75                          stroke.c                        under_75   adjusted 1.22 0.95  1.58         367    12562.38                      29.21              14641
stroke.c_unadjusted_no_other_drugs                  stroke.c                  no_other_drugs unadjusted 1.28 1.15  1.43        1770    44876.78                      39.44              56731
stroke.c_adjusted_no_other_drugs                    stroke.c                  no_other_drugs   adjusted 1.30 1.16  1.45        1770    44876.78                      39.44              56731
stroke.c_unadjusted_CVD                             stroke.c                             CVD unadjusted 1.17 1.08  1.28        3387    45030.13                      75.22              58594
stroke.c_adjusted_CVD                               stroke.c                             CVD   adjusted 1.17 1.07  1.28        3387    45030.13                      75.22              58594
stroke.c_unadjusted_No_CVD                          stroke.c                          No_CVD unadjusted 1.42 1.25  1.61        1503    74873.49                      20.07              91110
stroke.c_adjusted_No_CVD                            stroke.c                          No_CVD   adjusted 1.43 1.26  1.62        1503    74873.49                      20.07              91110
stroke.c_unadjusted_diabetes                        stroke.c                        diabetes unadjusted 1.24 0.99  1.54         320     5776.59                      55.40               7583
stroke.c_adjusted_diabetes                          stroke.c                        diabetes   adjusted 1.37 1.08  1.72         320     5776.59                      55.40               7583
stroke.c_unadjusted_Obese_overweight                stroke.c                Obese_overweight unadjusted 1.19 1.03  1.36         927    22907.78                      40.47              28684
stroke.c_adjusted_Obese_overweight                  stroke.c                Obese_overweight   adjusted 1.21 1.05  1.40         927    22907.78                      40.47              28684
stroke.c_unadjusted_atrialFibrillation              stroke.c              atrialFibrillation unadjusted 1.04 0.85  1.27         413     4794.25                      86.14               6740
stroke.c_adjusted_atrialFibrillation                stroke.c              atrialFibrillation   adjusted 1.12 0.90  1.39         413     4794.25                      86.14               6740
stroke.c_unadjusted_risperidone_Age_65_74           stroke.c           risperidone_Age_65_74 unadjusted 1.21 0.95  1.54         367    12562.38                      29.21              14641
stroke.c_adjusted_risperidone_Age_65_74             stroke.c           risperidone_Age_65_74   adjusted 1.22 0.95  1.58         367    12562.38                      29.21              14641
stroke.c_unadjusted_risperidone_Age_75_84           stroke.c           risperidone_Age_75_84 unadjusted 1.25 1.13  1.39        2188    56312.26                      38.85              68371
stroke.c_adjusted_risperidone_Age_75_84             stroke.c           risperidone_Age_75_84   adjusted 1.26 1.13  1.40        2188    56312.26                      38.85              68371
stroke.c_unadjusted_risperidone_Age_85+             stroke.c             risperidone_Age_85+ unadjusted 1.23 1.11  1.36        2335    51028.99                      45.76              66692
stroke.c_adjusted_risperidone_Age_85+               stroke.c             risperidone_Age_85+   adjusted 1.24 1.12  1.38        2335    51028.99                      45.76              66692
stroke.c_unadjusted_totalcholesterol_LESSTHAN160    stroke.c    totalcholesterol_LESSTHAN160 unadjusted 1.11 0.93  1.33         521     7941.36                      65.61              11272
stroke.c_adjusted_totalcholesterol_LESSTHAN160      stroke.c    totalcholesterol_LESSTHAN160   adjusted 1.24 1.02  1.50         521     7941.36                      65.61              11272
stroke.c_unadjusted_totalcholesterol_GREATERTHAN280 stroke.c totalcholesterol_GREATERTHAN280 unadjusted 1.54 0.40  5.86           5      156.66                      31.92                191
stroke.c_adjusted_totalcholesterol_GREATERTHAN280   stroke.c totalcholesterol_GREATERTHAN280   adjusted 4.57 1.40 14.94           5      156.66                      31.92                191
stroke.c_unadjusted_totalcholesterol_EQUAL199       stroke.c       totalcholesterol_EQUAL199 unadjusted 1.25 0.99  1.57         315     7391.12                      42.62               9891
stroke.c_adjusted_totalcholesterol_EQUAL199         stroke.c       totalcholesterol_EQUAL199   adjusted 1.22 0.97  1.55         315     7391.12                      42.62               9891
stroke.c_unadjusted_totalcholesterol_200_239        stroke.c        totalcholesterol_200_239 unadjusted 1.32 0.94  1.85         133     5156.15                      25.79               6675
stroke.c_adjusted_totalcholesterol_200_239          stroke.c        totalcholesterol_200_239   adjusted 1.29 0.91  1.84         133     5156.15                      25.79               6675
stroke.c_unadjusted_totalcholesterol_240_279        stroke.c        totalcholesterol_240_279 unadjusted 1.63 0.66  4.02          19     1002.84                      18.95               1285
stroke.c_adjusted_totalcholesterol_240_279          stroke.c        totalcholesterol_240_279   adjusted 1.71 0.61  4.77          19     1002.84                      18.95               1285
stroke.c_unadjusted_hypertension_stage1AndHigher    stroke.c    hypertension_stage1AndHigher unadjusted 1.25 1.13  1.39        1829    44968.91                      40.67              55863
stroke.c_adjusted_hypertension_stage1AndHigher      stroke.c    hypertension_stage1AndHigher   adjusted 1.25 1.12  1.38        1829    44968.91                      40.67              55863
stroke.c_unadjusted_hypertension_stage2AndHigher    stroke.c    hypertension_stage2AndHigher unadjusted 1.32 1.01  1.73         216     4942.10                      43.71               6312
stroke.c_adjusted_hypertension_stage2AndHigher      stroke.c    hypertension_stage2AndHigher   adjusted 1.35 1.02  1.78         216     4942.10                      43.71               6312
stroke.c_unadjusted_carehome_preIndexDate           stroke.c           carehome_preIndexDate unadjusted 1.22 0.90  1.66         176     3267.70                      53.86               4938
stroke.c_adjusted_carehome_preIndexDate             stroke.c           carehome_preIndexDate   adjusted 1.34 0.98  1.85         176     3267.70                      53.86               4938
stroke.c_unadjusted_HES&ONS_stroke                  stroke.c                  HES&ONS_stroke unadjusted 1.24 1.15  1.32        4890   119903.62                      40.78             149704
stroke.c_adjusted_HES&ONS_stroke                    stroke.c                  HES&ONS_stroke   adjusted 1.25 1.16  1.34        4890   119903.62                      40.78             149704
stroke.c_unadjusted_ischaemicstroke                 stroke.c                 ischaemicstroke unadjusted 1.27 1.15  1.40        2088     9252.35                     225.67              12840
stroke.c_adjusted_ischaemicstroke                   stroke.c                 ischaemicstroke   adjusted 1.17 1.06  1.30        2088     9252.35                     225.67              12840
stroke.c_unadjusted_haemorrhagicstroke              stroke.c              haemorrhagicstroke unadjusted 1.62 0.92  2.86          53      301.21                     175.96                421
stroke.c_adjusted_haemorrhagicstroke                stroke.c              haemorrhagicstroke   adjusted 1.71 0.92  3.19          53      301.21                     175.96                421
stroke.c_unadjusted_12weeksFollowUp                 stroke.c                 12weeksFollowUp unadjusted 1.65 1.47  1.85        1721          NA                         NA             149704
stroke.c_adjusted_12weeksFollowUp                   stroke.c                 12weeksFollowUp   adjusted 1.70 1.52  1.91        1721          NA                         NA             149704
```



****Treatment group****
```
                                                     outcome                        subgroup      model   hr ci.l  ci.u event_count person_time incidence_rate_per_1000_PY number_of_patients
stroke.c_unadjusted_all                             stroke.c                             all unadjusted 1.24 1.15  1.32         973    19025.43                      51.14              26793
stroke.c_adjusted_all                               stroke.c                             all   adjusted 1.25 1.16  1.34         973    19025.43                      51.14              26793
stroke.c_unadjusted_no_stroke                       stroke.c                       no_stroke unadjusted 1.34 1.21  1.48         491    16822.87                      29.19              23347
stroke.c_adjusted_no_stroke                         stroke.c                       no_stroke   adjusted 1.35 1.22  1.50         491    16822.87                      29.19              23347
stroke.c_unadjusted_with_stroke                     stroke.c                     with_stroke unadjusted 1.16 1.05  1.28         482     2202.56                     218.84               3446
stroke.c_adjusted_with_stroke                       stroke.c                     with_stroke   adjusted 1.16 1.05  1.28         482     2202.56                     218.84               3446
stroke.c_unadjusted_over_75                         stroke.c                         over_75 unadjusted 1.24 1.15  1.33         883    16813.42                      52.52              23908
stroke.c_adjusted_over_75                           stroke.c                         over_75   adjusted 1.25 1.16  1.35         883    16813.42                      52.52              23908
stroke.c_unadjusted_under_75                        stroke.c                        under_75 unadjusted 1.21 0.95  1.54          90     2212.00                      40.69               2885
stroke.c_adjusted_under_75                          stroke.c                        under_75   adjusted 1.22 0.95  1.58          90     2212.00                      40.69               2885
stroke.c_unadjusted_no_other_drugs                  stroke.c                  no_other_drugs unadjusted 1.28 1.15  1.43         434     8517.91                      50.95              12521
stroke.c_adjusted_no_other_drugs                    stroke.c                  no_other_drugs   adjusted 1.30 1.16  1.45         434     8517.91                      50.95              12521
stroke.c_unadjusted_CVD                             stroke.c                             CVD unadjusted 1.17 1.08  1.28         644     7160.44                      89.94              10668
stroke.c_adjusted_CVD                               stroke.c                             CVD   adjusted 1.17 1.07  1.28         644     7160.44                      89.94              10668
stroke.c_unadjusted_No_CVD                          stroke.c                          No_CVD unadjusted 1.42 1.25  1.61         329    11864.99                      27.73              16125
stroke.c_adjusted_No_CVD                            stroke.c                          No_CVD   adjusted 1.43 1.26  1.62         329    11864.99                      27.73              16125
stroke.c_unadjusted_diabetes                        stroke.c                        diabetes unadjusted 1.24 0.99  1.54         131     2001.44                      65.45               2935
stroke.c_adjusted_diabetes                          stroke.c                        diabetes   adjusted 1.37 1.08  1.72         131     2001.44                      65.45               2935
stroke.c_unadjusted_Obese_overweight                stroke.c                Obese_overweight unadjusted 1.19 1.03  1.36         293     6121.36                      47.87               8639
stroke.c_adjusted_Obese_overweight                  stroke.c                Obese_overweight   adjusted 1.21 1.05  1.40         293     6121.36                      47.87               8639
stroke.c_unadjusted_atrialFibrillation              stroke.c              atrialFibrillation unadjusted 1.04 0.85  1.27         153     1643.79                      93.08               2600
stroke.c_adjusted_atrialFibrillation                stroke.c              atrialFibrillation   adjusted 1.12 0.90  1.39         153     1643.79                      93.08               2600
stroke.c_unadjusted_risperidone_Age_65_74           stroke.c           risperidone_Age_65_74 unadjusted 1.21 0.95  1.54          90     2212.00                      40.69               2885
stroke.c_adjusted_risperidone_Age_65_74             stroke.c           risperidone_Age_65_74   adjusted 1.22 0.95  1.58          90     2212.00                      40.69               2885
stroke.c_unadjusted_risperidone_Age_75_84           stroke.c           risperidone_Age_75_84 unadjusted 1.25 1.13  1.39         435     8889.49                      48.93              12136
stroke.c_adjusted_risperidone_Age_75_84             stroke.c           risperidone_Age_75_84   adjusted 1.26 1.13  1.40         435     8889.49                      48.93              12136
stroke.c_unadjusted_risperidone_Age_85+             stroke.c             risperidone_Age_85+ unadjusted 1.23 1.11  1.36         448     7923.93                      56.54              11772
stroke.c_adjusted_risperidone_Age_85+               stroke.c             risperidone_Age_85+   adjusted 1.24 1.12  1.38         448     7923.93                      56.54              11772
stroke.c_unadjusted_totalcholesterol_LESSTHAN160    stroke.c    totalcholesterol_LESSTHAN160 unadjusted 1.11 0.93  1.33         183     2459.24                      74.41               4008
stroke.c_adjusted_totalcholesterol_LESSTHAN160      stroke.c    totalcholesterol_LESSTHAN160   adjusted 1.24 1.02  1.50         183     2459.24                      74.41               4008
stroke.c_unadjusted_totalcholesterol_GREATERTHAN280 stroke.c totalcholesterol_GREATERTHAN280 unadjusted 1.54 0.40  5.86           3       69.81                      42.98                 92
stroke.c_adjusted_totalcholesterol_GREATERTHAN280   stroke.c totalcholesterol_GREATERTHAN280   adjusted 4.57 1.40 14.94           3       69.81                      42.98                 92
stroke.c_unadjusted_totalcholesterol_EQUAL199       stroke.c       totalcholesterol_EQUAL199 unadjusted 1.25 0.99  1.57         130     2518.88                      51.61               3811
stroke.c_adjusted_totalcholesterol_EQUAL199         stroke.c       totalcholesterol_EQUAL199   adjusted 1.22 0.97  1.55         130     2518.88                      51.61               3811
stroke.c_unadjusted_totalcholesterol_200_239        stroke.c        totalcholesterol_200_239 unadjusted 1.32 0.94  1.85          58     1882.93                      30.80               2652
stroke.c_adjusted_totalcholesterol_200_239          stroke.c        totalcholesterol_200_239   adjusted 1.29 0.91  1.84          58     1882.93                      30.80               2652
stroke.c_unadjusted_totalcholesterol_240_279        stroke.c        totalcholesterol_240_279 unadjusted 1.63 0.66  4.02          10      412.60                      24.24                567
stroke.c_adjusted_totalcholesterol_240_279          stroke.c        totalcholesterol_240_279   adjusted 1.71 0.61  4.77          10      412.60                      24.24                567
stroke.c_unadjusted_hypertension_stage1AndHigher    stroke.c    hypertension_stage1AndHigher unadjusted 1.25 1.13  1.39         517    10285.65                      50.26              14363
stroke.c_adjusted_hypertension_stage1AndHigher      stroke.c    hypertension_stage1AndHigher   adjusted 1.25 1.12  1.38         517    10285.65                      50.26              14363
stroke.c_unadjusted_hypertension_stage2AndHigher    stroke.c    hypertension_stage2AndHigher unadjusted 1.32 1.01  1.73          95     1839.42                      51.65               2572
stroke.c_adjusted_hypertension_stage2AndHigher      stroke.c    hypertension_stage2AndHigher   adjusted 1.35 1.02  1.78          95     1839.42                      51.65               2572
stroke.c_unadjusted_carehome_preIndexDate           stroke.c           carehome_preIndexDate unadjusted 1.22 0.90  1.66          72     1170.09                      61.53               1912
stroke.c_adjusted_carehome_preIndexDate             stroke.c           carehome_preIndexDate   adjusted 1.34 0.98  1.85          72     1170.09                      61.53               1912
stroke.c_unadjusted_HES&ONS_stroke                  stroke.c                  HES&ONS_stroke unadjusted 1.24 1.15  1.32         973    19025.43                      51.14              26793
stroke.c_adjusted_HES&ONS_stroke                    stroke.c                  HES&ONS_stroke   adjusted 1.25 1.16  1.34         973    19025.43                      51.14              26793
stroke.c_unadjusted_ischaemicstroke                 stroke.c                 ischaemicstroke unadjusted 1.27 1.15  1.40         508     1823.63                     278.57               2850
stroke.c_adjusted_ischaemicstroke                   stroke.c                 ischaemicstroke   adjusted 1.17 1.06  1.30         508     1823.63                     278.57               2850
stroke.c_unadjusted_haemorrhagicstroke              stroke.c              haemorrhagicstroke unadjusted 1.62 0.92  2.86          28      132.02                     212.10                190
stroke.c_adjusted_haemorrhagicstroke                stroke.c              haemorrhagicstroke   adjusted 1.71 0.92  3.19          28      132.02                     212.10                190
stroke.c_unadjusted_12weeksFollowUp                 stroke.c                 12weeksFollowUp unadjusted 1.65 1.47  1.85         414          NA                         NA              26793
stroke.c_adjusted_12weeksFollowUp                   stroke.c                 12weeksFollowUp   adjusted 1.70 1.52  1.91         414          NA                         NA              26793
```


****Control group****

```
                                                     outcome                        subgroup      model   hr ci.l  ci.u event_count person_time incidence_rate_per_1000_PY number_of_patients
stroke.c_unadjusted_all                             stroke.c                             all unadjusted 1.24 1.15  1.32        3917   100878.19                      38.83             122911
stroke.c_adjusted_all                               stroke.c                             all   adjusted 1.25 1.16  1.34        3917   100878.19                      38.83             122911
stroke.c_unadjusted_no_stroke                       stroke.c                       no_stroke unadjusted 1.34 1.21  1.48        1896    89959.38                      21.08             108267
stroke.c_adjusted_no_stroke                         stroke.c                       no_stroke   adjusted 1.35 1.22  1.50        1896    89959.38                      21.08             108267
stroke.c_unadjusted_with_stroke                     stroke.c                     with_stroke unadjusted 1.16 1.05  1.28        2021    10918.81                     185.09              14644
stroke.c_adjusted_with_stroke                       stroke.c                     with_stroke   adjusted 1.16 1.05  1.28        2021    10918.81                     185.09              14644
stroke.c_unadjusted_over_75                         stroke.c                         over_75 unadjusted 1.24 1.15  1.33        3640    90527.82                      40.21             111155
stroke.c_adjusted_over_75                           stroke.c                         over_75   adjusted 1.25 1.16  1.35        3640    90527.82                      40.21             111155
stroke.c_unadjusted_under_75                        stroke.c                        under_75 unadjusted 1.21 0.95  1.54         277    10350.37                      26.76              11756
stroke.c_adjusted_under_75                          stroke.c                        under_75   adjusted 1.22 0.95  1.58         277    10350.37                      26.76              11756
stroke.c_unadjusted_no_other_drugs                  stroke.c                  no_other_drugs unadjusted 1.28 1.15  1.43        1336    36358.87                      36.74              44210
stroke.c_adjusted_no_other_drugs                    stroke.c                  no_other_drugs   adjusted 1.30 1.16  1.45        1336    36358.87                      36.74              44210
stroke.c_unadjusted_CVD                             stroke.c                             CVD unadjusted 1.17 1.08  1.28        2743    37869.69                      72.43              47926
stroke.c_adjusted_CVD                               stroke.c                             CVD   adjusted 1.17 1.07  1.28        2743    37869.69                      72.43              47926
stroke.c_unadjusted_No_CVD                          stroke.c                          No_CVD unadjusted 1.42 1.25  1.61        1174    63008.50                      18.63              74985
stroke.c_adjusted_No_CVD                            stroke.c                          No_CVD   adjusted 1.43 1.26  1.62        1174    63008.50                      18.63              74985
stroke.c_unadjusted_diabetes                        stroke.c                        diabetes unadjusted 1.24 0.99  1.54         189     3775.14                      50.06               4648
stroke.c_adjusted_diabetes                          stroke.c                        diabetes   adjusted 1.37 1.08  1.72         189     3775.14                      50.06               4648
stroke.c_unadjusted_Obese_overweight                stroke.c                Obese_overweight unadjusted 1.19 1.03  1.36         634    16786.42                      37.77              20045
stroke.c_adjusted_Obese_overweight                  stroke.c                Obese_overweight   adjusted 1.21 1.05  1.40         634    16786.42                      37.77              20045
stroke.c_unadjusted_atrialFibrillation              stroke.c              atrialFibrillation unadjusted 1.04 0.85  1.27         260     3150.46                      82.53               4140
stroke.c_adjusted_atrialFibrillation                stroke.c              atrialFibrillation   adjusted 1.12 0.90  1.39         260     3150.46                      82.53               4140
stroke.c_unadjusted_risperidone_Age_65_74           stroke.c           risperidone_Age_65_74 unadjusted 1.21 0.95  1.54         277    10350.37                      26.76              11756
stroke.c_adjusted_risperidone_Age_65_74             stroke.c           risperidone_Age_65_74   adjusted 1.22 0.95  1.58         277    10350.37                      26.76              11756
stroke.c_unadjusted_risperidone_Age_75_84           stroke.c           risperidone_Age_75_84 unadjusted 1.25 1.13  1.39        1753    47422.76                      36.97              56235
stroke.c_adjusted_risperidone_Age_75_84             stroke.c           risperidone_Age_75_84   adjusted 1.26 1.13  1.40        1753    47422.76                      36.97              56235
stroke.c_unadjusted_risperidone_Age_85+             stroke.c             risperidone_Age_85+ unadjusted 1.23 1.11  1.36        1887    43105.06                      43.78              54920
stroke.c_adjusted_risperidone_Age_85+               stroke.c             risperidone_Age_85+   adjusted 1.24 1.12  1.38        1887    43105.06                      43.78              54920
stroke.c_unadjusted_totalcholesterol_LESSTHAN160    stroke.c    totalcholesterol_LESSTHAN160 unadjusted 1.11 0.93  1.33         338     5482.12                      61.65               7264
stroke.c_adjusted_totalcholesterol_LESSTHAN160      stroke.c    totalcholesterol_LESSTHAN160   adjusted 1.24 1.02  1.50         338     5482.12                      61.65               7264
stroke.c_unadjusted_totalcholesterol_GREATERTHAN280 stroke.c totalcholesterol_GREATERTHAN280 unadjusted 1.54 0.40  5.86           2       86.85                      23.03                 99
stroke.c_adjusted_totalcholesterol_GREATERTHAN280   stroke.c totalcholesterol_GREATERTHAN280   adjusted 4.57 1.40 14.94           2       86.85                      23.03                 99
stroke.c_unadjusted_totalcholesterol_EQUAL199       stroke.c       totalcholesterol_EQUAL199 unadjusted 1.25 0.99  1.57         185     4872.24                      37.97               6080
stroke.c_adjusted_totalcholesterol_EQUAL199         stroke.c       totalcholesterol_EQUAL199   adjusted 1.22 0.97  1.55         185     4872.24                      37.97               6080
stroke.c_unadjusted_totalcholesterol_200_239        stroke.c        totalcholesterol_200_239 unadjusted 1.32 0.94  1.85          75     3273.22                      22.91               4023
stroke.c_adjusted_totalcholesterol_200_239          stroke.c        totalcholesterol_200_239   adjusted 1.29 0.91  1.84          75     3273.22                      22.91               4023
stroke.c_unadjusted_totalcholesterol_240_279        stroke.c        totalcholesterol_240_279 unadjusted 1.63 0.66  4.02           9      590.24                      15.25                718
stroke.c_adjusted_totalcholesterol_240_279          stroke.c        totalcholesterol_240_279   adjusted 1.71 0.61  4.77           9      590.24                      15.25                718
stroke.c_unadjusted_hypertension_stage1AndHigher    stroke.c    hypertension_stage1AndHigher unadjusted 1.25 1.13  1.39        1312    34683.26                      37.83              41500
stroke.c_adjusted_hypertension_stage1AndHigher      stroke.c    hypertension_stage1AndHigher   adjusted 1.25 1.12  1.38        1312    34683.26                      37.83              41500
stroke.c_unadjusted_hypertension_stage2AndHigher    stroke.c    hypertension_stage2AndHigher unadjusted 1.32 1.01  1.73         121     3102.68                      39.00               3740
stroke.c_adjusted_hypertension_stage2AndHigher      stroke.c    hypertension_stage2AndHigher   adjusted 1.35 1.02  1.78         121     3102.68                      39.00               3740
stroke.c_unadjusted_carehome_preIndexDate           stroke.c           carehome_preIndexDate unadjusted 1.22 0.90  1.66         104     2097.61                      49.58               3026
stroke.c_adjusted_carehome_preIndexDate             stroke.c           carehome_preIndexDate   adjusted 1.34 0.98  1.85         104     2097.61                      49.58               3026
stroke.c_unadjusted_HES&ONS_stroke                  stroke.c                  HES&ONS_stroke unadjusted 1.24 1.15  1.32        3917   100878.19                      38.83             122911
stroke.c_adjusted_HES&ONS_stroke                    stroke.c                  HES&ONS_stroke   adjusted 1.25 1.16  1.34        3917   100878.19                      38.83             122911
stroke.c_unadjusted_ischaemicstroke                 stroke.c                 ischaemicstroke unadjusted 1.27 1.15  1.40        1580     7428.72                     212.69               9990
stroke.c_adjusted_ischaemicstroke                   stroke.c                 ischaemicstroke   adjusted 1.17 1.06  1.30        1580     7428.72                     212.69               9990
stroke.c_unadjusted_haemorrhagicstroke              stroke.c              haemorrhagicstroke unadjusted 1.62 0.92  2.86          25      169.20                     147.76                231
stroke.c_adjusted_haemorrhagicstroke                stroke.c              haemorrhagicstroke   adjusted 1.71 0.92  3.19          25      169.20                     147.76                231
stroke.c_unadjusted_12weeksFollowUp                 stroke.c                 12weeksFollowUp unadjusted 1.65 1.47  1.85        1307          NA                         NA             122911
stroke.c_adjusted_12weeksFollowUp                   stroke.c                 12weeksFollowUp   adjusted 1.70 1.52  1.91        1307          NA                         NA             122911
```


**Unadjusted formula**
```
m.fail.marg <- coxph(Surv(stime, fail) ~ risperidone,
                       data = data,x=T,y=T, robust =T, weights = weights, cluster = subclass)
```

**Adjusted formula**

```
m.fail.cond <- coxph(Surv(stime, fail) ~ risperidone + sex + age_risperidone + ethnicity + pre_index_date_stroke + pre_index_date_qof_diabetes + pre_index_date_haem_cancer + pre_index_date_ihd + pre_index_date_af + pre_index_date_myocardialinfarction + pre_index_date_heartfailure + pre_index_date_hypertension,
                        data = data,x=T,y=T, robust =T, weights = weights, cluster = subclass)
```

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



***12 weeks***
```
                                                             scenario              outcome      model        hr      ci.l     ci.u
stroke.pc_12weeks_unadjusted_all                                  all            stroke.pc unadjusted 1.3135815 1.1409241 1.512367
stroke.pc_12weeks_adjusted_all                                    all            stroke.pc   adjusted 1.3185788 1.1429141 1.521243
stroke.hes_12weeks_unadjusted_all                                 all           stroke.hes unadjusted 1.3152429 1.1301374 1.530667
stroke.hes_12weeks_adjusted_all                                   all           stroke.hes   adjusted 1.3439445 1.1538468 1.565361
stroke.c_12weeks_unadjusted_all                                   all             stroke.c unadjusted 1.3562112 1.2167700 1.511632
stroke.c_12weeks_adjusted_all                                     all             stroke.c   adjusted 1.3743219 1.2307120 1.534689
death_12weeks_unadjusted_all                                      all                death unadjusted 1.5827430 1.5000369 1.670009
death_12weeks_adjusted_all                                        all                death   adjusted 1.6459693 1.5589843 1.737808
cvd_12weeks_unadjusted_all                                        all                  cvd unadjusted 1.1316388 1.0592270 1.209001
cvd_12weeks_adjusted_all                                          all                  cvd   adjusted 1.1320986 1.0582770 1.211070
tia_12weeks_unadjusted_all                                        all                  tia unadjusted 1.2574972 1.0538692 1.500470
tia_12weeks_adjusted_all                                          all                  tia   adjusted 1.2330424 1.0322568 1.472883
heartfailure_12weeks_unadjusted_all                               all         heartfailure unadjusted 1.1023533 0.9649302 1.259348
heartfailure_12weeks_adjusted_all                                 all         heartfailure   adjusted 1.0995990 0.9616738 1.257306
myocardialinfarction_12weeks_unadjusted_all                       all myocardialinfarction unadjusted 1.0266141 0.8087568 1.303156
myocardialinfarction_12weeks_adjusted_all                         all myocardialinfarction   adjusted 1.0378019 0.8174034 1.317627
angina_12weeks_unadjusted_all                                     all               angina unadjusted 1.0440593 0.8461399 1.288274
angina_12weeks_adjusted_all                                       all               angina   adjusted 1.0574100 0.8565964 1.305301
pad_12weeks_unadjusted_all                                        all                  pad unadjusted 1.1991741 1.0037832 1.432599
pad_12weeks_adjusted_all                                          all                  pad   adjusted 1.1910173 0.9948526 1.425862
falls_12weeks_unadjusted_all                                      all                falls unadjusted 1.5653055 1.4894721 1.645000
falls_12weeks_adjusted_all                                        all                falls   adjusted 1.5400906 1.4649787 1.619054
lowerlimbfracture_12weeks_unadjusted_all                          all    lowerlimbfracture unadjusted 1.5286171 1.3428492 1.740084
lowerlimbfracture_12weeks_adjusted_all                            all    lowerlimbfracture   adjusted 1.5502267 1.3602834 1.766693
stroke.pc_12weeks_unadjusted_no_stroke                      no_stroke            stroke.pc unadjusted 1.5977324 1.2762373 2.000215
stroke.pc_12weeks_adjusted_no_stroke                        no_stroke            stroke.pc   adjusted 1.6052148 1.2795896 2.013704
stroke.hes_12weeks_unadjusted_no_stroke                     no_stroke           stroke.hes unadjusted 1.3162923 1.0579375 1.637739
stroke.hes_12weeks_adjusted_no_stroke                       no_stroke           stroke.hes   adjusted 1.3567707 1.0902269 1.688480
stroke.c_12weeks_unadjusted_no_stroke                       no_stroke             stroke.c unadjusted 1.5042515 1.2668363 1.786160
stroke.c_12weeks_adjusted_no_stroke                         no_stroke             stroke.c   adjusted 1.5283773 1.2859280 1.816538
death_12weeks_unadjusted_no_stroke                          no_stroke                death unadjusted 1.5764876 1.4855588 1.672982
death_12weeks_adjusted_no_stroke                            no_stroke                death   adjusted 1.6417568 1.5458758 1.743585
cvd_12weeks_unadjusted_no_stroke                            no_stroke                  cvd unadjusted 1.1395119 1.0555478 1.230155
cvd_12weeks_adjusted_no_stroke                              no_stroke                  cvd   adjusted 1.1321847 1.0468186 1.224512
tia_12weeks_unadjusted_no_stroke                            no_stroke                  tia unadjusted 1.2743956 1.0428386 1.557368
tia_12weeks_adjusted_no_stroke                              no_stroke                  tia   adjusted 1.2275358 1.0025949 1.502944
heartfailure_12weeks_unadjusted_no_stroke                   no_stroke         heartfailure unadjusted 1.1532188 0.9977916 1.332857
heartfailure_12weeks_adjusted_no_stroke                     no_stroke         heartfailure   adjusted 1.1322116 0.9783817 1.310228
myocardialinfarction_12weeks_unadjusted_no_stroke           no_stroke myocardialinfarction unadjusted 1.0150255 0.7829369 1.315913
myocardialinfarction_12weeks_adjusted_no_stroke             no_stroke myocardialinfarction   adjusted 1.0322484 0.7959775 1.338652
angina_12weeks_unadjusted_no_stroke                         no_stroke               angina unadjusted 1.0400145 0.8289209 1.304865
angina_12weeks_adjusted_no_stroke                           no_stroke               angina   adjusted 1.0501175 0.8368467 1.317740
pad_12weeks_unadjusted_no_stroke                            no_stroke                  pad unadjusted 1.1929662 0.9807571 1.451092
pad_12weeks_adjusted_no_stroke                              no_stroke                  pad   adjusted 1.1795250 0.9669662 1.438809
falls_12weeks_unadjusted_no_stroke                          no_stroke                falls unadjusted 1.5684103 1.4860689 1.655314
falls_12weeks_adjusted_no_stroke                            no_stroke                falls   adjusted 1.5424030 1.4608874 1.628467
lowerlimbfracture_12weeks_unadjusted_no_stroke              no_stroke    lowerlimbfracture unadjusted 1.5716463 1.3685213 1.804920
lowerlimbfracture_12weeks_adjusted_no_stroke                no_stroke    lowerlimbfracture   adjusted 1.5922556 1.3845935 1.831063
stroke.pc_12weeks_unadjusted_with_stroke                  with_stroke            stroke.pc unadjusted 1.1785054 0.9817486 1.414695
stroke.pc_12weeks_adjusted_with_stroke                    with_stroke            stroke.pc   adjusted 1.1786971 0.9803473 1.417178
stroke.hes_12weeks_unadjusted_with_stroke                 with_stroke           stroke.hes unadjusted 1.3158429 1.0637988 1.627603
stroke.hes_12weeks_adjusted_with_stroke                   with_stroke           stroke.hes   adjusted 1.3216347 1.0685050 1.634731
stroke.c_12weeks_unadjusted_with_stroke                   with_stroke             stroke.c unadjusted 1.2774790 1.1074399 1.473626
stroke.c_12weeks_adjusted_with_stroke                     with_stroke             stroke.c   adjusted 1.2841464 1.1124320 1.482367
death_12weeks_unadjusted_with_stroke                      with_stroke                death unadjusted 1.6099111 1.4197964 1.825483
death_12weeks_adjusted_with_stroke                        with_stroke                death   adjusted 1.6638536 1.4659735 1.888444
cvd_12weeks_unadjusted_with_stroke                        with_stroke                  cvd unadjusted 1.1116334 0.9735665 1.269280
cvd_12weeks_adjusted_with_stroke                          with_stroke                  cvd   adjusted 1.1253510 0.9855082 1.285037
tia_12weeks_unadjusted_with_stroke                        with_stroke                  tia unadjusted 1.2043384 0.8297224 1.748092
tia_12weeks_adjusted_with_stroke                          with_stroke                  tia   adjusted 1.2572315 0.8693155 1.818248
heartfailure_12weeks_unadjusted_with_stroke               with_stroke         heartfailure unadjusted 0.8918440 0.6367516 1.249130
heartfailure_12weeks_adjusted_with_stroke                 with_stroke         heartfailure   adjusted 0.9356064 0.6668475 1.312683
myocardialinfarction_12weeks_unadjusted_with_stroke       with_stroke myocardialinfarction unadjusted 1.0929110 0.5965451 2.002287
myocardialinfarction_12weeks_adjusted_with_stroke         with_stroke myocardialinfarction   adjusted 1.0366210 0.5690404 1.888413
angina_12weeks_unadjusted_with_stroke                     with_stroke               angina unadjusted 1.0695257 0.6120810 1.868846
angina_12weeks_adjusted_with_stroke                       with_stroke               angina   adjusted 1.0769560 0.6195505 1.872058
pad_12weeks_unadjusted_with_stroke                        with_stroke                  pad unadjusted 1.2273998 0.8029132 1.876305
pad_12weeks_adjusted_with_stroke                          with_stroke                  pad   adjusted 1.2369323 0.8087753 1.891751
falls_12weeks_unadjusted_with_stroke                      with_stroke                falls unadjusted 1.5493153 1.3641378 1.759630
falls_12weeks_adjusted_with_stroke                        with_stroke                falls   adjusted 1.5316482 1.3470582 1.741533
lowerlimbfracture_12weeks_unadjusted_with_stroke          with_stroke    lowerlimbfracture unadjusted 1.2670325 0.8749859 1.834740
lowerlimbfracture_12weeks_adjusted_with_stroke            with_stroke    lowerlimbfracture   adjusted 1.2887882 0.8888444 1.868690
stroke.pc_12weeks_unadjusted_over_75                          over_75            stroke.pc unadjusted 1.2482257 1.0751529 1.449159
stroke.pc_12weeks_adjusted_over_75                            over_75            stroke.pc   adjusted 1.2461971 1.0711152 1.449898
stroke.hes_12weeks_unadjusted_over_75                         over_75           stroke.hes unadjusted 1.3296332 1.1341487 1.558812
stroke.hes_12weeks_adjusted_over_75                           over_75           stroke.hes   adjusted 1.3581237 1.1573941 1.593666
stroke.c_12weeks_unadjusted_over_75                           over_75             stroke.c unadjusted 1.3272515 1.1839861 1.487852
stroke.c_12weeks_adjusted_over_75                             over_75             stroke.c   adjusted 1.3401703 1.1933030 1.505113
death_12weeks_unadjusted_over_75                              over_75                death unadjusted 1.5828972 1.4979770 1.672632
death_12weeks_adjusted_over_75                                over_75                death   adjusted 1.6496834 1.5603138 1.744172
cvd_12weeks_unadjusted_over_75                                over_75                  cvd unadjusted 1.1226854 1.0474618 1.203311
cvd_12weeks_adjusted_over_75                                  over_75                  cvd   adjusted 1.1191093 1.0427841 1.201021
tia_12weeks_unadjusted_over_75                                over_75                  tia unadjusted 1.2848076 1.0701489 1.542524
tia_12weeks_adjusted_over_75                                  over_75                  tia   adjusted 1.2560439 1.0449410 1.509795
heartfailure_12weeks_unadjusted_over_75                       over_75         heartfailure unadjusted 1.0787563 0.9390021 1.239311
heartfailure_12weeks_adjusted_over_75                         over_75         heartfailure   adjusted 1.0749122 0.9348020 1.236022
myocardialinfarction_12weeks_unadjusted_over_75               over_75 myocardialinfarction unadjusted 1.0430698 0.8134969 1.337429
myocardialinfarction_12weeks_adjusted_over_75                 over_75 myocardialinfarction   adjusted 1.0535823 0.8216400 1.351000
angina_12weeks_unadjusted_over_75                             over_75               angina unadjusted 1.0632864 0.8517170 1.327410
angina_12weeks_adjusted_over_75                               over_75               angina   adjusted 1.0625209 0.8505924 1.327252
pad_12weeks_unadjusted_over_75                                over_75                  pad unadjusted 1.2040764 0.9991699 1.451005
pad_12weeks_adjusted_over_75                                  over_75                  pad   adjusted 1.1930629 0.9875704 1.441314
falls_12weeks_unadjusted_over_75                              over_75                falls unadjusted 1.5567178 1.4785220 1.639049
falls_12weeks_adjusted_over_75                                over_75                falls   adjusted 1.5297373 1.4524031 1.611189
lowerlimbfracture_12weeks_unadjusted_over_75                  over_75    lowerlimbfracture unadjusted 1.5115534 1.3210162 1.729573
lowerlimbfracture_12weeks_adjusted_over_75                    over_75    lowerlimbfracture   adjusted 1.5411724 1.3454918 1.765312
stroke.pc_12weeks_unadjusted_under_75                        under_75            stroke.pc unadjusted 2.0154861 1.2849344 3.161394
stroke.pc_12weeks_adjusted_under_75                          under_75            stroke.pc   adjusted 2.1402941 1.3883653 3.299462
stroke.hes_12weeks_unadjusted_under_75                       under_75           stroke.hes unadjusted 1.1905952 0.7196754 1.969661
stroke.hes_12weeks_adjusted_under_75                         under_75           stroke.hes   adjusted 1.2655115 0.7508702 2.132885
stroke.c_12weeks_unadjusted_under_75                         under_75             stroke.c unadjusted 1.6429950 1.1566580 2.333821
stroke.c_12weeks_adjusted_under_75                           under_75             stroke.c   adjusted 1.7633076 1.2368490 2.513851
death_12weeks_unadjusted_under_75                            under_75                death unadjusted 1.5997974 1.2591652 2.032578
death_12weeks_adjusted_under_75                              under_75                death   adjusted 1.5788979 1.2379255 2.013787
cvd_12weeks_unadjusted_under_75                              under_75                  cvd unadjusted 1.2296999 0.9865992 1.532701
cvd_12weeks_adjusted_under_75                                under_75                  cvd   adjusted 1.2481630 0.9954162 1.565085
tia_12weeks_unadjusted_under_75                              under_75                  tia unadjusted 0.9857591 0.5019733 1.935802
tia_12weeks_adjusted_under_75                                under_75                  tia   adjusted 1.0010454 0.5129444 1.953607
heartfailure_12weeks_unadjusted_under_75                     under_75         heartfailure unadjusted 1.4671140 0.9108847 2.363003
heartfailure_12weeks_adjusted_under_75                       under_75         heartfailure   adjusted 1.5934284 0.9833564 2.581988
myocardialinfarction_12weeks_unadjusted_under_75             under_75 myocardialinfarction unadjusted 0.8786749 0.3807779 2.027611
myocardialinfarction_12weeks_adjusted_under_75               under_75 myocardialinfarction   adjusted 0.9005127 0.3881980 2.088942
angina_12weeks_unadjusted_under_75                           under_75               angina unadjusted 0.8893060 0.4601170 1.718835
angina_12weeks_adjusted_under_75                             under_75               angina   adjusted 0.9507123 0.4903097 1.843435
pad_12weeks_unadjusted_under_75                              under_75                  pad unadjusted 1.1560999 0.6411406 2.084671
pad_12weeks_adjusted_under_75                                under_75                  pad   adjusted 1.1995277 0.6618597 2.173975
falls_12weeks_unadjusted_under_75                            under_75                falls unadjusted 1.6973182 1.4068950 2.047693
falls_12weeks_adjusted_under_75                              under_75                falls   adjusted 1.6800433 1.3918874 2.027855
lowerlimbfracture_12weeks_unadjusted_under_75                under_75    lowerlimbfracture unadjusted 1.7607759 1.0941772 2.833482
lowerlimbfracture_12weeks_adjusted_under_75                  under_75    lowerlimbfracture   adjusted 1.6897150 1.0379312 2.750796
stroke.pc_12weeks_unadjusted_no_other_drugs            no_other_drugs            stroke.pc unadjusted 1.5424927 1.2483054 1.906011
stroke.pc_12weeks_adjusted_no_other_drugs              no_other_drugs            stroke.pc   adjusted 1.5399080 1.2399472 1.912434
stroke.hes_12weeks_unadjusted_no_other_drugs           no_other_drugs           stroke.hes unadjusted 1.4048540 1.1163937 1.767848
stroke.hes_12weeks_adjusted_no_other_drugs             no_other_drugs           stroke.hes   adjusted 1.4237408 1.1292532 1.795025
stroke.c_12weeks_unadjusted_no_other_drugs             no_other_drugs             stroke.c unadjusted 1.5414808 1.3078955 1.816784
stroke.c_12weeks_adjusted_no_other_drugs               no_other_drugs             stroke.c   adjusted 1.5508413 1.3103093 1.835528
death_12weeks_unadjusted_no_other_drugs                no_other_drugs                death unadjusted 1.6393958 1.5116193 1.777973
death_12weeks_adjusted_no_other_drugs                  no_other_drugs                death   adjusted 1.7087422 1.5739006 1.855136
cvd_12weeks_unadjusted_no_other_drugs                  no_other_drugs                  cvd unadjusted 1.1580761 1.0430009 1.285847
cvd_12weeks_adjusted_no_other_drugs                    no_other_drugs                  cvd   adjusted 1.1460047 1.0303264 1.274671
tia_12weeks_unadjusted_no_other_drugs                  no_other_drugs                  tia unadjusted 1.2503771 0.9445384 1.655245
tia_12weeks_adjusted_no_other_drugs                    no_other_drugs                  tia   adjusted 1.2410780 0.9378529 1.642341
heartfailure_12weeks_unadjusted_no_other_drugs         no_other_drugs         heartfailure unadjusted 0.9888448 0.7952458 1.229575
heartfailure_12weeks_adjusted_no_other_drugs           no_other_drugs         heartfailure   adjusted 0.9304984 0.7491862 1.155691
myocardialinfarction_12weeks_unadjusted_no_other_drugs no_other_drugs myocardialinfarction unadjusted 1.1683156 0.7901613 1.727446
myocardialinfarction_12weeks_adjusted_no_other_drugs   no_other_drugs myocardialinfarction   adjusted 1.1648367 0.7871455 1.723753
angina_12weeks_unadjusted_no_other_drugs               no_other_drugs               angina unadjusted 1.1897104 0.8602046 1.645435
angina_12weeks_adjusted_no_other_drugs                 no_other_drugs               angina   adjusted 1.1930074 0.8625429 1.650082
pad_12weeks_unadjusted_no_other_drugs                  no_other_drugs                  pad unadjusted 1.1534879 0.8659022 1.536587
pad_12weeks_adjusted_no_other_drugs                    no_other_drugs                  pad   adjusted 1.1628402 0.8719206 1.550826
falls_12weeks_unadjusted_no_other_drugs                no_other_drugs                falls unadjusted 1.5477557 1.4355126 1.668775
falls_12weeks_adjusted_no_other_drugs                  no_other_drugs                falls   adjusted 1.5144462 1.4036437 1.633995
lowerlimbfracture_12weeks_unadjusted_no_other_drugs    no_other_drugs    lowerlimbfracture unadjusted 1.6093893 1.3281575 1.950171
lowerlimbfracture_12weeks_adjusted_no_other_drugs      no_other_drugs    lowerlimbfracture   adjusted 1.5869202 1.3078273 1.925572

```

***CVD vs no CVD***

```
                                               subgroup              outcome      model        hr      ci.l     ci.u
stroke.pc_12weeks_unadjusted_CVD                    CVD            stroke.pc unadjusted 1.2372468 1.0525332 1.454377
stroke.pc_12weeks_adjusted_CVD                      CVD            stroke.pc   adjusted 1.2333453 1.0467121 1.453256
stroke.hes_12weeks_unadjusted_CVD                   CVD           stroke.hes unadjusted 1.3027190 1.0846446 1.564639
stroke.hes_12weeks_adjusted_CVD                     CVD           stroke.hes   adjusted 1.3178525 1.0962351 1.584273
stroke.c_12weeks_unadjusted_CVD                     CVD             stroke.c unadjusted 1.3129840 1.1577030 1.489093
stroke.c_12weeks_adjusted_CVD                       CVD             stroke.c   adjusted 1.3212714 1.1624709 1.501765
death_12weeks_unadjusted_CVD                        CVD                death unadjusted 1.6426810 1.5245167 1.770004
death_12weeks_adjusted_CVD                          CVD                death   adjusted 1.6640894 1.5434332 1.794178
cvd_12weeks_unadjusted_CVD                          CVD                  cvd unadjusted 1.0807992 1.0036440 1.163886
cvd_12weeks_adjusted_CVD                            CVD                  cvd   adjusted 1.0841246 1.0066873 1.167519
tia_12weeks_unadjusted_CVD                          CVD                  tia unadjusted 1.0873888 0.8822027 1.340298
tia_12weeks_adjusted_CVD                            CVD                  tia   adjusted 1.1001101 0.8934954 1.354503
heartfailure_12weeks_unadjusted_CVD                 CVD         heartfailure unadjusted 1.0711230 0.9274204 1.237092
heartfailure_12weeks_adjusted_CVD                   CVD         heartfailure   adjusted 1.0702226 0.9264102 1.236360
myocardialinfarction_12weeks_unadjusted_CVD         CVD myocardialinfarction unadjusted 1.0752153 0.8334956 1.387036
myocardialinfarction_12weeks_adjusted_CVD           CVD myocardialinfarction   adjusted 1.0898348 0.8449267 1.405731
angina_12weeks_unadjusted_CVD                       CVD               angina unadjusted 1.0402290 0.8383624 1.290702
angina_12weeks_adjusted_CVD                         CVD               angina   adjusted 1.0508882 0.8470250 1.303818
pad_12weeks_unadjusted_CVD                          CVD                  pad unadjusted 1.2252362 0.9970344 1.505669
pad_12weeks_adjusted_CVD                            CVD                  pad   adjusted 1.2268304 0.9973167 1.509162
falls_12weeks_unadjusted_CVD                        CVD                falls unadjusted 1.5694019 1.4596227 1.687438
falls_12weeks_adjusted_CVD                          CVD                falls   adjusted 1.5641032 1.4542053 1.682306
lowerlimbfracture_12weeks_unadjusted_CVD            CVD    lowerlimbfracture unadjusted 1.4551100 1.1873502 1.783252
lowerlimbfracture_12weeks_adjusted_CVD              CVD    lowerlimbfracture   adjusted 1.4846819 1.2106012 1.820815
stroke.pc_12weeks_unadjusted_No_CVD              No_CVD            stroke.pc unadjusted 1.6311130 1.2186980 2.183092
stroke.pc_12weeks_adjusted_No_CVD                No_CVD            stroke.pc   adjusted 1.6504605 1.2316553 2.211674
stroke.hes_12weeks_unadjusted_No_CVD             No_CVD           stroke.hes unadjusted 1.3539599 1.0320980 1.776195
stroke.hes_12weeks_adjusted_No_CVD               No_CVD           stroke.hes   adjusted 1.4078945 1.0717706 1.849432
stroke.c_12weeks_unadjusted_No_CVD               No_CVD             stroke.c unadjusted 1.5132813 1.2176964 1.880617
stroke.c_12weeks_adjusted_No_CVD                 No_CVD             stroke.c   adjusted 1.5585118 1.2522035 1.939748
death_12weeks_unadjusted_No_CVD                  No_CVD                death unadjusted 1.5258038 1.4120750 1.648692
death_12weeks_adjusted_No_CVD                    No_CVD                death   adjusted 1.6262317 1.5033589 1.759147
cvd_12weeks_unadjusted_No_CVD                    No_CVD                  cvd unadjusted 1.4663031 1.2507362 1.719024
cvd_12weeks_adjusted_No_CVD                      No_CVD                  cvd   adjusted 1.4140587 1.2034586 1.661513
tia_12weeks_unadjusted_No_CVD                    No_CVD                  tia unadjusted 1.9580698 1.3972654 2.743958
tia_12weeks_adjusted_No_CVD                      No_CVD                  tia   adjusted 1.7684213 1.2519502 2.497954
heartfailure_12weeks_unadjusted_No_CVD           No_CVD         heartfailure unadjusted 1.3840430 0.9657800 1.983448
heartfailure_12weeks_adjusted_No_CVD             No_CVD         heartfailure   adjusted 1.3311556 0.9260820 1.913411
myocardialinfarction_12weeks_unadjusted_No_CVD   No_CVD myocardialinfarction unadjusted 0.7707645 0.3829654 1.551257
myocardialinfarction_12weeks_adjusted_No_CVD     No_CVD myocardialinfarction   adjusted 0.7354700 0.3667068 1.475064
angina_12weeks_unadjusted_No_CVD                 No_CVD               angina unadjusted 1.2847297 0.4825714 3.420282
angina_12weeks_adjusted_No_CVD                   No_CVD               angina   adjusted 1.1873876 0.4560954 3.091216
pad_12weeks_unadjusted_No_CVD                    No_CVD                  pad unadjusted 1.1395662 0.7999361 1.623394
pad_12weeks_adjusted_No_CVD                      No_CVD                  pad   adjusted 1.1107609 0.7706980 1.600873
falls_12weeks_unadjusted_No_CVD                  No_CVD                falls unadjusted 1.5646751 1.4614760 1.675161
falls_12weeks_adjusted_No_CVD                    No_CVD                falls   adjusted 1.5205569 1.4194562 1.628858
lowerlimbfracture_12weeks_unadjusted_No_CVD      No_CVD    lowerlimbfracture unadjusted 1.5836801 1.3386020 1.873628
lowerlimbfracture_12weeks_adjusted_No_CVD        No_CVD    lowerlimbfracture   adjusted 1.5943900 1.3449402 1.890106
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
