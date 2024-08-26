

create_layout <- function(ncol, nrow) {

  create_matrix <- function(data, byrow) {
    matrix(data = data, nrow = nrow, ncol = ncol, byrow = byrow)
  }

  n <- ncol * nrow

  mat <- matrix(data = seq_len(n), nrow = nrow, ncol = ncol, byrow = TRUE)
  mat_axe_y_col <- create_matrix(rep(0 + ((seq_len(ncol) - 1) * 2), rep = nrow), TRUE)
  mat_axe_y_row <- create_matrix(rep(1 + ((seq_len(nrow) - 1) * 3), rep = ncol), FALSE)
  mat_axe_x_col <- create_matrix(rep(1 + ((seq_len(ncol) - 1) * 2), rep = nrow), TRUE)
  mat_axe_x_row <- create_matrix(rep(2 + ((seq_len(nrow) - 1) * 3), rep = ncol), FALSE)
  mat_chart_col <- create_matrix(rep(1 + ((seq_len(ncol) - 1) * 2), rep = nrow), TRUE)
  mat_chart_row <- create_matrix(rep(1 + ((seq_len(nrow) - 1) * 3), rep = ncol), FALSE)
  mat_ind_col <- create_matrix(rep(0 + ((seq_len(ncol) - 1) * 2), rep = nrow), TRUE)
  mat_ind_row <- create_matrix(rep(0 + ((seq_len(nrow) - 1) * 3), rep = ncol), FALSE)

  list(
    type = "grid",
    col = ncol * 2,
    row = nrow * 3,
    rowHeight = lapply(
      X = 0 + (seq_len(nrow) - 1) * 3,
      FUN = function(index) {
        list(index = index, size = 30)
      }
    ),
    elements = c(
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
      ),
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
      ),
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
            colSpan = 2
          )
        }
      )
    )
  )
}


create_region <- function(ncol, nrow) {
  mat <- matrix(data = seq_len(ncol * nrow), nrow = nrow, ncol = ncol, byrow = TRUE)
  n <- length(mat)
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
      split_data <- split(vc$x$specs$data[[i]]$values, f = as.character(facet))
      lapply(
        X = seq_along(split_data),
        FUN = function(ii) {
          list(
            id = paste0("data_", ii, "_", i),
            name = names(split_data)[ii],
            values = split_data[[ii]]
          )
        }
      )
    }
  )
  Reduce(f = "c", list_data)
}



create_facet_series <- function(vc, facet) {
  facets <- unique(as.character(facet))
  list_data <- lapply(
    X = seq_along(facets),
    FUN = function(i) {
      serie <- vc$x$specs$series
      lapply(
        X = seq_along(serie),
        FUN = function(ii) {
          this <- serie[[ii]]
          this$id <- paste0("serie_", i, "_", ii)
          this$dataId <- paste0("data_", i, "_", ii)
          this$regionId <- paste0("chart_", i)
          return(this)
        }
      )
    }
  )
  Reduce(f = "c", list_data)
}


create_indicator <- function(facet, label_fun = identity) {
  values <- unique(facet)
  lapply(
    X = seq_along(values),
    FUN = function(i) {
      value <- label_fun(values[i])
      regionId <- paste0("indicator_", i)
      if (is.null(value) || is.na(value)) {
        return(list(regionId = regionId, visible = FALSE))
      }
      if (is.character(value)) {
        return(list(
          regionId = regionId,
          visible = TRUE,
          title = list(
            style = list(
              text = value,
              textAlign = "center",
              fontSize = 16
            )
          )
        ))
      }
      list(
        regionId = regionId,
        visible = TRUE,
        title = list(style = value)
      )
    }
  )
}

