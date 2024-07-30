

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
#' @example examples/v_scale_date.R
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
  mapdata <- vc$x$mapdata

  if (is.null(date_breaks))
    date_breaks <- 5
  if (is.null(date_labels))
    date_labels <- "%Y-%m-%d"

  aesthetic <- switch(
    position,
    "bottom" = "x",
    "top" = "x",
    "right" = "y",
    "left" = "y"
  )

  date_breaks_min <- if (!is.null(min)) {
    as.Date(min, origin = "1970-01-01")
  } else {
    min(as.Date(mapdata[[aesthetic]], origin = "1970-01-01"), na.rm = TRUE)
  }

  date_breaks_max <- if (!is.null(max)) {
    as.Date(max, origin = "1970-01-01")
  } else {
    max(as.Date(mapdata[[aesthetic]], origin = "1970-01-01"), na.rm = TRUE)
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

  label <- if (!is.null(dates_ticks)) {
    list(
      formatMethod = JS("val => {var date = new Date(val * 3600*24 * 1000); return date.toLocaleDateString();}"),
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(dates_ticks, collapse = ", ")
      ))
    )
  }

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

  v_axes(
    vc = vc,
    position = position,
    type = "linear",
    sampling = FALSE,
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
#' @example examples/v_scale_continuous.R
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
  mapdata <- vc$x$mapdata

  if (is.null(breaks))
    breaks <- 5

  aesthetic <- switch(
    position,
    "bottom" = "x",
    "top" = "x",
    "right" = "y",
    "left" = "y"
  )

  breaks_min <- if (!is.null(min)) {
    as.numeric(min)
  } else {
    min(as.numeric(mapdata[[aesthetic]]), na.rm = TRUE)
  }

  breaks_max <- if (!is.null(max)) {
    as.numeric(max, origin = "1970-01-01")
  } else {
    max(as.numeric(mapdata[[aesthetic]]), na.rm = TRUE)
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

  v_axes(
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

