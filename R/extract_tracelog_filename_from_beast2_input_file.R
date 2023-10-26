#' Internal function to extract the tracelog filename for a BEAST2 input file
#'
#' Extract the tracelog filename for a BEAST2 input file
#' @inheritParams default_params_doc
#' @return the name of the tracelog file
#' @examples
#' if (beautier::is_on_ci())
#' {
#'
#'   beast2_input_filename <- get_beastier_tempfilename()
#'   tracelog_filename <- get_beastier_tempfilename()
#'   beautier::create_beast2_input_file_from_model(
#'     input_filename = beautier::get_beautier_path("test_output_0.fas"),
#'     output_filename = beast2_input_filename,
#'     inference_model = beautier::create_inference_model(
#'       mcmc = beautier::create_mcmc(
#'         tracelog = beautier::create_tracelog(
#'           filename = tracelog_filename
#'         )
#'       )
#'     )
#'   )
#'   extract_tracelog_filename_from_beast2_input_file(
#'     input_filename = beast2_input_filename
#'   )
#'   file.remove(beast2_input_filename)
#'
#'   remove_beaustier_folders()
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
extract_tracelog_filename_from_beast2_input_file <- function( # nolint indeed a long internal function name
  input_filename
) {
  # Extract the tracelog file
  check_true(file.exists(input_filename))
  text <- readr::read_lines(input_filename, progress = FALSE)
  tracelog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"tracelog\""
  )
  check_true(length(tracelog_line) == 1)
  matches <- stringr::str_match(
    string = tracelog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )
  check_true(ncol(matches) == 2)
  tracelog_filename <- matches[1, 2]
  tracelog_filename
}
