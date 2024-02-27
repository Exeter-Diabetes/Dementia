

.libPaths("C:/Users/rh530/OneDrive - University of Exeter/R/win-library/4.1")
install.packages("readr")
# install.packages("vroom")
# library(vroom) 
library(readr) 
library(tidyverse) 
library(dplyr)
library(stringi)
library(stringr)

#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
rm(list=ls())

#Load product dictionary
CPRDAurumProduct <- read_delim("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/CPRDAurumProduct.txt", 
                               "\t", escape_double = FALSE, col_types = cols(ProdCodeId = col_character(), dmdid = col_character(),Release = col_character()),trim_ws = TRUE) %>%
  rename(Term.from.EMIS = 'Term from EMIS')

#Define terms to search (you will probably want something to inform this e.g. a read code list)
#terms =str_to_lower(c("Olanzapine", "Zyprexa", "Olazax", "Zypadhera","Zalasta", "Symbyax" ))


# Read data from the CSV file
data <- read.csv("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/OtherAntipsychoticDrugs_1D.csv")

data$Drugs <- stri_trans_tolower(data$Drugs)
terms <- as.list(data$Drugs)
terms <- unlist(terms)


# Convert the Drugs column in data to lowercase
data$Drugs <- str_to_lower(data$Drugs)

# Convert the Term.from.EMIS column in CPRDAurumProduct to lowercase
CPRDAurumProduct$Term.from.EMIS <- str_to_lower(CPRDAurumProduct$Term.from.EMIS)

# Search for these terms in the prodcode dictionary, select relevant columns and find distinct prodcodes
prodcodelist <- CPRDAurumProduct[grep(paste(terms, collapse='|'),CPRDAurumProduct$Term.from.EMIS, ignore.case=TRUE),]



#Save as csv file
prodcodelist$ProdCodeId <- paste0(prodcodelist$ProdCodeId, "#")
prodcodelist$dmdid <- paste0(prodcodelist$dmdid, "#")

# Save as CSV file
write_csv(prodcodelist, "OtherAntipsychoticDrugsCodelist.csv")

# Save as text file
write.table(prodcodelist, "OtherAntipsychoticDrugsCodelist.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)


#############################################################

