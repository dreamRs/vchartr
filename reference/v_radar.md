# Create a Radar Chart

Create a Radar Chart

## Usage

``` r
v_radar(
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

# Default radar chart
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(aes(source, generation))

{"x":{"specs":{"type":"common","data":[{"id":"data_74bb9682","values":[{"x":"solar","y":61.56},{"x":"wind","y":137.29},{"x":"hydro","y":19.48},{"x":"nuclear","y":8.75},{"x":"oil","y":20.13},{"x":"gas","y":76},{"x":"coal","y":135.35}]}],"series":[{"type":"radar","id":"serie_d6f04e70","dataId":"data_74bb9682","categoryField":"x","valueField":"y"}],"axes":[{"orient":"angle"},{"orient":"radius"}]},"data":[{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"}],"mapping":null,"type":"radar"},"evals":[],"jsHooks":[]}
# Without area
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(
    aes(source, generation),
    area = list(visible = FALSE)
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_2baccb95","values":[{"x":"solar","y":61.56},{"x":"wind","y":137.29},{"x":"hydro","y":19.48},{"x":"nuclear","y":8.75},{"x":"oil","y":20.13},{"x":"gas","y":76},{"x":"coal","y":135.35}]}],"series":[{"type":"radar","id":"serie_a74bee52","dataId":"data_2baccb95","categoryField":"x","valueField":"y","area":{"visible":false}}],"axes":[{"orient":"angle"},{"orient":"radius"}]},"data":[{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"}],"mapping":null,"type":"radar"},"evals":[],"jsHooks":[]}

# Mutliple series
subset(electricity_mix, country %in% c("Germany", "Canada")) %>%
  vchart() %>%
  v_radar(aes(source, generation, color = country))

{"x":{"specs":{"type":"common","data":[{"id":"data_1e2483d7","values":[{"x":"solar","y":7.48,"colour":"Canada"},{"x":"solar","y":61.56,"colour":"Germany"},{"x":"wind","y":38.1,"colour":"Canada"},{"x":"wind","y":137.29,"colour":"Germany"},{"x":"hydro","y":365.39,"colour":"Canada"},{"x":"hydro","y":19.48,"colour":"Germany"},{"x":"nuclear","y":88.91,"colour":"Canada"},{"x":"nuclear","y":8.75,"colour":"Germany"},{"x":"oil","y":2.61,"colour":"Canada"},{"x":"oil","y":20.13,"colour":"Germany"},{"x":"gas","y":91.16,"colour":"Canada"},{"x":"gas","y":76,"colour":"Germany"},{"x":"coal","y":32.33,"colour":"Canada"},{"x":"coal","y":135.35,"colour":"Germany"}]}],"series":[{"type":"radar","id":"serie_c5a78dd2","dataId":"data_1e2483d7","categoryField":"x","valueField":"y","seriesField":"colour"}],"axes":[{"orient":"angle"},{"orient":"radius"}],"legends":[{"visible":true}]},"data":[{"country":"Canada","source":"solar","generation":7.48,"type":"Low carbon"},{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"Canada","source":"wind","generation":38.1,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"Canada","source":"hydro","generation":365.39,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"Canada","source":"nuclear","generation":88.91,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"Canada","source":"oil","generation":2.61,"type":"Fossil fuels"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"Canada","source":"gas","generation":91.16,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"Canada","source":"coal","generation":32.33,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"}],"mapping":null,"type":"radar"},"evals":[],"jsHooks":[]}


# Custom axes
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(aes(source, generation)) %>%
  v_scale_y_continuous(min = 0, max = 200)

{"x":{"specs":{"type":"common","data":[{"id":"data_26277d0b","values":[{"x":"solar","y":61.56},{"x":"wind","y":137.29},{"x":"hydro","y":19.48},{"x":"nuclear","y":8.75},{"x":"oil","y":20.13},{"x":"gas","y":76},{"x":"coal","y":135.35}]}],"series":[{"type":"radar","id":"serie_aeebb206","dataId":"data_26277d0b","categoryField":"x","valueField":"y"}],"axes":[{"orient":"angle"},{"orient":"radius","type":"linear","zero":false,"sampling":false,"nice":true,"softMin":0,"softMax":200,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"}],"mapping":null,"type":"radar"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(aes(source, generation)) %>%
  v_scale_y_continuous(
    grid = list(smooth = FALSE),
    domainLine = list(visible = FALSE)
  ) %>%
  v_scale_x_discrete(
    label = list(space = 20),
    domainLine = list(visible = FALSE)
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_585ce551","values":[{"x":"solar","y":61.56},{"x":"wind","y":137.29},{"x":"hydro","y":19.48},{"x":"nuclear","y":8.75},{"x":"oil","y":20.13},{"x":"gas","y":76},{"x":"coal","y":135.35}]}],"series":[{"type":"radar","id":"serie_0b27a3fc","dataId":"data_585ce551","categoryField":"x","valueField":"y"}],"axes":[{"orient":"angle","type":"band","label":{"space":20},"domainLine":{"visible":false}},{"orient":"radius","type":"linear","zero":false,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"},"grid":{"smooth":false},"domainLine":{"visible":false}}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"}],"mapping":null,"type":"radar"},"evals":["specs.axes.1.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
