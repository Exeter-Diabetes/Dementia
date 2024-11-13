################################################################################################################################




# Setup
library(aurum)
library(tidyverse)

# Create a CPRDData instance
cprd = CPRDData$new(cprdEnv = "test-remote-full", cprdConf = "~/.aurum.yaml")
#analysis = cprd$analysis("all_patid")
codesets = cprd$codesets()
# Load Dementia_index_dates data onto the cprd instance
RisperidoneCodes = readr::read_tsv(
  here::here("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/RisperidoneCodelist.txt"),
  col_types = cols(.default = col_character()))
codesets$loadProdCodeSet(name = "RisperidoneCodes",        
                        version = "31/10/2021",   codeSetDf = RisperidoneCodes)





############################################################################################################################################## Anti-psychotic#################################################
OtherAntipsychoticDrugsCodelist = readr::read_tsv(
  here::here("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/OtherAntipsychoticDrugsCodelist.txt"),
  col_types = cols(.default = col_character()))

codesets$loadProdCodeSet(name = "OtherAntipsychoticDrugsCodelist",        
                         version = "31/10/2021",   codeSetDf = OtherAntipsychoticDrugsCodelist)





##################################################################################################### NonRisperidoneDrugs#################################################
NonRisperidoneDrugs = readr::read_tsv(
  here::here("C:/Users/njc232/OneDrive - University of Exeter/Documents/ProductCodelist/NonRisperidoneDrugs.txt"),
  col_types = cols(.default = col_character()))

codesets$loadProdCodeSet(name = "NonRisperidoneDrugs",        
                         version = "31/10/2021",   codeSetDf = NonRisperidoneDrugs, category = "Category")

View(NonRisperidoneDrugs)
#######################################################################################################



# codesets$deleteCodeSet("dementiadementiacodelist_v3")
# codesets$deleteCodeSet("dementiadementiacodelist_v2")
# codesets$deleteCodeSet("dementiadementiacodelist")

dementiadementiacodelist = readr::read_tsv(
  here::here("C:/Users/njc232/OneDrive - University of Exeter/Documents/DementiaDementiaCodelist/DementiaDementiaCodelist.txt"),
  col_types = cols(.default=col_character()))

dementiadementiacodelist %>% codesets$loadMedCodeSet(name = "dementiadementiacodelist", version="31/10/2021", category="Term")


View(dementiadementiacodelist)
############################################################ Demementia Dementia Codelist#################################################

rm(cprd)







