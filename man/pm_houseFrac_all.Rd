% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/houseFrac.R
\name{pm_houseFrac_all}
\alias{pm_houseFrac_all}
\title{Do All Addresses Have House Numbers}
\usage{
pm_houseFrac_all(.data)
}
\arguments{
\item{.data}{A postmastr object created with \link{pm_prep}}
}
\value{
A logical scalar is returned that is \code{TRUE} if all observations contain
    fractional house numbers and \code{FALSE} otherwise.
}
\description{
Determine whether the fractional house number test returns matches for every
    observation.
}
\details{
A fractional house number is used in some parts of the United States.
   Fractional house numbers typically look like \code{123 1/2 Main St}.
   The U.S.P.S allows any fraction, though \code{1/2} appears commonly.
}
