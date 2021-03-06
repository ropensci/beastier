% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_beast2_options.R
\name{check_beast2_options_data_types}
\alias{check_beast2_options_data_types}
\title{Check if the \code{beast2_options}, which is a list,
has all elements of the right data types}
\usage{
check_beast2_options_data_types(beast2_options)
}
\arguments{
\item{beast2_options}{a set of BEAST2 options,
that are the R equivalent of the BEAST2 command-line options,
as can be created by \link{create_beast2_options}}
}
\value{
nothing
}
\description{
Calls \code{stop} if not.
}
\seealso{
Use \link{check_beast2_options} to check
  the entire \code{beast2_options} object
}
\author{
Richèl J.C. Bilderbeek
}
