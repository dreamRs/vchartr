# Theme for Charts

Theme for Charts

## Usage

``` r
v_theme(
  vc,
  .colorPalette = NULL,
  .backgroundColor = NULL,
  .borderColor = NULL,
  .shadowColor = NULL,
  .hoverBackgroundColor = NULL,
  .sliderRailColor = NULL,
  .sliderHandleColor = NULL,
  .sliderTrackColor = NULL,
  .popupBackgroundColor = NULL,
  .primaryFontColor = NULL,
  .secondaryFontColor = NULL,
  .tertiaryFontColor = NULL,
  .axisLabelFontColor = NULL,
  .disableFontColor = NULL,
  .axisMarkerFontColor = NULL,
  .axisGridColor = NULL,
  .axisDomainColor = NULL,
  .dataZoomHandleStrokeColor = NULL,
  .dataZoomChartColor = NULL,
  .playerControllerColor = NULL,
  .scrollBarSliderColor = NULL,
  .axisMarkerBackgroundColor = NULL,
  .markLabelBackgroundColor = NULL,
  .markLineStrokeColor = NULL,
  .dangerColor = NULL,
  .warningColor = NULL,
  .successColor = NULL,
  .infoColor = NULL,
  .discreteLegendPagerTextColor = NULL,
  .discreteLegendPagerHandlerColor = NULL,
  .discreteLegendPagerHandlerDisableColor = NULL,
  ...
)
```

## Arguments

- vc:

  An htmlwidget created with
  [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md).

- .colorPalette:

  Vector of colors to use as default.

- .backgroundColor:

  background Color

- .borderColor:

  border Color

- .shadowColor:

  shadow Color

- .hoverBackgroundColor:

  hoverBackground Color

- .sliderRailColor:

  slider Rail Color

- .sliderHandleColor:

  slider Handle Color

- .sliderTrackColor:

  slider Track Color

- .popupBackgroundColor:

  popup Background Color

- .primaryFontColor:

  primary Font Color

- .secondaryFontColor:

  secondary Font Color

- .tertiaryFontColor:

  tertiary Font Color

- .axisLabelFontColor:

  axisLabel Font Color

- .disableFontColor:

  disable Font Color

- .axisMarkerFontColor:

  axis Marker Font Color

- .axisGridColor:

  axis Grid Color

- .axisDomainColor:

  axis Domain Color

- .dataZoomHandleStrokeColor:

  data Zoom Handle Stroke Color

- .dataZoomChartColor:

  data Zoom Chart Color

- .playerControllerColor:

  player Controller Color

- .scrollBarSliderColor:

  scroll Bar Slider Color

- .axisMarkerBackgroundColor:

  axis Marker Background Color

- .markLabelBackgroundColor:

  mark Label Background Color

- .markLineStrokeColor:

  mark Line Stroke Color

- .dangerColor:

  danger Color

- .warningColor:

  warning Color

- .successColor:

  success Color

- .infoColor:

  info Color

- .discreteLegendPagerTextColor:

  discrete Legend Pager Text Color

- .discreteLegendPagerHandlerColor:

  discrete Legend Pager Handler Color

- .discreteLegendPagerHandlerDisableColor:

  discrete Legend Pager Handler Disable Color

- ...:

  Other parameters.

## Value

