# Axis scale for continuous data

Axis scale for continuous data

## Usage

``` r
v_scale_x_continuous(
  vc,
  name = NULL,
  breaks = NULL,
  pretty = TRUE,
  labels = NULL,
  labels_tooltip = labels,
  zero = NULL,
  min = NULL,
  max = NULL,
  ...,
  position = "bottom"
)

v_scale_y_continuous(
  vc,
  name = NULL,
  breaks = NULL,
  pretty = TRUE,
  labels = NULL,
  labels_tooltip = labels,
  zero = NULL,
  min = NULL,
  max = NULL,
  ...,
  position = "left"
)

v_scale_x_log(
  vc,
  name = NULL,
  breaks = NULL,
  pretty = TRUE,
  labels = NULL,
  labels_tooltip = labels,
  zero = NULL,
  min = NULL,
  max = NULL,
  ...,
  position = "bottom"
)

v_scale_y_log(
  vc,
  name = NULL,
  breaks = NULL,
  pretty = TRUE,
  labels = NULL,
  labels_tooltip = labels,
  zero = NULL,
  min = NULL,
  max = NULL,
  ...,
  position = "left"
)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md) or
  specific chart's type function.

- name:

  Title for the axis.

- breaks:

  One of:

  - A single `numeric` value giving the number of breaks.

  - A numeric vector of positions.

- pretty:

  Use [`pretty()`](https://rdrr.io/r/base/pretty.html) to identify
  breaks if `breaks` is a single numeric value.

- labels, labels_tooltip:

  The format to be applied on numeric in the labels/tooltip. Either:

  - A single character indicating the D3 format.

  - A `JS` function, such as
    [`format_num_d3()`](https://dreamrs.github.io/vchartr/reference/format_num_d3.md).

- zero:

  Force axis to start at 0.

- min:

  Minimum value on the axis.

- max:

  Maximum value on the axis.

- ...:

  Additional parameters for the axis.

- position:

  Position of the axis.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

# Add a title to the axis
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(name = "Electricity generation")

{"x":{"specs":{"type":"common","data":[{"id":"data_54391c49","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"},"title":{"visible":true,"text":"Electricity generation","position":"middle"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0ed12bb5","dataId":"data_54391c49","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source)) %>%
  v_scale_y_continuous(name = "Electricity generation")

{"x":{"specs":{"type":"common","data":[{"id":"data_8d41f8c4","values":[{"x":2014,"y":7784.29,"fill":"Low carbon"},{"x":2015,"y":8052.15,"fill":"Low carbon"},{"x":2016,"y":8429.6,"fill":"Low carbon"},{"x":2017,"y":8828.690000000001,"fill":"Low carbon"},{"x":2018,"y":9305.83,"fill":"Low carbon"},{"x":2019,"y":9764.709999999999,"fill":"Low carbon"},{"x":2020,"y":10132.17,"fill":"Low carbon"},{"x":2021,"y":10689.37,"fill":"Low carbon"},{"x":2022,"y":11124.31,"fill":"Low carbon"},{"x":2023,"y":11599.64,"fill":"Low carbon"},{"x":2014,"y":15965.13,"fill":"Fossil fuels"},{"x":2015,"y":15953.64,"fill":"Fossil fuels"},{"x":2016,"y":16233.18,"fill":"Fossil fuels"},{"x":2017,"y":16574.461,"fill":"Fossil fuels"},{"x":2018,"y":17094,"fill":"Fossil fuels"},{"x":2019,"y":17006.52,"fill":"Fossil fuels"},{"x":2020,"y":16522.65,"fill":"Fossil fuels"},{"x":2021,"y":17480.51,"fill":"Fossil fuels"},{"x":2022,"y":17719.189,"fill":"Fossil fuels"},{"x":2023,"y":17879.41,"fill":"Fossil fuels"}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"},"title":{"visible":true,"text":"Electricity generation","position":"middle"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_c2e3ec65","dataId":"data_8d41f8c4","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"year":2014,"source":"Low carbon","generation":7784.29,"type":"total"},{"year":2015,"source":"Low carbon","generation":8052.15,"type":"total"},{"year":2016,"source":"Low carbon","generation":8429.6,"type":"total"},{"year":2017,"source":"Low carbon","generation":8828.690000000001,"type":"total"},{"year":2018,"source":"Low carbon","generation":9305.83,"type":"total"},{"year":2019,"source":"Low carbon","generation":9764.709999999999,"type":"total"},{"year":2020,"source":"Low carbon","generation":10132.17,"type":"total"},{"year":2021,"source":"Low carbon","generation":10689.37,"type":"total"},{"year":2022,"source":"Low carbon","generation":11124.31,"type":"total"},{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2014,"source":"Fossil fuels","generation":15965.13,"type":"total"},{"year":2015,"source":"Fossil fuels","generation":15953.64,"type":"total"},{"year":2016,"source":"Fossil fuels","generation":16233.18,"type":"total"},{"year":2017,"source":"Fossil fuels","generation":16574.461,"type":"total"},{"year":2018,"source":"Fossil fuels","generation":17094,"type":"total"},{"year":2019,"source":"Fossil fuels","generation":17006.52,"type":"total"},{"year":2020,"source":"Fossil fuels","generation":16522.65,"type":"total"},{"year":2021,"source":"Fossil fuels","generation":17480.51,"type":"total"},{"year":2022,"source":"Fossil fuels","generation":17719.189,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# Specify number of breaks
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(breaks = 10)

{"x":{"specs":{"type":"common","data":[{"id":"data_6b835237","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":{"visible":true,"tickStep":1,"dataFilter":"axisData => axisData.filter((x) => {var values = [0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]; return values.includes(x.rawValue);})"},"label":{"dataFilter":"axisData => axisData.filter((x) => {var values = [0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]; return values.includes(x.rawValue);})","formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"},"grid":{"style":"(value, index, datum) => {var values = [0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]; return {visible: values.includes(value)};}"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_f2d124e9","dataId":"data_6b835237","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.tick.dataFilter","specs.axes.0.label.dataFilter","specs.axes.0.label.formatMethod","specs.axes.0.grid.style","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# Specify breaks position
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(breaks = c(0, 5000, 10000))

{"x":{"specs":{"type":"common","data":[{"id":"data_1edcb3f7","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":{"visible":true,"tickStep":1,"dataFilter":"axisData => axisData.filter((x) => {var values = [0, 5000, 10000]; return values.includes(x.rawValue);})"},"label":{"dataFilter":"axisData => axisData.filter((x) => {var values = [0, 5000, 10000]; return values.includes(x.rawValue);})","formatMethod":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"},"grid":{"style":"(value, index, datum) => {var values = [0, 5000, 10000]; return {visible: values.includes(value)};}"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_33b890d6","dataId":"data_1edcb3f7","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"value => {\nif (value.hasOwnProperty('y')) return value.y;\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return value.ymin + ' - ' + value.ymax;\nreturn value;\n}"}}}},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.tick.dataFilter","specs.axes.0.label.dataFilter","specs.axes.0.label.formatMethod","specs.axes.0.grid.style","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# Format labels
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(labels = "~s")

{"x":{"specs":{"type":"common","data":[{"id":"data_ff580948","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~s')(value) + '';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_c917b6c8","dataId":"data_ff580948","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~s')(value) + '';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~s')(value) + '';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}}}},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
# Format labels with options
vchart(top_generation) %>%
  v_bar(aes(country, electricity_generation)) %>%
  v_scale_y_continuous(labels = format_num_d3(",", suffix = " TWh", locale = "fr-FR"))

{"x":{"specs":{"type":"common","data":[{"id":"data_1c304ebe","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0€\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format(',')(value) + ' TWh';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_d258b2ee","dataId":"data_1c304ebe","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0€\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format(',')(value) + ' TWh';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0€\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format(',')(value) + ' TWh';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}}}},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source)) %>%
  v_scale_y_continuous(labels = format_num_d3(",", suffix = " TWh", locale = "fr-FR"))

{"x":{"specs":{"type":"common","data":[{"id":"data_1ebacaee","values":[{"x":2014,"y":7784.29,"fill":"Low carbon"},{"x":2015,"y":8052.15,"fill":"Low carbon"},{"x":2016,"y":8429.6,"fill":"Low carbon"},{"x":2017,"y":8828.690000000001,"fill":"Low carbon"},{"x":2018,"y":9305.83,"fill":"Low carbon"},{"x":2019,"y":9764.709999999999,"fill":"Low carbon"},{"x":2020,"y":10132.17,"fill":"Low carbon"},{"x":2021,"y":10689.37,"fill":"Low carbon"},{"x":2022,"y":11124.31,"fill":"Low carbon"},{"x":2023,"y":11599.64,"fill":"Low carbon"},{"x":2014,"y":15965.13,"fill":"Fossil fuels"},{"x":2015,"y":15953.64,"fill":"Fossil fuels"},{"x":2016,"y":16233.18,"fill":"Fossil fuels"},{"x":2017,"y":16574.461,"fill":"Fossil fuels"},{"x":2018,"y":17094,"fill":"Fossil fuels"},{"x":2019,"y":17006.52,"fill":"Fossil fuels"},{"x":2020,"y":16522.65,"fill":"Fossil fuels"},{"x":2021,"y":17480.51,"fill":"Fossil fuels"},{"x":2022,"y":17719.189,"fill":"Fossil fuels"},{"x":2023,"y":17879.41,"fill":"Fossil fuels"}]}],"axes":[{"orient":"left","type":"linear","zero":true,"sampling":false,"nice":true,"tick":[],"label":{"formatMethod":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0€\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format(',')(value) + ' TWh';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_1664b8f3","dataId":"data_1ebacaee","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"tooltip":{"dimension":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0€\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format(',')(value) + ' TWh';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}},"mark":{"content":{"key":"datum => {\nif (datum.hasOwnProperty('colour')) return datum.colour;\nif (datum.hasOwnProperty('fill')) return datum.fill;\nreturn datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;\n}","value":"function(value) {\nconst fun = function(value) {var locale = d3_format_locale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0€\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format(',')(value) + ' TWh';};\nif (value.hasOwnProperty('y')) return fun(value.y);\nif (value.hasOwnProperty('ymin') & value.hasOwnProperty('ymax')) return fun(value.ymin) + ' - ' + fun(value.ymax);\nreturn fun(value);\n}"}}}},"data":[{"year":2014,"source":"Low carbon","generation":7784.29,"type":"total"},{"year":2015,"source":"Low carbon","generation":8052.15,"type":"total"},{"year":2016,"source":"Low carbon","generation":8429.6,"type":"total"},{"year":2017,"source":"Low carbon","generation":8828.690000000001,"type":"total"},{"year":2018,"source":"Low carbon","generation":9305.83,"type":"total"},{"year":2019,"source":"Low carbon","generation":9764.709999999999,"type":"total"},{"year":2020,"source":"Low carbon","generation":10132.17,"type":"total"},{"year":2021,"source":"Low carbon","generation":10689.37,"type":"total"},{"year":2022,"source":"Low carbon","generation":11124.31,"type":"total"},{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2014,"source":"Fossil fuels","generation":15965.13,"type":"total"},{"year":2015,"source":"Fossil fuels","generation":15953.64,"type":"total"},{"year":2016,"source":"Fossil fuels","generation":16233.18,"type":"total"},{"year":2017,"source":"Fossil fuels","generation":16574.461,"type":"total"},{"year":2018,"source":"Fossil fuels","generation":17094,"type":"total"},{"year":2019,"source":"Fossil fuels","generation":17006.52,"type":"total"},{"year":2020,"source":"Fossil fuels","generation":16522.65,"type":"total"},{"year":2021,"source":"Fossil fuels","generation":17480.51,"type":"total"},{"year":2022,"source":"Fossil fuels","generation":17719.189,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"bar"},"evals":["specs.axes.0.label.formatMethod","specs.tooltip.dimension.content.key","specs.tooltip.dimension.content.value","specs.tooltip.mark.content.key","specs.tooltip.mark.content.value"],"jsHooks":[]}
```
