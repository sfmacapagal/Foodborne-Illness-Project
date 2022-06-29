################################################################################
# Filename: 02-gg-time-series.R                                                #
# Path: src/02-gg-time-series.R                                                #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-11                                                     #
# Date modified: 2022-06-11                                                    #
# Purpose: This script plots some exploratory time series from the data.       #
# Inputs: df_outbreaks_summary                                                 #
# Outputs: df_outbreaks_filter                                                 #
# Notes:                                                                       #
################################################################################

df_outbreaks_filter <- df_outbreaks_summary %>%
  mutate(total_illnesses_filter = stats::filter(total_illnesses,
                                                sides = 1, filter = rep(1/6, 6)),
         total_hospitalizations_filter = stats::filter(total_hospitalizations,
                                                       sides = 1, filter = rep(1/6, 6)),
         total_fatalities_filter = stats::filter(total_fatalities,
                                                 sides = 1, filter = rep(1/6, 6)))



# graph of all illnesses over time ---------------------------------------------

ggplot(df_outbreaks_filter) +
  geom_line(aes(x = date,
                y = total_illnesses),
            col = "yellowgreen") +
  geom_line(aes(x = date,
                y = total_illnesses_filter),
            col = "red",
            size = 1,
            linetype = "dashed") +

  labs(x = "Date",
       y = "Illnesses per month",
       title = "Total Illnesses per Month",
       subtitle = "January 1998 - December 2015") +
  scale_x_date(date_labels = "%Y-%b",
               breaks = function(x) seq.Date(from = min(x),
                                             to = max(x),
                                             by = "2 years"),
               minor_breaks = function(x) seq.Date(from = min(x),
                                                   to = max(x),
                                                   by = "6 months")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
  NULL


# graph of all hospitalizations over time --------------------------------------

ggplot(df_outbreaks_filter) +
  # geom_line(aes(x = date,
  #               y = total_hospitalizations),
  #           col = "blue") +
  geom_line(aes(x = date,
                y = total_hospitalizations_filter),
            col = "red",
            size = 1,
            linetype = "dashed") +
  
  labs(x = "Date",
       y = "Hospitalizations per month",
       title = "Total Hospitalizations per Month",
       subtitle = "January 1998 - December 2015") +
  scale_x_date(date_labels = "%Y-%b",
               breaks = function(x) seq.Date(from = min(x),
                                             to = max(x),
                                             by = "2 years"),
               minor_breaks = function(x) seq.Date(from = min(x),
                                                   to = max(x),
                                                   by = "6 months")) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
  NULL

# graph of all fatalities over time --------------------------------------------

ggplot(df_outbreaks_filter) +
  # geom_line(aes(x = date,
  #               y = total_fatalities),
  #           col = "blue") +
  geom_line(aes(x = date,
                y = total_fatalities_filter),
            col = "red",
            size = 1,
            linetype = "dashed") +
  
  labs(x = "Date",
       y = "Fatalities per month",
       title = "Total Fatalities per Month",
       subtitle = "January 1998 - December 2015") +
  scale_x_date(date_labels = "%Y-%b",
               breaks = function(x) seq.Date(from = min(x),
                                             to = max(x),
                                             by = "2 years"),
               minor_breaks = function(x) seq.Date(from = min(x),
                                                   to = max(x),
                                                   by = "6 months")) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
  NULL


# graph of seasonality ---------------------------------------------------------

df_outbreaks_summary %>%
  mutate(month = factor(month, levels = month.name)) %>%
  ggplot() +
  geom_line(aes(x = month,
                y = total_illnesses,
                group = as.factor(year),
                col = as.factor(year))) +
  theme(legend.position = "bottom") +
  labs(x = "Month",
       y = "Total Illnesses",
       title = "Total Illnesses by Month",
       subtitle = "Grouped by Year",
       color = "Year")
