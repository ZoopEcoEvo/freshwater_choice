# Load in required packages
library(rmarkdown)
library(tidyverse)
library(survminer)
library(survival)

#Determine which scripts should be run
process_data = F #Runs data analysis 
make_report = T #Runs project summary
knit_manuscript = F #Compiles manuscript draft

############################
### Read in the RAW data ###
############################
raw_surv_data = readxl::read_excel(path = "Data/raw_surv_data.xlsx")
raw_fecund_data = readxl::read_excel(path = "Data/raw_fecund_data.xlsx", na = "NA")

if(process_data == T){
  source(file = "Scripts/01_data_processing.R")
}

##################################
### Read in the PROCESSED data ###
##################################
surv_data = read.csv(file = "Output/Data/surv.csv")
mort_data = read.csv(file = "Output/Data/mort.csv")
clutch_data = read.csv(file = "Output/Data/clutch_data.csv")
size_data = readxl::read_excel(path = "Data/raw_size_data.xlsx", na = "NA") %>%  
  drop_na(length)

if(make_report == T){
  render(input = "Output/Reports/report.Rmd", #Input the path to your .Rmd file here
         #output_file = "report", #Name your file here if you want it to have a different name; leave off the .html, .md, etc. - it will add the correct one automatically
         output_format = "all")
}
