
#' @title Facets for vchart
#'
#' @description Create matrix of charts by row and column faceting variable (`v_facet_grid`),
#'  or by specified number of row and column for faceting variable(s) (`v_facet_wrap`).
#'
#' @param vc A chart initialized with [vchart()].
#' @param facets Variable(s) to use for facetting, wrapped in `vars(...)`.
#' @param nrow,ncol Number of row and column in output matrix.
#' @param scales Should scales be fixed (`"fixed"`, the default),
#'  free (`"free"`), or free in one dimension (`"free_x"`, `"free_y"`)?
#' @param labeller A function with one argument containing for each facet the value of the faceting variable.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @importFrom rlang quos syms
#'
#' @example examples/facet_wrap.R
v_facet_wrap <- function(vc,
                         facets,
                         nrow = NULL,
                         ncol = NULL,
                         scales = c("fixed", "free", "free_y", "free_x"),
                         labeller = label_value) {
  stopifnot(
    "\'vc\' must be a chart constructed with vchart()" = inherits(vc, "vchart")
  )
  scales <- match.arg(scales)
  if (is.character(facets))
    facets <- quos(!!!syms(facets))
  data <- get_data(vc, NULL)
  facets_values <- get_facets_values(data, facets)
  n <- length(unique(facets_values$facet_id))
  dims <- get_facets_dims(n, nrow = nrow, ncol = ncol)
  mat <- matrix(
    data = seq_len(n)[seq_len(dims$nrow * dims$ncol)],
    nrow = dims$nrow,
    ncol = dims$ncol,
    byrow = TRUE
  )
  no_axes <- c("pie", "treemap", "circlepacking", "sankey", "wordcloud", "radar")
  vc$x$specs$layout <- create_layout(
    ncol = dims$ncol,
    nrow = dims$nrow,
    title = !is.null(vc$title), 
    axe_x = !any(no_axes %in% vc$x$type), 
    axe_y = !any(no_axes %in% vc$x$type)
  )
  vc$x$specs$region <- create_region(n)
  vc$x$specs$indicator <- create_indicator(facets_values, label_fun = labeller)
  vc$x$specs$data <- create_facet_data(vc, facet = facets_values)
  vc$x$specs$series <- create_facet_series(vc, facet = facets_values)
  x <- get_aes_data(extract_data(vc), c("x", "xmin", "xmax"))
  y <- get_aes_data(extract_data(vc), c("y", "ymin", "ymax"))
  vc$x$specs$axes <- c(
    create_axis_x(vc, x = x, facet = facets_values, free = scales %in% c("free", "free_x"), last_row = get_last_row(mat)),
    create_axis_y(vc, y = y, facet = facets_values, free = scales %in% c("free", "free_y"), first_col = mat[, 1])
  )
  return(vc)
}



