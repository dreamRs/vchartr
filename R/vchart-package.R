#' An `htmlwidget` interface to the
#' VChart javascript chart library
#'
#' This package allow you to use VChart.js ([https://www.visactor.io/vchart](https://www.visactor.io/vchart)),
#' to create interactive charts.
#'
#' @name vchartr-package
#' @author Victor Perrier (@@dreamRs_fr)
"_PACKAGE"

#' vchartr exported operators and S3 methods
#'
#' The following functions are imported and then re-exported
#' from the vchartr package to avoid listing the magrittr
#' as Depends of vchartr
#'
#' @name vchartr-exports
NULL

#' @importFrom magrittr %>%
#' @name %>%
#' @export
#' @rdname vchartr-exports
NULL

#' @importFrom ggplot2 aes
#' @name aes
#' @export
#' @rdname vchartr-exports
NULL

#' @importFrom ggplot2 vars
#' @name vars
#' @export
#' @rdname vchartr-exports
NULL

#' @importFrom ggplot2 label_value
#' @name label_value
#' @export
#' @rdname vchartr-exports
NULL

#' @importFrom htmlwidgets JS
#' @name JS
#' @export
#' @rdname vchartr-exports
NULL
