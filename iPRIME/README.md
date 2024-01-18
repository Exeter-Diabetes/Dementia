# Dementia dementia incident cohort

This repository will host the R scripts used to build the diabetes dementia incident cohort

Below we provide an overview of the methodology used to create the Dementia Dementia Incidence Cohort using data from the Clinical Practice Research Datalink (CPRD).

Originally, the CPRD dataset included a total of 361,187 patients diagnosed with dementia. To refine our cohort, we focused on individuals diagnosed after January 1, 1990, who were 65 years of age or older at the time of diagnosis. By applying this criterion, we were able to filter out 344,204 eligible patients from the dataset.

Exclusion criteria were applied to further narrow down the cohort: Individuals who died before January 10, 1990 (90 patients), individuals who were registered more than 12 months before their date of birth (7,296), and individuals with a negative difference between the start and end of the follow-up period (3,729 patients) were excluded. After all these steps, we have 333,089 patients diagnosed with dementia, 1565 suffered a stroke.

Within the remaining dataset, we specifically examined those patients who were diagnosed with dementia after registration. Of the 210,393 patients meeting these criteria, 191,574 were diagnosed three months after registration. Within this subgroup, 18,098 patients were prescribed the drug risperidone, with 14,944 receiving the prescription after being diagnosed with dementia.

Of these 14,944 patients, only 420 suffered a stroke, of which 385 were ischemic and 35 were hemorrhagic strokes. In contrast, of the 191,574 patients who were diagnosed with dementia after registration but not prescribed risperidone, 3,733 suffered a stroke, 3,315 of which were ischemic and 418 hemorrhagic strokes.
 

   
This flowchart below outlines the data processing steps and the number of instances under each step



```mermaid
flowchart TD
    A[Dementia dementia cohort codelist ] -->|All patients with dementia: Selected first observation| B(n = 361,187 patients)
    B[n = 361,187 patients ] -->| All patients diagnosed at the age of 65 or above, starting from 1990-01-01  | C(n = 344,204 patients)
    C[n = 344,204 patients ] -->| Excluding patients who died before 1990-01-01, **90**   | D(n = 344,114 patients)
    D[n = 344,114 patients ] -->| Excluding patients who were registered before date of birth, **7,296**    | F(n = 336,818 patients)
    F[n = 336,818 patients ] -->| Excluding Difference in time: Start and End of follow up < 0 , **3,729**  | K(n = 333,089 patients)
    K[n = 333,089 patients ] -->| Obsdate < regstartdate  | G(n = 117,192 patients)
    K[n = 333,089 patients ] -->| Obsdate == regstartdate  | H(n = 3,612 patients)
    K[n = 333,089 patients ] -->| Obsdate > regstartdate  | I(n = 210,393 patients)
    K[n = 333,089 patients ] -->| Patients with stroke  | IZ(n = 8,941 patients)
    IZ[n = 8,941 patients ] -->| ischaemic  | IK(n = 7,987 patients)
    IZ[n = 8,941 patients ] -->| haemorrhagic   | IJ(n = 954 patients)
    I[n = 210,393 patients ] -->| Obsdate > regstartdate + 90 days  | J(n = 191,574 patients)
    J[n = 191,574 patients ] -->| Patients on risperidone  | N(n = 18,098 patients)
    J[n = 191,574 patients ] -->| Patients with stroke but not on risperidone  | NK(n = 3,733 patients)
    NK[n = 3,733 patients ] -->| ischaemic   | RK(n = 3,315  patients)
    NK[n = 3,733 patients ] -->| haemorrhagic      | TK(n = 418 patients)
    N[n = 18,098 patients ] -->| Patients prescribed risperidone after dementia diagnosis  | P(n = 14,944 patients)
    P[n = 14,944 patients ] -->| Patients with stroke  | Q(n = 420 patients)
    Q[n = 420  patients ] -->| ischaemic   | R(n = 385 patients)
    Q[n = 420  patients ] -->| haemorrhagic      | T(n = 35 patients)
    
    R[n = 385  patients ] -->| Stroke prior to risperidone| RZ(n = 277 patients)
    R[n = 385  patients ] -->| Stroke in year after first risperidone prescription| RY(n = 129 patients)
    R[n = 385  patients ] -->| Died in year after first risperidone prescription| RV(n = 188 patients)

    T[n = 35  patients ] -->| Stroke prior to risperidone| RZS(n = 55 patients)
    T[n = 35  patients ] -->| Stroke in year after first risperidone prescription| RYS(n = 13 patients)
    T[n = 35  patients ] -->| Died in year after first risperidone prescription| RVS(n = 32 patients)
    G[n = 117,192  patients ] -->| Patients with stroke but not on risperidone  | NS(n = 3,550 patients)
    NS[n = 3,550  patients ] -->| ischaemic   | RS(n = 3,165  patients)
    NS[n = 3,550  patients ] -->| haemorrhagic      | TS(n = 385 patients)
    
    H[n = 3,612 patients ] -->| Patients with stroke but not on risperidone  | NP(n = 78 patient)
    NP[n = 78  patient ] -->| ischaemic   | RP(n = 72  patient)
    NP[n = 78  patient ] -->| haemorrhagic      | TP(n = 6 patients)

    G[n = 117,192 patients ] -->| Patients on risperidone  | X(n = 17,159 patients)
    X[n = 17,159  patients ] -->| Patients prescribed risperidone after dementia diagnosis  | Z(n = 16,701 patients)
    Z[n = 16,701  patients ] -->| Patients with stroke  | Y(n = 51 patients)
    Y[n = 592  patients ] -->| ischaemic   | U(n = 515 patients)
    Y[n = 592  patients ] -->| haemorrhagic      | V(n = 77 patients)



    H[ n = 3,612 patients ] -->| Patients on risperidone  | XV(n = 425 patients)
    XV[n = 425 patients ] -->| Patients prescribed risperidone after dementia diagnosis  | ZV(n = 387 patients)
    ZV[n = 387 patients ] -->| Patients with stroke  | YV(n = 15 patients)
    YV[n = 15 patients ] -->| ischaemic   | UV(n = 15 patients)
    YV[n = 15 patients ] -->| haemorrhagic      | VV(n = 0 patients)

    U[n = 515 patients ] -->| Stroke prior to risperidone| RZK(n = 176 patients)
    U[n = 515 patients ] -->| Stroke in year after first risperidone prescription| RYK(n = 116 patients)
    U[n = 515 patients ] -->| Died in year after first risperidone prescription| RVK(n = 132 patients)


    V[n = 77 patients ] -->| Stroke prior to risperidone| RZSR(n = 16 patients)
    V[n = 77 patients ] -->| Stroke in year after first risperidone prescription| RYSR(n = 13 patients)
    V[n = 77 patients ] -->| Died in year after first risperidone prescription| RVSR(n = 8 patients)





```






















































































































































