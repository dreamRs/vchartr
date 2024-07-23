
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

null_or_empty <- function(x) {
  is.null(x) || length(x) == 0
}

dropNullsOrEmpty <- function(x) {
  x[!vapply(x, null_or_empty, FUN.VALUE = logical(1))]
}

genId <- function(bytes = 12) {
  paste(format(as.hexmode(
    sample(256, bytes, replace = TRUE) -  1
  ), width = 2), collapse = "")
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

#' @importFrom rlang eval_tidy
eval_mapping <- function(data, mapping, convert_date = FALSE) {
  mapdata <- lapply(mapping, eval_tidy, data = data)
  if (isTRUE(convert_date)) {
    if (inherits(mapdata$x, "Date")) {
      mapdata$x <- as.numeric(mapdata$x) * 3600*24 * 1000
      attr(mapdata, "datetime_format") <- "date"
    } else if (inherits(mapdata$x, "POSIXt")) {
      mapdata$x <- as.numeric(mapdata$x) * 1000
      attr(mapdata, "datetime_format") <- "datetime"
    }
  }
  return(mapdata)
}


get_serie_index <- function(vc, id) {
  ids <- unlist(lapply(vc$x$specs$series, `[[`, "dataId"))
  index <- which(id == ids)
  if (length(index) < 1)
    warning("Serie ID: ", id, " not found.", call. = FALSE)
  index
}




create_tree <- function(data,
                        levels,
                        value,
                        fill = NULL,
                        ...) {
  args <- list(...)
  data <- as.data.frame(data)
  if (!all(levels %in% names(data)))
    stop("All levels must be valid variables in data", call. = FALSE)
  data[levels] <- lapply(data[levels], as.character)
  data <- unique(x = data)
  lapply(
    X = unique(data[[levels[1]]][!is.na(data[[levels[1]]])]),
    FUN = function(var) {
      dat <- data[data[[levels[1]]] == var, , drop = FALSE]
      args_level <- args[[levels[1]]]
      if (length(levels) == 1) {
        dropNullsOrEmpty(c(list(
          name = var,
          value = sum(dat[[value]], na.rm = TRUE),
          fill = if (!is.null(fill)) dat[[fill]][1]
        ), args_level))
      }
      else {
        c(dropNullsOrEmpty(list(
          name = var,
          children = create_tree(
            data = dat,
            levels = levels[-1],
            value = value,
            fill = fill,
            ...
          )
        )), args_level)
      }
    }
  )
}


