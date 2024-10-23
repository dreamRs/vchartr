
#' Theme for Charts
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param .colorPalette Vector of colors to use as default.
#' @param .backgroundColor background Color
#' @param .borderColor border Color
#' @param .shadowColor shadow Color
#' @param .hoverBackgroundColor hoverBackground Color
#' @param .sliderRailColor slider Rail Color
#' @param .sliderHandleColor slider Handle Color
#' @param .sliderTrackColor slider Track Color
#' @param .popupBackgroundColor popup Background Color
#' @param .primaryFontColor primary Font Color
#' @param .secondaryFontColor secondary Font Color
#' @param .tertiaryFontColor tertiary Font Color
#' @param .axisLabelFontColor axisLabel Font Color
#' @param .disableFontColor disable Font Color
#' @param .axisMarkerFontColor axis Marker Font Color
#' @param .axisGridColor axis Grid Color
#' @param .axisDomainColor axis Domain Color
#' @param .dataZoomHandleStrokeColor data Zoom Handle Stroke Color
#' @param .dataZoomChartColor data Zoom Chart Color
#' @param .playerControllerColor player Controller Color
#' @param .scrollBarSliderColor scroll Bar Slider Color
#' @param .axisMarkerBackgroundColor axis Marker Background Color
#' @param .markLabelBackgroundColor mark Label Background Color
#' @param .markLineStrokeColor mark Line Stroke Color
#' @param .dangerColor danger Color
#' @param .warningColor warning Color
#' @param .successColor success Color
#' @param .infoColor info Color
#' @param .discreteLegendPagerTextColor discrete Legend Pager Text Color
#' @param .discreteLegendPagerHandlerColor discrete Legend Pager Handler Color
#' @param .discreteLegendPagerHandlerDisableColor discrete LegendP ager Handler Disable Color
#' @param ... Other parameters.
#'
#' @return A [vchart()] `htmlwidget` object.
#' @export
#'
#' @example examples/theme.R
v_theme <- function(vc,
                    .colorPalette = NULL,
                    .backgroundColor = NULL,
                    .borderColor = NULL,
                    .shadowColor = NULL,
                    .hoverBackgroundColor = NULL,
                    .sliderRailColor = NULL,
                    .sliderHandleColor = NULL,
                    .sliderTrackColor = NULL,
                    .popupBackgroundColor = NULL,
                    .primaryFontColor = NULL,
                    .secondaryFontColor = NULL,
                    .tertiaryFontColor = NULL,
                    .axisLabelFontColor = NULL,
                    .disableFontColor = NULL,
                    .axisMarkerFontColor = NULL,
                    .axisGridColor = NULL,
                    .axisDomainColor = NULL,
                    .dataZoomHandleStrokeColor = NULL,
                    .dataZoomChartColor = NULL,
                    .playerControllerColor = NULL,
                    .scrollBarSliderColor = NULL,
                    .axisMarkerBackgroundColor = NULL,
                    .markLabelBackgroundColor = NULL,
                    .markLineStrokeColor = NULL,
                    .dangerColor = NULL,
                    .warningColor = NULL,
                    .successColor = NULL,
                    .infoColor = NULL,
                    .discreteLegendPagerTextColor = NULL,
                    .discreteLegendPagerHandlerColor = NULL,
                    .discreteLegendPagerHandlerDisableColor = NULL,
                    ...) {
  palette <- list_(
    backgroundColor = .backgroundColor,
    borderColor = .borderColor,
    shadowColor = .shadowColor,
    hoverBackgroundColor = .hoverBackgroundColor,
    sliderRailColor = .sliderRailColor,
    sliderHandleColor = .sliderHandleColor,
    sliderTrackColor = .sliderTrackColor,
    popupBackgroundColor = .popupBackgroundColor,
    primaryFontColor = .primaryFontColor,
    secondaryFontColor = .secondaryFontColor,
    tertiaryFontColor = .tertiaryFontColor,
    axisLabelFontColor = .axisLabelFontColor,
    disableFontColor = .disableFontColor,
    axisMarkerFontColor = .axisMarkerFontColor,
    axisGridColor = .axisGridColor,
    axisDomainColor = .axisDomainColor,
    dataZoomHandleStrokeColor = .dataZoomHandleStrokeColor,
    dataZoomChartColor = .dataZoomChartColor,
    playerControllerColor = .playerControllerColor,
    scrollBarSliderColor = .scrollBarSliderColor,
    axisMarkerBackgroundColor = .axisMarkerBackgroundColor,
    markLabelBackgroundColor = .markLabelBackgroundColor,
    markLineStrokeColor = .markLineStrokeColor,
    dangerColor = .dangerColor,
    warningColor = .warningColor,
    successColor = .successColor,
    infoColor = .infoColor,
    discreteLegendPagerTextColor = .discreteLegendPagerTextColor,
    discreteLegendPagerHandlerColor = .discreteLegendPagerHandlerColor,
    discreteLegendPagerHandlerDisableColor = .discreteLegendPagerHandlerDisableColor
  )
  options <- list(...)
  if (length(palette) > 0)
    options$colorScheme$default$palette <- palette
  if (!is.null(.colorPalette))
    options$colorScheme$default$dataScheme[[1]]$scheme <- unname(.colorPalette)
  .vchart_specs(
    vc = vc,
    name = "theme",
    options = options
  )
}



#' Builtin themes for Charts
#'
#' @param vc An htmlwidget created with [vchart()].
#' @param name Name of the theme to use, see [available themes online](https://www.visactor.io/vchart/guide/tutorial_docs/Theme/Theme_Extension).
#'
#' @return A [vchart()] `htmlwidget` object.
#' @noRd
#'
#' @example examples/theme_builtin.R
v_theme_builtin <- function(vc, name) {
  stopifnot(
    "'vc' must be a 'vchart' htmlwidget object" = inherits(vc, "vchart")
  )
  vc$x$theme <- name
  return(vc)
}

