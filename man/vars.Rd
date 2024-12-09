% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reexports.R
\name{vars}
\alias{vars}
\title{Quote faceting variables}
\usage{
vars(...)
}
\arguments{
\item{...}{<\code{\link[rlang:topic-data-mask]{data-masking}}> Variables or
expressions automatically quoted. These are evaluated in the context of the
data to form faceting groups. Can be named (the names are passed to a
\link[ggplot2:labellers]{labeller}).}
}
\value{
A list with class \code{uneval}. Components of the list are either quosures or constants.
}
\description{
See \code{\link[ggplot2:vars]{ggplot2::vars()}} for details.
}
\keyword{internal}
