################################################################################
# Filename: 03-log-transform.R                                                 #
# Path: src/03-log-transform.R                                                 #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-28                                                     #
# Date modified: 2022-06-28                                                    #
# Purpose: This script log transforms the illness data to reduce any           #
#           heteroskedasticity in the data.                                    #
# Inputs: df_outbreaks_summary                                                 #
# Outputs:                                                                     #
# Notes:                                                                       #
################################################################################


df_outbreaks_summary %>%
  ggplot() + 
  geom_line(aes(x = date,
                y = log_illnesses))

# lag plots
lag1.plot(df_outbreaks_summary$log_illnesses, 12)
lag2.plot(df_outbreaks_summary$log_illnesses, df_outbreaks_summary$log_hospitalizations, 6)

# differencing produces smaller ACF, particularly with log transformations
tsplot(diff(df_outbreaks_summary$log_illnesses))
acf1(diff(df_outbreaks_summary$log_illnesses))
qqnorm(df_outbreaks_summary$log_illnesses); qqline(df_outbreaks_summary$log_illnesses, col=2, lwd=2)
qqnorm(diff(df_outbreaks_summary$log_illnesses)); qqline(diff(df_outbreaks_summary$log_illnesses), col=2, lwd=2)

tsplot(diff(df_outbreaks_summary$total_illnesses))
acf1(diff(df_outbreaks_summary$total_illnesses))
qqnorm(df_outbreaks_summary$total_illnesses); qqline(df_outbreaks_summary$total_illnesses, col=2, lwd=2)

tsplot(diff(df_outbreaks_summary$total_hospitalizations))

tsplot(diff(df_outbreaks_summary$log_hospitalizations))


# detrending using lm produces stronger ACF, particularly with log transformations
fit <- lm(total_illnesses ~ time(total_illnesses), 
          data = df_outbreaks_summary,
          na.action = NULL)
tsplot(resid(fit))
acf1(resid(fit))


fit_log <- lm(log_illnesses ~ time(log_illnesses),
              data = df_outbreaks_summary,
              na.action = NULL)
tsplot(resid(fit_log))
acf1(resid(fit_log))


