# Set tooltip options

Set tooltip options

## Usage

``` r
v_specs_tooltip(vc, ..., .reset = FALSE)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- ...:

  Options for the tooltip, see examples or [online
  documentation](https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Tooltip).

- .reset:

  Reset previous tooltip configuration before updating.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)
data("mpg", package = "ggplot2")

vchart(table(Class = mpg$class, Year = mpg$year)) %>%
  v_bar(aes(Class, Freq, fill = Year)) %>%
  v_specs_tooltip(
    visible = FALSE
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_5076bb36","values":[{"x":"2seater","y":2,"fill":"1999"},{"x":"compact","y":25,"fill":"1999"},{"x":"midsize","y":20,"fill":"1999"},{"x":"minivan","y":6,"fill":"1999"},{"x":"pickup","y":16,"fill":"1999"},{"x":"subcompact","y":19,"fill":"1999"},{"x":"suv","y":29,"fill":"1999"},{"x":"2seater","y":3,"fill":"2008"},{"x":"compact","y":22,"fill":"2008"},{"x":"midsize","y":21,"fill":"2008"},{"x":"minivan","y":5,"fill":"2008"},{"x":"pickup","y":17,"fill":"2008"},{"x":"subcompact","y":16,"fill":"2008"},{"x":"suv","y":33,"fill":"2008"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_ed559e73","dataId":"data_5076bb36","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"Freq"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"tooltip":{"visible":false}},"data":[[2,3],[25,22],[20,21],[6,5],[16,17],[19,16],[29,33]],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
```
