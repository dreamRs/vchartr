# Axes configuration

Axes configuration

## Usage

``` r
v_specs_axes(
  vc,
  position = c("left", "bottom", "right", "top", "angle", "radius"),
  ...,
  remove = FALSE
)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- position:

  Position of the axe on the chart.

- ...:

  Configuration options.

- remove:

  If `TRUE` then axe is removed and other parameters are ignored.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

# Configure some options for axes
vchart() %>%
  v_line(aes(x = month.name, y = sample(5:25, 12))) %>%
  v_specs_axes(
    position = "left",
    title = list(
      visible = TRUE,
      text = "Y axis title",
      position = "start"
    ),
    label = list(
      formatMethod = JS("val => `${val}°C`")
    ),
    domainLine = list(
      visible = TRUE,
      style = list(stroke = "#000")
    ),
    tick = list(
      visible = TRUE,
      tickStep = 2,
      tickSize = 6,
      style = list(stroke = "#000")
    ),
    grid = list(
      visible = TRUE,
      style = list(lineDash = list(0), stroke = "#6E6E6E", zIndex = 100)
    )
  )%>%
  v_specs_axes(
    position = "bottom",
    title = list(
      visible = TRUE,
      text = "X axis title",
      position = "end"
    ),
    domainLine = list(
      visible = TRUE,
      style = list(stroke = "#000")
    ),
    tick = list(
      visible = TRUE,
      tickStep = 2,
      tickSize = 6,
      style = list(stroke = "#000")
    ),
    grid = list(
      visible = TRUE,
      style = list(lineDash = list(0)),
      alternateColor = c("#F2F2F2", "#FFFFFF"),
      alignWithLabel = TRUE
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_45085863","values":[{"x":"January","y":23},{"x":"February","y":24},{"x":"March","y":20},{"x":"April","y":19},{"x":"May","y":18},{"x":"June","y":21},{"x":"July","y":5},{"x":"August","y":8},{"x":"September","y":13},{"x":"October","y":17},{"x":"November","y":7},{"x":"December","y":25}]}],"series":[{"type":"line","name":"sample(5:25, 12)","id":"serie_ab1da805","dataId":"data_45085863","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band","title":{"visible":true,"text":"X axis title","position":"end"},"domainLine":{"visible":true,"style":{"stroke":"#000"}},"tick":{"visible":true,"tickStep":2,"tickSize":6,"style":{"stroke":"#000"}},"grid":{"visible":true,"style":{"lineDash":[0]},"alternateColor":["#F2F2F2","#FFFFFF"],"alignWithLabel":true}},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":{"visible":true,"tickStep":2,"tickSize":6,"style":{"stroke":"#000"}},"label":{"formatMethod":"val => `${val}°C`"},"title":{"visible":true,"text":"Y axis title","position":"start"},"domainLine":{"visible":true,"style":{"stroke":"#000"}},"grid":{"visible":true,"style":{"lineDash":[0],"stroke":"#6E6E6E","zIndex":100}}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":null,"mapping":null,"type":"line"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}


# By default vline add an axe on the left
vchart() %>%
  v_line(aes(x = month.name, y = sample(5:25, 12))) %>%
  v_specs_axes(position = "left", remove = TRUE) %>%
  v_specs_axes(position = "right", type = "linear")

{"x":{"specs":{"type":"common","data":[{"id":"data_b73f7a44","values":[{"x":"January","y":20},{"x":"February","y":12},{"x":"March","y":10},{"x":"April","y":19},{"x":"May","y":11},{"x":"June","y":23},{"x":"July","y":17},{"x":"August","y":16},{"x":"September","y":24},{"x":"October","y":14},{"x":"November","y":21},{"x":"December","y":7}]}],"series":[{"type":"line","name":"sample(5:25, 12)","id":"serie_a3be86bf","dataId":"data_b73f7a44","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},{"orient":"right","type":"linear"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":null,"mapping":null,"type":"line"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# Use secondary axes
vchart() %>%
  v_line(aes(x = month.name, y = sample(5:25, 12)), serie_id = "serie_left") %>%
  v_line(aes(x = month.name, y = sample(5:25 * 100, 12)), serie_id = "serie_right") %>%
  v_specs_axes(position = "left", seriesId = "serie_left") %>%
  v_specs_axes(position = "right", type = "linear", seriesId = "serie_right")

{"x":{"specs":{"type":"common","data":[{"id":"data_c6fd3f28","values":[{"x":"January","y":13},{"x":"February","y":6},{"x":"March","y":15},{"x":"April","y":24},{"x":"May","y":9},{"x":"June","y":21},{"x":"July","y":12},{"x":"August","y":18},{"x":"September","y":16},{"x":"October","y":17},{"x":"November","y":20},{"x":"December","y":25}]},{"id":"data_a156dad6","values":[{"x":"January","y":1900},{"x":"February","y":1000},{"x":"March","y":2500},{"x":"April","y":2200},{"x":"May","y":600},{"x":"June","y":700},{"x":"July","y":1400},{"x":"August","y":500},{"x":"September","y":2300},{"x":"October","y":1600},{"x":"November","y":900},{"x":"December","y":1200}]}],"series":[{"type":"line","name":"sample(5:25, 12)","id":"serie_left","dataId":"data_c6fd3f28","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}},{"type":"line","name":"sample(5:25 * 100, 12)","id":"serie_right","dataId":"data_a156dad6","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"},"seriesId":"serie_left"},{"orient":"right","type":"linear","seriesId":"serie_right"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":null,"mapping":null,"type":["line","line"]},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
