

# Date --------------------------------------------------------------------


#' Axis scale for date/time data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the axis.
#' @param date_breaks One of:
#'   * A single `numeric` value giving the number of breaks.
#'   * A string giving the distance between breaks like "2 weeks", or "10 years".
#'   * A Date/POSIXct vector giving positions of breaks.
#' @param date_labels The format to be applied on Date/POSIXct in the labels.
#' @param min Minimum value on the axis.
#' @param max Maximum value on the axis.
#' @param position Position of the axis.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name scale-date
#'
#' @example examples/scale_date.R
v_scale_x_date <- function(vc,
                           name = NULL,
                           date_breaks = NULL,
                           date_labels = NULL,
                           min = NULL,
                           max = NULL,
                           position = "bottom") {
  v_scale_date(
    vc = vc,
    position = position,
    name = name,
    date_breaks = date_breaks,
    date_labels = date_labels,
    min = min,
    max = max
  )
}

#' @export
#'
#' @rdname scale-date
v_scale_y_date <- function(vc,
                           name = NULL,
                           date_breaks = NULL,
                           date_labels = NULL,
                           min = NULL,
                           max = NULL,
                           position = "left") {
  v_scale_date(
    vc = vc,
    position = position,
    name = name,
    date_breaks = date_breaks,
    date_labels = date_labels,
    min = min,
    max = max
  )
}


v_scale_date <- function(vc,
                         position,
                         name = NULL,
                         date_breaks = NULL,
                         date_labels = NULL,
                         min = NULL,
                         max = NULL) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  
  aesthetic <- switch(
    position,
    "bottom" = "x",
    "top" = "x",
    "right" = "y",
    "left" = "y"
  )
  
  if (!is.null(vc$x$mapdata[[aesthetic]])) {
    x <- vc$x$mapdata[[aesthetic]]
  } else {
    x <- unlist(lapply(vc$x$mapdata, `[[`, aesthetic))
  }

  if (is.null(date_breaks))
    date_breaks <- 5
  if (is.null(date_labels))
    date_labels <- "%Y-%m-%d"

  date_breaks_min <- if (!is.null(min)) {
    as.Date(min, origin = "1970-01-01")
  } else {
    min(as.Date(x, origin = "1970-01-01"), na.rm = TRUE)
  }

  date_breaks_max <- if (!is.null(max)) {
    as.Date(max, origin = "1970-01-01")
  } else {
    max(as.Date(x, origin = "1970-01-01"), na.rm = TRUE)
  }

  dates_ticks <- NULL
  if (is.numeric(date_breaks) & length(date_breaks) == 1) {
    dates_ticks <- round(as.numeric(seq(from = date_breaks_min, to = date_breaks_max, length.out = date_breaks)))
  } else if (is.character(date_breaks) & length(date_breaks) == 1) {
    dates_ticks <- as.numeric(seq(from = date_breaks_min, to = date_breaks_max, by = date_breaks))
  } else {
    if (is.character(date_breaks)) {
      dates_ticks <- as.numeric(as.Date(dates_ticks, origin = "1970-01-01"))
    } else {
      dates_ticks <- as.numeric(dates_ticks)
    }
  }

  tick <- if (!is.null(dates_ticks)) {
    list(
      visible = TRUE,
      tickStep = 1,
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(dates_ticks, collapse = ", ")
      ))
    )
  }

  label <- list()
  if (!is.null(dates_ticks)) {
    label$dataFilter <- JS(sprintf(
      "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
      paste(dates_ticks, collapse = ", ")
    ))
  }
  if (inherits(date_labels, "JS_EVAL")) {
    label$formatMethod <- JS(
      "function(value) {",
      "var date = new Date(value * 3600 * 24 * 1000);",
      sprintf("const fun = %s;", date_labels),
      "return fun(date);",
      "}"
    )
  } else if (is.character(date_labels)) {
    label$formatMethod <- JS(
      "function(value) {",
      "var date = new Date(value * 3600 * 24 * 1000);",
      sprintf("const fun = %s;", d3_format_time(date_labels)),
      "return fun(date);",
      "}"
    )
  }
  if (length(label) < 1)
    label <- NULL

  grid <- if (!is.null(dates_ticks)) {
    list(
      style = JS(sprintf(
        "(value, index, datum) => {var values = [%s]; return {visible: values.includes(value)};}",
        paste(dates_ticks, collapse = ", ")
      ))
    )
  }

  title <- if (is.character(name) & length(name) == 1) {
    list(
      visible = TRUE,
      text = name,
      position = "middle"
    )
  } else {
    name
  }

  v_specs_axes(
    vc = vc,
    position = position,
    type = "linear",
    sampling = FALSE,
    zero = FALSE,
    min = if (!is.null(min)) as.numeric(as.Date(min)),
    max = if (!is.null(max)) as.numeric(as.Date(max)),
    tick = tick,
    label = label,
    grid = grid,
    title = title
  )
}




