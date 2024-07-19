
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

