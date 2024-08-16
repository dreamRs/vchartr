

# Date --------------------------------------------------------------------


#' Axis scale for date/time data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the axis.
#' @param date_breaks One of:
#'   * A single `numeric` value giving the number of breaks.
#'   * A string giving the distance between breaks like "2 weeks", or "10 years".
#'   * A Date/POSIXct vector giving positions of breaks.
#' @param date_labels The format to be applied on Date/POSIXct in the labels, see [format_date_dayjs()].
#' @param date_labels_tooltip The format to be applied on Date/POSIXct in the tooltip, see [format_date_dayjs()].
#' @param min Minimum value on the axis.
#' @param max Maximum value on the axis.
#' @param ... Additional parameters for the axis.
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
                           date_labels_tooltip = date_labels,
                           min = NULL,
                           max = NULL,
                           ...,
                           position = "bottom") {
  v_scale_date(
    vc = vc,
    position = position,
    name = name,
    date_breaks = date_breaks,
    date_labels = date_labels,
    date_labels_tooltip = date_labels_tooltip,
    min = min,
    max = max,
    ...
  )
}

#' @export
#'
#' @rdname scale-date
v_scale_y_date <- function(vc,
                           name = NULL,
                           date_breaks = NULL,
                           date_labels = NULL,
                           date_labels_tooltip = date_labels,
                           min = NULL,
                           max = NULL,
                           ...,
                           position = "left") {
  v_scale_date(
    vc = vc,
    position = position,
    name = name,
    date_breaks = date_breaks,
    date_labels = date_labels,
    date_labels_tooltip = date_labels_tooltip,
    min = min,
    max = max,
    ...
  )
}


v_scale_date <- function(vc,
                         position,
                         name = NULL,
                         date_breaks = NULL,
                         date_labels = NULL,
                         date_labels_tooltip = date_labels,
                         min = NULL,
                         max = NULL,
                         ...) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )

  args <- list(...)

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

  if (is.null(date_labels))
    date_labels <- "YYYY-MM-DD"
  if (is.null(date_labels_tooltip))
    date_labels_tooltip <- "YYYY-MM-DD"

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

  tick <- if (length(dates_ticks) > 0) {
    list(
      visible = TRUE,
      tickStep = 1,
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(dates_ticks, collapse = ", ")
      ))
    )
  }

  label <- args$label %||% list()
  if (length(dates_ticks) > 0) {
    label$dataFilter <- JS(sprintf(
      "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
      paste(dates_ticks, collapse = ", ")
    ))
  }
  label$formatMethod <- label_format_date(date_labels)
  if (length(label) < 1)
    label <- NULL

  grid <- if (length(dates_ticks) > 0) {
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

  vc <- v_specs_axes(
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
    title = title,
    ...
  )
  v_specs_tooltip(
    vc = vc,
    dimension = list(
      title = list(
        value = label_format_date(date_labels_tooltip)
      ),
      content = list(
        key = tooltip_key_default(),
        value = JS("datum => datum.y")
      )
    )
  )
}





# Datetime ----------------------------------------------------------------

#' @param tz The timezone.
#'
#' @export
#'
#' @rdname scale-date
v_scale_x_datetime <- function(vc,
                               name = NULL,
                               date_breaks = NULL,
                               date_labels = NULL,
                               date_labels_tooltip = date_labels,
                               tz = NULL,
                               min = NULL,
                               max = NULL,
                               ...,
                               position = "bottom") {
  v_scale_datetime(
    vc = vc,
    position = position,
    name = name,
    date_breaks = date_breaks,
    date_labels = date_labels,
    date_labels_tooltip = date_labels_tooltip,
    tz = tz,
    min = min,
    max = max,
    ...
  )
}

