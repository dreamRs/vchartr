#' @title Create interactive charts with VChart
#'
#' @description
#' VChart is a charting component library, see more about it here : [https://www.visactor.io/vchart]
#'
#' @inheritParams htmlwidgets::createWidget
#'
#' @note
#' This function allow you to use JavaScript function `VChart` directly, see [https://www.visactor.io/vchart/option/] for how to specify options.
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#'
#' @export
#'
#' @example examples/vchart.R
vchart <- function(..., width = NULL, height = NULL, elementId = NULL) {

  x <- list(specs = list(...))

  # create widget
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

#' Shiny bindings for vchart
#'
#' Output and render functions for using [vchart()] within Shiny
#' applications and interactive Rmd documents.
#'
#' @inheritParams htmlwidgets::shinyWidgetOutput
#' @inheritParams htmlwidgets::shinyRenderWidget
#'
#' @name vchart-shiny
#'
#' @export
#'
#' @importFrom htmlwidgets shinyWidgetOutput
vchartOutput <- function(outputId, width = "100%", height = "400px"){
  shinyWidgetOutput(outputId, "vchart", width, height, package = "vchartr")
}

#' @rdname vchart-shiny
#' @export
#'
#' @importFrom htmlwidgets shinyRenderWidget
renderVchart <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, vchartOutput, env, quoted = TRUE)
}
