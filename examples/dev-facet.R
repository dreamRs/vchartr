

pkgload::load_all()


library(dplyr)
library(ggplot2)
library(rlang)

str(.Last.value$x$specs)

vc <- vchart(mpg) %>%
  v_scatter(aes(displ, cty))

vc$x$specs$axes


mat <- matrix(data = seq_len(2 * 2), nrow = 2, ncol = 2, byrow = TRUE)

create_axis_x(vc, x = mpg %>% pull(displ), facet = mpg$cyl, free = FALSE, last_row = c(3, 4))


facets_values <- get_facets_values(mpg, vars(cyl))
create_indicator(facets_values, label_fun = ggplot2::label_value)

ggplot2::label_value(c(8, "totot"), multi_line = TRUE)

vc <- vchart(mpg) %>%
  v_scatter(aes(displ, cty)) %>%
  v_facet_wrap(vars(cyl))


vchart(mpg) %>%
  v_scatter(aes(displ, cty)) %>%
  v_facet_wrap(vars(cyl, year))



vc$x$specs$indicator

ggplot(mpg) +
  geom_point(aes(displ, cty)) +
  facet_wrap(vars(cyl), scales = "fixed")


str(create_layout(2, 2))

create_facet_data(vc, facet = as.character(mpg$cyl))
create_facet_series(vc, facet = as.character(mpg$cyl))

vchart(
  type = "common",
  # title = list(text = "Title", id = "title"),
  layout = create_layout(2, 2, title = FALSE),
  region = create_region(2, 2),
  indicator = create_indicator(as.character(mpg$cyl)),
  data = create_facet_data(vc, facet = as.character(mpg$cyl)),
  series = create_facet_series(vc, facet = as.character(mpg$cyl)),
  axes = c(
    create_axis_x(vc, x = mpg %>% pull(displ), facet = mpg$cyl, free = TRUE, last_row = c(3, 4)),
    create_axis_y(vc, y = mpg %>% pull(cty), facet = mpg$cyl, free = TRUE, first_col = c(1, 3))
  )
)


facets <- eval_mapping_(mpg, vars(year, drv))
unique(as.data.frame(facets, col.names = lapply(vars(year, drv), as_label)))


n_facet(facets)

get_facets_dims(6)


get_facets_values(mpg, vars(year, drv))

split(mpg, f = get_facets_values(mpg, vars(year, drv))$facet_id)

