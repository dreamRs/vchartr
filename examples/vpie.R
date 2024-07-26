
library(vchartr)

# Bvasic Pie Chart
subset(world_electricity, year == 2023 & type == "total") %>%
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


# Nested Pie Chart
subset(world_electricity, year == 2023) %>%
  vpie(aes(x = source, y = generation, group = type), dataserie_id = "pie") %>%
  v_specs(
    dataserie_id = "pie_total", # serie_id + '_' + group name
    outerRadius = 0.65,
    innerRadius = 0,
    label = list(
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
  v_specs(
    dataserie_id = "pie_detail", # serie_id + '_' + group name
    outerRadius = 0.8,
    innerRadius = 0.67,
    pie = list(
      style = list(
        stroke = "#FFFFFF",
        lineWidth = 2
      )
    )
  )

