# Diabetes Dementia Incident Cohort 

This repository will host the R scripts used to build the diabetes dementia incident cohort

1. Data source: 358,406 patient records from the Clinical Practice Research Datalink (CPRD).
2. Inclusion criteria: Individuals diagnosed with dementia after age 65 after January 1, 1990, who have not taken risperidone before their diagnosis.
3. Of the 346,614 patients diagnosed with dementia, 1565 suffered a stroke.
 ![Over65_regstartdateB4obs90_days_stroke_cat_plot](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/b7c59aab-20ea-4878-8c21-f4e81f51b2f8)

   
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
    N[n = 18,667  patients ] -->| Patients prescribed risperidone after dementia diagnosis  | P(n = 15,401 patients)
    P[n = 15,401  patients ] -->| Patients with stroke  | Q(n = 87 patients)
    Q[n = 87  patients ] -->| ischaemic   | R(n = 76 patients)
    Q[n = 87  patients ] -->| haemorrhagic      | T(n = 11 patients)


    

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

The following graph shows the number of patients who have suffered a stroke while taking risperidone
![Risperidone_stroke_cat_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/769f4cb7-0ad6-4a5f-8750-921cf39539e6)

The following graph shows the number of deceased patients who took risperidone
![Risperidone_death_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/6174ede5-f2ca-46d1-b9ef-23ab51f6ebc0)

The gender distribution of patients on risperidone
![Risperidone_gender_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/07e94827-c3a0-4fd4-948f-434a3d794ea3)

The age distribution of patients who are on risperidone
![Risperidone_age_plot_positiveMonths](https://github.com/Exeter-Diabetes/Dementia/assets/145013232/473507f1-87cb-4dad-ba23-fda41d2fcc4a)






