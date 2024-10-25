
#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
NULL

#' Mark character strings as literal JavaScript code
#'
#' See [htmlwidgets::JS()] for details.
#'
#' @name JS
#' @keywords internal
#' @export
#' @importFrom htmlwidgets JS
#' @usage JS(...)
#' @inheritParams htmlwidgets::JS
#' @return A string that will be interpreted as JavaScript code in htmlwidgets.
NULL

#' Construct aesthetic mappings
#'
#' See [ggplot2::aes()] for details.
#'
#' @name aes
#' @keywords internal
#' @export
#' @importFrom ggplot2 aes
#' @usage aes(x, y, ...)
#' @inheritParams ggplot2::aes
#' @return A list with class `uneval`. Components of the list are either quosures or constants. 
NULL

#' Quote faceting variables
#'
#' See [ggplot2::vars()] for details.
#'
#' @name vars
#' @keywords internal
#' @export
#' @importFrom ggplot2 vars
#' @usage vars(...)
#' @inheritParams ggplot2::vars
#' @return A list with class `uneval`. Components of the list are either quosures or constants. 
NULL

#' Useful labeller functions
#'
#' See [ggplot2::label_value()] for details.
#'
#' @name label_value
#' @keywords internal
#' @export
#' @importFrom ggplot2 label_value
#' @usage label_value(labels, multi_line = TRUE)
#' @inheritParams ggplot2::label_value
#' @return Labels to be used in a facetted chart.
NULL
