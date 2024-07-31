
library(vchartr)

# Classic Bar Chart
vchart(top_generation) %>% 
  v_bar(aes(country, electricity_generation))

# Horizontal Bar Chart
vchart(top_generation) %>% 
  v_bar(aes(country, electricity_generation), direction = "horizontal")

# Grouped Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source))

# Horizontal Grouped Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source), direction = "horizontal")

# Stacked Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source), stack = TRUE)

# Percentage Stacked Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source), stack = TRUE, percent = TRUE)
