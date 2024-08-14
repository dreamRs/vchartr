
#' @importFrom utils modifyList
.vchart_specs <- function(vc, name, options) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  if (is.null(vc$x$specs[[name]])) {
    vc$x$specs[[name]] <- dropNulls(options)
  } else {
    if (name %in% c("data", "series", "legends")) {
      vc$x$specs[[name]] <- c(
        vc$x$specs[[name]],
        options
      )
    } else {
      vc$x$specs[[name]] <- modifyList(
        x = vc$x$specs[[name]],
        val = dropNulls(options),
        keep.null = TRUE
      )
    }
  }
  return(vc)
}


.vchart_specs2 <- function(vc, name, options) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  if (is.null(vc$x$specs[[name]])) {
    vc$x$specs[[name]] <- list()
  }
  vc$x$specs[[name]][[length(vc$x$specs[[name]]) + 1]] <- dropNulls(options)
  return(vc)
}



#' Specify configuration options for a [vchart()].
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param ... List of options to specify for the chart, see [https://www.visactor.io/vchart/option/](https://www.visactor.io/vchart/option/).
#' @param dataserie_id Used to set or modify options for a chart where there are multiple series. You can use :
#'   * a `numeric` to target the position of the serie in the order where it's added to the chart
#'   * a `character` to refer to a `serie_id` set when the serie was added to the plot.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vchart(table(Class = mpg$class)) %>%
#'   v_bar(aes(Class, Freq)) %>%
#'   v_specs(
#'     label = list(visible = TRUE),
#'     color = list("firebrick")
#'   )
v_specs <- function(vc, ..., dataserie_id = NULL) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  if (is.null(dataserie_id)) {
    vc$x$specs <- modifyList(
      x = vc$x$specs,
      val = list(...),
      keep.null = TRUE
    )
  } else if (is.numeric(dataserie_id)) {
    vc$x$specs$series[[dataserie_id]] <- dropNulls(modifyList(
      x = vc$x$specs$series[[dataserie_id]],
      val = list(...),
      keep.null = TRUE
    ))
  } else if (is.character(dataserie_id)) {
    serie <- get_serie_index(vc, dataserie_id)
    if (length(serie) == 1) {
      vc$x$specs$series[[serie]] <- dropNulls(modifyList(
        x = vc$x$specs$series[[serie]],
        val = list(...),
        keep.null = TRUE
      ))
    }
  }
  return(vc)
}






#' Set chart title and subtitle
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param title Title for the chart.
#' @param subtitle Subtitle for the chart.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vchart(table(Class = mpg$class), aes(Class, Freq)) %>%
#'   v_bar() %>%
#'   v_labs(
#'     title = "Title for the chart",
#'     subtitle = "A subtitle to be placed under the title"
#'   )
v_labs <- function(vc, title, subtitle = NULL) {
  vc <- .vchart_specs(
    vc,
    "title",
    list(
      text = title,
      subtext = subtitle
    )
  )
  return(vc)
}



#' Set color(s) for chart
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param ... Colors options, can be a single color code, a vector of colors to use or a list with more options.
#'  For `v_colors_manual` it should be a named list with data values as name and color as values.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vchart(table(Class = mpg$class)) %>%
#'   v_bar(aes(Class, Freq)) %>%
#'   v_specs_colors("#8FBCBB")
#'
v_specs_colors <- function(vc, ...) {
  args <- list(...)
  if (length(args) == 1 && is.character(args[[1]]))
    args <- as.list(args[[1]])
  vc <- .vchart_specs(
    vc,
    "color",
    args
  )
  return(vc)
}





#' Set legend options
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param ... Options for the legend, see examples or
#'  [online documentation](https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Legend).
#' @param add Add the legend to exiting ones or overwrite all previous legends.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vchart(table(Class = mpg$class, Year = mpg$year)) %>%
#'   v_bar(aes(Class, Freq, fill = Year)) %>%
#'   v_specs_legend(
#'     title = list(text = "Title", visible = TRUE),
#'     orient = "right",
#'     position = "start",
#'     item = list(focus = TRUE)
#'   )
v_specs_legend <- function(vc, ..., add = FALSE) {
  if (isTRUE(add)) {
    vc <- .vchart_specs(
      vc,
      "legends",
      list(list(...))
    )
  } else {
    vc$x$specs$legends <- list(list(...))
  }
  return(vc)
}



#' Set tooltip options
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param ... Options for the tooltip, see examples or
#'  [online documentation](https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Tooltip).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vchart(table(Class = mpg$class, Year = mpg$year)) %>%
#'   v_bar(aes(Class, Freq, fill = Year)) %>%
#'   v_specs_tooltip(
#'     visible = FALSE
#'   )
v_specs_tooltip <- function(vc, ...) {
  vc <- .vchart_specs(
    vc,
    "tooltip",
    list(...)
  )
  return(vc)
}



#' Axes configuration
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param position Position of the axe on the chart.
#' @param ... Configuration options.
#' @param remove If `TRUE` then axe is removed and other parameters are ignored.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/axes.R
v_specs_axes <- function(vc,
                         position = c("left", "bottom", "right", "top", "angle", "radius"),
                         ...,
                         remove = FALSE) {
  position <- match.arg(position)
  index <- get_axes_index(vc, position)
  if (isTRUE(remove)) {
    if (index == 1)
      vc$x$specs$axes[[index]] <- NULL
  } else {
    if (length(index) < 1)
      index <- length(vc$x$specs$axes) + 1
    if (index > length(vc$x$specs$axes)) {
      vc$x$specs$axes[[index]] <- dropNulls(list(orient = position, ...))
    } else {
      vc$x$specs$axes[[index]] <- modifyList(
        x = vc$x$specs$axes[[index]],
        val = dropNulls(list(orient = position, ...)),
        keep.null = TRUE
      )
    }
  }
  return(vc)
}





#' Set player options
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param ... Options for the legend, see examples or
#'  [online documentation](https://www.visactor.io/vchart/option/commonChart#player).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vchart(table(Class = mpg$class, Year = mpg$year)) %>%
#'   v_bar(aes(Class, Freq, fill = Year)) %>%
#'   v_specs_tooltip(
#'     visible = FALSE
#'   )
v_specs_player <- function(vc, ...) {
  vc <- .vchart_specs(
    vc,
    "player",
    list(...)
  )
  return(vc)
}


v_default_player <- function(vc,
                             mapdata,
                             dataserie_id,
                             fun_values = create_values,
                             ...) {
  v_specs_player(
    vc,
    auto = FALSE,
    loop = FALSE,
    alternate = TRUE,
    interval = 500,
    width = 500,
    position = "middle",
    type = "discrete",
    specs = lapply(
      X = mapdata,
      FUN = function(dat) {
        list(
          data = list(
            id = dataserie_id,
            values = fun_values(dat, ...)
          )
        )
      }
    )
  )
}



#' Add custom mark to chart
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param ... Options for the legend, see examples or
#'  [online documentation](https://www.visactor.io/vchart/option/commonChart#customMark).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
v_specs_custom_mark <- function(vc, ...) {
  vc <- .vchart_specs2(
    vc,
    "customMark",
    list(...)
  )
  return(vc)
}
