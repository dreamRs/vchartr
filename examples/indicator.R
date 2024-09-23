
library(vchartr)

electricity_mix %>% 
  subset(country == "France") %>%
  vchart() %>% 
  v_pie(
    aes(x = source, y = generation),
    outerRadius = 0.8,
    innerRadius = 0.5,
    padAngle = 0.6
  ) %>%
  v_specs_tooltip(visible = FALSE) %>% 
  v_specs_indicator(
    visible = TRUE,
    trigger = "hover",
    limitRatio = 0.5,
    title = list(
      visible = TRUE,
      autoFit = TRUE,
      fitStrategy = "inscribed",
      style = list(
        fontWeight = "bolder",
        fill = "#888",
        text = JS("datum => datum !== null ? datum.x : ''")
      )
    ),
    content = list(
      list(
        visible = TRUE,
        autoFit = TRUE,
        fitStrategy = "inscribed",
        style = list(
          fontWeight = "bolder",
          fill = "#000",
          text = JS("datum => datum !== null ? Math.round(datum.y) + 'TWh' : ''")
        )
      )
    )
  )
