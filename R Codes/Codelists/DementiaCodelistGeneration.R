#load packages
library(readr) 
library(tidyverse)
library(rms)
library(dplyr)

#Load CPRD Aurum lookup (CPRDAurumMedical.txt) from wherever you have it saved
CPRDAurumMedical <- read_delim("C:/Users/njc232/OneDrive - University of Exeter/Documents/CodelistGeneration/CPRDAurumMedical.txt", 
                               "\t", escape_double = FALSE, col_types = cols(MedCodeId = col_character(), SnomedCTConceptId = col_character(), 
                                                                             SnomedCTDescriptionId = col_character(),Release = col_character(), EmisCodeCategoryId = col_character()),trim_ws = TRUE)
CPRDAurumMedical <- CPRDAurumMedical %>% mutate(readcode=as.character(substr(CleansedReadCode, start=1, stop=5)))
names(CPRDAurumMedical)[names(CPRDAurumMedical) == "readcode"] <- "Readcode"
CPRDAurumMedical$Readcode <- paste0(CPRDAurumMedical$Readcode, "#")
CPRDAurumMedical$SnomedCTConceptId <- paste0(CPRDAurumMedical$SnomedCTConceptId, "#")
CPRDAurumMedical$MedCodeId <- paste0(CPRDAurumMedical$MedCodeId, "#")
view(CPRDAurumMedical)
names(CPRDAurumMedical)




#####################################################################################################
# Filtering out all the rejected codes, i.e readcodes and snomedcodes
#####################################################################################################


CliniciansRejectedReadCodes <- read.csv("C:/Users/njc232/OneDrive - University of Exeter/Documents/CodelistGeneration/CliniciansRejectedReadCodes.csv")
colnames(CliniciansRejectedReadCodes) <- c("Readcode", "term_medcode")
#CliniciansRejectedReadCodes$Readcode <- paste0(CliniciansRejectedReadCodes$Readcode, "#")
#names(CliniciansRejectedReadCodes)[names(CliniciansRejectedReadCodes) == "Readcode"] <- "OriginalReadCode"
view(CliniciansRejectedReadCodes)

#### Removing the clinicians snomed rejected codes
CliniciansRejectedSnomedCodes <- read.csv("C:/Users/njc232/OneDrive - University of Exeter/Documents/CodelistGeneration/CliniciansRejectedSnomedCodes.csv")
colnames(CliniciansRejectedSnomedCodes) <- c("Snomedcode", "term_medcode")
#CliniciansRejectedSnomedCodes$Snomedcode <- paste0(CliniciansRejectedSnomedCodes$Snomedcode, "#")
names(CliniciansRejectedSnomedCodes)[names(CliniciansRejectedSnomedCodes) == "Snomedcode"] <- "SnomedCTConceptId"
view(CliniciansRejectedSnomedCodes)


# Create or load your dataframe 'df', 'clinician', and 'exeter' tables
filtered_df <- anti_join(CPRDAurumMedical, CliniciansRejectedReadCodes, by = "Readcode") %>%
  anti_join(., CliniciansRejectedSnomedCodes, by = "SnomedCTConceptId")
view(filtered_df)





#####################################################################################################
# select the 8 keywords
#####################################################################################################
#### These are the keywords to look for
keywords <- c("dementia", "alzheimer", "lewy body", "cogniti", "pick", "GDS", "global deterioration scale", "CDR")

Filtered <- filtered_df %>%
  filter(grepl(paste(keywords, collapse = "|"), Term, ignore.case = TRUE))
view(Filtered)

Final <- Filtered %>% filter(!grepl("alcohol|HIV|CJD|epilepsy", Term, ignore.case = TRUE))
view(Final)


#combinedCodes <- rbind(Final, common_records_df)
#view(combinedCodes)
file_name <- "JoshuaAllNew_DementiaCodeList.csv"
write.csv(Final, file = file_name, row.names = FALSE)
names(Final)
FinalLists <- Final[, c("SnomedCTConceptId", "MedCodeId", "Term", "Readcode")]

file_name <- "JoshuaAllNew_DementiaCodeList_final.csv"
write.csv(FinalLists, file = file_name, row.names = FALSE)
view(FinalLists)