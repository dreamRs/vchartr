
library(vchartr)

world_electricity %>% 
  subset(type == "detail") %>% 
  vchart() %>%
  v_bar(
    aes(source, generation, player = year),
    direction = "h",
    data_id = "mydata"
  ) %>%
  v_specs_custom_mark(
    type = "text",
    dataId = "mydata",
    style = list(
      textBaseline = "bottom",
      fontSize = 60,
      textAlign = "right",
      fontWeight = 700,
      text = JS("datum => datum.player"),
      x = JS(
        "(datum, ctx) => {",
        " return ctx.vchart.getChart().getCanvasRect().width - 50;",
        "}"
      ),
      y = JS(
        "(datum, ctx) => {",
        " return ctx.vchart.getChart().getCanvasRect().height - 150;",
        "}"
      ),
      fill = "grey",
      fillOpacity = 0.5
    )
  )
