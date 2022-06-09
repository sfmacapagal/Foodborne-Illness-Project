################################################################################
# Filename: 01-graph-initial-ts.R                                              #
# Path: src/01-graph-initial-ts.R                                              #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-08                                                     #
# Date modified: 2022-06-09                                                    #
# Purpose: This script plots some exploratory time series from the data.       #
# Inputs: df_outbreaks                                                         #
# Outputs:                                                                     #
# Notes:                                                                       #
################################################################################

# graph of all illnesses over time ---------------------------------------------
tsplot(df_outbreaks$total_illnesses,
       main = "Total Illnesses",
       ylab = "Illnesses",
       col = 4)

ts_total_illnesses_filter <- stats::filter(df_outbreaks$total_illnesses,
                                           sides = 1,
                                           filter = rep(1/1000, 1000))

lines(ts_total_illnesses_filter,
      col = 2,
      lty = 2,
      lwd = 3)


# graph of all hospitalizations over time --------------------------------------
tsplot(df_outbreaks$total_hospitalizations,
       main = "Total Hospitalizations",
       ylab = "Hospitalizations",
       col = 4)

ts_total_hospitalizations_filter <- stats::filter(df_outbreaks$total_hospitalizations,
                                                  sides = 1,
                                                  filter = rep(1/1000, 1000))

lines(ts_total_hospitalizations_filter,
      col = 2,
      lty = 2,
      lwd = 3)


# graph of all fatalities over time --------------------------------------------
tsplot(df_outbreaks$total_fatalities,
       main = "Total Fatalities",
       ylab = "Fatalities",
       col = 4)

ts_total_fatalities_filter <- stats::filter(df_outbreaks$total_fatalities,
                                            sides = 1,
                                            filter = rep(1/1000, 1000))

lines(ts_total_fatalities_filter,
      col = 2,
      lty = 2,
      lwd = 3)
