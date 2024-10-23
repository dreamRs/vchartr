
#' VChart events
#'
#' @param vc A chart initialized with [vchart()].
#' @param name Name of the event, e.g. `"click"`.
#' @param params Parameters to specifically monitor events in a certain part of the chart.
#' @param fun JavaScript function executed when the event occurs.
#' @param ... Not used.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/events.R
v_event <- function(vc,
                    name,
                    params,
                    fun,
                    ...) {
  if (is.null(vc$x$events)) {
    vc$x$events <- list(
      list(
        name = name,
        params = params,
        fun = fun
      )
    )
  } else {
    vc$x$events <- append(
      vc$x$events, 
      list(
        list(
          name = name,
          params = params,
          fun = fun
        )
      )
    )
  }
  return(vc)
}
