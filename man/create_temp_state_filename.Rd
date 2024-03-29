% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_temp_state_filename.R
\name{create_temp_state_filename}
\alias{create_temp_state_filename}
\title{Create a temporary file for the BEAST2 XML output file that
stores its state.}
\usage{
create_temp_state_filename()
}
\value{
a temporary filename, that starts with `beast2_`
and has extension `.xml.state`
}
\description{
Create a temporary file for the BEAST2 XML output file that
stores its state.
}
\examples{
check_empty_beaustier_folders()

create_temp_state_filename()

check_empty_beaustier_folders()
}
\author{
Richèl J.C. Bilderbeek
}
