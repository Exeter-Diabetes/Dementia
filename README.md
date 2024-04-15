**The table below shows the number of prescriptions per year for each category**


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
