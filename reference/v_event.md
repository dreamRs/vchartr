# VChart events

VChart events

## Usage

``` r
v_event(vc, name, params, fun, ...)
```

## Arguments

- vc:

  A chart initialized with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- name:

  Name of the event, e.g. `"click"`.

- params:

  Parameters to specifically monitor events in a certain part of the
  chart.

- fun:

  JavaScript function executed when the event occurs.

- ...:

  Not used.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

vchart(top_generation) %>% 
  v_bar(aes(country, electricity_generation)) %>% 
  v_event(
    name = "click",
    params = list(level = "mark", type = "bar"),
    fun = JS(
      "e => {",
      " console.log(e);",
      " alert(e.datum.x);",
      "}"
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_23af59a1","values":[{"x":"China","y":9459.59},{"x":"United States","y":4249.05},{"x":"India","y":1967.9},{"x":"Russia","y":1177.47},{"x":"Japan","y":1013.51},{"x":"Brazil","y":713.1799999999999},{"x":"Canada","y":634.9},{"x":"South Korea","y":614.1900000000001},{"x":"France","y":514.11},{"x":"Germany","y":504.79}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_099971fa","dataId":"data_23af59a1","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"electricity_generation"}]},"data":[{"country":"China","electricity_generation":9459.59},{"country":"United States","electricity_generation":4249.05},{"country":"India","electricity_generation":1967.9},{"country":"Russia","electricity_generation":1177.47},{"country":"Japan","electricity_generation":1013.51},{"country":"Brazil","electricity_generation":713.1799999999999},{"country":"Canada","electricity_generation":634.9},{"country":"South Korea","electricity_generation":614.1900000000001},{"country":"France","electricity_generation":514.11},{"country":"Germany","electricity_generation":504.79}],"mapping":null,"type":"bar","events":[{"name":"click","params":{"level":"mark","type":"bar"},"fun":"e => {\n console.log(e);\n alert(e.datum.x);\n}"}]},"evals":["events.0.fun"],"jsHooks":[]}
```
