#' Internal function to extract the tracelog filename for a BEAST2 input file
#'
#' Extract the tracelog filename for a BEAST2 input file
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
extract_tracelog_filename_from_beast2_input_file <- function( # nolint indeed a long internal function name
  input_filename
) {
  # Extract the tracelog file
  testthat::expect_true(file.exists(input_filename))
  text <- readr::read_lines(input_filename)
  tracelog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"tracelog\""
  )
  testthat::expect_equal(length(tracelog_line), 1)
  matches <- stringr::str_match(
    string = tracelog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )
  testthat::expect_equal(ncol(matches), 2)
  tracelog_filename <- matches[1, 2]
  tracelog_filename
}
