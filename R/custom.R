
#' Add data zoom on a line or area chart
#'
#' @param vc A chart created with [vline()].
#' @param start,end Formatter for the start/end label, e.g. : `"Start: \{label:%Y-%m-%d\}"`,
#'  where the part between braces will be replaced by the date with the format specified.
#' @param brush Logical, add the ability to brush the chart to zoom in.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @examples
#' library(vchart)
#' data("economics", package = "ggplot2")
#' vline(economics, aes(date, unemploy)) %>%
#'   v_line_datazoom()
v_line_datazoom <- function(vc,
                            start = "{label:%Y-%m-%d}",
                            end = "{label:%Y-%m-%d}",
                            brush = TRUE) {
  stopifnot(
    "'vc' must be a chart constructed with vline()" = inherits(vc, "vline")
  )
  vc <- v_specs(
    vc = vc,
    dataZoom = list(
      list(
        orient = "bottom",
        startText = list(formatter = start),
        endText = list(formatter = end)
      )
    )
  )
  if (isTRUE(brush)) {
    vc <- v_specs(
      vc = vc,
      brush = list(
        brushType = "x",
        zoomAfterBrush = TRUE
      )
    )
  }
  return(vc)
}