#' @export
#'
#' @rdname scale-date
v_scale_y_datetime <- function(vc,
                               name = NULL,
                               date_breaks = NULL,
                               date_labels = NULL,
                               date_labels_tooltip = date_labels,
                               tz = NULL,
                               min = NULL,
                               max = NULL,
                               ...,
                               position = "left") {
  v_scale_datetime(
    vc = vc,
    position = position,
    name = name,
    date_breaks = date_breaks,
    date_labels = date_labels,
    date_labels_tooltip = date_labels_tooltip,
    tz = tz,
    min = min,
    max = max,
    ...
  )
}




v_scale_datetime <- function(vc,
                             position,
                             name = NULL,
                             date_breaks = NULL,
                             date_labels = NULL,
                             date_labels_tooltip = date_labels,
                             tz = NULL,
                             min = NULL,
                             max = NULL,
                             ...) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )

  args <- list(...)

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

  if (is.null(date_labels))
    date_labels <- "YYYY-MM-DD HH:mm"
  if (is.null(date_labels_tooltip))
    date_labels_tooltip <- "YYYY-MM-DD HH:mm"

  date_breaks_min <- if (!is.null(min)) {
    as.POSIXct(min, origin = "1970-01-01", tz = tz)
  } else {
    min(as.POSIXct(x, origin = "1970-01-01", tz = tz), na.rm = TRUE)
  }

  date_breaks_max <- if (!is.null(max)) {
    as.POSIXct(max, origin = "1970-01-01", tz = tz)
  } else {
    max(as.POSIXct(x, origin = "1970-01-01", tz = tz), na.rm = TRUE)
  }

  dates_ticks <- NULL
  if (is.numeric(date_breaks) & length(date_breaks) == 1) {
    dates_ticks <- round(as.numeric(seq(from = date_breaks_min, to = date_breaks_max, length.out = date_breaks)))
  } else if (is.character(date_breaks) & length(date_breaks) == 1) {
    dates_ticks <- as.numeric(seq(from = date_breaks_min, to = date_breaks_max, by = date_breaks))
  } else {
    if (is.character(date_breaks)) {
      dates_ticks <- as.numeric(as.POSIXct(dates_ticks, origin = "1970-01-01", tz = tz))
    } else {
      dates_ticks <- as.numeric(dates_ticks)
    }
  }

  tick <- if (length(dates_ticks) > 0) {
    list(
      visible = TRUE,
      tickStep = 1,
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(dates_ticks, collapse = ", ")
      ))
    )
  }

  label <- args$label %||% list()
  if (length(dates_ticks) > 0) {
    label$dataFilter <- JS(sprintf(
      "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
      paste(dates_ticks, collapse = ", ")
    ))
  }
  label$formatMethod <- label_format_datetime(date_labels, tz = tz)
  if (length(label) < 1)
    label <- NULL

  grid <- if (length(dates_ticks) > 0) {
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

  vc <- v_specs_axes(
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
    title = title,
    ...
  )
  v_specs_tooltip(
    vc = vc,
    dimension = list(
      title = list(
        value = label_format_datetime(date_labels_tooltip, tz = tz)
      ),
      content = list(
        key = tooltip_key_default(),
        value = JS("datum => datum.y")
      )
    )
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
#' @param labels,labels_tooltip The format to be applied on numeric in the labels/tooltip. Either:
#'   * A single character indicating the D3 format.
#'   * A `JS` function, such as [format_num_d3()].
#' @param zero Force axis to start at 0.
#' @param min Minimum value on the axis.
#' @param max Maximum value on the axis.
#' @param ... Additional parameters for the axis.
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
                                 labels_tooltip = labels,
                                 zero = FALSE,
                                 min = NULL,
                                 max = NULL,
                                 ...,
                                 position = "bottom") {
  if ("radar" %in% vc$x$type)
    position <- "angle"
  v_scale_continuous(
    vc = vc,
    position = position,
    name = name,
    breaks = breaks,
    pretty = pretty,
    labels = labels,
    labels_tooltip = labels_tooltip,
    min = min,
    max = max,
    ...
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
                                 labels_tooltip = labels,
                                 zero = FALSE,
                                 min = NULL,
                                 max = NULL,
                                 ...,
                                 position = "left") {
  if ("radar" %in% vc$x$type)
    position <- "radius"
  if ("gauge" %in% vc$x$type)
    position <- "gauge"
  v_scale_continuous(
    vc = vc,
    position = position,
    name = name,
    breaks = breaks,
    pretty = pretty,
    labels = labels,
    labels_tooltip = labels_tooltip,
    min = min,
    max = max,
    ...
  )
}

#' @importFrom rlang %||%
v_scale_continuous <- function(vc,
                               position,
                               name = NULL,
                               breaks = NULL,
                               pretty = TRUE,
                               labels = NULL,
                               labels_tooltip = labels,
                               zero = FALSE,
                               min = NULL,
                               max = NULL,
                               ...) {
  args <- list(...)
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )

  aesthetic <- switch(
    position,
    "bottom" = "x",
    "top" = "x",
    "right" = "y",
    "left" = "y",
    "radius" = "y",
    "angle" = "x",
    "gauge" = "y"
  )
  if (position == "gauge")
    position <- "angle"

  x <- get_aes_data(vc$x$mapdata, c(aesthetic, paste0(aesthetic, c("min", "max"))))

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

  tick <- if (length(breaks_ticks) > 0) {
    list(
      visible = TRUE,
      tickStep = 1,
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(breaks_ticks, collapse = ", ")
      ))
    )
  }

  label <- args$label %||% list()
  if (length(breaks_ticks) > 0) {
    label$dataFilter <- JS(sprintf(
      "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
      paste(breaks_ticks, collapse = ", ")
    ))
  }
  label$formatMethod <- label_format_num(labels, aesthetic)
  if (length(label) < 1)
    label <- NULL

  grid <- if (length(breaks_ticks) > 0) {
    c(
      list(
        style = JS(sprintf(
          "(value, index, datum) => {var values = [%s]; return {visible: values.includes(value)};}",
          paste(breaks_ticks, collapse = ", ")
        ))
      ),
      args$grid
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

  vc <- v_specs_axes(
    vc = vc,
    position = position,
    type = "linear",
    zero = zero,
    sampling = TRUE,
    softMin = if (!is.null(min)) as.numeric(min),
    softMax = if (!is.null(max)) as.numeric(max),
    tick = tick,
    label = label,
    grid = grid,
    title = title,
    ...
  )
  v_specs_tooltip(
    vc = vc,
    dimension = list(
      content = list_(
        key = tooltip_key_default(),
        value = label_format_num(labels_tooltip, aesthetic)
      )
    ),
    mark = list(
      content = list_(
        key = tooltip_key_default(),
        value = label_format_num(labels_tooltip, aesthetic)
      )
    )
  )
}




# Discrete ----------------------------------------------------------------


#' Axis scale for discrete data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the axis.
#' @param ... Additional parameters for the axis.
#' @param position Position of the axis.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name scale-discrete
#'
#' @example examples/scale_discrete.R
v_scale_x_discrete <- function(vc,
                               name = NULL,
                               ...,
                               position = "bottom") {
  if ("radar" %in% vc$x$type)
    position <- "angle"
  v_scale_discrete(
    vc = vc,
    position = position,
    name = name,
    ...
  )
}


#' @export
#'
#' @rdname scale-discrete
v_scale_y_discrete <- function(vc,
                               name = NULL,
                               ...,
                               position = "left") {
  if ("radar" %in% vc$x$type)
    position <- "radius"
  v_scale_discrete(
    vc = vc,
    position = position,
    name = name,
    ...
  )
}


v_scale_discrete <- function(vc,
                             position,
                             name = NULL,
                             ...) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )

  aesthetic <- switch(
    position,
    "bottom" = "x",
    "top" = "x",
    "right" = "y",
    "left" = "y",
    "radius" = "y",
    "angle" = "x"
  )

  if (!is.null(vc$x$mapdata[[aesthetic]])) {
    x <- vc$x$mapdata[[aesthetic]]
  } else {
    x <- unlist(lapply(vc$x$mapdata, `[[`, aesthetic))
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
    type = "band",
    title = title,
    ...
  )
}




