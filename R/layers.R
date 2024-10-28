
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
#' @param data_id,serie_id ID for the data/serie, can be used to further customize the chart with [v_specs()].
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
                  serie_id = NULL,
                  data_id = NULL) {
  direction <- match.arg(direction)
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "bar")
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(list(id = data_id, values = filter_values(mapdata)))
  )
  serie <- list_(
    type = "bar",
    id = serie_id,
    dataId = data_id,
    name = name,
    seriesField = if (has_name(mapping, "fill")) "fill",
    stack = stack,
    percent = percent,
    direction = direction,
    ...
  )
  if (direction == "horizontal") {
    serie$xField <- "y"
    serie$yField <- "x"
    if (has_name(mapping, "group"))
      serie$yField <- c("group", serie$yField)
    if (has_name(mapping, "fill") & isFALSE(stack))
      serie$yField <- c(serie$yField, "fill")
    if (is.null(name) & !is.null(mapping$x))
      serie$name <- rlang::as_label(mapping$x)
    vc <- v_specs_axes(vc, position = "bottom", type = "linear")
    vc <- v_specs_axes(vc, position = "left", type = "band")
  } else {
    serie$xField <- "x"
    if (has_name(mapping, "group"))
      serie$xField <- c("group", serie$xField)
    if (has_name(mapping, "fill") & isFALSE(stack))
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
  if (has_name(mapping, "fill")) {
    vc <- v_scale_fill_discrete(vc, palette.colors(palette = "Okabe-Ito")[-1])
  }
  if (has_player(mapdata)) {
    vc <- v_default_player(vc, mapdata, data_id)
  }
  if (has_select(mapdata)) {
    vc <- v_default_select(vc, mapdata, data_id)
  }
  return(vc)
}