# Diabetes Dementia Incident Cohort 

This repository will host the R scripts used to build the diabetes dementia incident cohort

Below we provide an overview of the methodology used to create the Diabetes Dementia Incidence Cohort using data from the Clinical Practice Research Datalink (CPRD).

Originally, the CPRD dataset included a total of 378,614 patients diagnosed with dementia. To refine our cohort, we focused on individuals diagnosed after January 1, 1990, who were 65 years of age or older at the time of diagnosis. By applying this criterion, we were able to filter out 358,406 eligible patients from the dataset.

Exclusion criteria were applied to further narrow down the cohort: Individuals who died before January 10, 1990 (114 patients), individuals who were registered more than 12 months before their date of birth (7588), and individuals with a negative difference between the start and end of the follow-up period (4,091 patients) were excluded. After all these steps, we have 346,614 patients diagnosed with dementia, 1565 suffered a stroke.
![Over65_regstartdateB4obs90_days_stroke_cat_plot](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/b7c59aab-20ea-4878-8c21-f4e81f51b2f8)

Within the remaining dataset, we specifically examined those patients who were diagnosed with dementia after registration. Of the 218 644 patients meeting these criteria, 199 047 were diagnosed three months after registration. Within this subgroup, 18,667 patients were prescribed the drug risperidone, with 15,401 receiving the prescription after being diagnosed with dementia.

Of these 15,401 patients, only 87 suffered a stroke, of which 76 were ischemic and 11 were hemorrhagic strokes. In contrast, of the 199,047 patients who were diagnosed with dementia after registration but not prescribed risperidone, 1,028 suffered a stroke, 953 of which were ischemic and 95 hemorrhagic strokes.
 

   
This flowchart below outlines the data processing steps and the number of instances under each step

