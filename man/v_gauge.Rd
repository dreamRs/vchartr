% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layers.R
\name{v_gauge}
\alias{v_gauge}
\title{Create a Gauge Chart}
\usage{
v_gauge(
  vc,
  mapping = NULL,
  data = NULL,
  name = NULL,
  outerRadius = 0.8,
  innerRadius = 0.75,
  startAngle = -240,
  endAngle = 60,
  ...,
  serie_id = NULL,
  data_id = NULL
)
}
\arguments{
\item{vc}{A chart initialized with \code{\link[=vchart]{vchart()}}.}

\item{mapping}{Default list of aesthetic mappings to use for chart.}

\item{data}{Default dataset to use for chart. If not already
a \code{data.frame}, it will be coerced to with \code{as.data.frame}.}

\item{name}{Name for the serie, only used for single serie (no \code{color}/\code{fill} aesthetic supplied).}

\item{outerRadius}{Sector outer radius, with a numerical range of 0 - 1.}

\item{innerRadius}{Sector inner radius, with a numerical range of 0 - 1.}

\item{startAngle}{Starting angle of the sector. In degrees.}

\item{endAngle}{Ending angle of the sector. In degrees.}

\item{...}{Additional parameters for the serie.}

\item{data_id, serie_id}{ID for the data/serie, can be used to further customize the chart with \code{\link[=v_specs]{v_specs()}}.}
}
\value{
A \code{\link[=vchart]{vchart()}} \code{htmlwidget} object.
}
\description{
Create a Gauge Chart
}
\examples{

library(vchartr)

vchart() \%>\%
  v_gauge(aes("My gauge", 0.8))

vchart() \%>\%
  v_gauge(
    aes("My gauge", 0.8),
    gauge = list(
      type = "circularProgress",
      cornerRadius = 20,
      progress = list(
        style = list(
          fill = "forestgreen"
        )
      ),
      track = list(
        style = list(
          fill = "#BCBDBC"
        )
      )
    ),
    pointer = list(
      style = list(
        fill = "#2F2E2F"
      )
    )
  )


vchart() \%>\%
  v_gauge(aes("My gauge", 0.8)) \%>\%
  v_scale_y_continuous(labels = ".0\%")
}