#' Create a Line Chart
#'
#' @inheritParams v_bar
#' @param line Line's options, such as curve interpolation type,
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
                   line = list(
                     style = list(
                       curveType = "linear",
                       lineDash = 0,
                       stroke = NULL
                     )
                   ),
                   point = list(visible = FALSE),
                   ...,
                   serie_id = NULL,      
                   data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "line")
  if (is.null(name)) {
    if (!is.null(mapping$y)) {
      name <- rlang::as_label(mapping$y)
    }
  }
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(list(id = data_id, values = filter_values(mapdata)))
  )
  serie <- list_(
    type = "line",
    name = name,
    id = serie_id,
    dataId = data_id,
    xField = "x",
    yField = "y",
    seriesField = if (has_name(mapping, "colour")) "colour",
    point = point,
    line = line,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  scale_x <- attr(mapdata, "scale_x")
  if (identical(scale_x, "discrete")) {
    vc <- v_scale_x_discrete(vc)
  } else if (identical(scale_x, "date")) {
    vc <- v_scale_x_date(vc)
  } else {
    vc <- v_scale_x_continuous(vc)
  }
  if (has_name(mapping, "colour")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  vc <- v_scale_y_continuous(vc)
  if (has_select(mapdata)) {
    vc <- v_default_select(vc, mapdata, data_id)
  }
  return(vc)
}



#' Create an Smooth Line Chart
#'
#' @inheritParams v_bar
#' @inheritParams ggplot2::stat_smooth
#' @param ... Additional parameters for lines.
#' @param args_area Arguments for area.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang sym exec
#' @importFrom ggplot2 ggplot geom_smooth scale_color_identity layer_data
#'
#' @example examples/v_smooth.R
v_smooth <- function(vc,
                     mapping = NULL,
                     data = NULL,
                     name = NULL,
                     method = NULL,
                     formula = NULL,
                     se = TRUE,
                     n = 80,
                     span = 0.75,
                     ...,
                     args_area = NULL,
                     serie_id = NULL,        
                     data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  p <- ggplot(data = data, mapping = mapping) +
    geom_smooth(
      method = method,
      formula = formula,
      se = se,
      n = n,
      span = span
    ) +
    scale_color_identity()
  mapdata <- layer_data(p, i = 1L)
  vc$x$type <- c(vc$x$type, "smooth")
  vc$x$mapping <- NULL
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  if (isTRUE(se)) {
    mapping_area <- aes(x = !!sym("x"), ymin = !!sym("ymin"), ymax = !!sym("ymax"))
    if (has_name(mapping, "colour"))
      mapping_area <- c(mapping_area, aes(fill = !!sym("colour")))
    args_area <- args_area %||% list()
    args_area$vc <- vc
    args_area$mapping <- mapping_area
    args_area$data <- mapdata
    if (is.null(args_area$area$style$fill) & is.null(mapping$fill))
      args_area$area$style$fill <- "grey60"
    if (is.null(args_area$area$style$fillOpacity))
      args_area$area$style$fillOpacity <- 0.3
    vc <- rlang::exec(v_area, !!!args_area)
  }
  args_line <- list(...)
  args_line$vc <- vc
  mapping_line <- aes(x = !!sym("x"), y = !!sym("y"))
  if (has_name(mapping, "colour"))
    mapping_line <- c(mapping_line, aes(colour = !!sym("colour")))
  args_line$mapping <- mapping_line
  args_line$data <- mapdata
  args_line$data_id <- data_id
  args_line$serie_id <- serie_id
  if (is.null(args_line$line$style$curveType))
    args_line$line$style$curveType <- "monotone"
  vc <- rlang::exec(v_line, !!!args_line)
  return(vc)
}




#' Create an Area Chart
#'
#' @inheritParams v_line
#' @param stack Whether to stack the data or not (if `fill` aesthetic is provided).
#' @param area Area's options, such as curve interpolation type, see [online documentation](https://www.visactor.io/vchart/option/AreaChart#area.style.curveType).
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
                   area = list(
                     style = list(
                       curveType = "linear",
                       fill = NULL,
                       fillOpacity = NULL
                     )
                   ),
                   point = list(visible = FALSE),
                   line = list(visible = FALSE),
                   ...,
                   serie_id = NULL,         
                   data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "area")
  if (is.null(name)) {
    if (!is.null(mapping$y)) {
      name <- rlang::as_label(mapping$y)
    }
    if (!is.null(mapping$ymin) & !is.null(mapping$ymax)) {
      name <- paste(rlang::as_label(mapping$ymin), rlang::as_label(mapping$ymax), sep = "/")
    }
  }
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  if (has_name(mapping, "y")) {
    type <- "area"
    yField <- "y"
  } else if (all(has_name(mapping, c("ymin", "ymax")))) {
    type <- "rangeArea"
    yField <- c("ymin", "ymax")
  } else {
    stop("v_area() must have aesthetic `y` or `ymin`/`ymax`", call. = FALSE)
  }
  serie <- list_(
    type = type,
    name = name,
    id = serie_id,
    dataId = data_id,
    xField = "x",
    yField = yField,
    seriesField = if (has_name(mapping, "fill")) "fill",
    stack = isTRUE(stack),
    point = point,
    line = line,
    area = area,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  scale_x <- attr(mapdata, "scale_x")
  if (identical(scale_x, "discrete")) {
    vc <- v_scale_x_discrete(vc)
  } else if (identical(scale_x, "date")) {
    vc <- v_scale_x_date(vc)
  } else {
    vc <- v_scale_x_continuous(vc)
  }
  if (has_name(mapping, "fill")) {
    vc <- v_scale_fill_discrete(vc, palette.colors(palette = "Okabe-Ito")[-1])
  }
  vc <- v_scale_y_continuous(vc)
  return(vc)
}



