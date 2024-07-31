
library(vchartr)

vbar(
  top_generation,
  aes(country, electricity_generation)
) %>%
  v_scale_y_continuous(name = "Electricity generation")

vbar(
  top_generation,
  aes(country, electricity_generation)
) %>%
  v_scale_y_continuous(breaks = 10)


vbar(
  top_generation,
  aes(country, electricity_generation)
) %>%
  v_scale_y_continuous(breaks = c(0, 5000, 10000))


vbar(
  top_generation,
  aes(country, electricity_generation)
) %>%
  v_scale_y_continuous(labels = "~s")


vbar(
  top_generation,
  aes(country, electricity_generation)
) %>%
  v_scale_y_continuous(labels = d3_format(",", suffix = " TWh", locale = "fr-FR"))

