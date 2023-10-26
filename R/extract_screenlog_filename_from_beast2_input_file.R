#' Internal function to extract the screenlog filename for a BEAST2 input file
#'
#' Extract the screenlog filename from a BEAST2 input file
#' @inheritParams default_params_doc
#' @return the screenlog filename for a BEAST2 input file
#' @author Richèl J.C. Bilderbeek
#' @export
extract_screenlog_filename_from_beast2_input_file <- function( # nolint indeed a long function name
  input_filename
) {
  check_true(file.exists(input_filename))
  text <- readr::read_lines(input_filename, progress = FALSE)
  screenlog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"screenlog"
  )
  check_true(length(screenlog_line) == 1)
  screenlog_filename <- stringr::str_match(
    string = screenlog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )[1, 2]

  screenlog_filename
}
