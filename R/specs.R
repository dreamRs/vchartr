
#' Specify configuration options for a [vchart()].
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param ... List of options to specify for the chart, see [https://www.visactor.io/vchart/option/](https://www.visactor.io/vchart/option/).
#' @param serie Used to set or modify options for a chart where there are multiple series. You can use :
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
#' vbar(table(Class = mpg$class), aes(Class, Freq)) %>%
#'   v_specs(
#'     label = list(visible = TRUE),
#'     color = list("firebrick")
#'   )
v_specs <- function(vc, ..., serie = NULL) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  if (is.null(serie)) {
    vc$x$specs <- modifyList(
      x = vc$x$specs,
      val = list(...),
      keep.null = TRUE
    )
  } else if (is.numeric(serie)) {
    vc$x$specs$series[[serie]] <- modifyList(
      x = vc$x$specs$series[[serie]],
      val = list(...),
      keep.null = TRUE
    )
  } else if (is.character(serie)) {
    serie <- get_serie_index(vc, serie)
    if (length(serie) == 1) {
      vc$x$specs$series[[serie]] <- modifyList(
        x = vc$x$specs$series[[serie]],
        val = list(...),
        keep.null = TRUE
      )
    }
  }
  return(vc)
}






#' Set chart title and subtitle
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
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
#' vbar(table(Class = mpg$class), aes(Class, Freq)) %>%
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
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param ... Colors options, can be a single color code, a vector of colors to use or a list with more options.
#'  For `v_colors_manual` it should be a named list with data values as name and color as values.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name vc-colors
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vbar(table(Class = mpg$class), aes(Class, Freq)) %>%
#'   v_colors("#8FBCBB")
#'
#' vbar(
#'   table(Class = mpg$class, Year = mpg$year),
#'   aes(Class, Freq, fill = Year)
#' ) %>%
#'   v_colors_manual("2008" = "#88C0D0", "1999" = "#5E81AC")
v_colors <- function(vc, ...) {
  vc <- .vchart_specs(
    vc,
    "color",
    list(...)
  )
  return(vc)
}

#' @export
#'
#' @rdname vc-colors
v_colors_manual <- function(vc, ...) {
  vc <- .vchart_specs(
    vc,
    "color",
    list(specified = list(...))
  )
  return(vc)
}




#' Set legend options
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param ... Options for the legend, see examples or online documentation :
#'  [https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Legend](https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Legend).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vbar(
#'   table(Class = mpg$class, Year = mpg$year),
#'   aes(Class, Freq, fill = Year)
#' ) %>%
#'   v_legend(
#'     title = list(text = "Title", visible = TRUE),
#'     orient = "right",
#'     position = "start",
#'     item = list(focus = TRUE)
#'   )
v_legend <- function(vc, ...) {
  vc <- .vchart_specs(
    vc,
    "legends",
    list(...)
  )
  return(vc)
}



#' Set tooltip options
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param ... Options for the legend, see examples or online documentation :
#'  [https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Tooltip](https://www.visactor.io/vchart/guide/tutorial_docs/Chart_Concepts/Tooltip).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchartr)
#' data("mpg", package = "ggplot2")
#'
#' vbar(
#'   table(Class = mpg$class, Year = mpg$year),
#'   aes(Class, Freq, fill = Year)
#' ) %>%
#'   v_tooltip(
#'     visible = FALSE
#'   )
v_tooltip <- function(vc, ...) {
  vc <- .vchart_specs(
    vc,
    "tooltip",
    list(...)
  )
  return(vc)
}



#' @importFrom utils modifyList
.vchart_specs <- function(vc, name, options) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  if (is.null(vc$x$specs[[name]])) {
    vc$x$specs[[name]] <- options
  } else {
    vc$x$specs[[name]] <- modifyList(
      x = vc$x$specs[[name]],
      val = options,
      keep.null = TRUE
    )
  }
  return(vc)
}

