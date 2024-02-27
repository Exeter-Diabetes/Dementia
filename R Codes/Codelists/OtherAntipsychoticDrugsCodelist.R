################################################################################
##Prodcode lists for Pancreatic Enzyme Replacement therapy

.libPaths("C:/Users/rh530/OneDrive - University of Exeter/R/win-library/4.1")
install.packages("readr")
# install.packages("vroom")
# library(vroom) 
library(readr) 
library(tidyverse) 
library(dplyr)
library(stringi)
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
rm(list=ls())

#Load product dictionary
CPRDAurumProduct <- read_delim("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/CPRDAurumProduct.txt", 
                               "\t", escape_double = FALSE, col_types = cols(ProdCodeId = col_character(), dmdid = col_character(),Release = col_character()),trim_ws = TRUE) %>%
  rename(Term.from.EMIS = 'Term from EMIS')

#Define terms to search (you will probably want something to inform this e.g. a read code list)
#terms =str_to_lower(c("Olanzapine", "Zyprexa", "Olazax", "Zypadhera","Zalasta", "Symbyax" ))

# Load the required library for string manipulation
library(stringr)

# Read data from the CSV file
data <- read.csv("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/OtherAntipsychoticDrugs_1D.csv")
# Create a character vector with unique combinations of Generic Names and Brand Names
# Assuming 'data' is your data frame
# data$Drugs <- tolower(data$Drugs)
data$Drugs <- stri_trans_tolower(data$Drugs)
terms <- as.list(data$Drugs)
terms <- unlist(terms)

# Print the resulting lowercase list
print(terms)

#terms <- with(data, unique(paste(str_to_lower(Drugs), sep = ",")))
#print(terms)
# Search for these terms in the prodcode dictionary, select relevant columns and find distinct prodcodes
#prodcodelist <- CPRDAurumProduct[CPRDAurumProduct$Term.from.EMIS %in% tolower(data$Drugs), ]
#prodcodelist <- CPRDAurumProduct[sapply(CPRDAurumProduct$Term.from.EMIS, function(x) any(tolower(data$Drugs) == tolower(x))), ]
# Convert the Drugs column to lowercase using iconv to handle encoding issues
# data$Drugs <- iconv(data$Drugs, to = "ASCII//TRANSLIT")
# 
# # Search for these terms in the prodcode dictionary, select relevant columns and find distinct prodcodes
# prodcodelist <- CPRDAurumProduct[sapply(CPRDAurumProduct$Term.from.EMIS, function(x) any(tolower(data$Drugs) == tolower(x))), ]


library(stringr)

# Convert the Drugs column in data to lowercase
data$Drugs <- str_to_lower(data$Drugs)

# Convert the Term.from.EMIS column in CPRDAurumProduct to lowercase
CPRDAurumProduct$Term.from.EMIS <- str_to_lower(CPRDAurumProduct$Term.from.EMIS)

# Search for these terms in the prodcode dictionary, select relevant columns and find distinct prodcodes
#prodcodelist <- CPRDAurumProduct[sapply(CPRDAurumProduct$Term.from.EMIS, function(x) any(data$Drugs == x)), ]




prodcodelist <- CPRDAurumProduct[grep(paste(terms, collapse='|'),CPRDAurumProduct$Term.from.EMIS, ignore.case=TRUE),]
# prodcodelist <- prodcodelist %>% select(ProdCodeId, dmdid, Term = Term.from.EMIS) %>% distinct(ProdCodeId, .keep_all = TRUE)


# Assuming 'terms' is your lowercase list
library(stringr)

# Convert the Drugs column in data to lowercase
# data$Drugs <- str_to_lower(data$Drugs)
# 
# # Convert the Term.from.EMIS column in CPRDAurumProduct to lowercase
# CPRDAurumProduct$Term.from.EMIS <- str_to_lower(CPRDAurumProduct$Term.from.EMIS)
# 
# # Initialize an empty data frame to store the results
# prodcodelist <- data.frame()
# 
# # Iterate through each term and filter rows in CPRDAurumProduct
# for (term in terms) {
#   matches <- grep(term, CPRDAurumProduct$Term.from.EMIS, ignore.case = TRUE)
#   prodcodelist <- rbind(prodcodelist, CPRDAurumProduct[matches, ])
# }
# 
# # Remove duplicates if any
# prodcodelist <- unique(prodcodelist)

# Print the resulting product code list
View(prodcodelist)

View(CPRDAurumProduct)




#Save as csv file
prodcodelist$ProdCodeId <- paste0(prodcodelist$ProdCodeId, "#")
prodcodelist$dmdid <- paste0(prodcodelist$dmdid, "#")
# Print the resulting product code list
print(prodcodelist)

# Save as CSV file
write_csv(prodcodelist, "OtherAntipsychoticDrugsCodelist.csv")

# Save as text file
write.table(prodcodelist, "OtherAntipsychoticDrugsCodelist.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)

# Print the first few rows of CPRDAurumProduct
print(head(CPRDAurumProduct))

# Print the first few rows of data
print(head(data))



#############################################################

