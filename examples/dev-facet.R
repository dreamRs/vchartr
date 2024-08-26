
pkgload::load_all()

str(.Last.value$x$specs)

library(dplyr)
library(ggplot2)
vc <- vchart(mpg) %>%
  v_scatter(aes(displ, cty))

vc$x$specs$series

split(vc$x$specs$data[[1]]$values, f = as.character(mpg$cyl))[[2]]


str(create_layout(2, 2))

create_facet_data(vc, facet = as.character(mpg$cyl))
create_facet_series(vc, facet = as.character(mpg$cyl))

vchart(
  type = "common",
  layout = create_layout(2, 2),
  region = create_region(2, 2),
  indicator = create_indicator(as.character(mpg$cyl)),
  data = create_facet_data(vc, facet = as.character(mpg$cyl)),
  series = create_facet_series(vc, facet = as.character(mpg$cyl)),
  axes = list(
    list(
      id = "axe_y_1",
      orient = "left",
      regionId = paste0("chart_", 1),
      type = "linear",
      domainLine = list(visible = TRUE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minWidth = 20
    ),
    list(
      id = "axe_y_2",
      orient = "left",
      regionId = paste0("chart_", 2),
      type = "linear",
      label = list(visible = FALSE),
      domainLine = list(visible = FALSE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minWidth = 20
    ),
    list(
      id = "axe_y_3",
      orient = "left",
      regionId = paste0("chart_", 3),
      type = "linear",
      domainLine = list(visible = TRUE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minWidth = 20
    ),
    list(
      id = "axe_y_4",
      orient = "left",
      regionId = paste0("chart_", 4),
      type = "linear",
      label = list(visible = FALSE),
      domainLine = list(visible = FALSE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(y) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minWidth = 20
    ),
    list(
      id = "axe_x_1",
      orient = "bottom",
      regionId = paste0("chart_", 1),
      type = "linear",
      visible = TRUE,
      label = list(visible = FALSE),
      domainLine = list(visible = FALSE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minHeight = 20
    ),
    list(
      id = "axe_x_2",
      orient = "bottom",
      regionId = paste0("chart_", 2),
      type = "linear",
      visible = TRUE,
      label = list(visible = FALSE),
      domainLine = list(visible = FALSE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minHeight = 20
    ),
    list(
      id = "axe_x_3",
      orient = "bottom",
      regionId = paste0("chart_", 3),
      type = "linear",
      domainLine = list(visible = TRUE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minHeight = 20
    ),
    list(
      id = "axe_x_4",
      orient = "bottom",
      regionId = paste0("chart_", 4),
      type = "linear",
      domainLine = list(visible = TRUE),
      zero = FALSE,
      # seriesId = paste0("serie_", 1:4),
      softMin = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% min(na.rm = TRUE),
      softMax = mpg %>% select(x = displ, y = cty) %>% pull(x) %>% max(na.rm = TRUE),
      expand = list(min = 0.2, max = 0.2),
      minHeight = 20
    )
  )
)
