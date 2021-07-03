#' Internal function to extract the treelog filename for a BEAST2 input file
#'
#' Extract the treelog filename from a BEAST2 input file
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
extract_treelog_filename_from_beast2_input_file <- function(
  input_filename
) {
  testthat::expect_true(file.exists(input_filename))
  text <- readr::read_lines(input_filename)
  treelog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"treelog.t:"
  )
  testthat::expect_equal(length(treelog_line), 1)
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
