
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

list_ <- function(...) {
  dropNulls(list(...))
}

null_or_empty <- function(x) {
  is.null(x) || length(x) == 0
}

dropNullsOrEmpty <- function(x) {
  x[!vapply(x, null_or_empty, FUN.VALUE = logical(1))]
}

list1 <- function(x){
  if (length(x) == 1) {
    list(x)
  } else {
    x
  }
}

genId <- function(bytes = 12) {
  paste(format(as.hexmode(
    sample(256, bytes, replace = TRUE) -  1
  ), width = 2), collapse = "")
}

to_camel_case <- function(x) {
  gsub("_([a-z])", "\\U\\1", x, perl = TRUE)
}

style_params <- function(x) {
  if (is.null(x)) return(NULL)
  params <- dropNulls(x)
  names(params) <- to_camel_case(names(params))
  params
}

get_mapping <- function(vc, mapping) {
  mapping <- c(vc$x$mapping, mapping)
  mapping <- mapping[!duplicated(names(mapping), fromLast = TRUE)]
  aes(!!!mapping)
}

get_data <- function(vc, data) {
  if (!is.null(vc$x$data))
    return(as.data.frame(vc$x$data))
  return(as.data.frame(data))
}

create_values <- function(data) {
  lapply(
    X = seq_along(data[[1]]),
    FUN = function(i) {
      lapply(data, `[`, i)
    }
  )
}


create_chart <- function(type,
                         specs,
                         data = NULL,
                         mapdata = NULL,
                         width,
                         height,
                         elementId) {
  args <- c(
    dropNulls(specs),
    list(
      width = width,
      height = height,
      elementId = elementId
    )
  )
  vc <- exec("vchart", !!!args)
  vc$x$data <- data
  vc$x$mapdata <- mapdata
  class(vc) <- c(class(vc), type)
  return(vc)
}

#' @importFrom rlang eval_tidy
eval_mapping <- function(data, mapping, convert_date = FALSE) {
  mapdata <- lapply(mapping, eval_tidy, data = data)
  attr(mapdata, "x_class") <- class(mapdata$x)[1]
  attr(mapdata, "scale_x") <- get_scale(mapdata$x)
  attr(mapdata, "scale_y") <- get_scale(mapdata$y)
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

#' @importFrom stats complete.cases
eval_mapping_ <- function(data, mapping, na_rm = FALSE) {
  mapdata <- lapply(mapping, eval_tidy, data = data)
  if (na_rm) {
    index <- complete.cases(mapdata)
    mapdata <- lapply(mapdata, `[`, index)
  }
  if (inherits(mapdata$x, "factor"))
    mapdata$x <- as.character(mapdata$x)
  attr(mapdata, "scale_x") <- get_scale(mapdata$x)
  attr(mapdata, "scale_y") <- get_scale(mapdata$y)
  attr(mapdata, "scale_colour") <- get_scale(mapdata$colour)
  attr(mapdata, "scale_fill") <- get_scale(mapdata$fill)
  attr(mapdata, "scale_size") <- get_scale(mapdata$size)
  if (inherits(mapdata$x, "Date")) {
    mapdata$x <- as.numeric(mapdata$x)
  } else if (inherits(mapdata$x, "POSIXt")) {
    mapdata$x <- as.numeric(mapdata$x)
  }
  return(mapdata)
}

get_scale <- function(x) {
  if (is.null(x)) return(NA_character_)
  if (inherits(x, c("numeric", "integer"))) {
    "continuous"
  } else if (inherits(x, c("character", "factor"))) {
    "discrete"
  } else if (inherits(x, "Date")) {
    "date"
  } else if (inherits(x, "POSIXt")) {
    "datetime"
  } else {
    class(x)[1]
  }
}


get_serie_index <- function(vc, id) {
  ids <- unlist(lapply(vc$x$specs$series, `[[`, "id"))
  index <- which(id == ids)
  if (length(index) < 1)
    warning("Serie ID: ", id, " not found.", call. = FALSE)
  index
}


get_axes_index <- function(vc, position) {
  orient <- unlist(lapply(vc$x$specs$axes, `[[`, "orient"))
  index <- which(position == orient)
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
          value = sum(dat[[value]], na.rm = TRUE),
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



rename_aes_lvl <- function(mapping) {
  if (has_name(mapping, "x"))
    names(mapping)[names(mapping) == "x"] <- "lvl1"
  if (has_name(mapping, "y") & has_name(mapping, "value"))
    names(mapping)[names(mapping) == "y"] <- "lvl2"
  if (has_name(mapping, "y") & !has_name(mapping, "value"))
    names(mapping)[names(mapping) == "y"] <- "value"
  mapping
}


rename_aes_sankey <- function(mapping) {
  if (has_name(mapping, "x"))
    names(mapping)[names(mapping) == "x"] <- "target"
  if (has_name(mapping, "y"))
    names(mapping)[names(mapping) == "y"] <- "source"
  mapping
}
