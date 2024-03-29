% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_bin_path.R
\name{is_win_bin_path}
\alias{is_win_bin_path}
\title{Is the path a path to the BEAST2 binary file?
Does not check if the file at that path is present}
\usage{
is_win_bin_path(path)
}
\arguments{
\item{path}{a string to a path}
}
\value{
TRUE if the path is a path to a BEAST2 binary file
}
\description{
Is the path a path to the BEAST2 binary file?
Does not check if the file at that path is present
}
\examples{
check_empty_beaustier_folders()

# TRUE
is_win_bin_path("BEAST.exe")
# FALSE
is_win_bin_path("beast")
is_win_bin_path("launcher.jar")

check_empty_beaustier_folders()
}
\author{
Richèl J.C. Bilderbeek
}
