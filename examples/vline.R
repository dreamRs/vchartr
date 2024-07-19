
library(vchartr)
data("economics", package = "ggplot2")
data("economics_long", package = "ggplot2")

vline(economics, aes(date, unemploy))
vline(economics_long, aes(date, value01, color = variable))