```mermaid
flowchart TD
    A[Diabetes dementia cohort codelist ] -->|All patients with dementia: Selected first observation| B(n = 378,614 patients)
    B[n = 378,614 patients ] -->| All patients diagnosed at the age of 65 or above, starting from 1990-01-01  | C(n = 358,406 patients)
    C[358,406 patients ] -->| Excluding patients who died before 1990-01-01, **114**   | D(n = 358,292 patients)
    D[358,292 patients ] -->| Excluding patients who were registered before date of birth, **8,751**1,163 >= -1**    | F(n = 350,705 patients)
    F[n = 350,705 patients ] -->| Excluding Difference in time: Start and End of follow up < 0 , **4091**  | K(n = 346,614 patients)
    K[n = 346,614 patients ] -->| Obsdate < regstartdate  | G(n = 122,0628 patients)
    K[n = 346,614 patients ] -->| Obsdate == regstartdate  | H(n = 3,805 patients)
    K[n = 346,614 patients ] -->| Obsdate > regstartdate  | I(n = 218,644 patients)
    K[n = 346,614 patients ] -->| Patients with stroke  | IZ(n = 218,644 patients)
    IZ[n = 1,565 patients ] -->| ischaemic  | IK(n = 1,429 patients)
    IZ[n = 1,565 patients ] -->| haemorrhagic   | IJ(n = 136 patients)
    I[n = 218,644  patients ] -->| Obsdate > regstartdate + 90 days  | J(n = 199,047 patients)
    J[n = 199,047  patients ] -->| Patients on risperidone  | N(n = 18,667 patients)
    J[n = 199,047  patients ] -->| Patients with stroke but not on risperidone  | NK(n = 1,028 patients)
    NK[n = 1,028  patients ] -->| ischaemic   | RK(n = 953  patients)
    NK[n = 1,028  patients ] -->| haemorrhagic      | TK(n = 95 patients)
    N[n = 18,667  patients ] -->| Patients prescribed risperidone after dementia diagnosis  | P(n = 15,401 patients)
    P[n = 15,401  patients ] -->| Patients with stroke  | Q(n = 87 patients)
    Q[n = 87  patients ] -->| ischaemic   | R(n = 76 patients)
    Q[n = 87  patients ] -->| haemorrhagic      | T(n = 11 patients)
    
    R[n = 76  patients ] -->| Stroke prior to risperidone| RZ(n = 45 patients)
    R[n = 76  patients ] -->| Stroke in year after first risperidone prescription| RY(n = 11 patients)
    R[n = 76  patients ] -->| Died in year after first risperidone prescription| RV(n = 17 patients)

    T[n = 11  patients ] -->| Stroke prior to risperidone| RZS(n = 8 patients)
    T[n = 11  patients ] -->| Stroke in year after first risperidone prescription| RYS(n = 1 patients)
    T[n = 11  patients ] -->| Died in year after first risperidone prescription| RVS(n = 3 patients)
    G[n = 122,0628  patients ] -->| Patients with stroke but not on risperidone  | NS(n = 332 patients)
    NS[n = 332  patients ] -->| ischaemic   | RS(n = 309  patients)
    NS[n = 332  patients ] -->| haemorrhagic      | TS(n = 23 patients)
    
    H[n = 3,805  patients ] -->| Patients with stroke but not on risperidone  | NP(n = 1 patient)
    NP[n = 1  patient ] -->| ischaemic   | RP(n = 1  patient)
    NP[n = 1  patient ] -->| haemorrhagic      | TP(n = 0 patients)

    G[n = 122,0628 patients ] -->| Patients on risperidone  | X(n = 17,680 patients)
    X[n = 17,680  patients ] -->| Patients prescribed risperidone after dementia diagnosis  | Z(n = 17,205 patients)
    Z[n = 17,205  patients ] -->| Patients with stroke  | Y(n = 51 patients)
    Y[n = 51  patients ] -->| ischaemic   | U(n = 45 patients)
    Y[n = 51  patients ] -->| haemorrhagic      | V(n = 6 patients)



    H[ n = 3,805 patients ] -->| Patients on risperidone  | XV(n = 459 patients)
    XV[n = 459 patients ] -->| Patients prescribed risperidone after dementia diagnosis  | ZV(n = 418 patients)
    ZV[n = 418 patients ] -->| Patients with stroke  | YV(n = 0 patients)
    YV[n = 0 patients ] -->| ischaemic   | UV(n = 0 patients)
    YV[n = 0 patients ] -->| haemorrhagic      | VV(n = 0 patients)






```



