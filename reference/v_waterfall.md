# Create a Waterfall Chart

Create a Waterfall Chart

## Usage

``` r
v_waterfall(
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

balance <- data.frame(
  desc = c("Starting Cash",
           "Sales", "Refunds", "Payouts", "Court Losses",
           "Court Wins", "Contracts", "End Cash"),
  amount = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800)
)

vchart(balance) %>% 
  v_waterfall(aes(x = desc, y = amount))

{"x":{"specs":{"type":"common","data":[{"id":"data_da4afc7e","values":[{"x":"Starting Cash","y":2000},{"x":"Sales","y":3400},{"x":"Refunds","y":-1100},{"x":"Payouts","y":-100},{"x":"Court Losses","y":-6600},{"x":"Court Wins","y":3800},{"x":"Contracts","y":1400},{"x":"End Cash","y":2800}]}],"series":[{"type":"waterfall","id":"serie_572f42a3","dataId":"data_da4afc7e","xField":"x","yField":"y","total":{"type":"field","tagField":"total","valueField":"y"}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"desc":"Starting Cash","amount":2000},{"desc":"Sales","amount":3400},{"desc":"Refunds","amount":-1100},{"desc":"Payouts","amount":-100},{"desc":"Court Losses","amount":-6600},{"desc":"Court Wins","amount":3800},{"desc":"Contracts","amount":1400},{"desc":"End Cash","amount":2800}],"mapping":null,"type":"waterfall"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}

# With total values and formatting
data.frame(
  x = c("Feb.4", "Feb.11", "Feb.20", "Feb.25", "Mar.4", 
        "Mar.11", "Mar.19", "Mar.26", "Apr.1", "Apr.8",
        "Apr.15", "Apr.22", "Apr.29", "May.6", "total"),
  total = c(TRUE, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, TRUE),
  y = c(45L, -5L, 2L, -2L, 2L, 2L, -2L, 1L, 1L, 1L, 2L, 1L, -2L, -1L, NA)
) %>% 
  vchart() %>% 
  v_waterfall(
    aes(x = x, y = y, total = total),
    stackLabel = list(
      valueType = "absolute",
      formatMethod = JS("text => text + '%'")
    )
  ) %>% 
  v_specs_legend(visible = TRUE)

{"x":{"specs":{"type":"common","data":[{"id":"data_00b78f3b","values":[{"x":"Feb.4","y":45,"total":true},{"x":"Feb.11","y":-5,"total":null},{"x":"Feb.20","y":2,"total":null},{"x":"Feb.25","y":-2,"total":null},{"x":"Mar.4","y":2,"total":null},{"x":"Mar.11","y":2,"total":null},{"x":"Mar.19","y":-2,"total":null},{"x":"Mar.26","y":1,"total":null},{"x":"Apr.1","y":1,"total":null},{"x":"Apr.8","y":1,"total":null},{"x":"Apr.15","y":2,"total":null},{"x":"Apr.22","y":1,"total":null},{"x":"Apr.29","y":-2,"total":null},{"x":"May.6","y":-1,"total":null},{"x":"total","y":null,"total":true}]}],"series":[{"type":"waterfall","id":"serie_8879638a","dataId":"data_00b78f3b","xField":"x","yField":"y","total":{"type":"field","tagField":"total","valueField":"y"},"stackLabel":{"valueType":"absolute","formatMethod":"text => text + '%'"}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}},"legends":[{"visible":true}]},"data":[{"x":"Feb.4","total":true,"y":45},{"x":"Feb.11","total":null,"y":-5},{"x":"Feb.20","total":null,"y":2},{"x":"Feb.25","total":null,"y":-2},{"x":"Mar.4","total":null,"y":2},{"x":"Mar.11","total":null,"y":2},{"x":"Mar.19","total":null,"y":-2},{"x":"Mar.26","total":null,"y":1},{"x":"Apr.1","total":null,"y":1},{"x":"Apr.8","total":null,"y":1},{"x":"Apr.15","total":null,"y":2},{"x":"Apr.22","total":null,"y":1},{"x":"Apr.29","total":null,"y":-2},{"x":"May.6","total":null,"y":-1},{"x":"total","total":true,"y":null}],"mapping":null,"type":"waterfall"},"evals":["specs.series.0.stackLabel.formatMethod","specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
