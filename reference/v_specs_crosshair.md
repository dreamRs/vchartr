# Add crosshair to chart

Add crosshair to chart

## Usage

``` r
v_specs_crosshair(vc, ...)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- ...:

  Options for the legend, see examples or [online
  documentation](https://www.visactor.io/vchart/option/commonChart#crosshair).

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

data.frame(month = month.abb, value = sample(1:50, 12)) %>% 
  vchart() %>% 
  v_line(aes(month, value)) %>% 
  v_specs_crosshair(
    xField = list(
      visible = TRUE,
      line = list(type = "rect"), 
      defaultSelect = list(
        axisIndex = 0, 
        datum = "May"
      ), 
      label = list(visible = TRUE)
    ), 
    yField = list(
      visible = TRUE, 
      defaultSelect = list(
        axisIndex = 1,
        datum = 30
      ), 
      line = list(
        style = list(
          lineWidth = 1, 
          opacity = 1, 
          stroke = "#000", 
          lineDash = c(2, 2)
        )
      ),
      label = list(visible = TRUE)
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_640d43da","values":[{"x":"Jan","y":6},{"x":"Feb","y":10},{"x":"Mar","y":38},{"x":"Apr","y":42},{"x":"May","y":31},{"x":"Jun","y":11},{"x":"Jul","y":30},{"x":"Aug","y":1},{"x":"Sep","y":32},{"x":"Oct","y":18},{"x":"Nov","y":12},{"x":"Dec","y":44}]}],"series":[{"type":"line","name":"value","id":"serie_c5607a36","dataId":"data_640d43da","xField":"x","yField":"y","point":{"visible":false},"line":{"style":{"curveType":"linear","lineDash":0,"stroke":null}}}],"axes":[{"orient":"bottom","type":"band"},{"orient":"left","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}},"crosshair":[{"xField":{"visible":true,"line":{"type":"rect"},"defaultSelect":{"axisIndex":0,"datum":"May"},"label":{"visible":true}},"yField":{"visible":true,"defaultSelect":{"axisIndex":1,"datum":30},"line":{"style":{"lineWidth":1,"opacity":1,"stroke":"#000","lineDash":[2,2]}},"label":{"visible":true}}}]},"data":[{"month":"Jan","value":6},{"month":"Feb","value":10},{"month":"Mar","value":38},{"month":"Apr","value":42},{"month":"May","value":31},{"month":"Jun","value":11},{"month":"Jul","value":30},{"month":"Aug","value":1},{"month":"Sep","value":32},{"month":"Oct","value":18},{"month":"Nov","value":12},{"month":"Dec","value":44}],"mapping":null,"type":"line"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
