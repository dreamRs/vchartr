# Set chart title and subtitle

Set chart title and subtitle

## Usage

``` r
v_labs(vc, title = NULL, subtitle = NULL, x = NULL, y = NULL)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- title:

  Title for the chart.

- subtitle:

  Subtitle for the chart.

- x, y:

  Axes titles.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)
data("mpg", package = "ggplot2")

vchart(table(Class = mpg$class), aes(Class, Freq)) %>%
  v_bar() %>%
  v_labs(
    title = "Title for the chart",
    subtitle = "A subtitle to be placed under the title"
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_8adff4b9","values":[{"x":"2seater","y":5},{"x":"compact","y":47},{"x":"midsize","y":41},{"x":"minivan","y":11},{"x":"pickup","y":33},{"x":"subcompact","y":35},{"x":"suv","y":62}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_e1bf1928","dataId":"data_8adff4b9","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"Freq"}],"title":{"text":"Title for the chart","subtext":"A subtitle to be placed under the title"}},"data":[5,47,41,11,33,35,62],"mapping":{"x":{},"y":{}},"type":"bar"},"evals":[],"jsHooks":[]}
```
