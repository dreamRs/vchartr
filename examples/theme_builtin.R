
library(vchartr)

vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_theme_builtin("dark")

vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_theme_builtin("vScreenVolcanoBlue")

vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_theme_builtin("vScreenClean")

vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_theme_builtin("chartHubLight")