create_layout <- function(ncol,
                          nrow,
                          title = FALSE,
                          axe_x = TRUE,
                          axe_y = TRUE) {
  
  create_matrix <- function(data, byrow) {
    matrix(data = data, nrow = nrow, ncol = ncol, byrow = byrow)
  }
  
  n <- ncol * nrow
  
  mat <- matrix(data = seq_len(n), nrow = nrow, ncol = ncol, byrow = TRUE)
  mat_axe_y_col <- create_matrix(rep(0 + ((seq_len(ncol) - 1) * 2), rep = nrow), TRUE)
  mat_axe_y_row <- create_matrix(rep(1 + ((seq_len(nrow) - 1) * 3), rep = ncol), FALSE) + title
  mat_axe_x_col <- create_matrix(rep(1 + ((seq_len(ncol) - 1) * 2), rep = nrow), TRUE)
  mat_axe_x_row <- create_matrix(rep(2 + ((seq_len(nrow) - 1) * 3), rep = ncol), FALSE) + title
  mat_chart_col <- create_matrix(rep(axe_x + ((seq_len(ncol) - 1) * (1 + axe_y)), rep = nrow), TRUE)
  mat_chart_row <- create_matrix(rep(1 + ((seq_len(nrow) - 1) * (2 + axe_x)), rep = ncol), FALSE) + title
  mat_ind_col <- create_matrix(rep(0 + ((seq_len(ncol) - 1) * (1 + axe_y)), rep = nrow), TRUE)
  mat_ind_row <- create_matrix(rep(0 + ((seq_len(nrow) - 1) * (2 + axe_x)), rep = ncol), FALSE) + title
  
  list(
    type = "grid",
    col = ncol + ncol * axe_x,
    row = nrow * 2 + nrow * axe_y + title,
    rowHeight = lapply(
      X = title + (seq_len(nrow) - 1) * (2 + axe_x),
      FUN = function(index) {
        list(index = index, size = 30)
      }
    ),
    elements = c(
      if (title) {
        list(list(modelId = "title", col = 0, row = 0, colSpan = ncol * 2))
      },
      if (isTRUE(axe_y)) {
        lapply(
          X = seq_len(n),
          FUN = function(num) {
            mat_num <- which(mat == num, arr.ind = TRUE, useNames = FALSE)
            i <- mat_num[1, 1]
            j <- mat_num[1, 2]
            list(
              modelId = paste0("axe_y_", num),
              col = mat_axe_y_col[i, j],
              row = mat_axe_y_row[i, j]
            )
          }
        )
      },
      if (isTRUE(axe_x)) {
        lapply(
          X = seq_len(n),
          FUN = function(num) {
            mat_num <- which(mat == num, arr.ind = TRUE, useNames = FALSE)
            i <- mat_num[1, 1]
            j <- mat_num[1, 2]
            list(
              modelId = paste0("axe_x_", num),
              col = mat_axe_x_col[i, j],
              row = mat_axe_x_row[i, j]
            )
          }
        )
      },
      lapply(
        X = seq_len(n),
        FUN = function(num) {
          mat_num <- which(mat == num, arr.ind = TRUE, useNames = FALSE)
          i <- mat_num[1, 1]
          j <- mat_num[1, 2]
          list(
            modelId = paste0("chart_", num),
            col = mat_chart_col[i, j],
            row = mat_chart_row[i, j]
          )
        }
      ),
      lapply(
        X = seq_len(n),
        FUN = function(num) {
          mat_num <- which(mat == num, arr.ind = TRUE, useNames = FALSE)
          i <- mat_num[1, 1]
          j <- mat_num[1, 2]
          list(
            modelId = paste0("indicator_", num),
            col = mat_ind_col[i, j],
            row = mat_ind_row[i, j],
            colSpan = 1 + axe_y
          )
        }
      )
    )
  )
}


create_region <- function(n) {
  c(
    lapply(
      X = seq_len(n),
      FUN = function(i) {
        list(id = paste0("chart_", i))
      }
    ),
    lapply(
      X = seq_len(n),
      FUN = function(i) {
        list(id = paste0("indicator_", i))
      }
    )
  )
}


create_facet_data <- function(vc, facet) {
  list_data <- lapply(
    X = seq_along(vc$x$specs$data),
    FUN = function(i) {
      split_data <- split(vc$x$specs$data[[i]]$values, f = facet$facet_id)
      lapply(
        X = seq_along(split_data),
        FUN = function(ii) {
          list(
            id = paste0("data_", ii, "_", i),
            name = get_facet_name(facet, names(split_data)[ii]),
            values = split_data[[ii]]
          )
        }
      )
    }
  )
  Reduce(f = "c", list_data)
}



create_facet_series <- function(vc, facet) {
  list_data <- lapply(
    X = unique(facet$facet_id),
    FUN = function(id) {
      serie <- vc$x$specs$series
      lapply(
        X = seq_along(serie),
        FUN = function(i) {
          this <- serie[[i]]
          this$id <- paste0("serie_", id, "_", i)
          this$dataId <- paste0("data_", id, "_", i)
          this$regionId <- paste0("chart_", id)
          return(this)
        }
      )
    }
  )
  Reduce(f = "c", list_data)
}


