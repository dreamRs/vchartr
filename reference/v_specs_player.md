# Set player options

Set player options

## Usage

``` r
v_specs_player(vc, ...)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- ...:

  Options for the legend, see examples or [online
  documentation](https://www.visactor.io/vchart/option/commonChart#player).

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

world_electricity %>% 
  subset(type == "detail") %>% 
  vchart() %>%
  v_bar(
    aes(source, generation, player = year)
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_6d6398f7","values":[{"x":"Renewables","y":5285.56,"player":2014},{"x":"Nuclear","y":2498.73,"player":2014},{"x":"Oil","y":1120.83,"player":2014},{"x":"Gas","y":5237,"player":2014},{"x":"Coal","y":9607.299999999999,"player":2014}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_2a24c969","dataId":"data_6d6398f7","stack":false,"percent":false,"direction":"vertical","xField":"x","yField":"y","name":"generation"}],"player":{"auto":false,"loop":false,"alternate":true,"interval":500,"width":500,"position":"middle","type":"discrete","specs":[{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":5285.56,"player":2014},{"x":"Nuclear","y":2498.73,"player":2014},{"x":"Oil","y":1120.83,"player":2014},{"x":"Gas","y":5237,"player":2014},{"x":"Coal","y":9607.299999999999,"player":2014}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":5519.22,"player":2015},{"x":"Nuclear","y":2532.93,"player":2015},{"x":"Oil","y":1118.41,"player":2015},{"x":"Gas","y":5553.96,"player":2015},{"x":"Coal","y":9281.27,"player":2015}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":5858.55,"player":2016},{"x":"Nuclear","y":2571.05,"player":2016},{"x":"Oil","y":1060.76,"player":2016},{"x":"Gas","y":5839.46,"player":2016},{"x":"Coal","y":9332.959999999999,"player":2016}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":6234.46,"player":2017},{"x":"Nuclear","y":2594.23,"player":2017},{"x":"Oil","y":987.45,"player":2017},{"x":"Gas","y":5958.21,"player":2017},{"x":"Coal","y":9628.799999999999,"player":2017}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":6647.13,"player":2018},{"x":"Nuclear","y":2658.7,"player":2018},{"x":"Oil","y":888.5700000000001,"player":2018},{"x":"Gas","y":6197,"player":2018},{"x":"Coal","y":10008.43,"player":2018}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":7010.63,"player":2019},{"x":"Nuclear","y":2754.08,"player":2019},{"x":"Oil","y":834.83,"player":2019},{"x":"Gas","y":6369.66,"player":2019},{"x":"Coal","y":9802.030000000001,"player":2019}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":7483.8,"player":2020},{"x":"Nuclear","y":2648.37,"player":2020},{"x":"Oil","y":773,"player":2020},{"x":"Gas","y":6332.21,"player":2020},{"x":"Coal","y":9417.440000000001,"player":2020}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":7927.13,"player":2021},{"x":"Nuclear","y":2762.24,"player":2021},{"x":"Oil","y":830.76,"player":2021},{"x":"Gas","y":6492.94,"player":2021},{"x":"Coal","y":10156.81,"player":2021}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":8484.629999999999,"player":2022},{"x":"Nuclear","y":2639.68,"player":2022},{"x":"Oil","y":849.26,"player":2022},{"x":"Gas","y":6581.64,"player":2022},{"x":"Coal","y":10288.29,"player":2022}]}},{"data":{"id":"data_6d6398f7","values":[{"x":"Renewables","y":8913.9,"player":2023},{"x":"Nuclear","y":2685.74,"player":2023},{"x":"Oil","y":788.55,"player":2023},{"x":"Gas","y":6622.93,"player":2023},{"x":"Coal","y":10467.93,"player":2023}]}}]}},"data":[{"year":2014,"source":"Renewables","generation":5285.56,"type":"detail"},{"year":2015,"source":"Renewables","generation":5519.22,"type":"detail"},{"year":2016,"source":"Renewables","generation":5858.55,"type":"detail"},{"year":2017,"source":"Renewables","generation":6234.46,"type":"detail"},{"year":2018,"source":"Renewables","generation":6647.13,"type":"detail"},{"year":2019,"source":"Renewables","generation":7010.63,"type":"detail"},{"year":2020,"source":"Renewables","generation":7483.8,"type":"detail"},{"year":2021,"source":"Renewables","generation":7927.13,"type":"detail"},{"year":2022,"source":"Renewables","generation":8484.629999999999,"type":"detail"},{"year":2023,"source":"Renewables","generation":8913.9,"type":"detail"},{"year":2014,"source":"Nuclear","generation":2498.73,"type":"detail"},{"year":2015,"source":"Nuclear","generation":2532.93,"type":"detail"},{"year":2016,"source":"Nuclear","generation":2571.05,"type":"detail"},{"year":2017,"source":"Nuclear","generation":2594.23,"type":"detail"},{"year":2018,"source":"Nuclear","generation":2658.7,"type":"detail"},{"year":2019,"source":"Nuclear","generation":2754.08,"type":"detail"},{"year":2020,"source":"Nuclear","generation":2648.37,"type":"detail"},{"year":2021,"source":"Nuclear","generation":2762.24,"type":"detail"},{"year":2022,"source":"Nuclear","generation":2639.68,"type":"detail"},{"year":2023,"source":"Nuclear","generation":2685.74,"type":"detail"},{"year":2014,"source":"Oil","generation":1120.83,"type":"detail"},{"year":2015,"source":"Oil","generation":1118.41,"type":"detail"},{"year":2016,"source":"Oil","generation":1060.76,"type":"detail"},{"year":2017,"source":"Oil","generation":987.45,"type":"detail"},{"year":2018,"source":"Oil","generation":888.5700000000001,"type":"detail"},{"year":2019,"source":"Oil","generation":834.83,"type":"detail"},{"year":2020,"source":"Oil","generation":773,"type":"detail"},{"year":2021,"source":"Oil","generation":830.76,"type":"detail"},{"year":2022,"source":"Oil","generation":849.26,"type":"detail"},{"year":2023,"source":"Oil","generation":788.55,"type":"detail"},{"year":2014,"source":"Gas","generation":5237,"type":"detail"},{"year":2015,"source":"Gas","generation":5553.96,"type":"detail"},{"year":2016,"source":"Gas","generation":5839.46,"type":"detail"},{"year":2017,"source":"Gas","generation":5958.21,"type":"detail"},{"year":2018,"source":"Gas","generation":6197,"type":"detail"},{"year":2019,"source":"Gas","generation":6369.66,"type":"detail"},{"year":2020,"source":"Gas","generation":6332.21,"type":"detail"},{"year":2021,"source":"Gas","generation":6492.94,"type":"detail"},{"year":2022,"source":"Gas","generation":6581.64,"type":"detail"},{"year":2023,"source":"Gas","generation":6622.93,"type":"detail"},{"year":2014,"source":"Coal","generation":9607.299999999999,"type":"detail"},{"year":2015,"source":"Coal","generation":9281.27,"type":"detail"},{"year":2016,"source":"Coal","generation":9332.959999999999,"type":"detail"},{"year":2017,"source":"Coal","generation":9628.799999999999,"type":"detail"},{"year":2018,"source":"Coal","generation":10008.43,"type":"detail"},{"year":2019,"source":"Coal","generation":9802.030000000001,"type":"detail"},{"year":2020,"source":"Coal","generation":9417.440000000001,"type":"detail"},{"year":2021,"source":"Coal","generation":10156.81,"type":"detail"},{"year":2022,"source":"Coal","generation":10288.29,"type":"detail"},{"year":2023,"source":"Coal","generation":10467.93,"type":"detail"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
```
