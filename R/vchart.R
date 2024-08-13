
#' @title Create interactive charts with VChart
#'
#' @description
#' VChart is a charting component library, see more about it here : [https://www.visactor.io/vchart](https://www.visactor.io/vchart).
#'
#' @param data Can be a `data.frame` if function used with other layers functions or a list of parameters for configuring a chart.
#' @param mapping Default list of aesthetic mappings to use for chart, only used if `data` is a `data.frame`.
#' @param ... Additional parameters.
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
vchart <- function(data = NULL,
                   mapping = NULL,
                   ...,
                   width = NULL,
                   height = NULL,
                   elementId = NULL) {
  if (inherits(data, c("data.frame", "table")) | is.null(data)) {
    x <- list(
      specs = list(type = "common"),
      data = data,
      mapping = mapping,
      mapdata = list(),
      ...
    )
    if (!is.null(mapping) & !is.null(data))
      x$mapdata <- c(x$mapdata, list(eval_mapping_(as.data.frame(data), mapping)))
  } else {
    x <- list(
      specs = list(data = data, ...)
    )
  }
  createWidget(
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
      knitr.defaultHeight = "400px",
      browser.fill = TRUE,
      viewer.suppress = FALSE,
      browser.external = TRUE,
      padding = 0
    )
  )
}


