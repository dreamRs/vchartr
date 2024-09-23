
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
#' 
#' @return An output or render function that enables the use of the widget within Shiny applications.
#'
#' @example examples/shiny.R
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