#' Create an Histogram
#'
#' @inheritParams v_bar
#' @inheritParams ggplot2::stat_bin
#' @param ... Additional properties for histogram bars.
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
                   ...,
                   serie_id = NULL,         
                   data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  p <- ggplot2::ggplot(data = data, mapping = mapping)
  p <- p + ggplot2::geom_histogram(bins = bins, binwidth = binwidth) +
    ggplot2::scale_fill_identity()
  mapdata <- ggplot2::layer_data(p, i = 1L)
  vc$x$type <- c(vc$x$type, "hist")
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- v_specs(
    vc = vc,
    data = list(
      list(
        id = data_id,
        values = mapdata
      )
    ),
    type = "histogram",
    id = serie_id,
    dataId = data_id,
    name = name,
    xField = "xmin",
    x2Field = "xmax",
    yField = "count",
    seriesField = if (has_name(mapping, "fill")) "fill",
    stack = stack,
    ...
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
    vc <- v_scale_fill_discrete(vc, palette.colors(palette = "Okabe-Ito")[-1])
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
                      serie_id = NULL,      
                      data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
  vc$x$type <- c(vc$x$type, "scatter")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(list(id = data_id, values = filter_values(mapdata)))
  )
  shapeField <- NULL
  if (has_name(mapping, "shape"))
    shapeField <- "shape"
  if (identical(mapping$colour, mapping$shape))
    shapeField <- "colour"
  shape <- if (!is.null(shapeField))
    list(type = "ordinal")
  serie <- list_(
    type = "scatter",
    id = serie_id,
    dataId = data_id,
    xField = "x",
    yField = "y",
    seriesField = if (has_name(mapping, "colour")) "colour",
    sizeField = if (has_name(mapping, "size")) "size",
    shapeField = shapeField,
    shape = shape,
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
    vc <- v_scale_color_discrete(vc, palette.colors(palette = "Okabe-Ito")[-1])
  }
  scale_size <- attr(mapdata, "scale_size")
  if (identical(scale_size, "continuous")) {
    vc <- v_scale_size(vc)
  }
  if (has_player(mapdata)) {
    vc <- v_default_player(vc, mapdata, data_id)
  }
  return(vc)
}


