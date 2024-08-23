
#' Add an horizontal or vertical line to a chart
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param x,y,xend,yend Target position for the line.
#' @param ... Additional parameters for the line,
#'  see [online documentation](https://www.visactor.io/vchart/option/commonChart#markLine) for more.
#' @param .line.style.stroke Stroke color.
#' @param .line.style.lineDash Used to configure the dashed line mode when filling lines.
#'  It uses an array of values to specify the alternating lengths of lines and gaps that describe the pattern.
#' @param .label.text Text for the label on the line.
#' @param .label.position The label position of the dimension line (the relative position of the label relative to the line).
#'  See [online documentation](https://www.visactor.io/vchart/option/commonChart#markLine.label.position) for options.
#' @param .label.refY,.label.refX The offset in the vertical direction of the reference line.
#' @param .endSymbol.style.visible,.startSymbol.style.visible Whether the symbol element is visible or not.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name mark-line
#'
#' @example examples/mark-line.R
v_mark_vline <- function(vc,
                         x,
                         ...,
                         .line.style.stroke = "#000",
                         .line.style.lineDash = list(8, 8),
                         .label.text = NULL,
                         .label.position = "end",
                         .label.refY = 0,
                         .label.refX = 0,
                         .endSymbol.style.visible = FALSE,
                         .startSymbol.style.visible = FALSE) {
  v_mark_line(
    vc = vc,
    value = x,
    name = "x",
    ...,
    .line.style.stroke = .line.style.stroke,
    .line.style.lineDash = .line.style.lineDash,
    .label.text = .label.text,
    .label.position = .label.position,
    .label.refY = .label.refY,
    .label.refX = .label.refX,
    .endSymbol.style.visible = .endSymbol.style.visible,
    .startSymbol.style.visible = .startSymbol.style.visible
  )
}


#' @export
#'
#' @rdname mark-line
#'
v_mark_hline <- function(vc,
                         y,
                         ...,
                         .line.style.stroke = "#000",
                         .line.style.lineDash = list(8, 8),
                         .label.text = NULL,
                         .label.position = "insideEndBottom",
                         .label.refY = -10,
                         .label.refX = 0,
                         .endSymbol.style.visible = FALSE,
                         .startSymbol.style.visible = FALSE) {
  v_mark_line(
    vc = vc,
    value = y,
    name = "y",
    ...,
    .line.style.stroke = .line.style.stroke,
    .line.style.lineDash = .line.style.lineDash,
    .label.text = .label.text,
    .label.position = .label.position,
    .label.refY = .label.refY,
    .label.refX = .label.refX,
    .endSymbol.style.visible = .endSymbol.style.visible,
    .startSymbol.style.visible = .startSymbol.style.visible
  )
}


#' @export
#'
#' @rdname mark-line
#'
v_mark_segment <- function(vc,
                           x,
                           xend,
                           y,
                           yend,
                           ...,
                           .line.style.stroke = "#000",
                           .line.style.lineDash = list(8, 8),
                           .label.text = NULL,
                           .label.position = "insideEndBottom",
                           .label.refY = -10,
                           .label.refX = 0,
                           .endSymbol.style.visible = FALSE,
                           .startSymbol.style.visible = FALSE) {
  if (inherits(x, c("Date", "POSIXt"))) {
    x <- as.numeric(x)
  }
  if (inherits(y, c("Date", "POSIXt"))) {
    y <- as.numeric(y)
  }
  if (inherits(xend, c("Date", "POSIXt"))) {
    xend <- as.numeric(xend)
  }
  if (inherits(yend, c("Date", "POSIXt"))) {
    yend <- as.numeric(yend)
  }
  v_mark_line(
    vc = vc,
    value = list(
      list(x = x, y = y),
      list(x = xend, y = yend)
    ),
    name = "coordinates",
    ...,
    .line.style.stroke = .line.style.stroke,
    .line.style.lineDash = .line.style.lineDash,
    .label.text = .label.text,
    .label.position = .label.position,
    .label.refY = .label.refY,
    .label.refX = .label.refX,
    .endSymbol.style.visible = .endSymbol.style.visible,
    .startSymbol.style.visible = .startSymbol.style.visible
  )
}


