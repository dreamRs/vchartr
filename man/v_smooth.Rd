% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layers.R
\name{v_smooth}
\alias{v_smooth}
\title{Create an Smooth Line Chart}
\usage{
v_smooth(
  vc,
  mapping = NULL,
  data = NULL,
  name = NULL,
  method = NULL,
  formula = NULL,
  se = TRUE,
  n = 80,
  span = 0.75,
  ...,
  args_area = NULL,
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

\item{method}{Smoothing method (function) to use, accepts either
\code{NULL} or a character vector, e.g. \code{"lm"}, \code{"glm"}, \code{"gam"}, \code{"loess"}
or a function, e.g. \code{MASS::rlm} or \code{mgcv::gam}, \code{stats::lm}, or \code{stats::loess}.
\code{"auto"} is also accepted for backwards compatibility.  It is equivalent to
\code{NULL}.

For \code{method = NULL} the smoothing method is chosen based on the
size of the largest group (across all panels). \code{\link[stats:loess]{stats::loess()}} is
used for less than 1,000 observations; otherwise \code{\link[mgcv:gam]{mgcv::gam()}} is
used with \code{formula = y ~ s(x, bs = "cs")} with \code{method = "REML"}. Somewhat anecdotally,
\code{loess} gives a better appearance, but is \eqn{O(N^{2})}{O(N^2)} in memory,
so does not work for larger datasets.

If you have fewer than 1,000 observations but want to use the same \code{gam()}
model that \code{method = NULL} would use, then set
\verb{method = "gam", formula = y ~ s(x, bs = "cs")}.}

\item{formula}{Formula to use in smoothing function, eg. \code{y ~ x},
\code{y ~ poly(x, 2)}, \code{y ~ log(x)}. \code{NULL} by default, in which case
\code{method = NULL} implies \code{formula = y ~ x} when there are fewer than 1,000
observations and \code{formula = y ~ s(x, bs = "cs")} otherwise.}

\item{se}{Display confidence interval around smooth? (\code{TRUE} by default, see
\code{level} to control.)}

\item{n}{Number of points at which to evaluate smoother.}

\item{span}{Controls the amount of smoothing for the default loess smoother.
Smaller numbers produce wigglier lines, larger numbers produce smoother
lines. Only used with loess, i.e. when \code{method = "loess"},
or when \code{method = NULL} (the default) and there are fewer than 1,000
observations.}

\item{...}{Additional parameters for lines.}

\item{args_area}{Arguments for area.}

\item{data_id, serie_id}{ID for the data/serie, can be used to further customize the chart with \code{\link[=v_specs]{v_specs()}}.}
}
\value{
A \code{\link[=vchart]{vchart()}} \code{htmlwidget} object.
}
\description{
Create an Smooth Line Chart
}
\examples{

library(vchartr)

data("mpg", package =  "ggplot2")

vchart(mpg, aes(displ, hwy)) \%>\%
  v_smooth()

vchart(mpg, aes(displ, hwy)) \%>\%
  v_smooth(se = FALSE)

vchart(mpg, aes(displ, hwy, color = class)) \%>\%
  v_smooth()

}
