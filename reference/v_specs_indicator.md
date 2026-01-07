# Add indicator to chart

Add indicator to chart

## Usage

``` r
v_specs_indicator(vc, ...)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- ...:

  Options for the legend, see examples or [online
  documentation](https://www.visactor.io/vchart/option/commonChart#indicator).

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
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

{"x":{"specs":{"type":"common","data":[{"id":"data_aa8f4f60","values":[{"x":"solar","y":23.26},{"x":"wind","y":48.61},{"x":"hydro","y":53.19},{"x":"nuclear","y":335.65},{"x":"oil","y":9.710000000000001},{"x":"gas","y":31.43},{"x":"coal","y":2.16}]}],"series":[{"type":"pie","id":"serie_9dde1db7","dataId":"data_aa8f4f60","seriesField":"x","valueField":"y","label":{"visible":true},"outerRadius":0.8,"innerRadius":0.5,"padAngle":0.6}],"tooltip":{"visible":false},"indicator":[{"visible":true,"trigger":"hover","limitRatio":0.5,"title":{"visible":true,"autoFit":true,"fitStrategy":"inscribed","style":{"fontWeight":"bolder","fill":"#888","text":"datum => datum !== null ? datum.x : ''"}},"content":[{"visible":true,"autoFit":true,"fitStrategy":"inscribed","style":{"fontWeight":"bolder","fill":"#000","text":"datum => datum !== null ? Math.round(datum.y) + 'TWh' : ''"}}]}]},"data":[{"country":"France","source":"solar","generation":23.26,"type":"Low carbon"},{"country":"France","source":"wind","generation":48.61,"type":"Low carbon"},{"country":"France","source":"hydro","generation":53.19,"type":"Low carbon"},{"country":"France","source":"nuclear","generation":335.65,"type":"Low carbon"},{"country":"France","source":"oil","generation":9.710000000000001,"type":"Fossil fuels"},{"country":"France","source":"gas","generation":31.43,"type":"Fossil fuels"},{"country":"France","source":"coal","generation":2.16,"type":"Fossil fuels"}],"mapping":null,"type":"pie"},"evals":["specs.indicator.0.title.style.text","specs.indicator.0.content.0.style.text"],"jsHooks":[]}
```
