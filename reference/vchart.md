# Create interactive charts with VChart

VChart is a charting component library, see more about it here :
<https://www.visactor.io/vchart>.

## Usage

``` r
vchart(
  data = NULL,
  mapping = NULL,
  ...,
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- data:

  Can be a `data.frame` if function used with other layers functions or
  a list of parameters for configuring a chart.

- mapping:

  Default list of aesthetic mappings to use for chart, only used if
  `data` is a `data.frame`.

- ...:

  Additional parameters.

- width:

  Fixed width for widget (in css units). The default is `NULL`, which
  results in intelligent automatic sizing based on the widget's
  container.

- height:

  Fixed height for widget (in css units). The default is `NULL`, which
  results in intelligent automatic sizing based on the widget's
  container.

- elementId:

  Use an explicit element ID for the widget (rather than an
  automatically generated one). Useful if you have other JavaScript that
  needs to explicitly discover and interact with a specific widget
  instance.

## Value

A `vchart()` `htmlwidget` object.

## Note

This function allow you to use JavaScript function `VChart` directly,
see <https://www.visactor.io/vchart/option/> for how to specify options.

## Examples

``` r
library(vchartr)

# Use JS syntax to construct chart
vchart(
  type = "line",
  data = list(
    list(
      values = list(
        list(month = "January", value = 4.3),
        list(month = "February", value = 4.6),
        list(month = "March", value = 7.4),
        list(month = "April", value = 10.7),
        list(month = "May", value = 14.3),
        list(month = "June", value = 17.7),
        list(month = "July", value = 19.8),
        list(month = "August", value = 19.4),
        list(month = "September", value = 16.4),
        list(month = "October", value = 12.6),
        list(month = "November", value = 7.9),
        list(month = "December", value = 4.8)
      )
    )
  ),
  xField = "month",
  yField = "value",
  crosshair = list(
    xField = list(visible = TRUE)
  )
)

