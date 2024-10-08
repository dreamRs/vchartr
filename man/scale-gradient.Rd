% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scales.R
\name{scale-gradient}
\alias{scale-gradient}
\alias{v_scale_colour_gradient}
\alias{v_scale_fill_gradient}
\title{Color scale for continuous data}
\usage{
v_scale_colour_gradient(
  vc,
  name = NULL,
  low = "#132B43",
  high = "#56B1F7",
  limits = NULL,
  position = c("right", "bottom", "left", "top"),
  align = c("middle", "start", "end")
)

v_scale_fill_gradient(
  vc,
  name = NULL,
  low = "#132B43",
  high = "#56B1F7",
  limits = NULL,
  position = c("right", "bottom", "left", "top"),
  align = c("middle", "start", "end")
)
}
\arguments{
\item{vc}{An htmlwidget created with \code{\link[=vchart]{vchart()}} or specific chart's type function.}

\item{name}{Title for the legend.}

\item{low, high}{Colours for low and high ends of the gradient.}

\item{limits}{Limits of the scale, default (\code{NULL}) is to use the default scale range of the data.}

\item{position}{Position of the legend.}

\item{align}{Alignment of the legend.}
}
\value{
A \code{\link[=vchart]{vchart()}} \code{htmlwidget} object.
}
\description{
Color scale for continuous data
}
\examples{

library(vchartr)
data("penguins", package = "palmerpenguins")

vchart(penguins) \%>\%
  v_scatter(aes(
    x = bill_length_mm, 
    y = bill_depth_mm,
    color = body_mass_g
  )) \%>\% 
  v_scale_colour_gradient(
    name = "Body mass",
    low = "yellow",
    high = "red"
  )
}
