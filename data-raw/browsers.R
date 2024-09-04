
# source  : https://www.visactor.io/vchart/demo/player/basic-player

library(jsonlite)

browsers <- jsonlite::fromJSON("data-raw/browser.json")
browsers <- do.call("rbind", browsers)
head(browsers)


vchart(browsers) %>%
  v_pie(aes(browserName, value, player = date), serie_id = "my_id") %>%
  v_specs(
    customMark = list(
      list(
        type = "text",
        dataId = "my_id",
        style = list(
          textBaseline = "bottom",
          fontSize = 120,
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
            " return ctx.vchart.getChart().getCanvasRect().height - 50;",
            "}"
          ),
          fill = "grey",
          fillOpacity = 0.5
        )
      )
    )
  )

vchart(browsers) %>%
  v_bar(aes(browserName, value, player = date), direction = "h")

vchart(browsers) %>%
  v_circlepacking(aes(browserName, value = value, player = date), label_visible = TRUE)

vchart(browsers) %>%
  v_treemap(aes(browserName, value, player = date), label = list(visible = TRUE))


# browsers <- subset(browsers, browserName %in% c("Chrome", "IE"))

specs <- lapply(
  X = unname(split(browsers, browsers$date)),
  FUN = function(dat) {
    list(
      data = list(
        id = "browser",
        values = create_values(eval_mapping_(dat, aes(browserName, value)))
      )
    )
  }
)


mapdata <- eval_mapping_(browsers, aes(browserName, value, player = date))

lapply(
  X = unname(split(as.data.frame(mapdata), mapdata$player)),
  FUN = as.list
)


jsonlite::toJSON(specs, pretty = FALSE, auto_unbox = TRUE)

vchart(subset(browsers, date == 2010)) %>%
  v_pie(aes(browserName, value, player = date))

vchart(subset(browsers, date == 2010)) %>%
  v_pie(aes(browserName, value), serie_id = "browser") %>%
  v_specs(
    player = list(
      auto = FALSE,
      loop = FALSE,
      alternate = TRUE,
      interval = 500,
      width = 500,
      position = "middle",
      type = "discrete",
      specs = specs
    )
  )

str(.Last.value$x$specs)
jsonlite::toJSON(.Last.value$x$specs, pretty = TRUE, auto_unbox = TRUE, force = TRUE)
