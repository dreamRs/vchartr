
library(vchartr)

# Add a title to the axis
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(name = "Electricity generation")

vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source)) %>%
  v_scale_y_continuous(name = "Electricity generation")

# Specify number of breaks
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(breaks = 10)

# Specify breaks position
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(breaks = c(0, 5000, 10000))

# Format labels
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(labels = "~s")

# Format labels with options
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(labels = format_num_d3(",", suffix = " TWh", locale = "fr-FR"))

vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source)) %>%
  v_scale_y_continuous(labels = format_num_d3(",", suffix = " TWh", locale = "fr-FR"))

