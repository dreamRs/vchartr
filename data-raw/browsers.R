

library(jsonlite)

browsers <- jsonlite::fromJSON("data-raw/browser.json")
browsers <- do.call("rbind", browsers)
head(browsers)


vchart(browsers) %>%
  v_pie(aes(browserName, value, player = date))

vchart(browsers) %>%
  v_bar(aes(browserName, value, player = date))

vchart(browsers) %>%
  v_circlepacking(aes(browserName, value = value, player = date), label_visible = TRUE)

vchart(browsers) %>%
  v_treemap(aes(browserName, value, player = date))


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
  v_pie(aes(browserName, value), dataserie_id = "browser") %>%
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
jsonlite::toJSON(.Last.value$x$specs, pretty = TRUE, auto_unbox = TRUE)
