################################################################################
# Filename: 01-get-outbreaks-data.R                                            #
# Path: data/01-get-outbreaks-data.R                                           #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-08                                                     #
# Date modified: 2022-06-08                                                    #
# Purpose: This script imports the CDC foodborne illness data set.             #
# Inputs: data/outbreaks.csv                                                   #
# Outputs:                                                                     #
# Notes: Source: https://www.kaggle.com/datasets/cdc/foodborne-diseases        #
################################################################################


csv_outbreaks <- read_csv(here::here("data", "outbreaks.csv")) %>%
  janitor::clean_names()
