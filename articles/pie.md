# pie

``` r
library(vchartr)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

## Pie

Add values for each items in the legend:

``` r
electricity_mix %>% 
  filter(country == "France") %>%
  arrange(desc(generation)) %>% 
  vchart() %>% 
  v_pie(aes(x = source, y = generation)) %>%
  v_scale_color_manual(c(
    "oil" = "#80549f",
    "coal" = "#a68832",
    "solar" = "#d66b0d",
    "gas" = "#f20809",
    "wind" = "#72cbb7",
    "hydro" = "#2672b0",
    "nuclear" = "#e4a701"
  )) %>% 
  v_specs_legend(
    orient = "right",
    data = JS(
      "items => {",
      sprintf(
        "var data = %s;", 
        electricity_mix %>%
          filter(country == "France") %>%
          arrange(desc(generation)) %>% 
          mutate(
            value = paste0(round(generation / sum(generation) * 100, 1), "%"),
            label = source
          ) %>%
          select(label, value) %>% 
          with(setNames(as.list(value), label)) %>% 
          jsonlite::toJSON(auto_unbox = TRUE)
      ),
      "return items.map(item => {
        item.value = data[item.label];
        return item;
      });",
      "}"
    ),
    item = list(
      width = "20%",
      value = list(
        alignRight = TRUE,
        style = list(
          fill = "#333",
          fillOpacity = 1
        )
      )
    )
  )
```

## Donut

Hover donut slices to reveal indicator card:

``` r
electricity_mix %>% 
  filter(country == "France") %>%
  arrange(desc(generation)) %>% 
  vchart() %>% 
  v_pie(
    aes(x = source, y = generation),
    outerRadius = 0.8,
    innerRadius = 0.5,
    padAngle = 0.6,
    pie = list(
      state = list(
        hover = list(
          outerRadius = 0.85,
          stroke = "#000",
          lineWidth = 1
        )
      )
    )
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
  ) %>% 
  v_scale_color_manual(c(
    "oil" = "#80549f",
    "coal" = "#a68832",
    "solar" = "#d66b0d",
    "gas" = "#f20809",
    "wind" = "#72cbb7",
    "hydro" = "#2672b0",
    "nuclear" = "#e4a701"
  )) %>% 
  v_specs_legend(visible = FALSE)
```
