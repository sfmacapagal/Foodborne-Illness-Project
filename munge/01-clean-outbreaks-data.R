################################################################################
# Filename: 01-clean-outbreaks-data.R                                          #
# Path: munge/01-clean-outbreaks-data.R                                        #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-08                                                     #
# Date modified: 2022-06-08                                                    #
# Purpose: This script creates indices for the time series of outbreaks.       #
# Inputs: csv_outbreaks                                                        #
# Outputs: df_outbreaks                                                        #
# Notes:                                                                       #
################################################################################

# initial data frame indexed by month, where
# January 1998 is time = 0,
# total illnesses, hospitalizations, fatalities are grouped by month,
# independent of other variables

df_outbreaks <- csv_outbreaks %>%
  mutate(date = glue::glue("{year}-{month}"), # concatenates year-month
         date = lubridate::ym(date), # changes to date format
         time = lubridate::time_length(interval(min(date), date),
                                       unit = "month")) %>% # computes number
                                                            # of months since
                                                            # lowest date
  group_by(time) %>%
  mutate(total_illnesses = sum(illnesses, na.rm = TRUE),
         total_hospitalizations = sum(hospitalizations, na.rm = TRUE),
         total_fatalities = sum(fatalities, na.rm = TRUE))