#' Create Jittered Points Scatter Chart
#'
#' @inheritParams v_scatter
#' @inheritParams ggplot2::geom_jitter
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang syms set_names
#' @importFrom ggplot2 ggplot geom_jitter scale_color_identity layer_data layer_scales
#'
#' @example examples/v_jitter.R
v_jitter <- function(vc,
                     mapping = NULL,
                     data = NULL,
                     name = NULL,
                     width = NULL,
                     height = NULL,
                     ...,
                     serie_id = NULL,      
                     data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  p <- ggplot(data = data, mapping = mapping) +
    geom_jitter(width = width, height = height) +
    scale_color_identity()
  ldata <- layer_data(p, i = 1L)
  lscales <- layer_scales(p)
  vc <- v_scatter(
    vc = vc,
    mapping = aes(!!!syms(set_names(names(mapping), names(mapping)))),
    data = ldata,
    name = name,
    ...,
    data_id = data_id,
    serie_id = serie_id
  )
  if (identical(attr(mapdata, "scale_x"), "discrete")) {
    vc <- v_scale_x_continuous(
      vc,
      zero = FALSE,
      softMin = 0,
      softMax = max(ldata$group) + 1,
      breaks = ldata$group,
      labels = JS(
        "function(value) {",
        sprintf("var labels = ['%s'];", paste(lscales$x$get_limits(), collapse = "', '")),
        "return labels[value - 1];",
        "}"
      )
    )
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
                  serie_id = NULL,            
                  data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
  vc$x$type <- c(vc$x$type, "pie")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(list(id = data_id, values = filter_values(mapdata)))
  )
  serie <- list_(
    type = "pie",
    id = serie_id,
    dataId = data_id,
    seriesField = "x",
    valueField = "y",
    label = label,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  if (has_player(mapdata)) {
    vc <- v_default_player(vc, mapdata, data_id)
  }
  return(vc)
}




#' Create a Radar Chart
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_radar.R
v_radar <- function(vc,
                    mapping = NULL,
                    data = NULL,
                    name = NULL,
                    ...,
                    serie_id = NULL,       
                    data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
  vc$x$type <- c(vc$x$type, "radar")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  serie <- list_(
    type = "radar",
    id = serie_id,
    dataId = data_id,
    categoryField = "x",
    valueField = "y",
    seriesField = if (has_name(mapping, "colour")) "colour",
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  vc <- v_specs_axes(vc, position = "angle")
  vc <- v_specs_axes(vc, position = "radius")
  if (has_name(mapping, "colour")) {
    vc <- v_specs_legend(vc, visible = TRUE)
  }
  return(vc)
}




#' Create a Circle Packing Chart
#'
#' @inheritParams v_bar
#' @param drill Drill-down function switch.
#' @param use_root Add a root level in the hierarchy, can be `TRUE`
#'  (in this case root level will be named `root`) or a `character` (use as the name for the root level).
#' @param fill_opacity Fill opacity, a JS function determining the opacity of the elements.
#' @param label_visible A JS function to control visibility of labels.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_circlepacking.R
v_circlepacking <- function(vc,
                            mapping = NULL,
                            data = NULL,
                            name = NULL,
                            drill = TRUE,
                            use_root = FALSE,
                            fill_opacity = JS("d => d.isLeaf ? 0.75 : 0.25;"),
                            label_visible = JS("d => d.depth === 1;"),
                            ...,
                            serie_id = NULL,   
                            data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "circlepacking")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  lvl_vars <- grep(pattern = "lvl\\d*", x = names(mapping), value = TRUE)
  lvl_vars <- sort(lvl_vars)
  if (length(lvl_vars) > 1) {
    values <- create_tree(
      data = mapdata,
      levels = lvl_vars,
      value = "value"
    )
  } else {
    values <- create_values(mapdata, .names = list(name = "x", value = "y"))
  }
  if (isTRUE(use_root) | is.character(use_root)) {
    if (isTRUE(use_root))
      use_root <- "root"
    values <- list(
      list(
        name = use_root,
        children = values
      )
    )
  }
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = values
      )
    )
  )
  serie <- list_(
    type = "circlePacking",
    id = serie_id,
    dataId = data_id,
    name = name,
    categoryField = "name",
    valueField = "value",
    drill = drill,
    ...
  )
  if (!is.null(fill_opacity)) {
    serie$circlePacking$style$fillOpacity <- fill_opacity
  }
  if (!is.null(label_visible)) {
    serie$label$style$visible <- label_visible
  }
  vc <- .vchart_specs(vc, "series", list(serie))
  if (has_player(mapdata)) {
    if (length(lvl_vars) > 1) {
      vc <- v_default_player(
        vc,
        mapdata,
        data_id,
        levels = lvl_vars,
        value = "value"
      )
    } else {
      vc <- v_default_player(
        vc, 
        mapdata,
        data_id,
        fun_values = create_values,
        .names = list(name = "x", value = "y")
      )
    }
  }
  return(vc)
}






#' Create a Treemap Chart
#'
#' @inheritParams v_bar
#' @param drill Drill-down function switch.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_treemap.R
v_treemap <- function(vc,
                      mapping = NULL,
                      data = NULL,
                      name = NULL,
                      drill = TRUE,
                      ...,
                      serie_id = NULL,      
                      data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "treemap")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  lvl_vars <- grep(pattern = "lvl\\d*", x = names(mapping), value = TRUE)
  lvl_vars <- sort(lvl_vars)
  if (length(lvl_vars) > 1) {
    values <- create_tree(
      data = mapdata,
      levels = lvl_vars,
      value = "value"
    )
  } else {
    values <- create_values(mapdata, .names = list(name = "x", value = "y"))
  }
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = values
      )
    )
  )
  serie <- list_(
    type = "treemap",
    id = serie_id,
    dataId = data_id,
    name = name,
    categoryField = "name",
    valueField = "value",
    drill = drill,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  if (has_player(mapdata)) {
    if (length(lvl_vars) > 1) {
      vc <- v_default_player(
        vc, mapdata, data_id,
        levels = lvl_vars,
        value = "value"
      )
    } else {
      vc <- v_default_player(
        vc, mapdata, data_id,
        fun_values = create_values,
        .names = list(name = "x", value = "y")
      )
    }
  }
  return(vc)
}





