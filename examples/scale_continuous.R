
library(vchartr)

vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(name = "Electricity generation")

vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(breaks = 10)


vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(breaks = c(0, 5000, 10000))


vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(labels = "~s")


vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(labels = d3_format(",", suffix = " TWh", locale = "fr-FR"))

