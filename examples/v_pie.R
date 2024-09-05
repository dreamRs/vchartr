
library(vchartr)

# Basic Pie Chart
subset(world_electricity, year == 2023 & type == "total") %>%
  vchart() %>% 
  v_pie(aes(x = source, y = generation))

# Use custom colors
subset(world_electricity, year == 2023 & type == "total") %>%
  vchart() %>% 
  v_pie(aes(x = source, y = generation)) %>%
  v_scale_color_manual(c(
    "Low carbon" = "#a3be8c",
    "Fossil fuels" = "#4C566A"
  ))

# Customize tooltip
subset(world_electricity, year == 2023 & type == "total") %>%
  vchart() %>% 
  v_pie(aes(x = source, y = generation)) %>%
  v_specs_tooltip(
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


# Nested Pie Chart
vchart() %>% 
  v_pie(
    data = subset(world_electricity, year == 2023 & type == "total"),
    mapping = aes(x = source, y = generation),
    outerRadius = 0.65,
    innerRadius = 0,
    label = list(
      visible = TRUE,
      position = "inside",
      rotate = FALSE,
      style = list(fill = "white")
    ),
    pie = list(
      style = list(
        stroke = "#FFFFFF",
        lineWidth = 2
      )
    )
  ) %>% 
  v_pie(
    data = subset(world_electricity, year == 2023 & type == "detail"),
    mapping = aes(x = source, y = generation),
    outerRadius = 0.8,
    innerRadius = 0.67,
    pie = list(
      style = list(
        stroke = "#FFFFFF",
        lineWidth = 2
      )
    )
  ) 
