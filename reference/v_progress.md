# Create a Progress Chart

Create a Progress Chart

## Usage

``` r
v_progress(
  vc,
  mapping = NULL,
  data = NULL,
  name = NULL,
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

vchart() %>%
  v_progress(aes(0.85, "My progress"))

{"x":{"specs":{"type":"linearProgress","data":[{"id":"data_72950fd0","values":[{"x":0.85,"y":"My progress"}]}],"id":"serie_cd3812f9","dataId":"data_72950fd0","xField":"x","yField":"y","seriesField":"y","direction":"horizontal"},"data":null,"mapping":null,"type":"progress"},"evals":[],"jsHooks":[]}
data.frame(
  x = c(0.4, 0.3, 0.8, 0.6),
  y = paste("Course", 1:4)
) %>%
  vchart() %>%
  v_progress(
    aes(x, y),
    cornerRadius = 20,
    bandWidth = 30
  ) %>%
  v_scale_y_discrete(
    label = list(visible = TRUE),
    domainLine = list(visible = FALSE)
  )

{"x":{"specs":{"type":"linearProgress","data":[{"id":"data_403409a3","values":[{"x":0.4,"y":"Course 1"},{"x":0.3,"y":"Course 2"},{"x":0.8,"y":"Course 3"},{"x":0.6,"y":"Course 4"}]}],"id":"serie_e3010ce4","dataId":"data_403409a3","xField":"x","yField":"y","seriesField":"y","direction":"horizontal","cornerRadius":20,"bandWidth":30,"axes":[{"orient":"left","type":"band","label":{"visible":true},"domainLine":{"visible":false}}]},"data":[{"x":0.4,"y":"Course 1"},{"x":0.3,"y":"Course 2"},{"x":0.8,"y":"Course 3"},{"x":0.6,"y":"Course 4"}],"mapping":null,"type":"progress"},"evals":[],"jsHooks":[]}
```
