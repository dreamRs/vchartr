# Create a Bar Chart

Create a Bar Chart

## Usage

``` r
v_bar(
  vc,
  mapping = NULL,
  data = NULL,
  name = NULL,
  stack = FALSE,
  percent = FALSE,
  direction = c("vertical", "horizontal"),
  ...,
  serie_id = NULL,
  data_id = NULL,
  data_specs = list()
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

- stack:

  Whether to stack the data or not (if `fill` aesthetic is provided).

- percent:

  Whether to display the data as a percentage.

- direction:

  The direction configuration of the chart: `"vertical"` (default) or
  `"horizontal"`.

- ...:

  Additional parameters for the serie.

- data_id, serie_id:

  ID for the data/serie, can be used to further customize the chart with
  [`v_specs()`](https://dreamrs.github.io/vchartr/reference/v_specs.md).

- data_specs:

  Additional options for the data, see [online
  documentation](https://visactor.io/vchart/option/commonChart#data(IDataType%7CIDataType%5B%5D).IDataValues).

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

# Classic Bar Chart
vchart(top_generation) %>% 
  v_bar(aes(country, electricity_generation))

{"x":{"specs":{"type":"common","data":[{"id":"data_bc8cedfb","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0f5e280b","dataId":"data_bc8cedfb","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}]},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Horizontal Bar Chart
vchart(top_generation) %>% 
  v_bar(aes(country, electricity_generation), direction = "horizontal")

{"x":{"specs":{"type":"common","data":[{"id":"data_ba3c8093","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"bottom","type":"linear"},{"orient":"left","type":"band"}],"series":[{"type":"bar","id":"serie_fb644765","dataId":"data_ba3c8093","stack":false,"percent":false,"direction":"horizontal","xField":"y","yField":"x","name":"country"}]},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Grouped Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source))

{"x":{"specs":{"type":"common","data":[{"id":"data_0de9a9ce","values":[{"x":2014,"y":7784.29,"fill":"Low carbon"},{"x":2015,"y":8052.15,"fill":"Low carbon"},{"x":2016,"y":8429.6,"fill":"Low carbon"},{"x":2017,"y":8828.690000000001,"fill":"Low carbon"},{"x":2018,"y":9305.83,"fill":"Low carbon"},{"x":2019,"y":9764.709999999999,"fill":"Low carbon"},{"x":2020,"y":10132.17,"fill":"Low carbon"},{"x":2021,"y":10689.37,"fill":"Low carbon"},{"x":2022,"y":11124.31,"fill":"Low carbon"},{"x":2023,"y":11599.64,"fill":"Low carbon"},{"x":2014,"y":15965.13,"fill":"Fossil fuels"},{"x":2015,"y":15953.64,"fill":"Fossil fuels"},{"x":2016,"y":16233.18,"fill":"Fossil fuels"},{"x":2017,"y":16574.461,"fill":"Fossil fuels"},{"x":2018,"y":17094,"fill":"Fossil fuels"},{"x":2019,"y":17006.52,"fill":"Fossil fuels"},{"x":2020,"y":16522.65,"fill":"Fossil fuels"},{"x":2021,"y":17480.51,"fill":"Fossil fuels"},{"x":2022,"y":17719.189,"fill":"Fossil fuels"},{"x":2023,"y":17879.41,"fill":"Fossil fuels"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_a9a25126","dataId":"data_0de9a9ce","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}]},"data":[{"year":2014,"source":"Low carbon","generation":7784.29,"type":"total"},{"year":2015,"source":"Low carbon","generation":8052.15,"type":"total"},{"year":2016,"source":"Low carbon","generation":8429.6,"type":"total"},{"year":2017,"source":"Low carbon","generation":8828.690000000001,"type":"total"},{"year":2018,"source":"Low carbon","generation":9305.83,"type":"total"},{"year":2019,"source":"Low carbon","generation":9764.709999999999,"type":"total"},{"year":2020,"source":"Low carbon","generation":10132.17,"type":"total"},{"year":2021,"source":"Low carbon","generation":10689.37,"type":"total"},{"year":2022,"source":"Low carbon","generation":11124.31,"type":"total"},{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2014,"source":"Fossil fuels","generation":15965.13,"type":"total"},{"year":2015,"source":"Fossil fuels","generation":15953.64,"type":"total"},{"year":2016,"source":"Fossil fuels","generation":16233.18,"type":"total"},{"year":2017,"source":"Fossil fuels","generation":16574.461,"type":"total"},{"year":2018,"source":"Fossil fuels","generation":17094,"type":"total"},{"year":2019,"source":"Fossil fuels","generation":17006.52,"type":"total"},{"year":2020,"source":"Fossil fuels","generation":16522.65,"type":"total"},{"year":2021,"source":"Fossil fuels","generation":17480.51,"type":"total"},{"year":2022,"source":"Fossil fuels","generation":17719.189,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Horizontal Grouped Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source), direction = "horizontal")

{"x":{"specs":{"type":"common","data":[{"id":"data_a93cc625","values":[{"x":2014,"y":7784.29,"fill":"Low carbon"},{"x":2015,"y":8052.15,"fill":"Low carbon"},{"x":2016,"y":8429.6,"fill":"Low carbon"},{"x":2017,"y":8828.690000000001,"fill":"Low carbon"},{"x":2018,"y":9305.83,"fill":"Low carbon"},{"x":2019,"y":9764.709999999999,"fill":"Low carbon"},{"x":2020,"y":10132.17,"fill":"Low carbon"},{"x":2021,"y":10689.37,"fill":"Low carbon"},{"x":2022,"y":11124.31,"fill":"Low carbon"},{"x":2023,"y":11599.64,"fill":"Low carbon"},{"x":2014,"y":15965.13,"fill":"Fossil fuels"},{"x":2015,"y":15953.64,"fill":"Fossil fuels"},{"x":2016,"y":16233.18,"fill":"Fossil fuels"},{"x":2017,"y":16574.461,"fill":"Fossil fuels"},{"x":2018,"y":17094,"fill":"Fossil fuels"},{"x":2019,"y":17006.52,"fill":"Fossil fuels"},{"x":2020,"y":16522.65,"fill":"Fossil fuels"},{"x":2021,"y":17480.51,"fill":"Fossil fuels"},{"x":2022,"y":17719.189,"fill":"Fossil fuels"},{"x":2023,"y":17879.41,"fill":"Fossil fuels"}]}],"axes":[{"orient":"bottom","type":"linear"},{"orient":"left","type":"band"}],"series":[{"type":"bar","id":"serie_2114057e","dataId":"data_a93cc625","seriesField":"fill","stack":false,"percent":false,"direction":"horizontal","xField":"y","yField":["x","fill"],"name":"year"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}]},"data":[{"year":2014,"source":"Low carbon","generation":7784.29,"type":"total"},{"year":2015,"source":"Low carbon","generation":8052.15,"type":"total"},{"year":2016,"source":"Low carbon","generation":8429.6,"type":"total"},{"year":2017,"source":"Low carbon","generation":8828.690000000001,"type":"total"},{"year":2018,"source":"Low carbon","generation":9305.83,"type":"total"},{"year":2019,"source":"Low carbon","generation":9764.709999999999,"type":"total"},{"year":2020,"source":"Low carbon","generation":10132.17,"type":"total"},{"year":2021,"source":"Low carbon","generation":10689.37,"type":"total"},{"year":2022,"source":"Low carbon","generation":11124.31,"type":"total"},{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2014,"source":"Fossil fuels","generation":15965.13,"type":"total"},{"year":2015,"source":"Fossil fuels","generation":15953.64,"type":"total"},{"year":2016,"source":"Fossil fuels","generation":16233.18,"type":"total"},{"year":2017,"source":"Fossil fuels","generation":16574.461,"type":"total"},{"year":2018,"source":"Fossil fuels","generation":17094,"type":"total"},{"year":2019,"source":"Fossil fuels","generation":17006.52,"type":"total"},{"year":2020,"source":"Fossil fuels","generation":16522.65,"type":"total"},{"year":2021,"source":"Fossil fuels","generation":17480.51,"type":"total"},{"year":2022,"source":"Fossil fuels","generation":17719.189,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Stacked Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source), stack = TRUE)

{"x":{"specs":{"type":"common","data":[{"id":"data_23c92f06","values":[{"x":2014,"y":7784.29,"fill":"Low carbon"},{"x":2015,"y":8052.15,"fill":"Low carbon"},{"x":2016,"y":8429.6,"fill":"Low carbon"},{"x":2017,"y":8828.690000000001,"fill":"Low carbon"},{"x":2018,"y":9305.83,"fill":"Low carbon"},{"x":2019,"y":9764.709999999999,"fill":"Low carbon"},{"x":2020,"y":10132.17,"fill":"Low carbon"},{"x":2021,"y":10689.37,"fill":"Low carbon"},{"x":2022,"y":11124.31,"fill":"Low carbon"},{"x":2023,"y":11599.64,"fill":"Low carbon"},{"x":2014,"y":15965.13,"fill":"Fossil fuels"},{"x":2015,"y":15953.64,"fill":"Fossil fuels"},{"x":2016,"y":16233.18,"fill":"Fossil fuels"},{"x":2017,"y":16574.461,"fill":"Fossil fuels"},{"x":2018,"y":17094,"fill":"Fossil fuels"},{"x":2019,"y":17006.52,"fill":"Fossil fuels"},{"x":2020,"y":16522.65,"fill":"Fossil fuels"},{"x":2021,"y":17480.51,"fill":"Fossil fuels"},{"x":2022,"y":17719.189,"fill":"Fossil fuels"},{"x":2023,"y":17879.41,"fill":"Fossil fuels"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_e22362e5","dataId":"data_23c92f06","seriesField":"fill","stack":true,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}]},"data":[{"year":2014,"source":"Low carbon","generation":7784.29,"type":"total"},{"year":2015,"source":"Low carbon","generation":8052.15,"type":"total"},{"year":2016,"source":"Low carbon","generation":8429.6,"type":"total"},{"year":2017,"source":"Low carbon","generation":8828.690000000001,"type":"total"},{"year":2018,"source":"Low carbon","generation":9305.83,"type":"total"},{"year":2019,"source":"Low carbon","generation":9764.709999999999,"type":"total"},{"year":2020,"source":"Low carbon","generation":10132.17,"type":"total"},{"year":2021,"source":"Low carbon","generation":10689.37,"type":"total"},{"year":2022,"source":"Low carbon","generation":11124.31,"type":"total"},{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2014,"source":"Fossil fuels","generation":15965.13,"type":"total"},{"year":2015,"source":"Fossil fuels","generation":15953.64,"type":"total"},{"year":2016,"source":"Fossil fuels","generation":16233.18,"type":"total"},{"year":2017,"source":"Fossil fuels","generation":16574.461,"type":"total"},{"year":2018,"source":"Fossil fuels","generation":17094,"type":"total"},{"year":2019,"source":"Fossil fuels","generation":17006.52,"type":"total"},{"year":2020,"source":"Fossil fuels","generation":16522.65,"type":"total"},{"year":2021,"source":"Fossil fuels","generation":17480.51,"type":"total"},{"year":2022,"source":"Fossil fuels","generation":17719.189,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Percentage Stacked Bar Chart
vchart(subset(world_electricity, type == "total")) %>% 
  v_bar(aes(year, generation, fill = source), stack = TRUE, percent = TRUE)

{"x":{"specs":{"type":"common","data":[{"id":"data_88d03aab","values":[{"x":2014,"y":7784.29,"fill":"Low carbon"},{"x":2015,"y":8052.15,"fill":"Low carbon"},{"x":2016,"y":8429.6,"fill":"Low carbon"},{"x":2017,"y":8828.690000000001,"fill":"Low carbon"},{"x":2018,"y":9305.83,"fill":"Low carbon"},{"x":2019,"y":9764.709999999999,"fill":"Low carbon"},{"x":2020,"y":10132.17,"fill":"Low carbon"},{"x":2021,"y":10689.37,"fill":"Low carbon"},{"x":2022,"y":11124.31,"fill":"Low carbon"},{"x":2023,"y":11599.64,"fill":"Low carbon"},{"x":2014,"y":15965.13,"fill":"Fossil fuels"},{"x":2015,"y":15953.64,"fill":"Fossil fuels"},{"x":2016,"y":16233.18,"fill":"Fossil fuels"},{"x":2017,"y":16574.461,"fill":"Fossil fuels"},{"x":2018,"y":17094,"fill":"Fossil fuels"},{"x":2019,"y":17006.52,"fill":"Fossil fuels"},{"x":2020,"y":16522.65,"fill":"Fossil fuels"},{"x":2021,"y":17480.51,"fill":"Fossil fuels"},{"x":2022,"y":17719.189,"fill":"Fossil fuels"},{"x":2023,"y":17879.41,"fill":"Fossil fuels"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_caefcc58","dataId":"data_88d03aab","seriesField":"fill","stack":true,"percent":true,"direction":"vertical","xField":"x","yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}]},"data":[{"year":2014,"source":"Low carbon","generation":7784.29,"type":"total"},{"year":2015,"source":"Low carbon","generation":8052.15,"type":"total"},{"year":2016,"source":"Low carbon","generation":8429.6,"type":"total"},{"year":2017,"source":"Low carbon","generation":8828.690000000001,"type":"total"},{"year":2018,"source":"Low carbon","generation":9305.83,"type":"total"},{"year":2019,"source":"Low carbon","generation":9764.709999999999,"type":"total"},{"year":2020,"source":"Low carbon","generation":10132.17,"type":"total"},{"year":2021,"source":"Low carbon","generation":10689.37,"type":"total"},{"year":2022,"source":"Low carbon","generation":11124.31,"type":"total"},{"year":2023,"source":"Low carbon","generation":11599.64,"type":"total"},{"year":2014,"source":"Fossil fuels","generation":15965.13,"type":"total"},{"year":2015,"source":"Fossil fuels","generation":15953.64,"type":"total"},{"year":2016,"source":"Fossil fuels","generation":16233.18,"type":"total"},{"year":2017,"source":"Fossil fuels","generation":16574.461,"type":"total"},{"year":2018,"source":"Fossil fuels","generation":17094,"type":"total"},{"year":2019,"source":"Fossil fuels","generation":17006.52,"type":"total"},{"year":2020,"source":"Fossil fuels","generation":16522.65,"type":"total"},{"year":2021,"source":"Fossil fuels","generation":17480.51,"type":"total"},{"year":2022,"source":"Fossil fuels","generation":17719.189,"type":"total"},{"year":2023,"source":"Fossil fuels","generation":17879.41,"type":"total"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
```
