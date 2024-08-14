
#' Format numbers with D3
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
#'
#' @importFrom htmlwidgets JS
#'
#' @example examples/format-numbers.R
format_num_d3 <- function(format, prefix = "", suffix = "", locale = "en-US") {
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


label_format_num <- function(fmt, aesthetic) {
  if (is.null(fmt))
    return(JS(sprintf("value => value.hasOwnProperty('%1$s') ? value.%1$s : value;", aesthetic)))
  if (!inherits(fmt, c("JS_EVAL", "character"))) {
    stop("vchart scale continuous : `labels` must either be a character or a JS function.", call. = FALSE)
  }
  if (!inherits(fmt, "JS_EVAL"))
    fmt <- format_num_d3(fmt)
  JS(
    "function(value) {",
    sprintf("var num = value.hasOwnProperty('%1$s') ? value.%1$s : value;", aesthetic),
    sprintf("const fun = %s;", fmt),
    "return fun(num);",
    "}"
  )
}




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



#' Format date with dayjs JavaScript library
#'
#' @param format Format for dates, see [online documentation](https://day.js.org/docs/en/display/format).
#' @param prefix Character string to append before formatted value.
#' @param suffix Character string to append after formatted value.
#' @param locale Localization to use, for example `"fr"` for french,
#'  see possible values [online](https://cdn.jsdelivr.net/npm/dayjs@1/locale.json).
#' @param tz Timezone to use.
#'
#' @return a `JS` function.
#' @export
#' 
#' @name format-date
#'
#' @example examples/format-dates.R
format_date_dayjs <- function(format, prefix = "", suffix = "", locale = "en") {
  JS(sprintf(
    "function(value) {return '%s' + dayjs(value).locale('%s').format('%s') + '%s';}",
    prefix, locale, format, suffix
  ))
}

#' @export
#' 
#' @rdname format-date
format_datetime_dayjs <- function(format, prefix = "", suffix = "", locale = "en", tz = NULL) {
  if (is.null(tz))
    return(format_date_dayjs(format, prefix, suffix, locale))
  JS(sprintf(
    "function(value) {return '%s' + dayjs(value).tz('%s').locale('%s').format('%s') + '%s';}",
    prefix, tz, locale, format, suffix
  ))
}


label_format_date <- function(fmt) {
  if (!inherits(fmt, c("JS_EVAL", "character"))) {
    stop("vchart scale date : `date_labels` must either be a character or a JS function.", call. = FALSE)
  }
  if (!inherits(fmt, "JS_EVAL"))
    fmt <- format_date_dayjs(fmt)
  JS(
    "function(value) {",
    "var num = value.hasOwnProperty('x') ? value.x : value;",
    "var date = new Date(num * 3600 * 24 * 1000);",
    sprintf("const fun = %s;", fmt),
    "return fun(date);",
    "}"
  )
}


label_format_datetime <- function(fmt, tz = NULL) {
  if (!inherits(fmt, c("JS_EVAL", "character"))) {
    stop("vchart scale date : `date_labels` must either be a character or a JS function.", call. = FALSE)
  }
  if (!inherits(fmt, "JS_EVAL"))
    fmt <- format_datetime_dayjs(fmt, tz = tz)
  JS(
    "function(value) {",
    "var num = value.hasOwnProperty('x') ? value.x : value;",
    "var date = new Date(num * 1000);",
    sprintf("const fun = %s;", fmt),
    "return fun(date);",
    "}"
  )
}


