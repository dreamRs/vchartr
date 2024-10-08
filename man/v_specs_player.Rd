% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/specs.R
\name{v_specs_player}
\alias{v_specs_player}
\title{Set player options}
\usage{
v_specs_player(vc, ...)
}
\arguments{
\item{vc}{An htmlwidget created with \code{\link[=vchart]{vchart()}}.}

\item{...}{Options for the legend, see examples or
\href{https://www.visactor.io/vchart/option/commonChart#player}{online documentation}.}
}
\value{
A \code{\link[=vchart]{vchart()}} \code{htmlwidget} object.
}
\description{
Set player options
}
\examples{

library(vchartr)

world_electricity \%>\% 
  subset(type == "detail") \%>\% 
  vchart() \%>\%
  v_bar(
    aes(source, generation, player = year)
  )


}