# Continuous --------------------------------------------------------------



#' Axis scale for continuous data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the axis.
#' @param breaks One of:
#'   * A single `numeric` value giving the number of breaks.
#'   * A numeric vector of positions.
#' @param pretty Use [pretty()] to dertimen breaks if `breaks` is a single numeric value.
#' @param labels The format to be applied on numeric in the labels. Either:
#'   * A single character indicationg th D3 format.
#'   * A `JS` function, such as [d3_format()].
#' @param zero Force axis to start at 0.
#' @param min Minimum value on the axis.
#' @param max Maximum value on the axis.
#' @param position Position of the axis.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name scale-continuous
#'
#' @example examples/scale_continuous.R
v_scale_x_continuous <- function(vc,
                                 name = NULL,
                                 breaks = NULL,
                                 pretty = TRUE,
                                 labels = NULL,
                                 zero = FALSE,
                                 min = NULL,
                                 max = NULL,
                                 position = "bottom") {
  v_scale_continuous(
    vc = vc,
    position = position,
    name = name,
    breaks = breaks,
    pretty = pretty,
    labels = labels,
    min = min,
    max = max
  )
}


#' @export
#'
#' @rdname scale-continuous
v_scale_y_continuous <- function(vc,
                                 name = NULL,
                                 breaks = NULL,
                                 pretty = TRUE,
                                 labels = NULL,
                                 zero = FALSE,
                                 min = NULL,
                                 max = NULL,
                                 position = "left") {
  v_scale_continuous(
    vc = vc,
    position = position,
    name = name,
    breaks = breaks,
    pretty = pretty,
    labels = labels,
    min = min,
    max = max
  )
}

v_scale_continuous <- function(vc,
                               position,
                               name = NULL,
                               breaks = NULL,
                               pretty = TRUE,
                               labels = NULL,
                               zero = FALSE,
                               min = NULL,
                               max = NULL) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  
  aesthetic <- switch(
    position,
    "bottom" = "x",
    "top" = "x",
    "right" = "y",
    "left" = "y"
  )
  
  if (!is.null(vc$x$mapdata[[aesthetic]])) {
    x <- vc$x$mapdata[[aesthetic]]
  } else {
    x <- unlist(lapply(vc$x$mapdata, `[[`, aesthetic))
  }

  if (is.null(breaks))
    breaks <- 5

  breaks_min <- if (!is.null(min)) {
    as.numeric(min)
  } else {
    min(as.numeric(x), na.rm = TRUE)
  }

  breaks_max <- if (!is.null(max)) {
    as.numeric(max, origin = "1970-01-01")
  } else {
    max(as.numeric(x), na.rm = TRUE)
  }

  breaks_ticks <- NULL
  if (is.numeric(breaks) & length(breaks) == 1) {
    if (isTRUE(pretty)) {
      breaks_ticks <- pretty(seq(from = breaks_min, to = breaks_max, length.out = 10), n = breaks)
    } else {
      breaks_ticks <- as.numeric(seq(from = breaks_min, to = breaks_max, length.out = breaks))
    }
  } else {
    breaks_ticks <- as.numeric(breaks)
  }

  tick <- if (!is.null(breaks_ticks)) {
    list(
      visible = TRUE,
      tickStep = 1,
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(breaks_ticks, collapse = ", ")
      ))
    )
  }

  label <- list()
  if (!is.null(breaks_ticks)) {
    label$dataFilter <- JS(sprintf(
      "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
      paste(breaks_ticks, collapse = ", ")
    ))
  }
  if (inherits(labels, "JS_EVAL")) {
    label$formatMethod <- labels
  } else if (is.character(labels)) {
    label$formatMethod <- d3_format(labels)
  }
  if (length(label) < 1)
    label <- NULL

  grid <- if (!is.null(breaks_ticks)) {
    list(
      style = JS(sprintf(
        "(value, index, datum) => {var values = [%s]; return {visible: values.includes(value)};}",
        paste(breaks_ticks, collapse = ", ")
      ))
    )
  }

  title <- if (is.character(name) & length(name) == 1) {
    list(
      visible = TRUE,
      text = name,
      position = "middle"
    )
  } else {
    name
  }

  v_specs_axes(
    vc = vc,
    position = position,
    type = "linear",
    zero = zero,
    sampling = FALSE,
    min = if (!is.null(min)) as.numeric(min),
    max = if (!is.null(max)) as.numeric(max),
    tick = tick,
    label = label,
    grid = grid,
    title = title
  )
}