{"x":{"specs":{"data":[{"values":[{"month":"January","value":4.3},{"month":"February","value":4.6},{"month":"March","value":7.4},{"month":"April","value":10.7},{"month":"May","value":14.3},{"month":"June","value":17.7},{"month":"July","value":19.8},{"month":"August","value":19.4},{"month":"September","value":16.4},{"month":"October","value":12.6},{"month":"November","value":7.9},{"month":"December","value":4.8}]}],"type":"line","xField":"month","yField":"value","crosshair":{"xField":{"visible":true}}}},"evals":[],"jsHooks":[]}
# or use R API
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_e2f2c200","values":[{"x":"January","y":4.3},{"x":"February","y":4.6},{"x":"March","y":7.4},{"x":"April","y":10.7},{"x":"May","y":14.3},{"x":"June","y":17.7},{"x":"July","y":19.8},{"x":"August","y":19.4},{"x":"September","y":16.4},{"x":"October","y":12.6},{"x":"November","y":7.9},{"x":"December","y":4.8}]}],"series":[{"type":"line","name":"temperature_avg","id":"serie_5498083b","dataId":"data_e2f2c200","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}},"crosshair":{"xField":{"visible":true}}},"data":[{"month":"January","temperature_avg":4.3,"temperature_min":1.7,"temperature_max":6.9,"precipitation":57,"humidity":0.85,"rainy_days":9,"sunshine_hours":3},{"month":"February","temperature_avg":4.6,"temperature_min":1.4,"temperature_max":8.1,"precipitation":52,"humidity":0.8100000000000001,"rainy_days":8,"sunshine_hours":4},{"month":"March","temperature_avg":7.4,"temperature_min":3.2,"temperature_max":11.6,"precipitation":53,"humidity":0.76,"rainy_days":8,"sunshine_hours":6},{"month":"April","temperature_avg":10.7,"temperature_min":5.8,"temperature_max":15.2,"precipitation":56,"humidity":0.71,"rainy_days":8,"sunshine_hours":8},{"month":"May","temperature_avg":14.3,"temperature_min":9.5,"temperature_max":18.6,"precipitation":69,"humidity":0.71,"rainy_days":9,"sunshine_hours":9},{"month":"June","temperature_avg":17.7,"temperature_min":12.8,"temperature_max":22.1,"precipitation":63,"humidity":0.68,"rainy_days":8,"sunshine_hours":9},{"month":"July","temperature_avg":19.8,"temperature_min":15,"temperature_max":24.2,"precipitation":60,"humidity":0.65,"rainy_days":8,"sunshine_hours":10},{"month":"August","temperature_avg":19.4,"temperature_min":14.6,"temperature_max":24,"precipitation":60,"humidity":0.66,"rainy_days":7,"sunshine_hours":9},{"month":"September","temperature_avg":16.4,"temperature_min":11.9,"temperature_max":20.9,"precipitation":51,"humidity":0.71,"rainy_days":6,"sunshine_hours":7},{"month":"October","temperature_avg":12.6,"temperature_min":9.199999999999999,"temperature_max":16.4,"precipitation":65,"humidity":0.79,"rainy_days":8,"sunshine_hours":5},{"month":"November","temperature_avg":7.9,"temperature_min":5.1,"temperature_max":10.7,"precipitation":64,"humidity":0.86,"rainy_days":8,"sunshine_hours":3},{"month":"December","temperature_avg":4.8,"temperature_min":2.3,"temperature_max":7.5,"precipitation":70,"humidity":0.86,"rainy_days":10,"sunshine_hours":3}],"mapping":null,"type":"line"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# or
vchart(meteo_paris, aes(month, temperature_avg)) %>%
  v_line() %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_35a31a4a","values":[{"x":"January","y":4.3},{"x":"February","y":4.6},{"x":"March","y":7.4},{"x":"April","y":10.7},{"x":"May","y":14.3},{"x":"June","y":17.7},{"x":"July","y":19.8},{"x":"August","y":19.4},{"x":"September","y":16.4},{"x":"October","y":12.6},{"x":"November","y":7.9},{"x":"December","y":4.8}]}],"series":[{"type":"line","name":"temperature_avg","id":"serie_f0902df8","dataId":"data_35a31a4a","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}},"crosshair":{"xField":{"visible":true}}},"data":[{"month":"January","temperature_avg":4.3,"temperature_min":1.7,"temperature_max":6.9,"precipitation":57,"humidity":0.85,"rainy_days":9,"sunshine_hours":3},{"month":"February","temperature_avg":4.6,"temperature_min":1.4,"temperature_max":8.1,"precipitation":52,"humidity":0.8100000000000001,"rainy_days":8,"sunshine_hours":4},{"month":"March","temperature_avg":7.4,"temperature_min":3.2,"temperature_max":11.6,"precipitation":53,"humidity":0.76,"rainy_days":8,"sunshine_hours":6},{"month":"April","temperature_avg":10.7,"temperature_min":5.8,"temperature_max":15.2,"precipitation":56,"humidity":0.71,"rainy_days":8,"sunshine_hours":8},{"month":"May","temperature_avg":14.3,"temperature_min":9.5,"temperature_max":18.6,"precipitation":69,"humidity":0.71,"rainy_days":9,"sunshine_hours":9},{"month":"June","temperature_avg":17.7,"temperature_min":12.8,"temperature_max":22.1,"precipitation":63,"humidity":0.68,"rainy_days":8,"sunshine_hours":9},{"month":"July","temperature_avg":19.8,"temperature_min":15,"temperature_max":24.2,"precipitation":60,"humidity":0.65,"rainy_days":8,"sunshine_hours":10},{"month":"August","temperature_avg":19.4,"temperature_min":14.6,"temperature_max":24,"precipitation":60,"humidity":0.66,"rainy_days":7,"sunshine_hours":9},{"month":"September","temperature_avg":16.4,"temperature_min":11.9,"temperature_max":20.9,"precipitation":51,"humidity":0.71,"rainy_days":6,"sunshine_hours":7},{"month":"October","temperature_avg":12.6,"temperature_min":9.199999999999999,"temperature_max":16.4,"precipitation":65,"humidity":0.79,"rainy_days":8,"sunshine_hours":5},{"month":"November","temperature_avg":7.9,"temperature_min":5.1,"temperature_max":10.7,"precipitation":64,"humidity":0.86,"rainy_days":8,"sunshine_hours":3},{"month":"December","temperature_avg":4.8,"temperature_min":2.3,"temperature_max":7.5,"precipitation":70,"humidity":0.86,"rainy_days":10,"sunshine_hours":3}],"mapping":{"x":{},"y":{}},"type":"line"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# or
vchart() %>%
  v_line(aes(month, temperature_avg), data = meteo_paris) %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_7cf7ed61","values":[{"x":"January","y":4.3},{"x":"February","y":4.6},{"x":"March","y":7.4},{"x":"April","y":10.7},{"x":"May","y":14.3},{"x":"June","y":17.7},{"x":"July","y":19.8},{"x":"August","y":19.4},{"x":"September","y":16.4},{"x":"October","y":12.6},{"x":"November","y":7.9},{"x":"December","y":4.8}]}],"series":[{"type":"line","name":"temperature_avg","id":"serie_d50190de","dataId":"data_7cf7ed61","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}},"crosshair":{"xField":{"visible":true}}},"data":null,"mapping":null,"type":"line"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
