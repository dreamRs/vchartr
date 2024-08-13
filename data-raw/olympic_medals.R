
# Source : https://www.kaggle.com/datasets/piterfm/olympic-games-medals-19862018

library(data.table)
olympic_medals <- fread("data-raw/olympic_results.csv")

olympic_medals_fr <- olympic_medals[country_name %in% c("France", "Italy", "Great Britain") & medal_type != "", list(n = .N), by = list(country_name, slug_game, medal_type)]
olympic_medals_fr[, year := gsub(".*(\\d{4})", "\\1", slug_game)]
olympic_medals_fr[, medal_type := factor(medal_type, levels = c("BRONZE", "SILVER", "GOLD"))]
olympic_medals_fr <- merge(
  x = CJ(
    year = unique(olympic_medals_fr$year),
    country_name = unique(olympic_medals_fr$country_name),
    medal_type = unique(olympic_medals_fr$medal_type)
  ),
  y = olympic_medals_fr,
  all.x = TRUE
)
olympic_medals_fr[is.na(n), n := 0]
setorder(olympic_medals_fr, year, medal_type)
olympic_medals_fr





vchart(subset(olympic_medals_fr, country_name == "France")) %>%
  v_bar(
    aes(medal_type, n, fill = medal_type, player = year),
    direction = "h",
    dataserie_id = "medals"
  ) %>%
  v_specs(dataserie_id = "medals", yField = "x") %>%
  v_scale_x_continuous(min = 0, max = 40) %>%
  v_specs_colors_manual(
    "BRONZE"="#8E6031",
    "SILVER"="#95948E",
    "GOLD"="#D1AE31"
  ) %>%
  v_specs_custom_mark(
    type = "text",
    dataId = "medals",
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




vchart(olympic_medals_fr) %>% # subset(olympic_medals_fr, year == 2000)
  v_bar(
    aes(country_name, n, fill = medal_type, group = medal_type, player = year),
    direction = "h",
    dataserie_id = "medals"
  ) %>%
  v_scale_x_continuous(min = 0, max = max(olympic_medals_fr$n) + 3) %>%
  v_specs(dataserie_id = "medals", yField = c("x", "fill")) %>%
  v_specs_colors_manual(
    "BRONZE"="#8E6031",
    "SILVER"="#95948E",
    "GOLD"="#D1AE31"
  ) %>%
  v_specs_custom_mark(
    type = "text",
    dataId = "medals",
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
