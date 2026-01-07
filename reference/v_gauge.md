# Create a Gauge Chart

Create a Gauge Chart

## Usage

``` r
v_gauge(
  vc,
  mapping = NULL,
  data = NULL,
  name = NULL,
  outerRadius = 0.8,
  innerRadius = 0.75,
  startAngle = -240,
  endAngle = 60,
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

- outerRadius:

  Sector outer radius, with a numerical range of 0 - 1.

- innerRadius:

  Sector inner radius, with a numerical range of 0 - 1.

- startAngle:

  Starting angle of the sector. In degrees.

- endAngle:

  Ending angle of the sector. In degrees.

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
  v_gauge(aes("My gauge", 0.8))

{"x":{"specs":{"type":"gauge","data":[{"id":"data_62836096","values":[{"x":"My gauge","y":0.8}]}],"radiusField":"x","valueField":"y","outerRadius":0.8,"innerRadius":0.75,"startAngle":-240,"endAngle":60},"data":null,"mapping":null,"type":"gauge"},"evals":[],"jsHooks":[]}
vchart() %>%
  v_gauge(
    aes("My gauge", 0.8),
    gauge = list(
      type = "circularProgress",
      cornerRadius = 20,
      progress = list(
        style = list(
          fill = "forestgreen"
        )
      ),
      track = list(
        style = list(
          fill = "#BCBDBC"
        )
      )
    ),
    pointer = list(
      style = list(
        fill = "#2F2E2F"
      )
    )
  )

{"x":{"specs":{"type":"gauge","data":[{"id":"data_b9fc5612","values":[{"x":"My gauge","y":0.8}]}],"radiusField":"x","valueField":"y","outerRadius":0.8,"innerRadius":0.75,"startAngle":-240,"endAngle":60,"gauge":{"type":"circularProgress","cornerRadius":20,"progress":{"style":{"fill":"forestgreen"}},"track":{"style":{"fill":"#BCBDBC"}}},"pointer":{"style":{"fill":"#2F2E2F"}}},"data":null,"mapping":null,"type":"gauge"},"evals":[],"jsHooks":[]}

vchart() %>%
  v_gauge(aes("My gauge", 0.8)) %>%
  v_scale_y_continuous(labels = ".0%")

{"x":{"specs":{"type":"gauge","data":[{"id":"data_90b02849","values":[{"x":"My gauge","y":0.8}]}],"radiusField":"x","valueField":"y","outerRadius":0.8,"innerRadius":0.75,"startAngle":-240,"endAngle":60,"axes":[{"orient":"angle","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('.0%')(value) + '';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('.0%')(value) + '';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('.0%')(value) + '';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}}}},"data":null,"mapping":null,"type":"gauge"},"evals":["specs.axes.0.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
