#' Get the .trees filenames that BEAST2 will produce
#' @inheritParams default_params_doc
#' @return character vector with the names of the .trees files that BEAST2
#'   will produce
#' @author Richel J.C. Bilderbeek
#' @export
get_trees_filenames <- function(input_filename) {

  alignment_ids <- get_alignment_ids(input_filename) # nolint internal function
  paste0(alignment_ids, ".trees")
}
