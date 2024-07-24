
#' Create a Bar Chart
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






#' Create a Line Chart
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
#' @name vline-varea
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
  vlinearea(
    type = "line",
    aesthetic = "colour",
    data = data,
    mapping = mapping,
    format_date = format_date,
    format_datetime = format_datetime,
    name = name,
    serie_id = serie_id,
    width = width,
    height = height,
    elementId = elementId
  )
}


#' @export
#'
#' @rdname vline-varea
varea <- function(data,
                  mapping,
                  format_date = "%Y-%m-%d",
                  format_datetime = "%Y-%m-%d %H:%M",
                  name = NULL,
                  serie_id = NULL,
                  width = NULL,
                  height = NULL,
                  elementId = NULL) {
  vlinearea(
    type = "area",
    aesthetic = "fill",
    data = data,
    mapping = mapping,
    format_date = format_date,
    format_datetime = format_datetime,
    name = name,
    serie_id = serie_id,
    width = width,
    height = height,
    elementId = elementId
  )
}

vlinearea <- function(type,
                      aesthetic,
                      data,
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
    serie_id <- paste0(type, "_", genId(4))
  axe_bottom_type <- switch(
    attr(mapdata, "x_class"),
    "character" = "band",
    "factor" = "band",
    "numeric" = "linear",
    "integer" = "linear",
    "POSIXct" = "time",
    "POSIXlt" = "time",
    "Date" = "time",
    "band"
  )
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
        type = type,
        name = name,
        id = serie_id,
        dataId = serie_id,
        xField = "x",
        yField = "y",
        seriesField = if (has_name(mapdata, aesthetic)) aesthetic,
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
        type = axe_bottom_type,
        nice = FALSE,
        layers = list(list(timeFormat = format_date))
      )
    ),
    tooltip = list_(
      dimension = list_(
        title = list_(
          valueTimeFormat = if (axe_bottom_type == "time") format_date
        ),
        content = list(
          list(
            key = JS(
              sprintf(
                "function(datum) {
                //console.log(datum);
                  let val = datum.y;
                  if (val === null) {
                    val = '-';
                  }
                  if (datum.hasOwnProperty('ymin')) {
                    val = datum.ymin + ' - ' + datum.ymax;
                  }
                  if (datum.hasOwnProperty('%1$s')) {
                    return datum.%1$s + ' : ' + val;
                  } else {
                   return datum.__VCHART_DEFAULT_DATA_SERIES_FIELD + ' : ' + val;
                  }
                }", aesthetic
              )
            )
          )
        )
      )
    )
  )
  if (has_name(mapdata, aesthetic)) {
    specs$legends$visible <- TRUE
  }
  vc <- create_chart(paste0("v", type), specs, width, height, elementId)
  vc$x$data <- data
  return(vc)
}



#' @param vc A chart created with [vline()].
#'
#' @export
#'
#' @rdname vline-varea
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
        id = serie_id,
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
#' @rdname vline-varea
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
        id = serie_id,
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
  create_chart("vhist", specs, width, height, elementId)
}






#' Create a Scatter Chart
#'
#' @inheritParams vchart
#' @inheritParams vbar
#' @param serie_id ID for the serie, can be used to customize the serie with [v_specs()]
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vscatter.R
vscatter <- function(data,
                     mapping,
                     serie_id = NULL,
                     width = NULL,
                     height = NULL,
                     elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, mapping, convert_date = FALSE)
  if (is.null(serie_id))
    serie_id <- paste0("scatter_", genId(4))
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
        type = "scatter",
        id = serie_id,
        dataId = serie_id,
        xField = "x",
        yField = "y",
        seriesField = if (has_name(mapdata, "colour")) "colour",
        sizeField = if (has_name(mapdata, "size")) "size",
        shapeField = if (has_name(mapdata, "shape")) "shape"
      )
    ),
    axes = list(
      list(
        orient = "left",
        type = "linear",
        domainLine = list(visible = TRUE),
        range = list(
          min = floor(min(mapdata$y, na.rm = TRUE)),
          max = ceiling(max(mapdata$y, na.rm = TRUE))
        )
      ),
      list(
        orient = "bottom",
        type = "linear",
        domainLine = list(visible = TRUE),
        range = list(
          min = floor(min(mapdata$x, na.rm = TRUE)),
          max = ceiling(max(mapdata$x, na.rm = TRUE))
        )
      )
    )
  )
  if (has_name(mapdata, "colour")) {
    specs$legends$visible <- TRUE
  }
  vc <- create_chart("vscatter", specs, width, height, elementId)
  vc$x$data <- data
  return(vc)
}





