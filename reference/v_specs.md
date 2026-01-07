# Specify configuration options for a [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

Specify configuration options for a
[`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

## Usage

``` r
v_specs(vc, ..., serie_id = NULL, drop_nulls = FALSE)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- ...:

  List of options to specify for the chart, see
  <https://www.visactor.io/vchart/option/>.

- serie_id:

  Used to set or modify options for a chart where there are multiple
  series. You can use :

  - a `numeric` to target the position of the serie in the order where
    it's added to the chart

  - a `character` to refer to a `serie_id` set when the serie was added
    to the plot.

- drop_nulls:

  Drop NULL elements from the options.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)
data("mpg", package = "ggplot2")

vchart(table(Class = mpg$class)) %>%
  v_bar(aes(Class, Freq)) %>%
  v_specs(
    label = list(visible = TRUE),
    color = list("firebrick")
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_65a61a29","values":[{"x":"2seater","y":5},{"x":"compact","y":47},{"x":"midsize","y":41},{"x":"minivan","y":11},{"x":"pickup","y":33},{"x":"subcompact","y":35},{"x":"suv","y":62}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_d614dfe9","dataId":"data_65a61a29","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"Freq"}],"label":{"visible":true},"color":["firebrick"]},"data":[5,47,41,11,33,35,62],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
```
