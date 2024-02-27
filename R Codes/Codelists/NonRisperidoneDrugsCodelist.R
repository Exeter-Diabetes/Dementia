# Load the required libraries
library(readr)
library(tidyverse)
library(stringi)
library(dplyr)
library(stringr)

# Load product dictionary
CPRDAurumProduct <- read_delim("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/CPRDAurumProduct.txt", 
                               "\t", escape_double = FALSE, col_types = cols(ProdCodeId = col_character(), dmdid = col_character(),Release = col_character()),trim_ws = TRUE) %>%
  rename(Term.from.EMIS = 'Term from EMIS')
CPRDAurumProduct$Term.from.EMIS <- str_to_lower(CPRDAurumProduct$Term.from.EMIS)
# Read data from the 2D CSV file
data <- read.csv("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/OtherAntipsychoticDrugs.csv")

# Use the "Brand Names" column as terms to search
terms <- stri_trans_tolower(data$Brand.Names)
print(terms)
# Search for the terms in the prodcode dictionary
prodcodelist <- CPRDAurumProduct[grep(paste(terms, collapse='|'), CPRDAurumProduct$Term.from.EMIS, ignore.case=TRUE), ]



prodcodelist <- as_tibble(prodcodelist)
data <- as_tibble(data)

# Convert Generic.Names and Brand.Names to lowercase
data <- data %>%
  mutate(
    Generic.Names = tolower(Generic.Names),
    Brand.Names = tolower(Brand.Names)
  )

# Create an empty column 'GenericName' in prodcodelist
prodcodelist$GenericName <- NA_character_

# Iterate over each row in prodcodelist
for (i in seq(nrow(prodcodelist))) {
  brand_names <- data$Brand.Names[str_detect(prodcodelist$Term.from.EMIS[i], data$Brand.Names)]
  
  if (length(brand_names) > 0) {
    prodcodelist$GenericName[i] <- data$Generic.Names[data$Brand.Names == brand_names][1]
  }
}
prodcodelist$ProdCodeId <- paste0(prodcodelist$ProdCodeId, "#")
prodcodelist$dmdid <- paste0(prodcodelist$dmdid, "#")
print(prodcodelist)

# # Save as CSV file
write_csv(prodcodelist, "NonRisperidoneDrugs.csv")
# 
# # Save as text file
write.table(prodcodelist, "NonRisperidoneDrugs.csv.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)
# 

View(prodcodelist)
# 