#' Create a Heatmap Chart
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_heatmap.R
v_heatmap <- function(vc,
                      mapping = NULL,
                      data = NULL,
                      name = NULL,
                      ...,
                      serie_id = NULL,     
                      data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "heatmap")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  if (is.numeric(mapdata$fill)) {
    color <- list(
      type = "linear",
      domain = range(pretty(range(mapdata$fill, na.rm = TRUE))),
      range = c(
        "#440154", "#482878", "#3E4A89", "#31688E", "#26828E",
        "#1F9E89", "#35B779", "#6DCD59", "#B4DE2C", "#FDE725"
      )
    )
    legend <- list(
      visible = TRUE,
      type = "color",
      field = "fill",
      seriesId = serie_id
    )
  } else if (is.character(mapdata$fill)) {
    color <- list(
      type = "ordinal"
    )
    legend <- list(
      visible = TRUE,
      type = "discrete",
      field = "fill",
      scale = "color",
      seriesId = serie_id
    )
  } else {
    stop(
      "vheatmap: `fill` aesthetic is required, and must either be a numeric or a character",
      call. = FALSE
    )
  }
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  serie <- list_(
    type = "heatmap",
    id = serie_id,
    dataId = data_id,
    name = name,
    xField = "x",
    yField = "y",
    valueField = "fill",
    cell = list(
      style = list(
        fill = list(field = "fill", scale = "color")
      )
    ),
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  vc <- .vchart_specs(vc, "color", color)
  vc <- .vchart_specs(vc, "legends", legend)
  vc <- v_specs_axes(
    vc,
    position = "left",
    type = "band",
    grid = list(visible = FALSE),
    domainLine = list(visible = FALSE)
  )
  vc <- v_specs_axes(
    vc,
    position = "bottom",
    type = "band",
    grid = list(visible = FALSE),
    domainLine = list(visible = FALSE)
  )
  return(vc)
}



#' Create a Wordcloud
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_wordcloud.R
#' @examples
#' \donttest{
#' 
#' # Use an image to shape the wordcloud
#' vchart(top_cran_downloads) %>%
#'   v_wordcloud(
#'     aes(word = package, count = count, color = package),
#'     maskShape = "https://jeroen.github.io/images/Rlogo.png"
#'   )
#'   
#' }
v_wordcloud <- function(vc,
                        mapping = NULL,
                        data = NULL,
                        name = NULL,
                        ...,
                        serie_id = NULL,     
                        data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, rename_aes_lvl(mapping))
  vc$x$type <- c(vc$x$type, "wordcloud")
  if (is.null(name) & !is.null(mapping$word))
    name <- rlang::as_label(mapping$word)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  serie <- list_(
    type = "wordCloud",
    id = serie_id,
    dataId = data_id,
    name = name,
    nameField = "word",
    valueField = "count",
    seriesField = if (has_name(mapping, "colour")) "colour",
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  return(vc)
}






#' Create a Sankey Chart
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_sankey.R
v_sankey <- function(vc,
                     mapping = NULL,
                     data = NULL,
                     name = NULL,
                     ...,
                     serie_id = NULL,      
                     data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  vc$x$type <- c(vc$x$type, "sankey")
  if (is.null(name) & !is.null(mapping$x))
    name <- rlang::as_label(mapping$word)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  specs <- list(
    type = "sankey",
    label = list(
      visible = TRUE,
      style = list(fontSize = 10)
    ),
    ...
  )
  mapdata <- NULL
  if (!is.null(data) & length(mapping) > 0) {
    if (has_name(mapping, "lvl1") & has_name(mapping, "value")) {
      mapdata <- eval_mapping(data, mapping)
      lvl_vars <- grep(pattern = "lvl\\d*", x = names(mapdata), value = TRUE)
      lvl_vars <- sort(lvl_vars)
      specs$data <- list(
        list(
          name = name,
          id = data_id,
          values = list(
            list(
              nodes = create_tree(as.data.frame(mapdata), lvl_vars, value = "value")
            )
          )
        )
      )
      specs$categoryField <- "name"
      specs$valueField <- "value"
      specs$nodeKey <- JS("datum => datum.name")
    } else {
      sankey_dat <- make_sankey_data(data, mapping)
      specs$data <- list(
        list(
          name = name,
          id = data_id,
          values = list(
            list(
              nodes = sankey_dat$nodes,
              links = sankey_dat$links
            )
          )
        )
      )
      specs$categoryField <- "nodes"
      specs$valueField <- "value"
      specs$sourceField <- "source"
      specs$targetField <- "target"
    }
  } else if (is.list(data) & !is.null(data$nodes) & !is.null(data$links)) {
    specs$data <- list(
      list(
        id = data_id,
        values = list(
          list(
            nodes = data$nodes,
            links = data$links
          )
        )
      )
    )
    specs$categoryField <- names(data$nodes)[1]
    specs$valueField <- names(data$links)[3]
    specs$sourceField <- names(data$links)[1]
    specs$targetField <- names(data$links)[2]
  }
  vc$x$specs <- dropNulls(specs)
  return(vc)
}





