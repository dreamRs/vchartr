
library(vchartr)

data("economics", package = "ggplot2")
vchart(economics, aes(date, unemploy)) %>%
  v_line() %>%
  v_specs_datazoom()


co2_emissions %>%
  subset(country %in% c("China", "United States", "India")) %>%
  vchart() %>%
  v_line(aes(year, co2, color = country)) %>%
  v_specs_datazoom(start = "{label:.0f}", startValue = 1990, end = "{label:.0f}")
