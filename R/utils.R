
dropNulls <-function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


create_values <- function(data) {
  lapply(
    X = seq_along(data[[1]]),
    FUN = function(i) {
      lapply(data, `[`, i)
    }
  )
}


create_chart <- function(type, specs, width, height, elementId) {
  args <- c(
    dropNulls(specs),
    list(
      width = width,
      height = height,
      elementId = elementId
    )
  )
  vc <- exec("vchart", !!!args)
  class(vc) <- c(class(vc), type)
  return(vc)
}