#' Create a Gauge Chart
#'
#' @inheritParams v_bar
#' @param outerRadius Sector outer radius, with a numerical range of 0 - 1.
#' @param innerRadius Sector inner radius, with a numerical range of 0 - 1.
#' @param startAngle Starting angle of the sector. In degrees.
#' @param endAngle Ending angle of the sector. In degrees.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_gauge.R
v_gauge <- function(vc,
                    mapping = NULL,
                    data = NULL,
                    name = NULL,
                    outerRadius = 0.8,
                    innerRadius = 0.75,
                    startAngle = -240,
                    endAngle = 60,
                    ...,
                    serie_id = NULL,        
                    data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
  vc$x$type <- "gauge"
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc$x$specs$type <- "gauge"
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  vc <- v_specs(
    vc,
    radiusField = "x",
    valueField = "y",
    outerRadius = outerRadius,
    innerRadius = innerRadius,
    startAngle = startAngle,
    endAngle = endAngle,
    ...
  )
  return(vc)
}






#' Create a Progress Chart
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_progress.R
v_progress <- function(vc,
                       mapping = NULL,
                       data = NULL,
                       name = NULL,
                       ...,
                       serie_id = NULL,     
                       data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  if (is.null(mapping$y)) {
    if (!is.null(name)) {
      mapping <- c(mapping, aes(y = !!name))
    } else {
      mapping <- c(mapping, aes(y = "Progress"))
    }
  }
  mapdata <- eval_mapping_(data, mapping, na_rm = TRUE)
  vc$x$type <- c(vc$x$type, "progress")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  vc <- v_specs(
    vc,
    type = "linearProgress",
    id = serie_id,
    dataId = data_id,
    xField = "x",
    yField = "y",
    seriesField = "y",
    direction = "horizontal",
    ...
  )
  return(vc)
}







