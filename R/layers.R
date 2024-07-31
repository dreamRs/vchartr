
#' Create a Bar Chart
#' 
#' @param vc A chart initialized with [vchart()].
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @param data Default dataset to use for chart. If not already
#'  a `data.frame`, it will be coerced to with `as.data.frame`.
#' @param name Name for the serie, only used for single serie (no `color`/`fill` aesthetic supplied).
#' @param stack Whether to stack the data or not (if `fill` aesthetic is provided).
#' @param percent Whether to display the data as a percentage.
#' @param direction The direction configuration of the chart: `"vertical"` (default) or `"horizontal"`.
#' @param dataserie_id ID for the serie, can be used to customize the serie with [v_specs()].
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang eval_tidy has_name exec
#'
#' @example examples/v_bar.R
v_bar <- function(vc,
                  mapping = NULL, 
                  data = NULL,
                  name = NULL,
                  stack = FALSE,
                  percent = FALSE,
                  direction = c("vertical", "horizontal"),
                  dataserie_id = NULL) {
  direction <- match.arg(direction)
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$mapdata <- c(vc$x$mapdata, list(mapdata))
  if (is.null(dataserie_id))
    dataserie_id <- paste0("serie_", genId(4))
  vc <- .vchart_specs(
    vc, "data", 
    list(
      list(
        id = dataserie_id,
        values = create_values(mapdata)
      )
    )
  )
  serie <- list_(
    type = "bar",
    id = dataserie_id,
    dataId = dataserie_id,
    name = name,
    seriesField = if (has_name(mapdata, "fill")) "fill",
    stack = stack,
    percent = percent,
    direction = direction
  )
  if (direction == "horizontal") {
    serie$xField <- "y"
    serie$yField <- "x"
    if (has_name(mapdata, "group"))
      serie$yField <- c("group", serie$yField)
    if (has_name(mapdata, "fill") & isFALSE(stack))
      serie$yField <- c(serie$yField, "fill")
    if (is.null(name) & !is.null(mapping$x))
      serie$name <- rlang::as_label(mapping$x)
    vc <- v_specs_axes(vc, position = "bottom", type = "linear")
    vc <- v_specs_axes(vc, position = "left", type = "band")
  } else {
    serie$xField <- "x"
    if (has_name(mapdata, "group"))
      serie$xField <- c("group", serie$xField)
    if (has_name(mapdata, "fill") & isFALSE(stack))
      serie$xField <- c(serie$xField, "fill")
    serie$yField <- "y"
    if (is.null(name) & !is.null(mapping$y))
      serie$name <- rlang::as_label(mapping$y)
    vc <- v_specs_axes(vc, position = "left", type = "linear")
    vc <- v_specs_axes(vc, position = "bottom", type = "band")
  }
  vc <- .vchart_specs(
    vc, "series",
    list(serie)
  )
  if (has_name(mapdata, "fill")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  return(vc)
}




#' Create a Line Chart
#'
#' @inheritParams v_bar
#' @param points Show points on lines or not.
#' @param curve_type Curve interpolation type, see [https://www.visactor.io](https://www.visactor.io/vchart/option/lineChart#line.style.curveType).
#' @param line_dash Used to configure the dashed line mode when filling lines.
#'  It uses an array of values to specify the alternating lengths of lines and gaps that describe the pattern.
#' @param stroke Stroke color. 
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_line.R
v_line <- function(vc,
                   mapping = NULL, 
                   data = NULL,
                   name = NULL,
                   dataserie_id = NULL,
                   points = FALSE,
                   curve_type = "linear",
                   line_dash = 0,
                   stroke = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$mapdata <- c(vc$x$mapdata, list(mapdata))
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  if (is.null(dataserie_id))
    dataserie_id <- paste0("serie_", genId(4))
  vc <- .vchart_specs(
    vc, "data", 
    list(
      list(
        id = dataserie_id,
        values = create_values(mapdata)
      )
    )
  )
  serie <- list_(
    type = "line",
    name = name,
    id = dataserie_id,
    dataId = dataserie_id,
    xField = "x",
    yField = "y",
    seriesField = if (has_name(mapdata, "colour")) "colour",
    point = list(
      visible = isTRUE(points)
    ),
    line = list(
      style = list_(
        curveType = curve_type,
        lineDash = list1(line_dash),
        stroke = stroke
      )
    )
  )
  vc <- .vchart_specs(
    vc, "series",
    list(serie)
  )
  vc <- v_specs_axes(vc, position = "left", type = "linear")
  scale_x <- attr(mapdata, "scale_x")
  if (scale_x == "discrete") {
    vc <- v_specs_axes(vc, position = "bottom", type = "band")
  } else if (scale_x == "date") {
    vc <- v_scale_x_date(vc = vc)
  } else {
    vc <- v_scale_x_continuous(vc = vc)
  }
  if (has_name(mapdata, "colour")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  return(vc)
}

