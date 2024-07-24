
#' Create a Map
#'
#' @param data An `sf` object.
#' @param mapping efault list of aesthetic mappings to use for map.
#' @param ... Configuration options for the map.
#' @param projection Geographical mapping type. See
#'  [online documentation](https://www.visactor.io/vchart/option/mapChart#region.projection.type) 
#'  for the various possible choices.
#' @inheritParams vchart
#'
#' @return A [vmap()] `htmlwidget` object.
#' @export
#'
#' @example examples/vmap.R
vmap <- function(data,
                 mapping = NULL, 
                 ..., 
                 projection = NULL,
                 width = NULL, 
                 height = NULL, 
                 elementId = NULL) {
  rlang::check_installed("geojsonio", reason = "to use `vmap()`.")
  specs <- list(type = "map", map = "mymap", ...)
  if (!is.null(mapping)) {
    mapdata <- eval_mapping(as.data.frame(data), mapping)
    data$name <- mapdata$name
    specs$data <- list(
      list(
        values = create_values(mapdata)
      )
    )
    specs$nameField <- "name"
    specs$valueField <- "fill"
    specs$nameProperty <- "name"
    specs$area <- list(
      style = list(
        fill = list(
          field = "fill",
          scale = "color",
          changeDomain = "replace"
        )
      )
    )
    if (is.numeric(mapdata$fill)) {
      specs$color <- list(
        type = "linear",
        domain = range(pretty(range(mapdata$fill, na.rm = TRUE))),
        range = c(
          "#440154", "#482878", "#3E4A89", "#31688E", "#26828E",
          "#1F9E89", "#35B779", "#6DCD59", "#B4DE2C", "#FDE725"
        )
      )
      specs$legends <- list(
        visible = TRUE,
        type = "color",
        field = "fill"
      )
    } else if (is.character(mapdata$fill)) {
      specs$color <- list(
        type = "ordinal"
      )
      specs$legends <- list(
        visible = TRUE,
        type = "discrete",
        field = "fill",
        scaleName = "color"
      )
    }
  }
  if (!is.null(projection))
    specs$region[[1]]$projection$type <- projection
  topojson <- geojsonio::topojson_json(data, object_name = "map")
  x <- list(
    specs = specs,
    map = list(
      name = "mymap",
      topojson = topojson
    )
  )
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
