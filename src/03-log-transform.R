################################################################################
# Filename: 03-log-difference-plots.R                                          #
# Path: src/03-log-difference-plots.R                                          #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-28                                                     #
# Date modified: 2022-07-09                                                    #
# Purpose: This script log transforms the illness data to reduce any           #
#           heteroskedasticity in the data.                                    #
# Inputs: df_outbreaks_summary                                                 #
# Outputs:                                                                     #
# Notes:                                                                       #
################################################################################


# ggplot of log(Illnesses) time series -----------------------------------------

df_outbreaks_summary %>%
  ggplot() + 
  geom_line(aes(x = date,
                y = log_illnesses),
            col = "dodgerblue",
            size = 0.8) +
  labs(x = "Date",
       y = "log(Illnesses) per month",
       title = "log(Illnesses) per Month",
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

# ggsave("graphs/08-log-illnesses.png", dpi = 600)

# lag approach -----------------------------------------------------------------

lag1.plot(df_outbreaks_summary$log_illnesses, 12)
lag2.plot(df_outbreaks_summary$log_illnesses, df_outbreaks_summary$log_hospitalizations, 6)

# differencing approach --------------------------------------------------------
#
# NOTE: differencing produces smaller ACF, particularly with log transformations
#
# 
# tsplot(diff(df_outbreaks_summary$log_illnesses),
#        main = "Differenced log(Illnesses)",
#        ylab = "Change in log(Illnesses)")


## ggplot for differenced log illnesses
df_outbreaks_summary %>%
  ggplot() +
  geom_line(aes(x = date,
                y = diff_log_illnesses),
            col = "dodgerblue",
            size = 0.9) +
  labs(x = "Date",
       y = TeX("$\\nabla$ log(Illnesses) per month"),
       title = "Differenced log(Illnesses) per Month",
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

# ggsave("graphs/09-diff-log-illnesses.png", dpi = 600)

## Q-Q plot for differenced log illnesses
df_outbreaks_summary %>%
  ggplot(aes(sample = diff_log_illnesses)) +
  geom_qq(shape = "circle open") +
  geom_qq_line(col = "dodgerblue",
               size = 1) +
  labs(x = "Theoretical Quantiles",
       y = "Sample Quantiles",
       title = "Normal Q-Q Plot",
       subtitle = TeX("$\\nabla$ log(Illnesess)")) +
  theme_minimal()

## ggplot for ACF
df_outbreaks_summary$diff_log_illnesses %>%
  ggAcf(size = 1,
        col = "dodgerblue") +
  labs(title = TeX("ACF for $\\nabla$ log(Illnesses)")) +
  theme_minimal()

# ggsave("graphs/10-acf-diff-log-illnesses.png", dpi = 600)

## ggplot for PACF
df_outbreaks_summary$diff_log_illnesses %>%
  ggPacf(size = 1,
         col = "dodgerblue") +
  labs(title = TeX("PACF for $\\nabla$ log(Illnesses)")) +
  theme_minimal()

# ggsave("graphs/11-pacf-diff-log-illnesses.png", dpi = 600)


# acf1(diff(df_outbreaks_summary$log_illnesses)) # 1 lag is significant
# pacf(diff(df_outbreaks_summary$log_illnesses)) # 2 lags are significant
# qqnorm(df_outbreaks_summary$log_illnesses); qqline(df_outbreaks_summary$log_illnesses, col=2, lwd=2)
# qqnorm(diff(df_outbreaks_summary$log_illnesses)); qqline(diff(df_outbreaks_summary$log_illnesses), col=2, lwd=2)

# tsplot(diff(df_outbreaks_summary$total_illnesses))
# acf1(diff(df_outbreaks_summary$total_illnesses))
# qqnorm(df_outbreaks_summary$total_illnesses); qqline(df_outbreaks_summary$total_illnesses, col=2, lwd=2)
# 
# tsplot(diff(df_outbreaks_summary$total_hospitalizations))
# 
# tsplot(diff(df_outbreaks_summary$log_hospitalizations))



# detrending approach ----------------------------------------------------------

# NOTE: detrending using lm produces stronger ACF, particularly with log transformations
#
# fit <- lm(total_illnesses ~ time(total_illnesses), 
#           data = df_outbreaks_summary,
#           na.action = NULL)
# tsplot(resid(fit))
# acf1(resid(fit))
# 
# 
# fit_log <- lm(log_illnesses ~ time(log_illnesses),
#               data = df_outbreaks_summary,
#               na.action = NULL)
# tsplot(resid(fit_log))
# acf1(resid(fit_log))
# 
# 
# pacf(diff(df_outbreaks_summary$log_illnesses))