# Scale colour ----------------------------------------------------------------------


#' Color scale for continuous data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the legend.
#' @param low,high Colours for low and high ends of the gradient.
#' @param limits Limits of the scale, default (`NULL`) is to use the default scale range of the data.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#' 
#' @name scale-gradient
#'
# @examples
v_scale_colour_gradient <- function(vc,
                                    name = NULL,
                                    low = "#132B43",
                                    high = "#56B1F7",
                                    limits = NULL) {
  v_scale_gradient(
    vc = vc,
    name = name,
    low = low,
    high = high,
    limits = limits,
    aesthetic = "colour"
  )
}

#' @export
#' 
#' @rdname scale-gradient
v_scale_fill_gradient <- function(vc,
                                  name = NULL,
                                  low = "#132B43",
                                  high = "#56B1F7",
                                  limits = NULL) {
  v_scale_gradient(
    vc = vc,
    name = name,
    low = low,
    high = high,
    limits = limits,
    aesthetic = "fill"
  )
}

v_scale_gradient <- function(vc,
                             name = NULL,
                             low = "#132B43",
                             high = "#56B1F7",
                             limits = NULL,
                             aesthetic) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  
  if (!is.null(vc$x$mapdata[[aesthetic]])) {
    x <- vc$x$mapdata[[aesthetic]]
  } else {
    x <- unlist(lapply(vc$x$mapdata, `[[`, aesthetic))
  }
  
  if (is.null(limits))
    limits <- range(pretty(range(x, na.rm = TRUE)))
  
  title <- if (is.character(name) & length(name) == 1) {
    list(
      visible = TRUE,
      text = name
    )
  } else {
    name
  }
  
  index <- vapply(
    X = vc$x$specs$series,
    FUN = function(x) has_name(x, "seriesField"),
    FUN.VALUE = logical(1)
  )
  dataserie_id <- vc$x$specs$series[index][[1]]$id
  vc <- v_specs(
    vc, 
    # seriesField = NULL,
    # point = list(
    #   style = list(
    #     fill = list(field = aesthetic, scale = "color")
    #   )
    # ),
    color = list(
      type = "linear",
      domain = limits,
      # domain = list(list(dataId = dataserie_id, fields = list(aesthetic))),
      range = c(low, high)
    ) 
    # , dataserie_id = dataserie_id
  )
  vc <- .vchart_specs(
    vc, "legends", 
    list(dropNulls(list(
      visible = TRUE,
      type = "color",
      field = aesthetic,
      title = title,
      serieId = dataserie_id
    )))
  )
  return(vc)
}




# Scale size ------------------------------------------------------------------------



#' Size scale for continuous data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the legend.
#' @param range Range of sizes for the points plotted.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
# @examples
v_scale_size <- function(vc,
                         name = NULL,
                         range = c(5, 30)) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  
  if (!is.null(vc$x$mapdata$size)) {
    x <- vc$x$mapdata$size
  } else {
    x <- unlist(lapply(vc$x$mapdata, `[[`, "size"))
  }
  
  
  title <- if (is.character(name) & length(name) == 1) {
    list(
      visible = TRUE,
      text = name
    )
  } else {
    name
  }
  
  index <- vapply(
    X = vc$x$specs$series,
    FUN = function(x) has_name(x, "sizeField"),
    FUN.VALUE = logical(1)
  )
  dataserie_id <- vc$x$specs$series[index][[1]]$id
  vc <- v_specs(
    vc,
    size = list(
      type = "linear",
      # domain = c(2000, 7000),
      range = range
    ),
    dataserie_id = dataserie_id
  )
  vc <- .vchart_specs(
    vc, "legends", 
    list(dropNulls(list(
      visible = TRUE, 
      type = "size",
      field = "size"
    )))
  )
  return(vc)
}

