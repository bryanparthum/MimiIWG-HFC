## Written by: US EPA National Center for Environmental Economics

##########################
#################  LIBRARY
##########################

## Clear worksace
rm(list = ls())
gc()

## This function will check if a package is installed, and if not, install it
list.of.packages <- c('tidyverse','magrittr','stringr')
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos = "http://cran.rstudio.com/")
lapply(list.of.packages, library, character.only = TRUE)

##########################
################  PREAMBLE
##########################

## List of gases
hfc_list <- c('23','32','125','134a','143a','152a','227ea','236fa','245fa','4310mee')

##########################
##############  START LOOP
##########################

for (hfc in hfc_list) {
  
page_dir    <- paste0("../data/hfc",hfc,"/page/discontinuity_mismatch") # location of file group
page_files  <- fs::dir_ls(page_dir, regexp = "\\.csv$") # create list of .csv files
page        <- page_files %>% 
                  map_dfr(read_csv, .id = "source") %>% # read in files (map), turn into data frame (df), and row bind (r)
                  as.data.table()

##########################
###################  CLEAN
##########################

page %<>% mutate(source = str_remove(source,paste0("data/hfc",hfc,"/page/discontinuity_mismatch/"))) %>%
          mutate(source = str_remove(source,".csv")) %>%
          separate(source, c("scenario","discount_rate"), " ") %>%
          mutate(scenario = case_when(scenario=="USG1" ~ "IMAGE",
                                      scenario=="USG2" ~ "MERGE Optimistic",
                                      scenario=="USG3" ~ "MESSAGE",
                                      scenario=="USG4" ~ "MiniCAM Base",
                                      scenario=="USG5" ~ "5th Scenario"),
                 discount_rate = paste0(as.numeric(discount_rate)*100,'%')) %>%
          group_by(scenario,discount_rate) %>%
          mutate(trial = seq(n()))

## WIDE TO LONG
years <-  paste(seq(2020,2060,5), sep=", ") # vector of years
page %<>% gather(year,discontinuity,all_of(years)) %>%
          mutate(model = 'PAGE 2009')

##########################
####################  SAVE
##########################

write_csv(page, paste0("../data/hfc",hfc,"_page_discontinuity.csv"))

}

## END OF SCRIPT. Have a great day!