The table below shows the descriptive statistics of study cohort

```latex
\begin{table}[!ht]
    \centering
    \begin{tabular}{|l|l|}
    \hline
        ​ & \textbf{Overall}​ \\ \hline
               \textbf{n}​ &      199047​ \\ \hline
        \textbf{Age of diagnosis (mean (SD))} &      82.25 (7.05)​ \\ \hline
        \textbf{Year of diagnosis category (\%)} & ​ \\ \hline
             1 (1990 - 1995)​ &      7787 (3.9)​ \\
             2​ (1996 - 2000) &      12954 (6.5)​ \\ 
             3​  (2001 - 2005)&      27539 (13.8)​ \\ 
             4​ (2006 - 2010)&      36404 (18.3)​ \\ 
             5​ (2011 - 2015) &      54028 (27.1)​ \\ 
             6​ (2016 - 2020) &      56572 (28.4)​ \\ 
             7​ (2021+) &      3763 (1.9)​ \\ \hline
        \textbf{Age category (\%)}​ & ​ \\ \hline
            65-74​ &     29586 (14.9)​ \\ 
            75-84​ &     90628 (45.5)​ \\ 
            85-94​ &     72325 (36.3)​ \\ 
            95+ ​ &     6508 (3.3)​ \\ \hline
        Sex = M (\%)​ &     71237 (35.8)​ \\ \hline
        Died (\%) &       90423(45)  \\ \hline
    \end{tabular}
\end{table}

```
The plot below shows the age distribution of the final cohort
![Over65_regstartdateB4obs90_days_age_plot](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/4c0e0c98-10c2-4788-afc8-58484d8b3855)

This pie chart shows the number of patients who have died, indicated by the number 1, and 0 for those who are still alive.
<img width="390" alt="Over65_regstartdateB4obs90_days_death_pie_chart" src="https://github.com/Exeter-Diabetes/Dementia/assets/145013232/6a3d36ad-e6ea-444c-b667-3e06620b3a18">

Here we are showing the difference between the start of and end of follow-up distribution
![Over65_regstartdateB4obs90_diff_plot](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/5e626a1d-13a4-4831-ad04-ee9632303b70)



The following graphs show the number of deaths per year for patients diagnosed 90 days after registration at the age of 65 years and above
![Over65_regstartdateB4obs90_days_NumberOfDeath](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/c96e4291-b438-44db-bcad-654d892794c7)



This plot shows Survival analysis stratified by sex categories
![image](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/699d5123-d2a0-47d8-bf64-76318ea5c7a3)

<img width="879" alt="SurvialAnalysisBySex" src="https://github.com/Exeter-Diabetes/Dementia/assets/145013232/a029df48-84ca-44f5-87fb-ebd1359d6dc1">

This plot shows Survival analysis stratified by age categories.
<img width="808" alt="SurvialAnalysisByAgeCat" src="https://github.com/Exeter-Diabetes/Dementia/assets/145013232/c73fa165-0118-4781-9007-d22e73ce2c10">




# Patients on Risperidone
#### These are patients who started taking risperidone after being diagnosed with dementia
```latex
\begin{table}[!ht]
    \centering
    \begin{tabular}{|l|l|}
    \hline
        Risperidone cohort & ~ \\ \hline
        N & 15401 \\ \hline
        Stroke ever & 87 \\ \hline
        Stroke prior to risperidone & 53 \\ \hline
        Stroke in year after first risperidone prescription & 12 \\ \hline
        Died in year after first risperidone prescription & 20 \\ \hline
    \end{tabular}
\end{table}
```
The following graph shows the number of patients who have suffered a stroke while taking risperidone
![Risperidone_stroke_cat_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/769f4cb7-0ad6-4a5f-8750-921cf39539e6)

The following graph shows the number of deceased patients who took risperidone
![Risperidone_death_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/6174ede5-f2ca-46d1-b9ef-23ab51f6ebc0)

The gender distribution of patients on risperidone
![Risperidone_gender_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/07e94827-c3a0-4fd4-948f-434a3d794ea3)

The age distribution of patients who are on risperidone
![Risperidone_age_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/473507f1-87cb-4dad-ba23-fda41d2fcc4a)






