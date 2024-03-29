% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/are_beast2_input_lines.R
\name{are_beast2_input_lines_fast}
\alias{are_beast2_input_lines_fast}
\title{Would these lines of text, when written to a file,
  result in a valid BEAST2 input file?}
\usage{
are_beast2_input_lines_fast(lines)
}
\arguments{
\item{lines}{lines of text}
}
\value{
TRUE if the text is valid, FALSE if not
}
\description{
Would these lines of text, when written to a file,
  result in a valid BEAST2 input file?
}
\examples{

beast2_filename <- get_beastier_path("anthus_2_4.xml")
text <- readLines(beast2_filename)

# TRUE
are_beast2_input_lines_fast(text)
check_empty_beaustier_folders()
}
\seealso{
Use \code{\link{is_beast2_input_file}} to check a file
}
\author{
Richèl J.C. Bilderbeek
}
