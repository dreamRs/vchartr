
#' Specify configuration options for a [vchart()].
#'
#' @param vc An htmlwidget created with [vchart()] or specific chart's type function.
#' @param ... List of options to specify for the chart, see [https://www.visactor.io/vchart/option/](https://www.visactor.io/vchart/option/).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' vbar(table(Class = mpg$class), aes(Class, Freq)) %>%
#'   v_specs(
#'     label = list(visible = TRUE),
#'     color = list("firebrick")
#'   )
v_specs <- function(vc, ...) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  vc$x$specs <- modifyList(
    x = vc$x$specs,
    val = list(...),
    keep.null = TRUE
  )
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
#' vbar(table(Class = mpg$class), aes(Class, Freq)) %>%
#'   v_labs(
#'     title = "Title for the chart",
#'     subtitle = "A subtitle to be placed under the title"
#'   )
v_labs <- function(vc, title, subtitle) {
  .vchart_specs(
    vc,
    "title",
    list(
      text = title,
      subtext = subtitle
    )
  )
}



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

