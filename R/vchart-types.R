
#' Create a bar chart
#'
#' @param data Default dataset to use for chart. If not already
#'  a `data.frame`, it will be coerced to with `as.data.frame`.
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @param stack Whether to stack the data.
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
  mapdata <- lapply(mapping, eval_tidy, data = data)

  specs <- list(
    type = "bar",
    data = list(
      list(
        values = lapply(
          X = seq_along(mapdata[[1]]),
          FUN = function(i) {
            lapply(mapdata, `[`, i)
          }
        )
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
  args <- c(
    dropNulls(specs),
    list(
      width = width,
      height = height,
      elementId = elementId
    )
  )
  exec("vchart", !!!args)
}
