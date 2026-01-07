# Create a Pie Chart

Create a Pie Chart

## Usage

``` r
v_pie(
  vc,
  mapping = NULL,
  data = NULL,
  name = NULL,
  label = list(visible = TRUE),
  ...,
  serie_id = NULL,
  data_id = NULL
)
```

## Arguments

- vc:

  A chart initialized with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- mapping:

  Default list of aesthetic mappings to use for chart.

- data:

  Default dataset to use for chart. If not already a `data.frame`, it
  will be coerced to with `as.data.frame`.

- name:

  Name for the serie, only used for single serie (no `color`/`fill`
  aesthetic supplied).

- label:

  Options for displaying labels on the pie chart.

- ...:

  Additional parameters for the serie.

- data_id, serie_id:

  ID for the data/serie, can be used to further customize the chart with
  [`v_specs()`](https://dreamrs.github.io/vchartr/reference/v_specs.md).

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

# Basic Pie Chart
subset(world_electricity, year == 2023 & type == "total") %>%
  vchart() %>% 
  v_pie(aes(x = source, y = generation))

{"x":{"specs":{"type":"common","data":[{"id":"data_828eb264","values":[{"x":"Low carbon","y":11599.64},{"x":"Fossil fuels","y":17879.41}]}],"series":[{"type":"pie","id":"serie_a2b4f4cc","dataId":"data_828eb264","seriesField":"x","valueField":"y","label":{"visible":true}}]},"data":[{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"pie"},"evals":[],"jsHooks":[]}
# Use custom colors
subset(world_electricity, year == 2023 & type == "total") %>%
  vchart() %>% 
  v_pie(aes(x = source, y = generation)) %>%
  v_scale_color_manual(c(
    "Low carbon" = "#a3be8c",
    "Fossil fuels" = "#4C566A"
  ))

{"x":{"specs":{"type":"common","data":[{"id":"data_6f093814","values":[{"x":"Low carbon","y":11599.64},{"x":"Fossil fuels","y":17879.41}]}],"series":[{"type":"pie","id":"serie_98197b79","dataId":"data_6f093814","seriesField":"x","valueField":"y","label":{"visible":true}}],"color":{"specified":{"Low carbon":"#a3be8c","Fossil fuels":"#4C566A"}}},"data":[{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"pie"},"evals":[],"jsHooks":[]}
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

{"x":{"specs":{"type":"common","data":[{"id":"data_49588d43","values":[{"x":"Low carbon","y":11599.64},{"x":"Fossil fuels","y":17879.41}]}],"series":[{"type":"pie","id":"serie_dc3fa300","dataId":"data_49588d43","seriesField":"x","valueField":"y","label":{"visible":true}}],"tooltip":{"mark":{"content":[{"key":"datum => datum['x']","value":"datum => Math.round(datum['y']) + ' TWh'"},{"hasShape":false,"key":"Proportion","value":"datum => datum._percent_ + '%'"}]}}},"data":[{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"pie"},"evals":["specs.tooltip.mark.content.0.key","specs.tooltip.mark.content.0.value","specs.tooltip.mark.content.1.value"],"jsHooks":[]}

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

{"x":{"specs":{"type":"common","data":[{"id":"data_559f478a","values":[{"x":"Low carbon","y":11599.64},{"x":"Fossil fuels","y":17879.41}]},{"id":"data_f777b1e0","values":[{"x":"Renewables","y":8913.9},{"x":"Nuclear","y":2685.74},{"x":"Oil","y":788.55},{"x":"Gas","y":6622.93},{"x":"Coal","y":10467.93}]}],"series":[{"type":"pie","id":"serie_d9080448","dataId":"data_559f478a","seriesField":"x","valueField":"y","label":{"visible":true,"position":"inside","rotate":false,"style":{"fill":"white"}},"outerRadius":0.65,"innerRadius":0,"pie":{"style":{"stroke":"#FFFFFF","lineWidth":2}}},{"type":"pie","id":"serie_0f97f580","dataId":"data_f777b1e0","seriesField":"x","valueField":"y","label":{"visible":true},"outerRadius":0.8,"innerRadius":0.67,"pie":{"style":{"stroke":"#FFFFFF","lineWidth":2}}}]},"data":null,"mapping":null,"type":["pie","pie"]},"evals":[],"jsHooks":[]}
```
