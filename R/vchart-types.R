
#' Create a bar chart
#'
#' @param data Default dataset to use for chart. If not already
#'  a `data.frame`, it will be coerced to with `as.data.frame`.
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @param stack Whether to stack the data or not (if `fill` aesthetic is provided).
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
  mapdata <- eval_mapping(data, mapping)
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
#' @param name Name for the serie, only used for single serie (no `color` aesthetic supplied).
#' @param serie_id ID for the serie, can be used to customize the serie with [v_specs()]
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name line-area-chart
#'
#' @example examples/vline.R
vline <- function(data,
                  mapping,
                  format_date = "%Y-%m-%d",
                  format_datetime = "%Y-%m-%d %H:%M",
                  name = NULL,
                  serie_id = NULL,
                  width = NULL,
                  height = NULL,
                  elementId = NULL) {
  data <- as.data.frame(data)
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  mapdata <- eval_mapping(data, mapping, convert_date = TRUE)
  if (identical(attr(mapdata, "datetime_format"), "datetime"))
    format_date <- format_datetime
  if (is.null(serie_id))
    serie_id <- paste0("line_", genId(4))
  specs <- list(
    type = "common",
    data = list(
      list(
        id = serie_id,
        values = create_values(mapdata)
      )
    ),
    series = list(
      list(
        type = "line",
        name = name,
        dataId = serie_id,
        xField = "x",
        yField = "y",
        seriesField = if (has_name(mapdata, "colour")) "colour",
        point = list(
          visible = FALSE
        )
      )
    ),
    axes = list(
      list(
        orient = "left",
        type = "linear"
      ),
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
              "function(datum) {
                //console.log(datum);
                  let val = datum.y;
                  if (val === null) {
                    val = '-';
                  }
                  if (datum.hasOwnProperty('ymin')) {
                    val = datum.ymin + ' - ' + datum.ymax;
                  }
                  if (datum.hasOwnProperty('colour')) {
                    return datum.colour + ' : ' + val;
                  } else {
                   return datum.__VCHART_DEFAULT_DATA_SERIES_FIELD + ' : ' + val;
                  }
                }"
            )
          )
        )
      )
    )
  )
  if (has_name(mapdata, "colour")) {
    specs$legends$visible <- TRUE
  }
  vc <- create_chart("vline", specs, width, height, elementId)
  vc$x$data <- data
  return(vc)
}


#' @param vc A chart created with [vline()].
#'
#' @export
#'
#' @rdname line-area-chart
v_add_line <- function(vc, mapping, data = NULL, name = NULL, serie_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vline()" = inherits(vc, "vline")
  )
  if (is.null(data)) {
    data <- vc$x$data
  }
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  mapdata <- eval_mapping(data, mapping, convert_date = TRUE)
  if (is.null(serie_id))
    serie_id <- paste0("line_", genId(4))
  vc$x$specs$data <- c(
    vc$x$specs$data,
    list(
      list(
        id = serie_id,
        values = create_values(mapdata)
      )
    )
  )
  vc$x$specs$series <- c(
    vc$x$specs$series,
    list(
      list(
        type = "line",
        name = name,
        dataId = serie_id,
        xField = "x",
        yField = "y",
        seriesField = if (has_name(mapdata, "colour")) "colour",
        point = list(
          visible = FALSE
        )
      )
    )
  )
  return(vc)
}


#' @export
#'
#' @rdname line-area-chart
v_add_range_area <- function(vc, mapping, data = NULL, name = NULL, serie_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vline()" = inherits(vc, "vline")
  )
  if (is.null(data)) {
    data <- vc$x$data
  }
  if (is.null(name) & !is.null(mapping$ymin) & !is.null(mapping$ymax))
    name <- paste(rlang::as_label(mapping$ymin), rlang::as_label(mapping$ymax), sep = " - ")
  mapdata <- eval_mapping(data, mapping, convert_date = TRUE)
  if (is.null(serie_id))
    serie_id <- paste0("range_area_", genId(4))
  vc$x$specs$data <- c(
    vc$x$specs$data,
    list(
      list(
        id = serie_id,
        values = create_values(mapdata)
      )
    )
  )
  vc$x$specs$series <- c(
    list(
      list(
        type = "rangeArea",
        name = name,
        dataId = serie_id,
        xField = "x",
        yField = c("ymin", "ymax"),
        seriesField = if (has_name(mapdata, "colour")) "colour",
        point = list(
          visible = FALSE
        )
      )
    ),
    vc$x$specs$series
  )
  return(vc)
}





#' Create an histogram
#'
#' @param data Default dataset to use for chart. If not already
#'  a `data.frame`, it will be coerced to with `as.data.frame`.
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @inheritParams ggplot2::stat_bin
#' @param stack Whether to stack the data or not (if `fill` aesthetic is provided).
#' @inheritParams vchart
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vhist.R
vhist <- function(data,
                  mapping,
                  bins = 30,
                  binwidth = NULL,
                  stack = FALSE,
                  width = NULL,
                  height = NULL,
                  elementId = NULL) {
  p <- ggplot2::ggplot(data = data, mapping = mapping)
  p <- p + ggplot2::geom_histogram(bins = bins, binwidth = binwidth) +
    ggplot2::scale_fill_identity()
  hdata <- ggplot2::layer_data(p, i = 1L)
  specs <- list(
    type = "histogram",
    data = list(
      list(
        values = create_values(hdata[, c("xmin", "xmax", "count", "fill")])
      )
    ),
    xField = "xmin",
    x2Field = "xmax",
    yField = "count",
    seriesField = if (has_name(mapping, "fill")) "fill",
    stack = stack,
    axes = list(
      list(
        orient = "bottom",
        type = "linear",
        zero = FALSE
      )
    ),
    tooltip = list(
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
    specs$legends$visible <- TRUE
  }
  create_chart("histogram", specs, width, height, elementId)
}