# Color/fill manual -----------------------------------------------------------------


#' Manual color scale
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param values A named list with data values as name and color as values
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang is_list is_named
#'
#' @name scale-color-manual
#' @example examples/scale_color_manual.R
v_scale_color_manual <- function(vc, values) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  color <- vc$x$specs$color
  if (is_list(color) & !is_named(color))
    vc$x$specs$color <- list()
  specified <- vc$x$specs$color$specified %||% list()
  specified <- modifyList(specified, as.list(values))
  vc$x$specs$color$specified <- specified
  vc <- v_specs_legend(vc, visible = TRUE)
  return(vc)
}

#' @export
#'
#' @rdname scale-color-manual
v_scale_fill_manual <- v_scale_color_manual


#' Discrete color scale
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param palette A color vector or the name of an R palette.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang is_list is_named
#' @importFrom grDevices palette.colors palette.pals
#'
#' @name scale-color-manual
#' @example examples/scale_color_discrete.R
v_scale_color_discrete <- function(vc, palette) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  if (length(palette) == 1 &&palette %in% palette.pals())
    palette <- palette.colors(palette = palette)
  vc <- v_specs_colors(vc = vc, unname(palette))
  vc <- v_specs_legend(vc, visible = TRUE)
  return(vc)
}

#' @export
#'
#' @rdname scale-color-manual
v_scale_fill_discrete <- v_scale_color_discrete




