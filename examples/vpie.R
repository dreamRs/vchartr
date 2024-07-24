
library(vchartr)

# Bvasic Pie Chart
subset(world_generation, year == 2023 & type == "total") %>% 
  vpie(aes(x = source, y = generation))

# Use custom colors
subset(world_electricity, year == 2023 & type == "total") %>% 
  vpie(aes(x = source, y = generation)) %>% 
  v_colors_manual(
    "Low carbon" = "#a3be8c", 
    "Fossil fuels" = "#4C566A"
  )

# Customize tooltip
subset(world_electricity, year == 2023 & type == "total") %>% 
  vpie(aes(x = source, y = generation)) %>% 
  v_tooltip(
    mark = list(
      content = list(
        list(
          key = JS("datum => datum['x']"),
          value = JS("datum => Math.round(datum['y']) + ' TWh'")
        ),
        list(
          hasShape = FALSE,
          key = "Proportion",
          value = JS("datum => datum._percent_ + '%'")
        )
      )
    )
  )

