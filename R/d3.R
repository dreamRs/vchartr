
#' Format numbers and dates with D3
#'
#' @param format Format for numbers, currency, percentage, e.g. `".0\%"` for rounded percentage.
#'  See online documentation : [https://github.com/d3/d3-format](https://github.com/d3/d3-format).
#' @param prefix Character string to append before formatted value.
#' @param suffix Character string to append after formatted value.
#' @param locale Localization to use, for example `"fr-FR"` for french,
#'  see possible values here: [https://github.com/d3/d3-format/tree/master/locale](https://github.com/d3/d3-format/tree/master/locale).
#'
#' @return a `JS` function.
#' @export
#'
#' @name d3-format
#'
#' @importFrom htmlwidgets JS
#'
#' @example examples/format.R
d3_format <- function(format, prefix = "", suffix = "", locale = "en-US") {
  check_locale_d3(locale)
  path <- system.file(file.path("d3-format-locale", paste0(locale, ".json")), package = "vchartr")
  if (path != "") {
    locale <- paste(readLines(con = path, encoding = "UTF-8"), collapse = "")
  }
  JS(sprintf(
    "function(value) {var locale = d3_format_locale(JSON.parse('%s')); return '%s' + locale.format('%s')(value) + '%s';}",
    locale, prefix, format, suffix
  ))
}

#' @export
#'
#' @rdname d3-format
d3_format_time <- function(format, prefix = "", suffix = "", locale = "en-US") {
  check_locale_d3(locale, path = "d3-time-format-locale")
  path <- system.file(file.path("d3-time-format-locale", paste0(locale, ".json")), package = "vchartr")
  if (path != "") {
    locale <- paste(readLines(con = path, encoding = "UTF-8"), collapse = "")
  }
  JS(sprintf(
    "function(value) {var locale = d3_time_format_locale(JSON.parse('%s')); return '%s' + locale.format('%s')(value) + '%s';}",
    locale, prefix, format, suffix
  ))
}


check_locale_d3 <- function(x, path = "d3-format-locale") {
  json <- list.files(system.file(path, package = "vchartr"))
  njson <- gsub("\\.json", "", json)
  if (!x %in% njson) {
    stop(paste(
      "Invalid D3 locale, must be one of:",
      paste(njson, collapse = ", ")
    ), call. = FALSE)
  }
}





