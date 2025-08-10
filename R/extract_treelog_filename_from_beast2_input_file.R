#' Internal function to extract the treelog filename for a BEAST2 input file
#'
#' Extract the treelog filename from a BEAST2 input file
#' @inheritParams default_params_doc
#' @return the treelog filename for a BEAST2 input file
#' @examples
#' if (beautier::is_on_ci()) {
#'
#'   beast2_input_filename <- get_beastier_tempfilename()
#'
#'   beautier::create_beast2_input_file_from_model(
#'     input_filename = beautier::get_beautier_path("test_output_0.fas"),
#'     output_filename = beast2_input_filename
#'   )
#'   extract_treelog_filename_from_beast2_input_file(
#'     input_filename = beast2_input_filename
#'   )
#'   file.remove(beast2_input_filename)
#'
#'   remove_beaustier_folders()
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
extract_treelog_filename_from_beast2_input_file <- function( # nolint indeed a long function name
  input_filename
) {
  beautier::check_true(file.exists(input_filename))
  text <- readr::read_lines(input_filename, progress = FALSE)
  treelog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"treelog.t:"
  )
  beautier::check_true(length(treelog_line) == 1)
  treelog_filename <- stringr::str_match(
    string = treelog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )[1, 2]

  # If there is '$(tree)', replacit by the tree ID
  tree_id <- stringr::str_match(
    string = treelog_line,
    pattern = "id=\\\"treelog.t:([:graph:]+)\\\" "
  )[1, 2]
  treelog_filename <- stringr::str_replace(
    string = treelog_filename,
    pattern = "\\$\\(tree\\)",
    replacement = tree_id
  )
  treelog_filename
}