v_mark_line <- function(vc,
                        value,
                        name,
                        ...,
                        .line.style.stroke = "#000",
                        .line.style.lineDash = list(8, 8),
                        .label.text = NULL,
                        .label.position = "end",
                        .label.refY = 0,
                        .label.refX = 0,
                        .endSymbol.style.visible = FALSE,
                        .startSymbol.style.visible = FALSE) {
  config <- list(...)
  if (inherits(value, c("Date", "POSIXt"))) {
    value <- as.numeric(value)
  }
  config[[name]] <- value
  unconfig <- unlist(config)

  if (is.na(unconfig["line.style.stroke"]))
    config$line$style$stroke <- .line.style.stroke
  if (is.na(unconfig["line.style.lineDash"]))
    config$line$style$lineDash <- .line.style.lineDash
  if (is.na(unconfig["label.text"]))
    config$label$text <- .label.text
  if (is.na(unconfig["label.position"]))
    config$label$position <- .label.position
  if (is.na(unconfig["label.refY"]))
    config$label$refY <- .label.refY
  if (is.na(unconfig["label.refX"]))
    config$label$refX <- .label.refX
  if (is.na(unconfig["endSymbol.style.visible"]))
    config$endSymbol$style$visible <- .endSymbol.style.visible
  if (is.na(unconfig["startSymbol.style.visible"]))
    config$startSymbol$style$visible <- .startSymbol.style.visible

  len <- length(value)
  config <- rapply(
    object = config,
    f = rep_len,
    length.out = len,
    how = "replace"
  )
  extract <- function(el, index) {
    `[`(el, index)
  }

  .vchart_specs(
    vc,
    "markLine",
    lapply(
      X = seq_len(len),
      FUN = function(i) {
        rapply(
          object = config,
          f = extract,
          index = i,
          how = "list"
        )
      }
    )
  )
}




#' Add a rectangle annotation to a chart
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param xmin,xmax,ymin,ymax Target position for the line.
#' @param .area.style.fill Fill color.
#' @param .area.style.fillOpacity Fill opacity.
#' @inheritParams mark-line
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @name mark-area
#'
#' @example examples/mark-area.R
v_mark_rect <- function(vc,
                        xmin = NULL,
                        xmax = NULL,
                        ymin = NULL,
                        ymax = NULL,
                        .area.style.fill = "grey35",
                        .area.style.fillOpacity = 0.3,
                        .label.text = NULL,
                        .label.position = "insideTop",
                        .label.refY = 0,
                        .label.refX = 0) {
  if (inherits(xmin, c("Date", "POSIXt"))) {
    xmin <- as.numeric(xmin)
  }
  if (inherits(xmax, c("Date", "POSIXt"))) {
    xmax <- as.numeric(xmax)
  }
  if (inherits(ymin, c("Date", "POSIXt"))) {
    ymin <- as.numeric(ymin)
  }
  if (inherits(xmin, c("Date", "POSIXt"))) {
    ymax <- as.numeric(ymax)
  }
  v_mark_area(
    vc = vc,
    x = xmin,
    x1 = xmax,
    y = ymin,
    y1 = ymax,
    .len = max(lengths(list(xmin, xmax, ymin, ymax))),
    .area.style.fill = .area.style.fill,
    .area.style.fillOpacity = .area.style.fillOpacity,
    .label.text = .label.text,
    .label.position = .label.position,
    .label.refY = .label.refY,
    .label.refX = .label.refX
  )
}



v_mark_area <- function(vc,
                        ...,
                        .len = 1,
                        .area.style.fill = "grey35",
                        .area.style.fillOpacity = 0.3,
                        .label.text = NULL,
                        .label.position = "insideTop",
                        .label.refY = 0,
                        .label.refX = 0) {
  config <- dropNulls(list(...))
  unconfig <- unlist(config)

  if (is.na(unconfig["area.style.fill"]))
    config$area$style$fill <- .area.style.fill
  if (is.na(unconfig["area.style.fillOpacity"]))
    config$area$style$fillOpacity <- .area.style.fillOpacity
  if (is.na(unconfig["label.text"]))
    config$label$text <- .label.text
  if (is.na(unconfig["label.position"]))
    config$label$position <- .label.position
  if (is.na(unconfig["label.refY"]))
    config$label$refY <- .label.refY
  if (is.na(unconfig["label.refX"]))
    config$label$refX <- .label.refX

  config <- rapply(
    object = config,
    f = rep_len,
    length.out = .len,
    how = "replace"
  )
  extract <- function(el, index) {
    `[`(el, index)
  }

  .vchart_specs(
    vc,
    "markArea",
    lapply(
      X = seq_len(.len),
      FUN = function(i) {
        rapply(
          object = config,
          f = extract,
          index = i,
          how = "list"
        )
      }
    )
  )
}