A [`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
`htmlwidget` object.

## Examples

``` r
library(vchartr)

chart <- subset(
  electricity_mix,
  country %in% c("Germany", "Brazil", "South Korea")
) %>%
  vchart() %>%
  v_bar(aes(country, generation, fill = source))

# Default appearance
chart

{"x":{"specs":{"type":"common","data":[{"id":"data_00267449","values":[{"x":"Brazil","y":51.72,"fill":"solar"},{"x":"Germany","y":61.56,"fill":"solar"},{"x":"South Korea","y":29.37,"fill":"solar"},{"x":"Brazil","y":95.73999999999999,"fill":"wind"},{"x":"Germany","y":137.29,"fill":"wind"},{"x":"South Korea","y":3.41,"fill":"wind"},{"x":"Brazil","y":431.28,"fill":"hydro"},{"x":"Germany","y":19.48,"fill":"hydro"},{"x":"South Korea","y":3.7,"fill":"hydro"},{"x":"Brazil","y":14.51,"fill":"nuclear"},{"x":"Germany","y":8.75,"fill":"nuclear"},{"x":"South Korea","y":180.49,"fill":"nuclear"},{"x":"Brazil","y":10.86,"fill":"oil"},{"x":"Germany","y":20.13,"fill":"oil"},{"x":"South Korea","y":6.87,"fill":"oil"},{"x":"Brazil","y":38.16,"fill":"gas"},{"x":"Germany","y":76,"fill":"gas"},{"x":"South Korea","y":169.23,"fill":"gas"},{"x":"Brazil","y":17.19,"fill":"coal"},{"x":"Germany","y":135.35,"fill":"coal"},{"x":"South Korea","y":202.66,"fill":"coal"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0c86bb8c","dataId":"data_00267449","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}]},"data":[{"country":"Brazil","source":"solar","generation":51.72,"type":"Low carbon"},{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"South Korea","source":"solar","generation":29.37,"type":"Low carbon"},{"country":"Brazil","source":"wind","generation":95.73999999999999,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"South Korea","source":"wind","generation":3.41,"type":"Low carbon"},{"country":"Brazil","source":"hydro","generation":431.28,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"South Korea","source":"hydro","generation":3.7,"type":"Low carbon"},{"country":"Brazil","source":"nuclear","generation":14.51,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"South Korea","source":"nuclear","generation":180.49,"type":"Low carbon"},{"country":"Brazil","source":"oil","generation":10.86,"type":"Fossil fuels"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"South Korea","source":"oil","generation":6.87,"type":"Fossil fuels"},{"country":"Brazil","source":"gas","generation":38.16,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"South Korea","source":"gas","generation":169.23,"type":"Fossil fuels"},{"country":"Brazil","source":"coal","generation":17.19,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"},{"country":"South Korea","source":"coal","generation":202.66,"type":"Fossil fuels"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Change background color
chart %>%
  v_theme(.backgroundColor = "#2F2E2F")

{"x":{"specs":{"type":"common","data":[{"id":"data_00267449","values":[{"x":"Brazil","y":51.72,"fill":"solar"},{"x":"Germany","y":61.56,"fill":"solar"},{"x":"South Korea","y":29.37,"fill":"solar"},{"x":"Brazil","y":95.73999999999999,"fill":"wind"},{"x":"Germany","y":137.29,"fill":"wind"},{"x":"South Korea","y":3.41,"fill":"wind"},{"x":"Brazil","y":431.28,"fill":"hydro"},{"x":"Germany","y":19.48,"fill":"hydro"},{"x":"South Korea","y":3.7,"fill":"hydro"},{"x":"Brazil","y":14.51,"fill":"nuclear"},{"x":"Germany","y":8.75,"fill":"nuclear"},{"x":"South Korea","y":180.49,"fill":"nuclear"},{"x":"Brazil","y":10.86,"fill":"oil"},{"x":"Germany","y":20.13,"fill":"oil"},{"x":"South Korea","y":6.87,"fill":"oil"},{"x":"Brazil","y":38.16,"fill":"gas"},{"x":"Germany","y":76,"fill":"gas"},{"x":"South Korea","y":169.23,"fill":"gas"},{"x":"Brazil","y":17.19,"fill":"coal"},{"x":"Germany","y":135.35,"fill":"coal"},{"x":"South Korea","y":202.66,"fill":"coal"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0c86bb8c","dataId":"data_00267449","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"theme":{"colorScheme":{"default":{"palette":{"backgroundColor":"#2F2E2F"}}}}},"data":[{"country":"Brazil","source":"solar","generation":51.72,"type":"Low carbon"},{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"South Korea","source":"solar","generation":29.37,"type":"Low carbon"},{"country":"Brazil","source":"wind","generation":95.73999999999999,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"South Korea","source":"wind","generation":3.41,"type":"Low carbon"},{"country":"Brazil","source":"hydro","generation":431.28,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"South Korea","source":"hydro","generation":3.7,"type":"Low carbon"},{"country":"Brazil","source":"nuclear","generation":14.51,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"South Korea","source":"nuclear","generation":180.49,"type":"Low carbon"},{"country":"Brazil","source":"oil","generation":10.86,"type":"Fossil fuels"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"South Korea","source":"oil","generation":6.87,"type":"Fossil fuels"},{"country":"Brazil","source":"gas","generation":38.16,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"South Korea","source":"gas","generation":169.23,"type":"Fossil fuels"},{"country":"Brazil","source":"coal","generation":17.19,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"},{"country":"South Korea","source":"coal","generation":202.66,"type":"Fossil fuels"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Change default color palette
chart %>%
  v_theme(
    .colorPalette = palette.colors(n = 8, palette = "Okabe-Ito")[-1]
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_00267449","values":[{"x":"Brazil","y":51.72,"fill":"solar"},{"x":"Germany","y":61.56,"fill":"solar"},{"x":"South Korea","y":29.37,"fill":"solar"},{"x":"Brazil","y":95.73999999999999,"fill":"wind"},{"x":"Germany","y":137.29,"fill":"wind"},{"x":"South Korea","y":3.41,"fill":"wind"},{"x":"Brazil","y":431.28,"fill":"hydro"},{"x":"Germany","y":19.48,"fill":"hydro"},{"x":"South Korea","y":3.7,"fill":"hydro"},{"x":"Brazil","y":14.51,"fill":"nuclear"},{"x":"Germany","y":8.75,"fill":"nuclear"},{"x":"South Korea","y":180.49,"fill":"nuclear"},{"x":"Brazil","y":10.86,"fill":"oil"},{"x":"Germany","y":20.13,"fill":"oil"},{"x":"South Korea","y":6.87,"fill":"oil"},{"x":"Brazil","y":38.16,"fill":"gas"},{"x":"Germany","y":76,"fill":"gas"},{"x":"South Korea","y":169.23,"fill":"gas"},{"x":"Brazil","y":17.19,"fill":"coal"},{"x":"Germany","y":135.35,"fill":"coal"},{"x":"South Korea","y":202.66,"fill":"coal"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0c86bb8c","dataId":"data_00267449","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"theme":{"colorScheme":{"default":{"dataScheme":[{"scheme":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7"]}]}}}},"data":[{"country":"Brazil","source":"solar","generation":51.72,"type":"Low carbon"},{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"South Korea","source":"solar","generation":29.37,"type":"Low carbon"},{"country":"Brazil","source":"wind","generation":95.73999999999999,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"South Korea","source":"wind","generation":3.41,"type":"Low carbon"},{"country":"Brazil","source":"hydro","generation":431.28,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"South Korea","source":"hydro","generation":3.7,"type":"Low carbon"},{"country":"Brazil","source":"nuclear","generation":14.51,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"South Korea","source":"nuclear","generation":180.49,"type":"Low carbon"},{"country":"Brazil","source":"oil","generation":10.86,"type":"Fossil fuels"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"South Korea","source":"oil","generation":6.87,"type":"Fossil fuels"},{"country":"Brazil","source":"gas","generation":38.16,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"South Korea","source":"gas","generation":169.23,"type":"Fossil fuels"},{"country":"Brazil","source":"coal","generation":17.19,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"},{"country":"South Korea","source":"coal","generation":202.66,"type":"Fossil fuels"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}
# Axis grid color
chart %>%
  v_theme(.axisGridColor = "red")

{"x":{"specs":{"type":"common","data":[{"id":"data_00267449","values":[{"x":"Brazil","y":51.72,"fill":"solar"},{"x":"Germany","y":61.56,"fill":"solar"},{"x":"South Korea","y":29.37,"fill":"solar"},{"x":"Brazil","y":95.73999999999999,"fill":"wind"},{"x":"Germany","y":137.29,"fill":"wind"},{"x":"South Korea","y":3.41,"fill":"wind"},{"x":"Brazil","y":431.28,"fill":"hydro"},{"x":"Germany","y":19.48,"fill":"hydro"},{"x":"South Korea","y":3.7,"fill":"hydro"},{"x":"Brazil","y":14.51,"fill":"nuclear"},{"x":"Germany","y":8.75,"fill":"nuclear"},{"x":"South Korea","y":180.49,"fill":"nuclear"},{"x":"Brazil","y":10.86,"fill":"oil"},{"x":"Germany","y":20.13,"fill":"oil"},{"x":"South Korea","y":6.87,"fill":"oil"},{"x":"Brazil","y":38.16,"fill":"gas"},{"x":"Germany","y":76,"fill":"gas"},{"x":"South Korea","y":169.23,"fill":"gas"},{"x":"Brazil","y":17.19,"fill":"coal"},{"x":"Germany","y":135.35,"fill":"coal"},{"x":"South Korea","y":202.66,"fill":"coal"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0c86bb8c","dataId":"data_00267449","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"theme":{"colorScheme":{"default":{"palette":{"axisGridColor":"red"}}}}},"data":[{"country":"Brazil","source":"solar","generation":51.72,"type":"Low carbon"},{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"South Korea","source":"solar","generation":29.37,"type":"Low carbon"},{"country":"Brazil","source":"wind","generation":95.73999999999999,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"South Korea","source":"wind","generation":3.41,"type":"Low carbon"},{"country":"Brazil","source":"hydro","generation":431.28,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"South Korea","source":"hydro","generation":3.7,"type":"Low carbon"},{"country":"Brazil","source":"nuclear","generation":14.51,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"South Korea","source":"nuclear","generation":180.49,"type":"Low carbon"},{"country":"Brazil","source":"oil","generation":10.86,"type":"Fossil fuels"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"South Korea","source":"oil","generation":6.87,"type":"Fossil fuels"},{"country":"Brazil","source":"gas","generation":38.16,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"South Korea","source":"gas","generation":169.23,"type":"Fossil fuels"},{"country":"Brazil","source":"coal","generation":17.19,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"},{"country":"South Korea","source":"coal","generation":202.66,"type":"Fossil fuels"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}# same as
chart %>%
  v_theme(
    component = list(
      axis = list(
        grid = list(
          style = list(
            # lineWidth = 3, # but more options available
            stroke = "red"
          )
        )
      )
    )
  )

{"x":{"specs":{"type":"common","data":[{"id":"data_00267449","values":[{"x":"Brazil","y":51.72,"fill":"solar"},{"x":"Germany","y":61.56,"fill":"solar"},{"x":"South Korea","y":29.37,"fill":"solar"},{"x":"Brazil","y":95.73999999999999,"fill":"wind"},{"x":"Germany","y":137.29,"fill":"wind"},{"x":"South Korea","y":3.41,"fill":"wind"},{"x":"Brazil","y":431.28,"fill":"hydro"},{"x":"Germany","y":19.48,"fill":"hydro"},{"x":"South Korea","y":3.7,"fill":"hydro"},{"x":"Brazil","y":14.51,"fill":"nuclear"},{"x":"Germany","y":8.75,"fill":"nuclear"},{"x":"South Korea","y":180.49,"fill":"nuclear"},{"x":"Brazil","y":10.86,"fill":"oil"},{"x":"Germany","y":20.13,"fill":"oil"},{"x":"South Korea","y":6.87,"fill":"oil"},{"x":"Brazil","y":38.16,"fill":"gas"},{"x":"Germany","y":76,"fill":"gas"},{"x":"South Korea","y":169.23,"fill":"gas"},{"x":"Brazil","y":17.19,"fill":"coal"},{"x":"Germany","y":135.35,"fill":"coal"},{"x":"South Korea","y":202.66,"fill":"coal"}]}],"axes":[{"orient":"left","type":"linear"},{"orient":"bottom","type":"band"}],"series":[{"type":"bar","id":"serie_0c86bb8c","dataId":"data_00267449","seriesField":"fill","stack":false,"percent":false,"direction":"vertical","xField":["x","fill"],"yField":"y","name":"generation"}],"color":["#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","#999999"],"legends":[{"visible":true}],"theme":{"component":{"axis":{"grid":{"style":{"stroke":"red"}}}}}},"data":[{"country":"Brazil","source":"solar","generation":51.72,"type":"Low carbon"},{"country":"Germany","source":"solar","generation":61.56,"type":"Low carbon"},{"country":"South Korea","source":"solar","generation":29.37,"type":"Low carbon"},{"country":"Brazil","source":"wind","generation":95.73999999999999,"type":"Low carbon"},{"country":"Germany","source":"wind","generation":137.29,"type":"Low carbon"},{"country":"South Korea","source":"wind","generation":3.41,"type":"Low carbon"},{"country":"Brazil","source":"hydro","generation":431.28,"type":"Low carbon"},{"country":"Germany","source":"hydro","generation":19.48,"type":"Low carbon"},{"country":"South Korea","source":"hydro","generation":3.7,"type":"Low carbon"},{"country":"Brazil","source":"nuclear","generation":14.51,"type":"Low carbon"},{"country":"Germany","source":"nuclear","generation":8.75,"type":"Low carbon"},{"country":"South Korea","source":"nuclear","generation":180.49,"type":"Low carbon"},{"country":"Brazil","source":"oil","generation":10.86,"type":"Fossil fuels"},{"country":"Germany","source":"oil","generation":20.13,"type":"Fossil fuels"},{"country":"South Korea","source":"oil","generation":6.87,"type":"Fossil fuels"},{"country":"Brazil","source":"gas","generation":38.16,"type":"Fossil fuels"},{"country":"Germany","source":"gas","generation":76,"type":"Fossil fuels"},{"country":"South Korea","source":"gas","generation":169.23,"type":"Fossil fuels"},{"country":"Brazil","source":"coal","generation":17.19,"type":"Fossil fuels"},{"country":"Germany","source":"coal","generation":135.35,"type":"Fossil fuels"},{"country":"South Korea","source":"coal","generation":202.66,"type":"Fossil fuels"}],"mapping":null,"type":"bar"},"evals":[],"jsHooks":[]}# see https://www.unpkg.com/@visactor/vchart-theme@1.11.6/public/light.json
# for all possibilities
```
