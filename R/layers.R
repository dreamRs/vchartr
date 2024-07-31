
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
#' @param ... Additional parameters for the serie.
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
                  ...,
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
    direction = direction,
    ...
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
#' @param line_style Area's styles options, such as curve interpolation type,
#'  see [online documentation](https://www.visactor.io/vchart/option/lineChart#line.style.curveType)
#' @param point Options for showing points on lines or not.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_line.R
v_line <- function(vc,
                   mapping = NULL, 
                   data = NULL,
                   name = NULL,
                   line_style = list(
                     curve_type = "linear",
                     line_dash = 0,
                     stroke = NULL
                   ),
                   point = list(visible = FALSE),
                   ...,
                   dataserie_id = NULL) {
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
    point = point,
    line = list(style = style_params(line_style)),
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  vc <- v_specs_axes(vc, position = "left", type = "linear")
  scale_x <- attr(mapdata, "scale_x")
  if (identical(scale_x, "discrete")) {
    vc <- v_specs_axes(vc, position = "bottom", type = "band")
  } else if (identical(scale_x, "date")) {
    vc <- v_scale_x_date(vc = vc)
  } else {
    vc <- v_scale_x_continuous(vc = vc)
  }
  if (has_name(mapdata, "colour")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  return(vc)
}




#' Create an Area Chart
#'
#' @inheritParams v_line
#' @param stack Whether to stack the data or not (if `fill` aesthetic is provided).
#' @param area_style Area's styles options, such as curve interpolation type, see [online documentation](https://www.visactor.io/vchart/option/AreaChart#area.style.curveType).
#' @param line Options for showing lines or not.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_area.R
v_area <- function(vc,
                   mapping = NULL, 
                   data = NULL,
                   name = NULL,
                   stack = FALSE,
                   area_style = list(
                     curve_type = "linear",
                     fill = NULL,
                     fill_opacity = NULL
                   ),
                   point = list(visible = FALSE),
                   line = list(visible = FALSE),
                   ...,
                   dataserie_id = NULL) {
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
  if (has_name(mapdata, "y")) {
    type <- "area"
    yField <- "y"
  } else if (all(has_name(mapdata, c("ymin", "ymax")))) {
    type <- "rangeArea"
    yField <- c("ymin", "ymax")
  } else {
    stop("v_area() must have aesthetic `y` or `ymin`/`ymax`", call. = FALSE)
  }
  serie <- list_(
    type = type,
    name = name,
    id = dataserie_id,
    dataId = dataserie_id,
    xField = "x",
    yField = yField,
    seriesField = if (has_name(mapdata, "fill")) "fill",
    stack = isTRUE(stack),
    point = point,
    line = line,
    area = list(
      style = style_params(area_style)
    ),
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  vc <- v_specs_axes(vc, position = "left", type = "linear")
  scale_x <- attr(mapdata, "scale_x")
  if (identical(scale_x, "discrete")) {
    vc <- v_specs_axes(vc, position = "bottom", type = "band")
  } else if (identical(scale_x, "date")) {
    vc <- v_scale_x_date(vc = vc)
  } else {
    vc <- v_scale_x_continuous(vc = vc)
  }
  if (has_name(mapdata, "fill")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  return(vc)
}



#' Create an Histogram
#'
#' @inheritParams v_bar
#' @inheritParams ggplot2::stat_bin
#' @param bar_style Style properties for histogram bars.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_hist.R
v_hist <- function(vc,
                   mapping = NULL, 
                   data = NULL,
                   name = NULL,
                   stack = FALSE,
                   bins = 30,
                   binwidth = NULL,
                   bar_style = NULL,
                   dataserie_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  p <- ggplot2::ggplot(data = data, mapping = mapping)
  p <- p + ggplot2::geom_histogram(bins = bins, binwidth = binwidth) +
    ggplot2::scale_fill_identity()
  mapdata <- ggplot2::layer_data(p, i = 1L)
  vc$x$mapdata <- c(vc$x$mapdata, as.list(mapdata))
  if (is.null(dataserie_id))
    dataserie_id <- paste0("serie_", genId(4))
  vc <- v_specs(
    vc = vc,
    data = list(
      list(
        id = dataserie_id,
        values = create_values(mapdata[, c("xmin", "xmax", "count", "fill")])
      )
    ),
    type = "histogram",
    id = dataserie_id,
    dataId = dataserie_id,
    name = name,
    xField = "xmin",
    x2Field = "xmax",
    yField = "count",
    seriesField = if (has_name(mapping, "fill")) "fill",
    stack = stack,
    bar = list_(style = style_params(bar_style))
  )
  vc <- v_specs_axes(vc, position = "left", type = "linear")
  vc <- v_specs_axes(vc, position = "bottom", type = "linear", zero = FALSE)
  vc <- .vchart_specs(
    vc, "tooltip",
    list(
      visible = TRUE,
      mark = list(
        title = list(
          key = "title",
          value = if (!has_name(mapping, "fill")) {
            "Count"
          } else {
            JS("datum => datum[\'fill\']")
          }
        ),
        content = list(
          list(
            key = JS("datum => Math.round(datum[\'xmin\']) + \'\uff5e\' + Math.round(datum[\'xmax\'])"),
            value = JS("datum => datum[\'count\']")
          )
        )
      )
    )
  )
  if (has_name(mapping, "fill")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  return(vc)
}





#' Create a Scatter Chart
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_scatter.R
v_scatter <- function(vc,
                      mapping = NULL, 
                      data = NULL,
                      name = NULL,
                      ...,
                      dataserie_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
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
    type = "scatter",
    id = dataserie_id,
    dataId = dataserie_id,
    xField = "x",
    yField = "y",
    seriesField = if (has_name(mapdata, "colour")) "colour",
    sizeField = if (has_name(mapdata, "size")) "size",
    shapeField = if (has_name(mapdata, "shape")) "shape",
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  vc <- v_specs_axes(
    vc, position = "left",
    type = "linear",
    domainLine = list(visible = TRUE),
    zero = FALSE
  )
  vc <- v_specs_axes(
    vc, position = "bottom",
    type = "linear",
    domainLine = list(visible = TRUE),
    zero = FALSE
  )
  vc <- .vchart_specs(
    vc, "crosshair",
     list(
      xField = list(
        visible = TRUE,
        line = list(visible = TRUE, type= "line"),
        label = list(visible = TRUE)
      ),
      yField = list(
        visible = TRUE,
        line = list(visible = TRUE, type= "line"),
        label = list(visible = TRUE)
      )
    )
  )
  # vc <- .vchart_specs(vc, "legends", list())
  scale_colour <- attr(mapdata, "scale_colour")
  if (identical(scale_colour, "continuous")) {
    vc <- v_scale_colour_gradient(vc)
  } else if (!is.na(scale_colour)) {
    vc <- v_specs_legend(vc, visible = TRUE, seriesId = dataserie_id)
  }
  scale_size <- attr(mapdata, "scale_size")
  if (identical(scale_size, "continuous")) {
    vc <- v_scale_size(vc)
  }
  return(vc)
}



#' Create a Pie Chart
#'
#' @inheritParams v_bar
#' @param label Options for displaying labels on the pie chart.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_pie.R
v_pie <- function(vc,
                  mapping = NULL, 
                  data = NULL,
                  name = NULL,
                  label = list(visible = TRUE),
                  ...,
                  dataserie_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
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
    type = "pie",
    id = dataserie_id,
    dataId = dataserie_id,
    categoryField = "x",
    valueField = "y",
    label = label,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  return(vc)
}

