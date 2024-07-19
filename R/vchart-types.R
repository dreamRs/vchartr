
#' Create a bar chart
#'
#' @param data Default dataset to use for chart. If not already
#'  a `data.frame`, it will be coerced to with `as.data.frame`.
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @param stack Whether to stack the data.
#' @param percent Whether to display the data as a percentage.
#' @param direction The direction configuration of the chart: `"vertical"` (default) or `"horizontal"`.
#' @inheritParams vchart
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang eval_tidy has_name exec
#'
#' @example examples/vbar.R
vbar <- function(data,
                 mapping,
                 stack = FALSE,
                 percent = FALSE,
                 direction = c("vertical", "horizontal"),
                 width = NULL,
                 height = NULL,
                 elementId = NULL) {
  direction <- match.arg(direction)
  data <- as.data.frame(data)
  mapdata <- lapply(mapping, eval_tidy, data = data)
  specs <- list(
    type = "bar",
    data = list(
      list(
        values = create_values(mapdata)
      )
    ),
    seriesField = if (has_name(mapdata, "fill")) "fill",
    stack = stack,
    percent = percent,
    direction = direction
  )
  if (direction == "horizontal") {
    specs$xField <- "y"
    specs$yField <- if (has_name(mapdata, "fill") & isFALSE(stack)) c("x", "fill") else "x"
  } else {
    specs$xField <- if (has_name(mapdata, "fill") & isFALSE(stack)) c("x", "fill") else "x"
    specs$yField <- "y"
  }
  if (has_name(mapdata, "fill")) {
    specs$legends$visible <- TRUE
  }
  create_chart("vbar", specs, width, height, elementId)
}






#' Create a line chart
#'
#' @inheritParams vchart
#' @inheritParams vbar
#' @param format_date Format to be applied if `x` aesthetic is a `Date`.
#' @param format_datetime Format to be applied if `x` aesthetic is a `POSIXt`.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
vline <- function(data,
                  mapping,
                  format_date = "%Y-%m-%d",
                  format_datetime = "%Y-%m-%d %H:%M",
                  width = NULL,
                  height = NULL,
                  elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- lapply(mapping, eval_tidy, data = data)
  if (inherits(mapdata$x, "Date")) {
    mapdata$x <- as.numeric(mapdata$x) * 3600*24 * 1000
  } else if (inherits(mapdata$x, "POSIXt")) {
    mapdata$x <- as.numeric(mapdata$x) * 1000
    format_date <- format_datetime
  }
  specs <- list(
    type = "line",
    data = list(
      list(
        values = create_values(mapdata)
      )
    ),
    xField = "x",
    yField = "y",
    seriesField = if (has_name(mapdata, "colour")) "colour",
    point = list(
      visible = FALSE
    ),
    axes = list(
      list(
        orient = "bottom",
        type = "time",
        nice = FALSE,
        layers = list(list(timeFormat = format_date))
      )
    ),
    tooltip = list(
      dimension = list(
        title = list(
          valueTimeFormat = format_date
        ),
        content = list(
          list(
            key = JS(
              "function(datum) {",
              "  if (datum.hasOwnProperty('colour')) {",
              "    return datum.colour + ' : ' + datum.y;",
              "  } else {",
              "   return datum.y;",
              "  }",
              "}"
            )
          )
        )
      )
    )
  )
  if (has_name(mapdata, "colour")) {
    specs$legends$visible <- TRUE
  }
  create_chart("vline", specs, width, height, elementId)
}



