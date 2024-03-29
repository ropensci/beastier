% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_can_create_state_output_file.R
\name{check_can_create_state_output_file}
\alias{check_can_create_state_output_file}
\title{Internal function}
\usage{
check_can_create_state_output_file(beast2_options)
}
\arguments{
\item{beast2_options}{a set of BEAST2 options,
that are the R equivalent of the BEAST2 command-line options,
as can be created by \link{create_beast2_options}}
}
\value{
Nothing.
Will \link{stop} if the state output file cannot be created.
}
\description{
Check if the state output file
can be created. Will \link{stop} otherwise
}
\author{
Richèl J.C. Bilderbeek
}
