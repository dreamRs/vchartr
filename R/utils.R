
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

dropColumns <- function(x) {
  x <- dropListColumns(x)
  x <- dropArrayColumns(x)
  return(x)
}
dropListColumns <- function(x) {
  type_col <- vapply(
    X = x, 
    FUN = typeof, 
    FUN.VALUE = character(1), 
    USE.NAMES = FALSE
  )
  x[, type_col != "list", drop = FALSE]
}
dropArrayColumns <- function(x) {
  cols_array <- vapply(
    X = x, 
    FUN = is.array, 
    FUN.VALUE = logical(1), 
    USE.NAMES = FALSE
  )
  x[, !cols_array, drop = FALSE]
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

genSerieId <- function() {
  paste0("serie_", genId(4))
}

genDataId <- function() {
  paste0("data_", genId(4))
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
  if (!is.null(data))
    return(as.data.frame(data))
  return(as.data.frame(vc$x$data))
}

create_values <- function(data, .names = NULL) {
  if (has_player(data))
    data <- data[[1]]
  if (!is.null(.names))
    data <- rename_list(data, .names)
  lapply(
    X = seq_along(data[[1]]),
    FUN = function(i) {
      lapply(data, `[`, i)
    }
  )
}

has_player <- function(x) {
  isTRUE(attr(x, "player"))
}
has_select <- function(x) {
  isTRUE(attr(x, "select"))
}
filter_values <- function(mapdata) {
  if (has_player(mapdata)) {
    player1 <- mapdata$player[1]
    mapdata <- mapdata[mapdata$player == player1, , drop = FALSE]
  }
  if (has_select(mapdata)) {
    select1 <- mapdata$select[1]
    mapdata <- mapdata[mapdata$select == select1, , drop = FALSE]
  }
  return(mapdata)
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
  mapdata <- as.data.frame(mapdata, check.names = FALSE)
  if (na_rm) {
    mapdata <- mapdata[complete.cases(mapdata), , drop = FALSE]
  }
  if (inherits(mapdata$x, "factor"))
    mapdata$x <- as.character(mapdata$x)
  if (inherits(mapdata$y, "factor"))
    mapdata$y <- as.character(mapdata$y)
  if (inherits(mapdata$fill, "factor"))
    mapdata$fill <- as.character(mapdata$fill)
  if (inherits(mapdata$colour, "factor"))
    mapdata$colour <- as.character(mapdata$colour)
  scale_x <- get_scale(mapdata$x)
  scale_y <- get_scale(mapdata$y)
  scale_colour <- get_scale(mapdata$colour)
  scale_fill <- get_scale(mapdata$fill)
  scale_size <- get_scale(mapdata$size)
  if (inherits(mapdata$x, c("Date", "POSIXt"))) {
    mapdata$x <- as.numeric(mapdata$x)
  }
  if (inherits(mapdata$y, c("Date", "POSIXt"))) {
    mapdata$y <- as.numeric(mapdata$y)
  }
  if (has_name(mapdata, "player")) {
    attr(mapdata, "player") <- TRUE
  }
  if (has_name(mapdata, "select")) {
    attr(mapdata, "select") <- TRUE
  }
  attr(mapdata, "scale_x") <- scale_x
  attr(mapdata, "scale_y") <- scale_y
  attr(mapdata, "scale_colour") <- scale_colour
  attr(mapdata, "scale_fill") <- scale_fill
  attr(mapdata, "scale_size") <- scale_size
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
  if (has_player(data))
    data <- data[[1]]
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



make_sankey_data <- function(data, mapping) {
  data <- as.data.frame(data)
  mapdata <- eval_mapping(data, rename_aes_sankey(mapping))
  nodes <- data.frame(nodes = sort(unique(c(mapdata$source, mapdata$target))))
  nodes$nodes_id <- seq_len(nrow(nodes)) - 1
  links <- as.data.frame(mapdata)
  links$target <- nodes$nodes_id[match(links$target, nodes$nodes)]
  links$source <- nodes$nodes_id[match(links$source, nodes$nodes)]
  return(list(nodes = nodes, links = links))
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


rename_list <- function(.list, .names) {
  for (i in seq_along(.names)) {
    new <- names(.names)[i]
    old <- .names[[i]]
    if (has_name(.list, old)) {
      names(.list)[names(.list) == old] <- new
    }
  }
  return(.list)
}


tooltip_key_default <- function() {
  JS(
    "datum => {",
    # "console.log(datum);",
    "if (datum.hasOwnProperty('colour')) return datum.colour;",
    "if (datum.hasOwnProperty('fill')) return datum.fill;",
    "return datum.__VCHART_DEFAULT_DATA_SERIES_FIELD;",
    "}"
  )
}



get_aes_data <- function(mapdata, aesthetics) {
  mapdata <- as.list(mapdata)
  if (is_named(mapdata)) {
    mapaes <- dropNullsOrEmpty(mapdata[aesthetics])
    unlist(mapaes, use.names = FALSE)
  } else {
    unlist(lapply(mapdata, get_aes_data, aesthetics))
  }
}



extract_data <- function(vc) {
  lapply(
    X = vc$x$specs$data,
    FUN = function(x) {
      x$values
    }
  )
}