#' Create a BoxPlot
#'
#' @inheritParams v_scatter
#' @param ... Arguments passed to [JavaScript methods](https://www.visactor.io/vchart/option/boxPlotChart).
#' @param outliers Display or not outliers.
#' @param args_outliers Arguments passed to [v_scatter()].
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang exec set_names
#' @importFrom ggplot2 ggplot geom_boxplot scale_color_identity layer_data layer_scales
#'
#' @example examples/v_boxplot.R
v_boxplot <- function(vc,
                      mapping = NULL,
                      data = NULL,
                      name = NULL,
                      ...,
                      outliers = TRUE,
                      args_outliers = NULL,
                      serie_id = NULL,     
                      data_id = NULL) {
  args <- list(...)
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  p <- ggplot(data = data, mapping = mapping) +
    geom_boxplot() +
    scale_color_identity()
  mapdata <- layer_data(p, i = 1L)
  if (isTRUE(outliers)) {
    outliers <- data.frame(
      x = rep(mapdata$x, lengths(mapdata$outliers)),
      y = unlist(mapdata$outliers),
      colour = rep(mapdata$colour, lengths(mapdata$outliers))
    )
    mapping_outliers <- aes(!!sym("x"), !!sym("y"))
    if (has_name(mapping, "colour"))
      mapping_outliers <- c(mapping_outliers, aes(colour = !!sym("colour")))
    args_outliers <- args_outliers %||% list()
    args_outliers$vc <- vc
    args_outliers$mapping <- mapping_outliers
    args_outliers$data <- outliers
    vc <- rlang::exec(v_scatter, !!!args_outliers)
  }
  mapdata <- dropColumns(mapdata)
  vc$x$type <- c(vc$x$type, "boxplot")
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  boxPlot <- args$boxPlot %||% list()
  # boxPlot$style$boxWidth <- boxPlot$style$boxWidth %||%
  #   JS(sprintf("(datum, ctx) => { console.log(ctx); return ctx.getRegion().getLayoutRect().width / %s; }", max(c(6, nrow(mapdata) * 2))))
  boxPlot$style$boxWidth <- boxPlot$style$boxWidth %||%
    JS(sprintf("(datum, ctx) => { return ctx.valueToX(%s); }", mapdata$xmax[1] - mapdata$xmin[1]))
  boxPlot$style$shaftWidth <- boxPlot$style$shaftWidth %||% 30
  boxPlot$style$shaftShape <- boxPlot$style$shaftShape %||% "line"
  boxPlot$style$lineWidth <- boxPlot$style$lineWidth %||% 1
  serie <- list_(
    name = name,
    id = serie_id,
    dataId = data_id,
    type = "boxPlot",
    xField = "x",
    minField = "ymin",
    q1Field = "lower",
    medianField = "middle",
    q3Field = "upper",
    maxField = "ymax",
    seriesField = if (has_name(mapping, "colour")) "colour",
    direction = "vertical",
    boxPlot = boxPlot,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  pscales <- layer_scales(p)
  vc <- v_scale_x_continuous(
    vc,
    zero = FALSE,
    softMin = 0,
    softMax = max(mapdata$x) + 1,
    tick = list(
      visible = TRUE,
      tickStep = 1,
      dataFilter = JS(sprintf(
        "axisData => axisData.filter((x) => {var values = [%s]; return values.includes(x.rawValue);})",
        paste(mapdata$x, collapse = ", ")
      ))
    ),
    labels = JS(
      "function(value) {",
      sprintf("var labels = ['%s'];", paste(pscales$x$get_limits(), collapse = "', '")),
      "return labels[value - 1];",
      "}"
    )
  )
  vc <- v_scale_y_continuous(
    vc,
    zero = FALSE,
    range = set_names(as.list(pscales$y$get_limits()), c("min", "max"))
  )
  return(vc)
}




#' Create a Venn Diagram
#'
#' @inheritParams v_bar
#' @param sets_sep Sets separator.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#' 
#' @importFrom stats aggregate
#'
#' @example examples/v_venn.R
v_venn <- function(vc,
                   mapping = NULL,
                   data = NULL,
                   name = NULL,
                   sets_sep = ",",
                   ...,
                   serie_id = NULL,     
                   data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "venn")
  
  if (has_name(mapping, "category") & has_name(mapping, "values")) {
    venndata <- as.data.frame(table(mapdata), responseName = "n")
    venndata <- venndata[venndata$n > 0, ]
    sets1 <- aggregate(n ~ category, data = venndata, sum)
    names(sets1) <- c("sets", "value")
    sets1$length <- 1
    venndata <- data.frame(
      sets = unname(tapply(venndata$category, venndata$values, paste, collapse = sets_sep)),
      length = unname(tapply(venndata$category, venndata$values, length)),
      value = unname(tapply(venndata$n, venndata$values, sum))
    )
    venndata <- aggregate(value ~ sets + length, data = venndata, sum)
    venndata <- rbind(sets1, venndata[venndata$length > 1, ])
  } else if (has_name(mapping, "sets") & has_name(mapping, "value")) {
    venndata <- mapdata
  }
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      id = data_id,
      values = lapply(
        X = seq_len(nrow(venndata)),
        FUN = function(i) {
          values <- lapply(venndata, `[`, i)
          sets <- as.character(values$sets)
          values$sets <- list1(unlist(strsplit(sets, split = sets_sep)))
          return(values)
        }
      )
    )
  )
  # vc <- v_specs(
  #   vc = vc,
  #   type = "venn",
  #   # id = serie_id,
  #   # dataId = data_id,
  #   # name = name,
  #   categoryField = "sets",
  #   valueField = "value",
  #   # seriesField = if (has_name(mapping, "colour")) "colour",
  #   seriesField = "sets",
  #   ...,
  #   drop_nulls = TRUE
  # )
  serie <- list_(
    type = "venn",
    id = serie_id,
    dataId = data_id,
    name = name,
    categoryField = "sets",
    valueField = "value",
    seriesField = if (has_name(mapping, "colour")) "colour",
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  return(vc)
}




