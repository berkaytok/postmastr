% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mutate.R
\name{pm_mutate}
\alias{pm_mutate}
\title{Modify Improperly Parsed Addresses}
\usage{
pm_mutate(.data, uid, address, house, house_range, house_frac, house_suf,
    pre_dir, street, street_suf, suf_dir, unit_type, unit_num,
    city, state, postal, locale = "us")
}
\arguments{
\item{.data}{A postmastr object created with \link{pm_prep}}

\item{uid}{A \code{pm.uid} value to edit.}

\item{address}{Optional; the new value for the \code{pm.address} variable.}

\item{house}{Optional; the new value for the \code{pm.house} variable.}

\item{house_range}{Optional; the new value (or vector) for the \code{pm.houseRange}
variable.}

\item{house_frac}{Optional; the new value for the \code{pm.houseFrac} variable.}

\item{house_suf}{Optional; the new value for the \code{pm.houseSuf} variable.}

\item{pre_dir}{Optional; the new value for the \code{pm.preDir} variable.}

\item{street}{Optional; the new value for the \code{pm.street} variable.}

\item{street_suf}{Optional; the new value for the \code{pm.streetSuf} variable.}

\item{suf_dir}{Optional; the new value for the \code{pm.sufDir} variable.}

\item{unit_type}{Optional; the new value for the \code{pm.unitType} variable.}

\item{unit_num}{Optional; the new value (or vector) for the \code{pm.unitNum}
variable.}

\item{city}{Optional; the new value for the \code{pm.city} variable.}

\item{state}{Optional; the new value for the \code{pm.state} variable.}

\item{postal}{Optional; the new value for the \code{pm.postal} variable.}

\item{locale}{A string indicating the country these data represent; the only
current option is "us" but this is included to facilitate future expansion.}
}
\description{
Difficult to parse addresses, particularly those that have
   alphanumeric house ranges as well as units associated with them,
   may be mis-parsed by \code{postmastr}. This function can be used
   to manually fix mis-parsed address data.
}