# Color/fill gradient ---------------------------------------------------------------


#' Color scale for continuous data
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param name Title for the legend.
#' @param low,high Colours for low and high ends of the gradient.
#' @param limits Limits of the scale, default (`NULL`) is to use the default scale range of the data.
#' @param position Position of the legend.
#' @param align Alignment of the legend.
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
                                    limits = NULL,
                                    position = c("right", "bottom", "left", "top"),
                                    align = c("middle", "start", "end")) {
  v_scale_gradient(
    vc = vc,
    name = name,
    low = low,
    high = high,
    limits = limits,
    position = position,
    align = align,
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
                                  limits = NULL,
                                  position = c("right", "bottom", "left", "top"),
                                  align = c("middle", "start", "end")) {
  v_scale_gradient(
    vc = vc,
    name = name,
    low = low,
    high = high,
    limits = limits,
    position = position,
    align = align,
    aesthetic = "fill"
  )
}

v_scale_gradient <- function(vc,
                             name = NULL,
                             low = "#132B43",
                             high = "#56B1F7",
                             limits = NULL,
                             position = c("right", "bottom", "left", "top"),
                             align = c("middle", "start", "end"),
                             aesthetic) {
  position <- match.arg(position)
  align <- match.arg(align)
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

  vc <- v_specs(
    vc,
    color = list(
      type = "linear",
      domain = limits,
      range = c(low, high)
    )
  )
  vc <- .vchart_specs(
    vc, "legends",
    list(dropNulls(list(
      visible = TRUE,
      type = "color",
      field = aesthetic,
      title = title,
      # serieId = dataserie_id,
      orient = position,
      position = align
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
#' @param position Position of the legend.
#' @param align Alignment of the legend.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
# @examples
v_scale_size <- function(vc,
                         name = NULL,
                         range = c(5, 30),
                         position = c("right", "bottom", "left", "top"),
                         align = c("middle", "start", "end")) {
  position <- match.arg(position)
  align <- match.arg(align)
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
      field = "size",
      orient = position,
      position = align
    )))
  )
  return(vc)
}

