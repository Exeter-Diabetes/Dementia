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









**Flow chart of the final cohorts**


![image](https://github.com/user-attachments/assets/76932b69-b718-4782-9a51-ec93a3996875)





![image](https://github.com/user-attachments/assets/38bb5d80-9991-42bc-9607-324f03c46e0d)


![image](https://github.com/user-attachments/assets/67487ba4-0da0-443c-ab98-7b3cf18f637d)


![image](https://github.com/user-attachments/assets/43dd35a4-05ae-416c-a0d9-a0ee567b839c)

![image](https://github.com/user-attachments/assets/fd2ea23d-d1c8-488c-85b9-033141927965)

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
                                                             Overall       
  n                                                        30060        
  diagnosedbeforeRegistration = 1 (%)                      17005 (56.6) 
  died = 1 (%)                                             17390 (57.9) 
  death_composite = 1 (%)                                  23726 (78.9) 
  ONS_died = 1 (%)                                         20695 (68.8) 
  age_diagnosis (mean (SD))                                80.44 (7.13) 
  age_risperidone (mean (SD))                              82.99 (6.87) 
  deprivation (%)                                                       
     1                                                      6726 (22.4) 
     2                                                      7388 (24.6) 
     3                                                      6070 (20.2) 
     4                                                      5181 (17.3) 
     5                                                      4657 (15.5) 
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
  Stroke__within_year_after_1st_risperidone_presc = 1 (%)   1094 ( 3.6) 
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













****Matchit algorithm****
```
                                              Stratified by risperidone
                                               0              1              p      test SMD   
  n                                            136624         28403                            
  sex = 1 (%)                                   51553 (37.7)  10804 ( 38.0)   0.339       0.006
  risperidone = 1 (%)                               0 ( 0.0)  28403 (100.0)  <0.001         NaN
  age_risperidone (mean (SD))                   83.24 (6.81)  83.14 (6.83)    0.021       0.015
  age_risperidone_cat (%)                                                     0.100       0.014
     65 - 74                                    15050 (11.0)   3250 ( 11.4)                    
     75 - 84                                    61688 (45.2)  12807 ( 45.1)                    
     85+                                        59886 (43.8)  12346 ( 43.5)                    
  death_composite = 1 (%)                       93401 (68.4)  22269 ( 78.4)  <0.001       0.229
  ethnicity (%)                                                               0.488       0.014
     Black                                       2519 ( 1.8)    486 (  1.7)                    
     Mixed                                        485 ( 0.4)    103 (  0.4)                    
     Other                                        761 ( 0.6)    155 (  0.5)                    
     South Asian                                 2453 ( 1.8)    476 (  1.7)                    
     Unknown                                     2190 ( 1.6)    453 (  1.6)                    
     White                                     128216 (93.8)  26730 ( 94.1)                    
  care_home_before_indexdate = 1 (%)            18141 (13.3)   3753 ( 13.2)   0.777       0.002
  deprivation (%)                                                             0.736       0.011
     1                                          30503 (22.3)   6381 ( 22.5)                    
     2                                          33667 (24.6)   6931 ( 24.4)                    
     3                                          27057 (19.8)   5721 ( 20.1)                    
     4                                          23891 (17.5)   4906 ( 17.3)                    
     5                                          21371 (15.6)   4437 ( 15.6)                    
     Unknown                                      135 ( 0.1)     27 (  0.1)                    
  stroke_composite_pre_index_date = 1 (%)       18500 (13.5)   3941 ( 13.9)   0.137       0.010
  pre_index_date_angina = 1 (%)                 15903 (11.6)   3321 ( 11.7)   0.810       0.002
  pre_index_date_heartfailure = 1 (%)           10570 ( 7.7)   2194 (  7.7)   0.955      <0.001
  BMI (%)                                                                     0.045       0.022
     Missing                                    25163 (18.4)   5456 ( 19.2)                    
     Normal                                     53097 (38.9)  11013 ( 38.8)                    
     Obesity                                    14388 (10.5)   2979 ( 10.5)                    
     Overweight                                 35229 (25.8)   7168 ( 25.2)                    
     Severely Obese                               953 ( 0.7)    190 (  0.7)                    
     Underweight                                 7794 ( 5.7)   1597 (  5.6)                    
  Prescribed_other_antipsychotic_Prior = 1 (%)  37008 (27.1)   7377 ( 26.0)  <0.001       0.025
  period_before_prescription (mean (SD))         2.75 (2.17)   2.62 (2.41)   <0.001       0.055
  pre_index_date_myocardialinfarction = 1 (%)   10815 ( 7.9)   2309 (  8.1)   0.231       0.008
  pre_index_date_tia = 1 (%)                    12972 ( 9.5)   2643 (  9.3)   0.327       0.006
  pre_index_date_falls = 1 (%)                  57162 (41.8)  11780 ( 41.5)   0.260       0.007
  pre_index_date_lowerlimbfracture = 1 (%)      22013 (16.1)   4550 ( 16.0)   0.706       0.003
  pre_index_date_ihd = 1 (%)                    22348 (16.4)   4694 ( 16.5)   0.489       0.005
  pre_index_date_pad = 1 (%)                    10299 ( 7.5)   2208 (  7.8)   0.176       0.009
  pre_index_date_af = 1 (%)                     21775 (15.9)   4560 ( 16.1)   0.631       0.003
  pre_index_date_revasc = 1 (%)                  7205 ( 5.3)   1513 (  5.3)   0.726       0.002
  pre_index_date_qof_diabetes = 1 (%)           23786 (17.4)   4959 ( 17.5)   0.848       0.001
  pre_index_date_anxiety_disorders = 1 (%)      27099 (19.8)   5633 ( 19.8)   0.999      <0.001
  pre_index_date_fh_diabetes = 1 (%)            28299 (20.7)   5828 ( 20.5)   0.467       0.005
  pre_index_date_fh_premature_cvd = 1 (%)       10993 ( 8.0)   2231 (  7.9)   0.285       0.007
  pre_index_date_pulmonary_embolism = 1 (%)      3608 ( 2.6)    727 (  2.6)   0.448       0.005
  pre_index_date_deep_vein_thrombosis = 1 (%)    7141 ( 5.2)   1470 (  5.2)   0.735       0.002
  pre_index_date_hearing_loss = 1 (%)           36785 (26.9)   7640 ( 26.9)   0.935       0.001
  pre_index_date_VTE = 1 (%)                     9870 ( 7.2)   2022 (  7.1)   0.541       0.004
  pre_index_date_haem_cancer = 1 (%)             2698 ( 2.0)    542 (  1.9)   0.477       0.005
  pre_index_date_solid_cancer = 1 (%)           21819 (16.0)   4512 ( 15.9)   0.730       0.002
  pre_index_date_cvd = 1 (%)                    55886 (40.9)  11686 ( 41.1)   0.461       0.005
  comorbidity_hypertension (%)                                               <0.001       0.037
     Elevated                                   24078 (17.6)   4960 ( 17.5)                    
     Normal                                     34906 (25.5)   7187 ( 25.3)                    
     Stage 1                                    53537 (39.2)  11171 ( 39.3)                    
     Stage 2                                    22459 (16.4)   4629 ( 16.3)                    
     Stage 3 (severe)                             185 ( 0.1)     38 (  0.1)                    
     Unknown                                     1459 ( 1.1)    418 (  1.5)                    
  totalcholesterol (%)                                                        0.095       0.020
     (< 160 mg/dl)                              37926 (27.8)   7818 ( 27.5)                    
     (> 280 mg/dl)                               3263 ( 2.4)    667 (  2.3)                    
     (199 mg/dl)                                34681 (25.4)   7163 ( 25.2)                    
     (200 - 239 mg/dl)                          25160 (18.4)   5176 ( 18.2)                    
     (240 - 279 mg/dl)                           9427 ( 6.9)   1919 (  6.8)                    
     Unknown                                    26167 (19.2)   5660 ( 19.9)                    
  smoking_cat (%)                                                             0.073       0.017
     Active smoker                               9759 ( 7.1)   2026 (  7.1)                    
     Ex-smoker                                  53462 (39.1)  11037 ( 38.9)                    
     Missing                                    33017 (24.2)   7068 ( 24.9)                    
     Non-smoker                                 40386 (29.6)   8272 ( 29.1)                    
  alcohol_cat (%)                                                             0.203       0.016
     Excess                                      6994 ( 5.1)   1443 (  5.1)                    
     Harmful                                     3733 ( 2.7)    760 (  2.7)                    
     Missing                                    43410 (31.8)   9231 ( 32.5)                    
     None                                       10556 ( 7.7)   2190 (  7.7)                    
     Within limits                              71931 (52.6)  14779 ( 52.0)   

```







***One year follow-up results***
```
                                                                             subgroup    outcome             Group N_total N_events Person_years_at_risk Incidence_rate_per_1000_PY Adjusted_HR_with_CI    NNH NNH_CI_lower NNH_CI_upper    ARR
Stroke_adjusted_all.1                                                         Overall     Stroke  Matched Controls  137622     4479               112575            39.8 (38.6, 41)    1.31 (1.22, 1.4)  88.07        71.09       115.69 0.0114
Stroke_adjusted_all.2                                                         Overall     Stroke Risperidone Users   28542     1085                20309          53.4 (50.2, 56.6)    1.31 (1.22, 1.4)  88.07        71.09       115.69 0.0114
stroke.hes_adjusted_all.1                                                     Overall stroke.hes  Matched Controls  137622     2410               113374          21.3 (20.4, 22.1)   1.26 (1.14, 1.38) 209.95       148.33       359.17 0.0048
stroke.hes_adjusted_all.2                                                     Overall stroke.hes Risperidone Users   28542      550                20494          26.8 (24.6, 29.1)   1.26 (1.14, 1.38) 209.95       148.33       359.17 0.0048
Stroke_adjusted_no_stroke.1                                         No stroke history     Stroke  Matched Controls  119028     2025                98701          20.5 (19.6, 21.4)   1.42 (1.29, 1.57) 124.91        97.82       172.74 0.0080
Stroke_adjusted_no_stroke.2                                         No stroke history     Stroke Risperidone Users   24599      521                17774          29.3 (26.8, 31.8)   1.42 (1.29, 1.57) 124.91        97.82       172.74 0.0080
stroke.hes_adjusted_no_stroke.1                                     No stroke history stroke.hes  Matched Controls  119028     1279                98881          12.9 (12.2, 13.6)    1.26 (1.1, 1.43) 361.65       225.37       914.90 0.0028
stroke.hes_adjusted_no_stroke.2                                     No stroke history stroke.hes Risperidone Users   24599      286                17826            16 (14.2, 17.9)    1.26 (1.1, 1.43) 361.65       225.37       914.90 0.0028
Stroke_adjusted_with_stroke.1                                          Stroke history     Stroke  Matched Controls   18594     2454                13874       176.9 (169.9, 183.9)   1.22 (1.11, 1.34)  34.00        23.47        61.61 0.0294
Stroke_adjusted_with_stroke.2                                          Stroke history     Stroke Risperidone Users    3943      564                 2535       222.5 (204.1, 240.8)   1.22 (1.11, 1.34)  34.00        23.47        61.61 0.0294
stroke.hes_adjusted_with_stroke.1                                      Stroke history stroke.hes  Matched Controls   18594     1131                14493            78 (73.5, 82.6)    1.25 (1.1, 1.43)  61.96        38.74       154.62 0.0161
stroke.hes_adjusted_with_stroke.2                                      Stroke history stroke.hes Risperidone Users    3943      264                 2669           98.9 (87, 110.9)    1.25 (1.1, 1.43)  61.96        38.74       154.62 0.0161
Stroke_adjusted_CVD.1                                                     CVD history     Stroke  Matched Controls   56188     3278                44305            74 (71.5, 76.5)   1.23 (1.13, 1.33)  65.86        48.47       102.72 0.0152
Stroke_adjusted_CVD.2                                                     CVD history     Stroke Risperidone Users   11722      748                 7901         94.7 (87.9, 101.4)   1.23 (1.13, 1.33)  65.86        48.47       102.72 0.0152
stroke.hes_adjusted_CVD.1                                                 CVD history stroke.hes  Matched Controls   56188     1657                44995          36.8 (35.1, 38.6)   1.22 (1.09, 1.36) 133.34        87.11       284.19 0.0075
stroke.hes_adjusted_CVD.2                                                 CVD history stroke.hes Risperidone Users   11722      370                 8051            46 (41.3, 50.6)   1.22 (1.09, 1.36) 133.34        87.11       284.19 0.0075
Stroke_adjusted_No_CVD.1                                               No CVD history     Stroke  Matched Controls   81434     1201                68270          17.6 (16.6, 18.6)   1.54 (1.36, 1.74) 110.72        86.11       155.02 0.0090
Stroke_adjusted_No_CVD.2                                               No CVD history     Stroke Risperidone Users   16820      337                12407          27.2 (24.3, 30.1)   1.54 (1.36, 1.74) 110.72        86.11       155.02 0.0090
stroke.hes_adjusted_No_CVD.1                                           No CVD history stroke.hes  Matched Controls   81434      753                68380            11 (10.2, 11.8)   1.35 (1.14, 1.59) 321.36       198.98       834.74 0.0031
stroke.hes_adjusted_No_CVD.2                                           No CVD history stroke.hes Risperidone Users   16820      180                12443          14.5 (12.4, 16.6)   1.35 (1.14, 1.59) 321.36       198.98       834.74 0.0031
Stroke_adjusted_HES_stroke.1                                               HES Stroke     Stroke  Matched Controls  137622     4479               112575            39.8 (38.6, 41)    1.31 (1.22, 1.4)  88.07        71.09       115.69 0.0114
Stroke_adjusted_HES_stroke.2                                               HES Stroke     Stroke Risperidone Users   28542     1085                20309          53.4 (50.2, 56.6)    1.31 (1.22, 1.4)  88.07        71.09       115.69 0.0114
stroke.hes_adjusted_HES_stroke.1                                           HES Stroke stroke.hes  Matched Controls  137622     2410               113374          21.3 (20.4, 22.1)   1.26 (1.14, 1.38) 209.95       148.33       359.17 0.0048
stroke.hes_adjusted_HES_stroke.2                                           HES Stroke stroke.hes Risperidone Users   28542      550                20494          26.8 (24.6, 29.1)   1.26 (1.14, 1.38) 209.95       148.33       359.17 0.0048
Stroke_adjusted_PreCovidPeriod_all.1                                Pre-COVID overall     Stroke  Matched Controls  125088     4302               103810          41.4 (40.2, 42.7)   1.27 (1.19, 1.36)  94.46        74.42       129.28 0.0106
Stroke_adjusted_PreCovidPeriod_all.2                                Pre-COVID overall     Stroke Risperidone Users   26382     1038                19119            54.3 (51, 57.6)   1.27 (1.19, 1.36)  94.46        74.42       129.28 0.0106
stroke.hes_adjusted_PreCovidPeriod_all.1                            Pre-COVID overall stroke.hes  Matched Controls  125088     2380               104557          22.8 (21.8, 23.7)   1.23 (1.12, 1.35) 225.02       152.60       428.29 0.0044
stroke.hes_adjusted_PreCovidPeriod_all.2                            Pre-COVID overall stroke.hes Risperidone Users   26382      540                19293            28 (25.6, 30.3)   1.23 (1.12, 1.35) 225.02       152.60       428.29 0.0044
Stroke_adjusted_PreCovidPeriod_no_stroke.1                Pre-COVID No stroke history     Stroke  Matched Controls  108378     1942                91177          21.3 (20.4, 22.2)   1.39 (1.26, 1.54) 131.02       100.42       188.43 0.0076
Stroke_adjusted_PreCovidPeriod_no_stroke.2                Pre-COVID No stroke history     Stroke Risperidone Users   22785      498                16756          29.7 (27.1, 32.3)   1.39 (1.26, 1.54) 131.02       100.42       188.43 0.0076
stroke.hes_adjusted_PreCovidPeriod_no_stroke.1            Pre-COVID No stroke history stroke.hes  Matched Controls  108378     1269                91338          13.9 (13.1, 14.7)   1.22 (1.07, 1.39) 408.71       236.72      1494.62 0.0024
stroke.hes_adjusted_PreCovidPeriod_no_stroke.2            Pre-COVID No stroke history stroke.hes Risperidone Users   22785      280                16804          16.7 (14.7, 18.6)   1.22 (1.07, 1.39) 408.71       236.72      1494.62 0.0024
Stroke_adjusted_PreCovidPeriod_with_stroke.1                 Pre-COVID Stroke history     Stroke  Matched Controls   16710     2360                12633       186.8 (179.3, 194.3)    1.19 (1.08, 1.3)  38.59        25.07        83.85 0.0259
Stroke_adjusted_PreCovidPeriod_with_stroke.2                 Pre-COVID Stroke history     Stroke Risperidone Users    3597      540                 2363       228.5 (209.2, 247.8)    1.19 (1.08, 1.3)  38.59        25.07        83.85 0.0259
stroke.hes_adjusted_PreCovidPeriod_with_stroke.1             Pre-COVID Stroke history stroke.hes  Matched Controls   16710     1111                13219              84 (79.1, 89)   1.24 (1.08, 1.42)  63.78        38.34       189.61 0.0157
stroke.hes_adjusted_PreCovidPeriod_with_stroke.2             Pre-COVID Stroke history stroke.hes Risperidone Users    3597      260                 2489        104.4 (91.7, 117.1)   1.24 (1.08, 1.42)  63.78        38.34       189.61 0.0157
Stroke_adjusted_PreCovidPeriod_no_cvd.1                      Pre-COVID No CVD history     Stroke  Matched Controls   74267     1154                63137          18.3 (17.2, 19.3)   1.51 (1.33, 1.71) 112.21        86.03       161.30 0.0089
Stroke_adjusted_PreCovidPeriod_no_cvd.2                      Pre-COVID No CVD history     Stroke Risperidone Users   15611      324                11710          27.7 (24.7, 30.7)   1.51 (1.33, 1.71) 112.21        86.03       161.30 0.0089
stroke.hes_adjusted_PreCovidPeriod_no_cvd.1                  Pre-COVID No CVD history stroke.hes  Matched Controls   74267      748                63238            11.8 (11, 12.7)     1.3 (1.1, 1.54) 349.02       204.21      1199.89 0.0029
stroke.hes_adjusted_PreCovidPeriod_no_cvd.2                  Pre-COVID No CVD history stroke.hes Risperidone Users   15611      176                11744            15 (12.8, 17.2)     1.3 (1.1, 1.54) 349.02       204.21      1199.89 0.0029
Stroke_adjusted_PreCovidPeriod_with_cvd.1                       Pre-COVID CVD history     Stroke  Matched Controls   50821     3148                40673          77.4 (74.7, 80.1)    1.19 (1.1, 1.29)  74.49        52.16       130.26 0.0134
Stroke_adjusted_PreCovidPeriod_with_cvd.2                       Pre-COVID CVD history     Stroke Risperidone Users   10771      714                 7409         96.4 (89.3, 103.4)    1.19 (1.1, 1.29)  74.49        52.16       130.26 0.0134
stroke.hes_adjusted_PreCovidPeriod_with_cvd.1                   Pre-COVID CVD history stroke.hes  Matched Controls   50821     1632                41319          39.5 (37.6, 41.4)   1.19 (1.07, 1.34) 141.26        88.18       354.99 0.0071
stroke.hes_adjusted_PreCovidPeriod_with_cvd.2                   Pre-COVID CVD history stroke.hes Risperidone Users   10771      364                 7550          48.2 (43.3, 53.2)   1.19 (1.07, 1.34) 141.26        88.18       354.99 0.0071
Stroke_adjusted_risperidone_Age_65_74.1                        Prescription age 65-74     Stroke  Matched Controls   15390      439                13394          32.8 (29.7, 35.8)   1.41 (1.15, 1.72)  66.58        43.98       136.93 0.0150
Stroke_adjusted_risperidone_Age_65_74.2                        Prescription age 65-74     Stroke Risperidone Users    3304      125                 2538          49.3 (40.6, 57.9)   1.41 (1.15, 1.72)  66.58        43.98       136.93 0.0150
stroke.hes_adjusted_risperidone_Age_65_74.1                    Prescription age 65-74 stroke.hes  Matched Controls   15390      267                13488          19.8 (17.4, 22.2)       1.3 (1, 1.71) 136.63        75.41       726.22 0.0073
stroke.hes_adjusted_risperidone_Age_65_74.2                    Prescription age 65-74 stroke.hes Risperidone Users    3304       70                 2563          27.3 (20.9, 33.7)       1.3 (1, 1.71) 136.63        75.41       726.22 0.0073
Stroke_adjusted_risperidone_Age_75_84.1                        Prescription age 75-84     Stroke  Matched Controls   62093     1974                52194          37.8 (36.2, 39.5)    1.3 (1.17, 1.44)  94.03        68.61       149.40 0.0106
Stroke_adjusted_risperidone_Age_75_84.2                        Prescription age 75-84     Stroke Risperidone Users   12858      479                 9424          50.8 (46.3, 55.4)    1.3 (1.17, 1.44)  94.03        68.61       149.40 0.0106
stroke.hes_adjusted_risperidone_Age_75_84.1                    Prescription age 75-84 stroke.hes  Matched Controls   62093     1065                52585            20.3 (19, 21.5)   1.33 (1.16, 1.53) 173.08       114.74       352.06 0.0058
stroke.hes_adjusted_risperidone_Age_75_84.2                    Prescription age 75-84 stroke.hes Risperidone Users   12858      259                 9512          27.2 (23.9, 30.5)   1.33 (1.16, 1.53) 173.08       114.74       352.06 0.0058
Stroke_adjusted_risperidone_Age_85+.1             Prescription age 85 years and above     Stroke  Matched Controls   60139     2066                46987            44 (42.1, 45.9)   1.29 (1.17, 1.43)  89.01        64.52       143.44 0.0112
Stroke_adjusted_risperidone_Age_85+.2             Prescription age 85 years and above     Stroke Risperidone Users   12380      481                 8347          57.6 (52.5, 62.8)   1.29 (1.17, 1.43)  89.01        64.52       143.44 0.0112
stroke.hes_adjusted_risperidone_Age_85+.1         Prescription age 85 years and above stroke.hes  Matched Controls   60139     1078                47301          22.8 (21.4, 24.2)      1.16 (1, 1.34) 342.02       168.86          Inf 0.0029
stroke.hes_adjusted_risperidone_Age_85+.2         Prescription age 85 years and above stroke.hes Risperidone Users   12380      221                 8420          26.2 (22.8, 29.7)      1.16 (1, 1.34) 342.02       168.86          Inf 0.0029
Stroke_adjusted_stroke_recency_1_year.1               Stroke recency less than 1 year     Stroke  Matched Controls     561      172                  354       485.5 (412.9, 558.1)    1.03 (0.8, 1.32) 146.57        14.84          Inf 0.0068
Stroke_adjusted_stroke_recency_1_year.2               Stroke recency less than 1 year     Stroke Risperidone Users     420      123                  228       539.2 (443.9, 634.5)    1.03 (0.8, 1.32) 146.57        14.84          Inf 0.0068
stroke.hes_adjusted_stroke_recency_1_year.1           Stroke recency less than 1 year stroke.hes  Matched Controls     561       41                  425         96.4 (66.9, 125.9)   2.29 (1.52, 3.46)  12.08         7.92        25.42 0.0828
stroke.hes_adjusted_stroke_recency_1_year.2           Stroke recency less than 1 year stroke.hes Risperidone Users     420       56                  262       213.4 (157.5, 269.3)   2.29 (1.52, 3.46)  12.08         7.92        25.42 0.0828
Stroke_adjusted_stroke_recency_1_5_years.1                   Stroke recency 1-5 years     Stroke  Matched Controls    2964      384                 2227       172.4 (155.2, 189.7)   1.23 (1.03, 1.47)  30.73        17.54       124.07 0.0325
Stroke_adjusted_stroke_recency_1_5_years.2                   Stroke recency 1-5 years     Stroke Risperidone Users    1345      192                  885       216.9 (186.2, 247.6)   1.23 (1.03, 1.47)  30.73        17.54       124.07 0.0325
stroke.hes_adjusted_stroke_recency_1_5_years.1               Stroke recency 1-5 years stroke.hes  Matched Controls    2964      205                 2321         88.3 (76.2, 100.4)   1.07 (0.83, 1.38) 321.48        47.41          Inf 0.0031
stroke.hes_adjusted_stroke_recency_1_5_years.2               Stroke recency 1-5 years stroke.hes Risperidone Users    1345       88                  929         94.7 (74.9, 114.5)   1.07 (0.83, 1.38) 321.48        47.41          Inf 0.0031
Stroke_adjusted_stroke_recency_over_5_years.1             Stroke recency Over 5 years     Stroke  Matched Controls    3539      297                 2713          109.5 (97, 121.9)   1.16 (0.94, 1.44)  76.93        31.23          Inf 0.0130
Stroke_adjusted_stroke_recency_over_5_years.2             Stroke recency Over 5 years     Stroke Risperidone Users    1474      127                  993       127.9 (105.7, 150.1)   1.16 (0.94, 1.44)  76.93        31.23          Inf 0.0130
stroke.hes_adjusted_stroke_recency_over_5_years.1         Stroke recency Over 5 years stroke.hes  Matched Controls    3539      159                 2769          57.4 (48.5, 66.4)   1.17 (0.87, 1.56) 144.73        46.91          Inf 0.0069
stroke.hes_adjusted_stroke_recency_over_5_years.2         Stroke recency Over 5 years stroke.hes Risperidone Users    1474       67                 1016          65.9 (50.1, 81.7)   1.17 (0.87, 1.56) 144.73        46.91          Inf 0.0069
Stroke_adjusted_ischaemicstroke.1                               Stroke type Ischaemic     Stroke  Matched Controls   10839     1613                 8069       199.9 (190.1, 209.7)    1.22 (1.1, 1.35)  24.56        17.51        41.10 0.0407
Stroke_adjusted_ischaemicstroke.2                               Stroke type Ischaemic     Stroke Risperidone Users    2966      496                 1896       261.6 (238.6, 284.7)    1.22 (1.1, 1.35)  24.56        17.51        41.10 0.0407
stroke.hes_adjusted_ischaemicstroke.1                           Stroke type Ischaemic stroke.hes  Matched Controls   10839      674                 8519          79.1 (73.1, 85.1)   1.29 (1.11, 1.51)  45.19        29.55        95.92 0.0221
stroke.hes_adjusted_ischaemicstroke.2                           Stroke type Ischaemic stroke.hes Risperidone Users    2966      215                 2018        106.5 (92.3, 120.8)   1.29 (1.11, 1.51)  45.19        29.55        95.92 0.0221
Stroke_adjusted_haemorrhagicstroke.1                         Stroke type Haemorrhagic     Stroke  Matched Controls     237       19                  174              109 (60, 158)   2.45 (1.34, 4.48)   7.89         5.07        17.72 0.1268
Stroke_adjusted_haemorrhagicstroke.2                         Stroke type Haemorrhagic     Stroke Risperidone Users     194       33                  124       265.3 (174.8, 355.8)   2.45 (1.34, 4.48)   7.89         5.07        17.72 0.1268
stroke.hes_adjusted_haemorrhagicstroke.1                     Stroke type Haemorrhagic stroke.hes  Matched Controls     237       13                  178         73.1 (33.4, 112.9)   1.32 (0.52, 3.37)  73.36        15.43          Inf 0.0136
stroke.hes_adjusted_haemorrhagicstroke.2                     Stroke type Haemorrhagic stroke.hes Risperidone Users     194       12                  134           89.4 (38.8, 140)   1.32 (0.52, 3.37)  73.36        15.43          Inf 0.0136
```


***12 weeks follow-up results***
```
                                                                             subgroup             Group N_total N_events Person_years_at_risk Incidence_rate_per_1000_PY Adjusted_HR_with_CI      NNH NNH_CI_lower NNH_CI_upper    ARR
Stroke_adjusted_all.1                                                         Overall  Matched Controls  137622     1572                31713            49.6 (47.1, 52)    1.45 (1.3, 1.61)  6537.71      2534.28          Inf 0.0002
Stroke_adjusted_all.2                                                         Overall Risperidone Users   28542      465                 6577          70.7 (64.3, 77.1)    1.45 (1.3, 1.61)  6537.71      2534.28          Inf 0.0002
stroke.hes_adjusted_all.1                                                     Overall  Matched Controls  137622      751                31714            23.7 (22, 25.4)   1.46 (1.26, 1.71) 60166.55      6022.57          Inf 0.0000
stroke.hes_adjusted_all.2                                                     Overall Risperidone Users   28542      219                 6578          33.3 (28.9, 37.7)   1.46 (1.26, 1.71) 60166.55      6022.57          Inf 0.0000
Stroke_adjusted_no_stroke.1                                         No stroke history  Matched Controls  119028      571                27430          20.8 (19.1, 22.5)    1.78 (1.51, 2.1) 64718.03      9989.07          Inf 0.0000
Stroke_adjusted_no_stroke.2                                         No stroke history Risperidone Users   24599      194                 5670            34.2 (29.4, 39)    1.78 (1.51, 2.1) 64718.03      9989.07          Inf 0.0000
stroke.hes_adjusted_no_stroke.1                                     No stroke history  Matched Controls  119028      357                27430            13 (11.7, 14.4)   1.51 (1.21, 1.88) 39637.67     18600.10          Inf 0.0000
stroke.hes_adjusted_no_stroke.2                                     No stroke history Risperidone Users   24599      102                 5670            18 (14.5, 21.5)   1.51 (1.21, 1.88) 39637.67     18600.10          Inf 0.0000
Stroke_adjusted_with_stroke.1                                          Stroke history  Matched Controls   18594     1001                 4284       233.7 (219.2, 248.2)   1.28 (1.12, 1.47)  1021.33       377.44          Inf 0.0010
Stroke_adjusted_with_stroke.2                                          Stroke history Risperidone Users    3943      271                  907       298.8 (263.2, 334.4)   1.28 (1.12, 1.47)  1021.33       377.44          Inf 0.0010
stroke.hes_adjusted_with_stroke.1                                      Stroke history  Matched Controls   18594      394                 4285             92 (82.9, 101)   1.43 (1.16, 1.77)  3805.14       750.36          Inf 0.0003
stroke.hes_adjusted_with_stroke.2                                      Stroke history Risperidone Users    3943      117                  907       128.9 (105.6, 152.3)   1.43 (1.16, 1.77)  3805.14       750.36          Inf 0.0003
Stroke_adjusted_CVD.1                                                     CVD history  Matched Controls   56188     1230                12944           95 (89.7, 100.3)   1.36 (1.21, 1.54)  2708.40      1044.00          Inf 0.0004
Stroke_adjusted_CVD.2                                                     CVD history Risperidone Users   11722      348                 2700       128.9 (115.4, 142.4)   1.36 (1.21, 1.54)  2708.40      1044.00          Inf 0.0004
stroke.hes_adjusted_CVD.1                                                 CVD history  Matched Controls   56188      544                12946            42 (38.5, 45.6)   1.41 (1.18, 1.69) 25810.57      2481.92          Inf 0.0000
stroke.hes_adjusted_CVD.2                                                 CVD history Risperidone Users   11722      156                 2700          57.8 (48.7, 66.8)   1.41 (1.18, 1.69) 25810.57      2481.92          Inf 0.0000
Stroke_adjusted_No_CVD.1                                               No CVD history  Matched Controls   81434      342                18769          18.2 (16.3, 20.2)    1.8 (1.46, 2.22)      Inf          Inf          Inf 0.0000
Stroke_adjusted_No_CVD.2                                               No CVD history Risperidone Users   16820      117                 3877          30.2 (24.7, 35.6)    1.8 (1.46, 2.22)      Inf          Inf          Inf 0.0000
stroke.hes_adjusted_No_CVD.1                                           No CVD history  Matched Controls   81434      207                18769             11 (9.5, 12.5)   1.63 (1.23, 2.16)      Inf          Inf          Inf 0.0000
stroke.hes_adjusted_No_CVD.2                                           No CVD history Risperidone Users   16820       63                 3877          16.2 (12.2, 20.3)   1.63 (1.23, 2.16)      Inf          Inf          Inf 0.0000
Stroke_adjusted_HES_stroke.1                                               HES Stroke  Matched Controls  137622     4479                30206       148.3 (143.9, 152.6)    1.31 (1.22, 1.4)   182.55       140.90       259.15 0.0055
Stroke_adjusted_HES_stroke.2                                               HES Stroke Risperidone Users   28542     1085                 6029         180 (169.2, 190.7)    1.31 (1.22, 1.4)   182.55       140.90       259.15 0.0055
stroke.hes_adjusted_HES_stroke.1                                           HES Stroke  Matched Controls  137622     2410                30289          79.6 (76.4, 82.7)   1.26 (1.14, 1.38)   403.27       278.00       734.02 0.0025
stroke.hes_adjusted_HES_stroke.2                                           HES Stroke Risperidone Users   28542      550                 6053          90.9 (83.3, 98.5)   1.26 (1.14, 1.38)   403.27       278.00       734.02 0.0025
Stroke_adjusted_PreCovidPeriod_all.1                                Pre-COVID overall  Matched Controls  125088     4302                27552       156.1 (151.5, 160.8)   1.27 (1.19, 1.36)   182.79       139.23       266.03 0.0055
Stroke_adjusted_PreCovidPeriod_all.2                                Pre-COVID overall Risperidone Users   26382     1038                 5607       185.1 (173.9, 196.4)   1.27 (1.19, 1.36)   182.79       139.23       266.03 0.0055
stroke.hes_adjusted_PreCovidPeriod_all.1                            Pre-COVID overall  Matched Controls  125088     2380                27630          86.1 (82.7, 89.6)   1.23 (1.12, 1.35)   424.39       282.44       853.15 0.0024
stroke.hes_adjusted_PreCovidPeriod_all.2                            Pre-COVID overall Risperidone Users   26382      540                 5629           95.9 (87.8, 104)   1.23 (1.12, 1.35)   424.39       282.44       853.15 0.0024
Stroke_adjusted_PreCovidPeriod_no_stroke.1                Pre-COVID No stroke history  Matched Controls  108378     1942                23994          80.9 (77.3, 84.5)   1.39 (1.26, 1.54)   300.70       217.73       485.83 0.0033
Stroke_adjusted_PreCovidPeriod_no_stroke.2                Pre-COVID No stroke history Risperidone Users   22785      498                 4869        102.3 (93.3, 111.3)   1.39 (1.26, 1.54)   300.70       217.73       485.83 0.0033
stroke.hes_adjusted_PreCovidPeriod_no_stroke.1            Pre-COVID No stroke history  Matched Controls  108378     1269                24006            52.9 (50, 55.8)   1.22 (1.07, 1.39)   880.85       483.11      4985.44 0.0011
stroke.hes_adjusted_PreCovidPeriod_no_stroke.2            Pre-COVID No stroke history Risperidone Users   22785      280                 4875          57.4 (50.7, 64.2)   1.22 (1.07, 1.39)   880.85       483.11      4985.44 0.0011
Stroke_adjusted_PreCovidPeriod_with_stroke.1                 Pre-COVID Stroke history  Matched Controls   16710     2360                 3558       663.3 (636.5, 690.1)    1.19 (1.08, 1.3)    56.30        36.79       119.91 0.0178
Stroke_adjusted_PreCovidPeriod_with_stroke.2                 Pre-COVID Stroke history Risperidone Users    3597      540                  738         732 (670.3, 793.7)    1.19 (1.08, 1.3)    56.30        36.79       119.91 0.0178
stroke.hes_adjusted_PreCovidPeriod_with_stroke.1             Pre-COVID Stroke history  Matched Controls   16710     1111                 3624       306.5 (288.5, 324.6)   1.24 (1.08, 1.42)   103.92        62.76       301.97 0.0096
stroke.hes_adjusted_PreCovidPeriod_with_stroke.2             Pre-COVID Stroke history Risperidone Users    3597      260                  754       344.8 (302.9, 386.7)   1.24 (1.08, 1.42)   103.92        62.76       301.97 0.0096
Stroke_adjusted_PreCovidPeriod_no_cvd.1                      Pre-COVID No CVD history  Matched Controls   74267     1154                16485                70 (66, 74)   1.51 (1.33, 1.71)   355.85       235.95       723.48 0.0028
Stroke_adjusted_PreCovidPeriod_no_cvd.2                      Pre-COVID No CVD history Risperidone Users   15611      324                 3357             96.5 (86, 107)   1.51 (1.33, 1.71)   355.85       235.95       723.48 0.0028
stroke.hes_adjusted_PreCovidPeriod_no_cvd.1                  Pre-COVID No CVD history  Matched Controls   74267      748                16493          45.4 (42.1, 48.6)     1.3 (1.1, 1.54)   898.09       460.03     18796.49 0.0011
stroke.hes_adjusted_PreCovidPeriod_no_cvd.2                  Pre-COVID No CVD history Risperidone Users   15611      176                 3362          52.4 (44.6, 60.1)     1.3 (1.1, 1.54)   898.09       460.03     18796.49 0.0011
Stroke_adjusted_PreCovidPeriod_with_cvd.1                       Pre-COVID CVD history  Matched Controls   50821     3148                11067       284.4 (274.5, 294.4)    1.19 (1.1, 1.29)   107.20        77.14       175.63 0.0093
Stroke_adjusted_PreCovidPeriod_with_cvd.2                       Pre-COVID CVD history Risperidone Users   10771      714                 2249       317.5 (294.2, 340.7)    1.19 (1.1, 1.29)   107.20        77.14       175.63 0.0093
stroke.hes_adjusted_PreCovidPeriod_with_cvd.1                   Pre-COVID CVD history  Matched Controls   50821     1632                11137       146.5 (139.4, 153.6)   1.19 (1.07, 1.34)   240.03       150.87       586.76 0.0042
stroke.hes_adjusted_PreCovidPeriod_with_cvd.2                   Pre-COVID CVD history Risperidone Users   10771      364                 2268           160.5 (144, 177)   1.19 (1.07, 1.34)   240.03       150.87       586.76 0.0042
Stroke_adjusted_risperidone_Age_65_74.1                        Prescription age 65-74  Matched Controls   15390      439                 3431         127.9 (116, 139.9)   1.41 (1.15, 1.72)   199.43       104.93      2006.89 0.0050
Stroke_adjusted_risperidone_Age_65_74.2                        Prescription age 65-74 Risperidone Users    3304      125                  714         175 (144.3, 205.6)   1.41 (1.15, 1.72)   199.43       104.93      2006.89 0.0050
stroke.hes_adjusted_risperidone_Age_65_74.1                    Prescription age 65-74  Matched Controls   15390      267                 3441          77.6 (68.3, 86.9)       1.3 (1, 1.71)   988.60       248.79          Inf 0.0010
stroke.hes_adjusted_risperidone_Age_65_74.2                    Prescription age 65-74 Risperidone Users    3304       70                  718         97.6 (74.7, 120.4)       1.3 (1, 1.71)   988.60       248.79          Inf 0.0010
Stroke_adjusted_risperidone_Age_75_84.1                        Prescription age 75-84  Matched Controls   62093     1974                13721       143.9 (137.5, 150.2)    1.3 (1.17, 1.44)   163.90       117.15       272.75 0.0061
Stroke_adjusted_risperidone_Age_75_84.2                        Prescription age 75-84 Risperidone Users   12858      479                 2740       174.8 (159.1, 190.5)    1.3 (1.17, 1.44)   163.90       117.15       272.75 0.0061
stroke.hes_adjusted_risperidone_Age_75_84.1                    Prescription age 75-84  Matched Controls   62093     1065                13762            77.4 (72.7, 82)   1.33 (1.16, 1.53)   258.57       177.45       476.32 0.0039
stroke.hes_adjusted_risperidone_Age_75_84.2                    Prescription age 75-84 Risperidone Users   12858      259                 2752         94.1 (82.7, 105.6)   1.33 (1.16, 1.53)   258.57       177.45       476.32 0.0039
Stroke_adjusted_risperidone_Age_85+.1             Prescription age 85 years and above  Matched Controls   60139     2066                13054       158.3 (151.4, 165.1)   1.29 (1.17, 1.43)   200.53       134.12       397.20 0.0050
Stroke_adjusted_risperidone_Age_85+.2             Prescription age 85 years and above Risperidone Users   12380      481                 2575       186.8 (170.1, 203.5)   1.29 (1.17, 1.43)   200.53       134.12       397.20 0.0050
stroke.hes_adjusted_risperidone_Age_85+.1         Prescription age 85 years and above  Matched Controls   60139     1078                13087          82.4 (77.5, 87.3)      1.16 (1, 1.34)   696.84       327.47          Inf 0.0014
stroke.hes_adjusted_risperidone_Age_85+.2         Prescription age 85 years and above Risperidone Users   12380      221                 2584          85.5 (74.3, 96.8)      1.16 (1, 1.34)   696.84       327.47          Inf 0.0014
Stroke_adjusted_stroke_recency_1_year.1               Stroke recency less than 1 year  Matched Controls     561      172                  108    1599.4 (1360.4, 1838.5)    1.03 (0.8, 1.32)    31.85        12.44          Inf 0.0314
Stroke_adjusted_stroke_recency_1_year.2               Stroke recency less than 1 year Risperidone Users     420      123                   79    1554.1 (1279.5, 1828.8)    1.03 (0.8, 1.32)    31.85        12.44          Inf 0.0314
stroke.hes_adjusted_stroke_recency_1_year.1           Stroke recency less than 1 year  Matched Controls     561       41                  117       349.4 (242.5, 456.4)   2.29 (1.52, 3.46)    18.92        12.24        41.59 0.0529
stroke.hes_adjusted_stroke_recency_1_year.2           Stroke recency less than 1 year Risperidone Users     420       56                   84       664.4 (490.4, 838.4)   2.29 (1.52, 3.46)    18.92        12.24        41.59 0.0529
Stroke_adjusted_stroke_recency_1_5_years.1                   Stroke recency 1-5 years  Matched Controls    2964      384                  630       609.2 (548.2, 670.1)   1.23 (1.03, 1.47)   121.64        43.23          Inf 0.0082
Stroke_adjusted_stroke_recency_1_5_years.2                   Stroke recency 1-5 years Risperidone Users    1345      192                  279       689.4 (591.8, 786.9)   1.23 (1.03, 1.47)   121.64        43.23          Inf 0.0082
stroke.hes_adjusted_stroke_recency_1_5_years.1               Stroke recency 1-5 years  Matched Controls    2964      205                  640         320.2 (276.4, 364)   1.07 (0.83, 1.38)   198.16        63.91          Inf 0.0050
stroke.hes_adjusted_stroke_recency_1_5_years.2               Stroke recency 1-5 years Risperidone Users    1345       88                  282       311.9 (246.7, 377.1)   1.07 (0.83, 1.38)   198.16        63.91          Inf 0.0050
Stroke_adjusted_stroke_recency_over_5_years.1             Stroke recency Over 5 years  Matched Controls    3539      297                  764       388.9 (344.7, 433.1)   1.16 (0.94, 1.44)   107.29        48.47          Inf 0.0093
Stroke_adjusted_stroke_recency_over_5_years.2             Stroke recency Over 5 years Risperidone Users    1474      127                  308         413 (341.2, 484.8)   1.16 (0.94, 1.44)   107.29        48.47          Inf 0.0093
stroke.hes_adjusted_stroke_recency_over_5_years.1         Stroke recency Over 5 years  Matched Controls    3539      159                  770       206.4 (174.3, 238.5)   1.17 (0.87, 1.56)   267.73        85.93          Inf 0.0037
stroke.hes_adjusted_stroke_recency_over_5_years.2         Stroke recency Over 5 years Risperidone Users    1474       67                  310         216 (164.3, 267.7)   1.17 (0.87, 1.56)   267.73        85.93          Inf 0.0037
Stroke_adjusted_ischaemicstroke.1                               Stroke type Ischaemic  Matched Controls   10839     1613                 2295       702.8 (668.5, 737.1)    1.22 (1.1, 1.35)    46.65        30.76        96.52 0.0214
Stroke_adjusted_ischaemicstroke.2                               Stroke type Ischaemic Risperidone Users    2966      496                  603         822 (749.6, 894.3)    1.22 (1.1, 1.35)    46.65        30.76        96.52 0.0214
stroke.hes_adjusted_ischaemicstroke.1                           Stroke type Ischaemic  Matched Controls   10839      674                 2346       287.3 (265.6, 308.9)   1.29 (1.11, 1.51)    94.35        56.53       284.97 0.0106
stroke.hes_adjusted_ischaemicstroke.2                           Stroke type Ischaemic Risperidone Users    2966      215                  619       347.6 (301.1, 394.1)   1.29 (1.11, 1.51)    94.35        56.53       284.97 0.0106
Stroke_adjusted_haemorrhagicstroke.1                         Stroke type Haemorrhagic  Matched Controls     237       19                   51       374.2 (205.9, 542.4)   2.45 (1.34, 4.48)    19.79        10.88       108.73 0.0505
Stroke_adjusted_haemorrhagicstroke.2                         Stroke type Haemorrhagic Risperidone Users     194       33                   40        832.9 (548.7, 1117)   2.45 (1.34, 4.48)    19.79        10.88       108.73 0.0505
stroke.hes_adjusted_haemorrhagicstroke.1                     Stroke type Haemorrhagic  Matched Controls     237       13                   51       254.7 (116.3, 393.2)   1.32 (0.52, 3.37)    72.07        26.20          Inf 0.0139
stroke.hes_adjusted_haemorrhagicstroke.2                     Stroke type Haemorrhagic Risperidone Users     194       12                   41       295.4 (128.2, 462.5)   1.32 (0.52, 3.37)    72.07        26.20          Inf 0.0139
```



***Discontinuation results***

```
                                                                subgroup outcome             Group N_total N_events Person_years_at_risk Incidence_rate_per_1000_PY Adjusted_HR_with_CI    NNH NNH_CI_lower NNH_CI_upper    ARR
Stroke_adjusted_all.1                                             Overall  Stroke  Matched Controls  137622     4479               112575            39.8 (38.6, 41)   1.35 (1.26, 1.44)  75.66        62.62        95.56 0.0132
Stroke_adjusted_all.2                                             Overall  Stroke Risperidone Users   28542     1026                18227          56.3 (52.8, 59.7)   1.35 (1.26, 1.44)  75.66        62.62        95.56 0.0132
Stroke_adjusted_no_stroke.1                             No stroke history  Stroke  Matched Controls  119028     2025                98701          20.5 (19.6, 21.4)    1.5 (1.36, 1.66) 104.28        84.33       136.60 0.0096
Stroke_adjusted_no_stroke.2                             No stroke history  Stroke Risperidone Users   24599      495                15912          31.1 (28.4, 33.8)    1.5 (1.36, 1.66) 104.28        84.33       136.60 0.0096
Stroke_adjusted_with_stroke.1                              Stroke history  Stroke  Matched Controls   18594     2454                13874       176.9 (169.9, 183.9)   1.23 (1.12, 1.35)  32.26        22.61        56.26 0.0310
Stroke_adjusted_with_stroke.2                              Stroke history  Stroke Risperidone Users    3943      531                 2315       229.4 (209.9, 248.9)   1.23 (1.12, 1.35)  32.26        22.61        56.26 0.0310
Stroke_adjusted_No_CVD.1                                   No CVD history  Stroke  Matched Controls   81434     1201                68270          17.6 (16.6, 18.6)   1.62 (1.43, 1.84)  94.98        75.92       126.82 0.0105
Stroke_adjusted_No_CVD.2                                   No CVD history  Stroke Risperidone Users   16820      319                11077            28.8 (25.6, 32)   1.62 (1.43, 1.84)  94.98        75.92       126.82 0.0105
Stroke_adjusted_CVD.1                                         CVD history  Stroke  Matched Controls   56188     3278                44305            74 (71.5, 76.5)   1.25 (1.16, 1.36)  57.94        43.94        85.05 0.0173
Stroke_adjusted_CVD.2                                         CVD history  Stroke Risperidone Users   11722      707                 7149         98.9 (91.6, 106.2)   1.25 (1.16, 1.36)  57.94        43.94        85.05 0.0173
Stroke_adjusted_HES_stroke.1                                   HES_stroke  Stroke  Matched Controls  137622     4479               112575            39.8 (38.6, 41)   1.35 (1.26, 1.44)  75.66        62.62        95.56 0.0132
Stroke_adjusted_HES_stroke.2                                   HES_stroke  Stroke Risperidone Users   28542     1026                18227          56.3 (52.8, 59.7)   1.35 (1.26, 1.44)  75.66        62.62        95.56 0.0132
Stroke_adjusted_PreCovidPeriod_all.1                   PreCovidPeriod_all  Stroke  Matched Controls  125088     4302               103810          41.4 (40.2, 42.7)   1.32 (1.23, 1.41)  79.79        64.82       103.76 0.0125
Stroke_adjusted_PreCovidPeriod_all.2                   PreCovidPeriod_all  Stroke Risperidone Users   26382      982                17132          57.3 (53.7, 60.9)   1.32 (1.23, 1.41)  79.79        64.82       103.76 0.0125
Stroke_adjusted_PreCovidPeriod_no_stroke.1       PreCovidPeriod_no_stroke  Stroke  Matched Controls  108378     1942                91177          21.3 (20.4, 22.2)   1.47 (1.32, 1.62) 107.39        85.51       144.30 0.0093
Stroke_adjusted_PreCovidPeriod_no_stroke.2       PreCovidPeriod_no_stroke  Stroke Risperidone Users   22785      474                14983          31.6 (28.8, 34.5)   1.47 (1.32, 1.62) 107.39        85.51       144.30 0.0093
Stroke_adjusted_PreCovidPeriod_with_stroke.1   PreCovidPeriod_with_stroke  Stroke  Matched Controls   16710     2360                12633       186.8 (179.3, 194.3)    1.2 (1.09, 1.32)  36.01        23.92        72.76 0.0278
Stroke_adjusted_PreCovidPeriod_with_stroke.2   PreCovidPeriod_with_stroke  Stroke Risperidone Users    3597      508                 2149       236.4 (215.8, 256.9)    1.2 (1.09, 1.32)  36.01        23.92        72.76 0.0278
Stroke_adjusted_PreCovidPeriod_no_cvd.1             PreCovidPeriod_no_cvd  Stroke  Matched Controls   74267     1154                63137          18.3 (17.2, 19.3)    1.59 (1.39, 1.8)  96.09        75.86       131.04 0.0104
Stroke_adjusted_PreCovidPeriod_no_cvd.2             PreCovidPeriod_no_cvd  Stroke Risperidone Users   15611      306                10446            29.3 (26, 32.6)    1.59 (1.39, 1.8)  96.09        75.86       131.04 0.0104
Stroke_adjusted_PreCovidPeriod_with_cvd.1         PreCovidPeriod_with_cvd  Stroke  Matched Controls   50821     3148                40673          77.4 (74.7, 80.1)   1.22 (1.12, 1.33)  63.45        46.37       100.46 0.0158
Stroke_adjusted_PreCovidPeriod_with_cvd.2         PreCovidPeriod_with_cvd  Stroke Risperidone Users   10771      676                 6687        101.1 (93.5, 108.7)   1.22 (1.12, 1.33)  63.45        46.37       100.46 0.0158
Stroke_adjusted_risperidone_Age_65_74.1             risperidone_Age_65_74  Stroke  Matched Controls   15390      439                13394          32.8 (29.7, 35.8)    1.47 (1.2, 1.81)  56.68        39.16       102.57 0.0176
Stroke_adjusted_risperidone_Age_65_74.2             risperidone_Age_65_74  Stroke Risperidone Users    3304      118                 2239          52.7 (43.2, 62.2)    1.47 (1.2, 1.81)  56.68        39.16       102.57 0.0176
Stroke_adjusted_risperidone_Age_75_84.1             risperidone_Age_75_84  Stroke  Matched Controls   62093     1974                52194          37.8 (36.2, 39.5)    1.33 (1.2, 1.48)  82.39        62.00       122.77 0.0121
Stroke_adjusted_risperidone_Age_75_84.2             risperidone_Age_75_84  Stroke Risperidone Users   12858      452                 8453          53.5 (48.5, 58.4)    1.33 (1.2, 1.48)  82.39        62.00       122.77 0.0121
Stroke_adjusted_risperidone_Age_85+.1                 risperidone_Age_85+  Stroke  Matched Controls   60139     2066                46987            44 (42.1, 45.9)   1.34 (1.21, 1.48)  75.43        56.87       112.00 0.0133
Stroke_adjusted_risperidone_Age_85+.2                 risperidone_Age_85+  Stroke Risperidone Users   12380      456                 7534            60.5 (55, 66.1)   1.34 (1.21, 1.48)  75.43        56.87       112.00 0.0133
Stroke_adjusted_stroke_recency_1_year.1             stroke_recency_1_year  Stroke  Matched Controls     561      172                  354       485.5 (412.9, 558.1)   1.07 (0.83, 1.38)  46.55        12.14          Inf 0.0215
Stroke_adjusted_stroke_recency_1_year.2             stroke_recency_1_year  Stroke Risperidone Users     420      121                  208         581 (477.4, 684.5)   1.07 (0.83, 1.38)  46.55        12.14          Inf 0.0215
Stroke_adjusted_stroke_recency_1_5_years.1       stroke_recency_1_5_years  Stroke  Matched Controls    2964      384                 2227       172.4 (155.2, 189.7)   1.24 (1.03, 1.49)  29.27        17.03       103.91 0.0342
Stroke_adjusted_stroke_recency_1_5_years.2       stroke_recency_1_5_years  Stroke Risperidone Users    1345      179                  811       220.8 (188.5, 253.2)   1.24 (1.03, 1.49)  29.27        17.03       103.91 0.0342
Stroke_adjusted_stroke_recency_over_5_years.1 stroke_recency_over_5_years  Stroke  Matched Controls    3539      297                 2713          109.5 (97, 121.9)   1.17 (0.93, 1.46)  76.18        31.09          Inf 0.0131
Stroke_adjusted_stroke_recency_over_5_years.2 stroke_recency_over_5_years  Stroke Risperidone Users    1474      118                  902       130.9 (107.3, 154.5)   1.17 (0.93, 1.46)  76.18        31.09          Inf 0.0131
Stroke_adjusted_ischaemicstroke.1                         ischaemicstroke  Stroke  Matched Controls   10839     1613                 8069       199.9 (190.1, 209.7)    1.22 (1.1, 1.36)  24.90        17.69        42.04 0.0402
Stroke_adjusted_ischaemicstroke.2                         ischaemicstroke  Stroke Risperidone Users    2966      463                 1733       267.2 (242.9, 291.5)    1.22 (1.1, 1.36)  24.90        17.69        42.04 0.0402
Stroke_adjusted_haemorrhagicstroke.1                   haemorrhagicstroke  Stroke  Matched Controls     237       19                  174              109 (60, 158)     2.6 (1.41, 4.8)   7.21         4.76        14.83 0.1387
Stroke_adjusted_haemorrhagicstroke.2                   haemorrhagicstroke  Stroke Risperidone Users     194       32                  114       280.1 (183.1, 377.2)     2.6 (1.41, 4.8)   7.21         4.76        14.83 0.1387
```
