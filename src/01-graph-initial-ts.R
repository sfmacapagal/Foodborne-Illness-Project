################################################################################
# Filename: 01-graph-initial-ts.R                                              #
# Path: src/01-graph-initial-ts.R                                              #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-08                                                     #
# Date modified: 2022-06-08                                                    #
# Purpose: This script plots some exploratory time series from the data.       #
# Inputs: df_outbreaks                                                         #
# Outputs:                                                                     #
# Notes:                                                                       #
################################################################################

# graph of all illnesses over time
tsplot(df_outbreaks$total_illnesses)


# graph of all hospitalizations over time
tsplot(df_outbreaks$total_hospitalizations)


# graph of all fatalities over time
tsplot(df_outbreaks$total_fatalities)
