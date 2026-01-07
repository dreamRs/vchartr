# Set color(s) for chart

Set color(s) for chart

## Usage

``` r
v_specs_colors(vc, ...)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- ...:

  Colors options, can be a single color code, a vector of colors to use
  or a list with more options. For `v_colors_manual` it should be a
  named list with data values as name and color as values.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)
data("mpg", package = "ggplot2")

vchart(table(Class = mpg$class)) %>%
  v_bar(aes(Class, Freq)) %>%
  v_specs_colors("#8FBCBB")

{"x":{"specs":{"type":"common","data":[{"id":"data_109ac483","values":[{"x":"2seater","y":5},{"x":"compact","y":47},{"x":"midsize","y":41},{"x":"minivan","y":11},{"x":"pickup","y":33},{"x":"subcompact","y":35},{"x":"suv","y":62}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_69bb7fc1","dataId":"data_109ac483","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"Freq"}],"color":["#8FBCBB"]},"data":[5,47,41,11,33,35,62],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
```
