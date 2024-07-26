
#' @title Create interactive charts with VChart
#'
#' @description
#' VChart is a charting component library, see more about it here : [https://www.visactor.io/vchart](https://www.visactor.io/vchart).
#'
#' @param ... Configuration for creating chart.
#' @inheritParams htmlwidgets::createWidget
#'
#' @note
#' This function allow you to use JavaScript function `VChart` directly,
#'  see [https://www.visactor.io/vchart/option/](https://www.visactor.io/vchart/option/) for how to specify options.
#'
#' @return A [vchart()] `htmlwidget` object.
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#'
#' @export
#'
#' @example examples/vchart.R
vchart <- function(..., width = NULL, height = NULL, elementId = NULL) {
  x <- list(specs = list(...))
  htmlwidgets::createWidget(
    name = "vchart",
    x = x,
    width = width,
    height = height,
    package = "vchartr",
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = "100%",
      viewer.defaultHeight = "100%",
      viewer.defaultWidth = "100%",
      knitr.figure = FALSE,
      knitr.defaultWidth = "100%",
      knitr.defaultHeight = "350px",
      browser.fill = TRUE,
      viewer.suppress = FALSE,
      browser.external = TRUE,
      padding = 0
    )
  )
}