create_indicator <- function(facet, label_fun = ggplot2::label_value) {
  lapply(
    X = unique(facet$facet_id),
    FUN = function(id) {
      value <- get_facet_name(facet, id, use_names = TRUE)
      value <- label_fun(value)
      regionId <- paste0("indicator_", id)
      if (is.null(value) || all(is.na(value))) {
        return(list(regionId = regionId, visible = FALSE))
      }
      list(
        regionId = regionId,
        visible = TRUE,
        content = list(
          style = list(
            text = unname(value),
            textAlign = "center",
            fontSize = 16
          )
        )
      )
    }
  )
}



create_axis_x <- function(vc, x, facet, free = TRUE, last_row = numeric(0)) {
  index <- get_axes_index(vc, position = "bottom")
  axe_x <- vc$x$specs$axes[[index]]
  lapply(
    X = unique(facet$facet_id),
    FUN = function(id) {
      this <- axe_x
      this$id <- paste0("axe_x_", id)
      this$regionId <- paste0("chart_", id)
      if (is.numeric(x) & isFALSE(free)) {
        valrange <-  scales::expand_range(
          range = range(x, na.rm = TRUE),
          mul = 0.05,
          add = 0
        )
        this$softMin <- valrange[1]
        this$softMax <- valrange[2]
      }
      this$label$visible <- isTRUE(free) | id %in% last_row
      this$domainLine$visible <- isTRUE(free) | id %in% last_row
      this$minHeight <- ifelse(isTRUE(free), 30, 20)
      return(this)
    }
  )
}




create_axis_y <- function(vc, y, facet, free = TRUE, first_col = numeric(0)) {
  index <- get_axes_index(vc, position = "left")
  axe_y <- vc$x$specs$axes[[index]]
  lapply(
    X = unique(facet$facet_id),
    FUN = function(id) {
      this <- axe_y
      this$id <- paste0("axe_y_", id)
      this$regionId <- paste0("chart_", id)
      if (is.numeric(y) & isFALSE(free)) {
        valrange <-  scales::expand_range(
          range = range(y, na.rm = TRUE),
          mul = 0.05,
          add = 0
        )
        this$softMin <- valrange[1]
        this$softMax <- valrange[2]
      }
      this$label$visible <- isTRUE(free) | id %in% first_col
      this$domainLine$visible <- isTRUE(free) | id %in% first_col
      this$minWidth <- ifelse(isTRUE(free), 35, 20)
      return(this)
    }
  )
}



get_facets_dims <- function(n, nrow = NULL, ncol = NULL) {
  if (is.null(nrow) & !is.null(ncol))
    nrow <- ceiling(n / ncol)
  if (!is.null(nrow) & is.null(ncol))
    ncol <- ceiling(n / nrow)
  if (is.null(nrow) & is.null(ncol)) {
    if (n %% 3 < 1) {
      ncol <- 3
      nrow <- ceiling(n / ncol)
    } else {
      ncol <- 2
      nrow <- ceiling(n / ncol)
    }
  }
  list(nrow = nrow, ncol = ncol)
}


#' @importFrom rlang as_label
get_facets_values <- function(data, facets) {
  facet_data <- eval_mapping_(data, facets)
  names(facet_data) <- vapply(facets, as_label, FUN.VALUE = character(1))
  facet_data$facet_id <- as.numeric(interaction(facet_data, drop = TRUE))
  return(facet_data)
}

#' @importFrom utils head
get_facet_name <- function(facet, id, use_names = FALSE) {
  unlist(head(facet[facet$facet_id == id, -ncol(facet)], 1), use.names = use_names)
}



get_last_row <- function(mat) {
  apply(X = mat, MARGIN = 2, FUN = function(x) {
    x <- x[!is.na(x)]
    x[length(x)]
  })
}


