################################################################################
# Filename: 01-graph-initial-ts.R                                              #
# Path: src/01-graph-initial-ts.R                                              #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-08                                                     #
# Date modified: 2022-06-11                                                    #
# Purpose: This script plots some exploratory time series from the data.       #
# Inputs: df_outbreaks                                                         #
# Outputs:                                                                     #
# Notes:                                                                       #
################################################################################

# graph of all illnesses over time ---------------------------------------------
tsplot(x = df_outbreaks_summary$date,
       y = df_outbreaks_summary$total_illnesses,
       main = "Total Illnesses per Month",
       xlab = "Time",
       ylab = "Illnesses",
       col = 4)

ts_total_illnesses_filter <- stats::filter(df_outbreaks_summary$total_illnesses,
                                           sides = 1,
                                           filter = rep(1/10, 10))

lines(x = df_outbreaks_summary$date,
      y = ts_total_illnesses_filter,
      col = 2,
      lty = 2,
      lwd = 3)

ggplot() +
  geom_line(aes(x = df_outbreaks_summary$date,
                y = df_outbreaks_summary$total_illnesses),
            col = "blue") +
  geom_line(aes(x = df_outbreaks_summary$date,
                y = ts_total_illnesses_filter),
            col = "red",
            size = 1,
            linetype = "dashed") +
  theme_grey() +
  labs(x = "Date",
       y = "Illnesses per month",
       title = "Total illnesses per month") +
  NULL
  
  


# graph of all hospitalizations over time --------------------------------------
tsplot(x = df_outbreaks_summary$date,
       y = df_outbreaks_summary$total_hospitalizations,
       main = "Total Hospitalizations per Month",
       xlab = "Time",
       ylab = "Hospitalizations",
       col = 4)

ts_total_hospitalizations_filter <- stats::filter(df_outbreaks_summary$total_hospitalizations,
                                                  sides = 1,
                                                  filter = rep(1/10, 10))

lines(x = df_outbreaks_summary$date,
      y = ts_total_hospitalizations_filter,
      col = 2,
      lty = 2,
      lwd = 3)


# graph of all fatalities over time --------------------------------------------
tsplot(x = df_outbreaks_summary$date,
       y = df_outbreaks_summary$total_fatalities,
       main = "Total Fatalities per Month",
       ylab = "Fatalities",
       col = 4)

ts_total_fatalities_filter <- stats::filter(df_outbreaks_summary$total_fatalities,
                                            sides = 1,
                                            filter = rep(1/10, 10))

lines(x = df_outbreaks_summary$date,
      y = ts_total_fatalities_filter,
      col = 2,
      lty = 2,
      lwd = 3)
