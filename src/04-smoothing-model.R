################################################################################
# Filename: 04-smoothing-model.R                                               #
# Path: src/04-smoothing-model.R                                               #
# Author: Steven Macapagal                                                     #
# Date created: 2022-06-29                                                     #
# Date modified: 2022-06-29                                                    #
# Purpose: This script uses smoothing techniques from section 3.3.             #
# Inputs: df_new                                                               #
# Outputs: df_seasonal                                                         #
# Notes:                                                                       #
################################################################################


# loess smoothing --------------------------------------------------------------
tsplot(df_outbreaks_summary$log_illnesses)
lines(lowess(df_outbreaks_summary$log_illnesses, f = 0.05), lwd=2, col=4)
lo <- predict(loess(log_illnesses ~ time,
                    data = df_outbreaks_summary),
              se=TRUE)
trnd <- ts(lo$fit)
lines(trnd, col=6, lwd=2)
L = trnd - qt(0.975, lo$df)*lo$se; U = trnd + qt(0.975, lo$df)*lo$se
xx <- c(df_outbreaks_summary$time, rev(df_outbreaks_summary$time)); yy <- c(L, rev(U))
polygon(xx, yy, border=8, col=gray(.6, alpha=.4))


# use structural equation model x_t = T_t + S_t + N_t --------------------------
df_seasonal <- df_outbreaks_summary %>%
  pull(log_illnesses) %>%
  ts(frequency = 12, start = c(1998, 1))

plot(decompose(df_seasonal))

plot(stl(df_seasonal, s.window = "per"))

culer = c(2:13)
par(mfrow = c(4, 1), cex.main = 1)

out = stl(df_seasonal, s.window = 15)$time.series

tsplot(df_seasonal, col=gray(.7))
text(df_seasonal, labels=1:12, col=culer, cex=1.25)

tsplot(out[,1], main="Seasonal", col=gray(.7))
text(out[,1], labels=1:12, col=culer, cex=1.25)

tsplot(out[,2], main="Trend", col=gray(.7))
text(out[,2], labels=1:12, col=culer, cex=1.25)

tsplot(out[,3], main="Noise", col=gray(.7))
text(out[,3], labels=1:12, col=culer, cex=1.25)