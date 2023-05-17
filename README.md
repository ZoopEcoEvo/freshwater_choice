# Copepod survival in different freshwater media

Matthew Sasaki

1. University of Vermont, Department of Biology

This project examined copepod survival in three different freshwater media: filtered lake water (~60-um filtered), store-bought bottled spring water, and reverse-osmosis filtered water. The copepods examined were mature female *Leptodiaptomus sicilis* collected from Lake Champlain on April 26th, 2023. At the time of collection, water temperatures was ~7°C. Copepods were retured to lab and isolated in small jars with 20 mL of the different media. Survival was checked daily. Fecundity (the number of eggs held in the egg sac) was measured on Day 1, and female prosome length was measured on Day 20 (note: body sizes were therefore only measured for surviving females, which represents a substantial bias in the sample).

## Directory Structure 
The root directory contains the README and Licensing files, along with a .Rproj file and three sub-directories: Data, Output, and Scripts.  

-   `Data/` contains the raw data used in this analysis.  

-   `Output/` contains the various products of the project (processed data, figures, and knit reports. Note, the `Reports/` directory contains the R Markdown file used to create the figures and generate the reports.  

-   `Scripts/` contains two R scripts. 
    -   `01_processing.R` is used to process the raw data. The primary components of this analysis are to reformat the raw survival data from a wide to long arrangement, and to extract clutch sizes and hold times from the raw fecundity data. 
    -   `02_controller.R` is use to control the project workflow. Through this script, you can choose whether to run the scripts that process the data and make the report. This script should be used rather than running isolated fragments individually. 


## Data Description 	

The `Data/` directory contains the three data sets used in this study, along with the images used to measure prosome lengths.  	

-   `raw_fecund_data.xlsx` contains data from the fecundity tracking portion of the experiment. This data is used to store clutch sizes and calculate how long females held clutches before nauplii hatched.   	
    -   *exp_rep* - Which day (Wednesday or Friday) copepods were set up.	  	
    -   *cup*	- The number assigned to each vessel. 	
    -   *volume* - The amount of water contained. 
    -   *treatment* - Which type of media was used (FLW - filtered lake water; BSW - bottled spring water; ROW - reverse osmosis filtered water)
    -   *day1* through *day20* - Daily observations of the status of the female. Numeric values indicate clutch sizes recorded on that day. It's also recorded which day clutches were released (i.e. - nauplii hatched) or when the clutch was dropped (before nauplii had hatched).

-   `raw_size_data.xlsx` contains the measured prosome lengths for females that survived to day 20 of the experiment.   	
    -   *exp_rep* - Which day (Wednesday or Friday) copepods were set up.	  	
    -   *cup*	- The number assigned to each vessel. 	
    -   *volume* - The amount of water contained. 
    -   *treatment* - Which type of media was used (FLW - filtered lake water; BSW - bottled spring water; ROW - reverse osmosis filtered water)
    -   *length* - Female prosome length, measured in mm.

-   `raw_surv_data.xlsx` contains data from the survival portion of the experiment. This data is used to estimate survival curves for females in the three different media.    	
    -   *exp_rep* - Which day (Wednesday or Friday) copepods were set up.	  	
    -   *cup*	- The number assigned to each vessel. 	
    -   *volume* - The amount of water contained. 
    -   *treatment* - Which type of media was used (FLW - filtered lake water; BSW - bottled spring water; ROW - reverse osmosis filtered water)
    -   *day1* through *day20* - Daily observations of the status of the female. 1 indicates the female was alive, 0 indicates mortality.
    
    
## Workflow

The workflow is operated via the 02_controller.R script in the Scripts directory. It is not recommended that you run analyses or knit documents from the files themselves as the file paths are internally set and may not be correct otherwise. At the top of this script, you are able to indicate whether:

1. The raw data should be processed to reformat survival data and estimate clutch sizes and hold times.  

2. The summary file (located in the Output/Reports directory) should be knit. This markdown file will generate figures and produce an HTML and a GitHub flavored markdown document summarizing the results.


## Versioning   

R version 4.1.3 (2022-03-10)

Platform: x86_64-apple-darwin17.0 (64-bit)  

Running under: macOS Ventura 13.3.1 
  
**Attached base packages:** stats, graphics, grDevices, utils, datasets, methods, base     

**Other attached packages:** 
httr_1.4.4, sass_0.4.5, jsonlite_1.8.4, splines_4.1.3, carData_3.0-5, modelr_0.1.8, bslib_0.4.2, assertthat_0.2.1, highr_0.10, cellranger_1.1.0, yaml_2.3.7, pillar_1.9.0, backports_1.4.1, lattice_0.20-45, glue_1.6.2, digest_0.6.31, ggsignif_0.6.3, rvest_1.0.2, colorspace_2.1-0, cowplot_1.1.1, htmltools_0.5.4, Matrix_1.4-0, pkgconfig_2.0.3, broom_0.7.12, haven_2.4.3, xtable_1.8-4, scales_1.2.1, km.ci_0.5-6, KMsurv_0.1-5, tzdb_0.3.0, timechange_0.2.0, mgcv_1.8-39, farver_2.1.1, generics_0.1.3, car_3.0-12, ellipsis_0.3.2, cachem_1.0.6, withr_2.5.0, monochromeR_0.1.4, cli_3.6.0, magrittr_2.0.3, crayon_1.5.2, readxl_1.3.1, evaluate_0.20, fs_1.6.0, fansi_1.0.4, nlme_3.1-155, rstatix_0.7.0, xml2_1.3.3, tools_4.1.3, data.table_1.14.6, hms_1.1.2, lifecycle_1.0.3, munsell_0.5.0, reprex_2.0.1, compiler_4.1.3, jquerylib_0.1.4, rlang_1.1.1, grid_4.1.3, rstudioapi_0.14, labeling_0.4.2, gtable_0.3.1, abind_1.4-5, DBI_1.1.3, R6_2.5.1, gridExtra_2.3, zoo_1.8-11, lubridate_1.9.2, knitr_1.42, fastmap_1.1.0, survMisc_0.5.6, utf8_1.2.3, stringi_1.7.12, Rcpp_1.0.10, vctrs_0.6.2, dbplyr_2.1.1, tidyselect_1.2.0, xfun_0.37


## Funding

No material support was required for this work. MCS is supported by an NSF postdoctoral fellowship (OCE-2205848).
