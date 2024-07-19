
library(vchartr)

# Classic Bar Chart
vbar(
  top_generation,
  aes(country, electricity_generation)
)

# Horizontal Bar Chart
vbar(
  top_generation,
  aes(country, electricity_generation),
  direction = "horizontal"
)


# Grouped Bar Chart
vbar(
  world_generation,
  aes(year, generation, fill = source)
)

# Horizontal Grouped Bar Chart
vbar(
  world_generation,
  aes(year, generation, fill = source),
  direction = "horizontal"
)

# Stacked Bar Chart
vbar(
  world_generation,
  aes(year, generation, fill = source),
  stack = TRUE
)

# Percentage Stacked Bar Chart
vbar(
  world_generation,
  aes(year, generation, fill = source),
  stack = TRUE,
  percent = TRUE
)

