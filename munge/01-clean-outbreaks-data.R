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

# df_outbreaks_full <- csv_outbreaks %>%
#   mutate(date = glue::glue("{year}-{month}"), # concatenates year-month
#          date = ym(date), # changes to date format
#          time = time_length(interval(min(date), date),
#                             unit = "month")) %>% # computes number
#                                                             # of months since
#                                                             # lowest date
#   group_by(time) %>%
#   mutate(total_illnesses = sum(illnesses, na.rm = TRUE),
#          total_hospitalizations = sum(hospitalizations, na.rm = TRUE),
#          total_fatalities = sum(fatalities, na.rm = TRUE))


df_outbreaks_summary <- csv_outbreaks %>%
  mutate(date = glue::glue("{year}-{month}"), # concatenates year-month
         date = ym(date), # changes to date format
         time = time_length(interval(min(date), date),
                            unit = "month")) %>% # computes number
  # of months since
  # lowest date
  group_by(time, year, month, date) %>%
  summarize(total_illnesses = sum(illnesses, na.rm = TRUE),
         total_hospitalizations = sum(hospitalizations, na.rm = TRUE),
         total_fatalities = sum(fatalities, na.rm = TRUE),
         log_illnesses = log(total_illnesses),
         log_hospitalizations = log(total_hospitalizations),
         log_fatalities = log(total_fatalities)) %>%
  ungroup() %>%
  mutate(diff_log_illnesses = c(NA, diff(log_illnesses)),
         diff_log_hospitalizations = c(NA, diff(log_hospitalizations)),
         diff_log_fatalities = c(NA, diff(log_fatalities))) %>%
  arrange(time)


# df_outbreaks_summary %>%
#   mutate(month = factor(month, levels = month.name),
#          year = factor(year)) %>%
#   group_by(month) %>%
#   summarize(mean_illnesses = mean(total_illnesses, na.rm = TRUE)) %>%
#   ungroup() %>%
#   ggplot() + 
#   geom_line(aes(x = month,
#                 y = mean_illnesses))
#   

