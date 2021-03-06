% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/houseRange.R
\name{pm_houseRange_detect}
\alias{pm_houseRange_detect}
\title{Detect Presence of House Range}
\usage{
pm_houseRange_detect(.data)
}
\arguments{
\item{.data}{A postmastr object created with \link{pm_prep}}
}
\value{
A tibble with a new logical variable \code{pm.hasHouse} that is
    \code{TRUE} if a house number is found in the first word of the address
    and \code{FALSE} otherwise.
}
\description{
Determine the presence of a houge range in a string.
}
\details{
A house range is used in some parts of the United States.
   House ranges typically look like \code{121-123 Main St}.
}