#' Create a Waterfall Chart
#'
#' @inheritParams v_bar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#' 
#'
#' @example examples/v_waterfall.R
v_waterfall <- function(vc,
                   mapping = NULL,
                   data = NULL,
                   name = NULL,
                   ...,
                   serie_id = NULL,     
                   data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "waterfall")
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = mapdata
      )
    )
  )
  serie <- list_(
    type = "waterfall",
    id = serie_id,
    dataId = data_id,
    name = name,
    xField = "x",
    yField = "y",
    total = list(
      type = "field",
      tagField = "total",
      valueField = "y"
    ),
    seriesField = if (has_name(mapping, "colour")) "colour",
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  scale_x <- attr(mapdata, "scale_x")
  if (identical(scale_x, "discrete")) {
    vc <- v_scale_x_discrete(vc)
  } else if (identical(scale_x, "date")) {
    vc <- v_scale_x_date(vc)
  } else if (identical(scale_x, "continuous")) {
    vc <- v_scale_x_continuous(vc)
  }
  vc <- v_scale_y_continuous(vc, zero = TRUE)
  return(vc)
}







#' Create a Sunburst Chart
#'
#' @inheritParams v_bar
#' @param drill Drill-down function switch.
#' @param gap Layer gap, supports passing an array to configure layer gaps layer by layer.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/v_sunburst.R
v_sunburst <- function(vc,
                       mapping = NULL,
                       data = NULL,
                       name = NULL,
                       drill = TRUE,
                       gap = 5,
                       ...,
                       serie_id = NULL,   
                       data_id = NULL) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  data <- get_data(vc, data)
  mapping <- get_mapping(vc, mapping)
  mapdata <- eval_mapping_(data, mapping)
  vc$x$type <- c(vc$x$type, "sunburst")
  if (is.null(name) & !is.null(mapping$y))
    name <- rlang::as_label(mapping$y)
  serie_id <- serie_id %||% genSerieId()
  data_id <- data_id %||% genDataId()
  lvl_vars <- grep(pattern = "lvl\\d*", x = names(mapping), value = TRUE)
  lvl_vars <- sort(lvl_vars)
  if (length(lvl_vars) > 1) {
    values <- create_tree(
      data = mapdata,
      levels = lvl_vars,
      value = "value"
    )
  } else {
    values <- create_values(mapdata, .names = list(name = "x", value = "y"))
  }
  vc <- .vchart_specs(
    vc, "data",
    list(
      list(
        id = data_id,
        values = values
      )
    )
  )
  serie <- list_(
    type = "sunburst",
    id = serie_id,
    dataId = data_id,
    name = name,
    categoryField = "name",
    valueField = "value",
    drill = drill,
    gap = gap,
    ...
  )
  vc <- .vchart_specs(vc, "series", list(serie))
  if (has_player(mapdata)) {
    if (length(lvl_vars) > 1) {
      vc <- v_default_player(
        vc,
        mapdata,
        data_id,
        levels = lvl_vars,
        value = "value"
      )
    } else {
      vc <- v_default_player(
        vc, 
        mapdata,
        data_id,
        fun_values = create_values,
        .names = list(name = "x", value = "y")
      )
    }
  }
  return(vc)
}