#' Create a Circle Packing Chart
#'
#' @inheritParams vchart
#' @inheritParams vbar
#' @param drill Drill-down function switch.
#' @param use_root Add a root level in the hierarchy, can be `TRUE`
#'  (in this case root level will be named `root`) or a `character` (use as the name for the root level).
#' @param fill_opacity Fill opacity, a JS function determining the opacity of the elements.
#' @param label_visible A JS function to control visibility of labels.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vcirclepacking.R
vcirclepacking <- function(data,
                           mapping,
                           drill = TRUE,
                           use_root = FALSE,
                           fill_opacity = JS("d => d.isLeaf ? 0.75 : 0.25;"),
                           label_visible = JS("d => d.depth === 1;"),
                           width = NULL,
                           height = NULL,
                           elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, mapping)
  lvl_vars <- grep(pattern = "lvl\\d*", x = names(mapdata), value = TRUE)
  lvl_vars <- sort(lvl_vars)
  if (length(lvl_vars) > 1) {
    values <- create_tree(
      data = mapdata,
      levels = lvl_vars,
      value = "value"
    )
  } else {
    names(mapdata)[names(mapdata) == lvl_vars] <- "name"
    values <- create_values(mapdata)
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
  specs <- list(
    type = "circlePacking",
    data = list(
      list(
        values = values
      )
    ),
    categoryField = "name",
    valueField = "value",
    drill = drill
  )
  if (!is.null(fill_opacity)) {
    specs$circlePacking$style$fillOpacity <- fill_opacity
  }
  if (!is.null(label_visible)) {
    specs$label$style$visible <- label_visible
  }
  create_chart("vcirclepacking", specs, width, height, elementId)
}



#' Create a Treemap Chart
#'
#' @inheritParams vcirclepacking
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vtreemap.R
vtreemap <- function(data,
                     mapping,
                     drill = TRUE,
                     width = NULL,
                     height = NULL,
                     elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, mapping)
  lvl_vars <- grep(pattern = "lvl\\d*", x = names(mapdata), value = TRUE)
  lvl_vars <- sort(lvl_vars)
  if (length(lvl_vars) > 1) {
    values <- create_tree(
      data = mapdata,
      levels = lvl_vars,
      value = "value"
    )
  } else {
    names(mapdata)[names(mapdata) == lvl_vars] <- "name"
    values <- create_values(mapdata)
  }
  specs <- list(
    type = "treemap",
    data = list(
      list(
        values = values
      )
    ),
    categoryField = "name",
    valueField = "value",
    drill = drill
  )
  create_chart("vtreemap", specs, width, height, elementId)
}




#' Create an Heatmap Chart
#'
#' @inheritParams vchart
#' @inheritParams vline-varea
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vheatmap.R
vheatmap <- function(data,
                     mapping,
                     serie_id = NULL,
                     width = NULL,
                     height = NULL,
                     elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, mapping)
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
      field = "fill"
    )
  } else if (is.character(mapdata$fill)) {
    color <- list(
      type = "ordinal"
    )
    legend <- list(
      visible = TRUE,
      type = "discrete",
      field = "fill",
      scaleName = "color"
    )
  } else {
    stop(
      "vheatmap: `fill` aesthetic is required, and must either a numeric or a character",
      call. = FALSE
    )
  }
  if (is.null(serie_id))
  serie_id <- paste0("heatmap_", genId(4))
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
        type = "heatmap",
        id = serie_id,
        dataId = serie_id,
        xField = "x",
        yField = "y",
        valueField = "fill",
        cell = list(
          style = list(
            fill = list(field = "fill", scale = "color")
          )
        )
      )
    ),
    axes = list(
      list(
        orient = "bottom",
        type = "band",
        grid = list(visible = FALSE),
        domainLine = list(visible = FALSE)
      ),
      list(
        orient = "left",
        type = "band",
        grid = list(visible = FALSE),
        domainLine = list(visible = FALSE)
      )
    ),
    color = color,
    legends = legend
  )
  create_chart("vheatmap", specs, width, height, elementId)
}




#' Create a Pie Chart
#'
#' @inheritParams vchart
#' @inheritParams vline-varea
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vpie.R
vpie <- function(data,
                 mapping,
                 serie_id = NULL,
                 width = NULL,
                 height = NULL,
                 elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, mapping)
  if (is.null(serie_id))
    serie_id <- paste0("pie_", genId(4))
  if (has_name(mapdata, "group")) {
    groups <- unique(mapdata$group)
    data <- lapply(
      X = groups,
      FUN = function(group) {
        index <- mapdata$group == group
        list(
          id = paste(serie_id, group, sep = "_"),
          values = create_values(lapply(mapdata, `[`, index))
        )
      }
    )
    series <- lapply(
      X = groups,
      FUN = function(group) {
        list(
          type = "pie",
          id = serie_id,
          dataId = paste(serie_id, group, sep = "_"),
          categoryField = "x",
          valueField = "y",
          label = list(
            visible = TRUE
          )
        )
      }
    )
  } else {
    data <- list(
      list(
        id = serie_id,
        values = create_values(mapdata)
      )
    )
    series <- list(
      list(
        type = "pie",
        id = serie_id,
        dataId = serie_id,
        categoryField = "x",
        valueField = "y",
        label = list(
          visible = TRUE
        )
      )
    )
  }
  specs <- list(
    type = "common",
    data = data,
    series = series
  )
  create_chart("vpie", specs, width, height, elementId)
}



#' Create a Wordcloud
#'
#' @inheritParams vbar
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/vwordcloud.R
vwordcloud <- function(data,
                       mapping,
                       width = NULL,
                       height = NULL,
                       elementId = NULL) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, mapping)
  specs <- list(
    type = "wordCloud",
    data = list(values = create_values(mapdata)),
    nameField = "word",
    valueField = "count",
    seriesField = if (has_name(mapdata, "colour")) "colour"
  )
  create_chart("vwordcloud", specs, width, height, elementId)
}


