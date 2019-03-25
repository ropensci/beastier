#' Get the .trees filenames that BEAST2 will produce
#' @inheritParams default_params_doc
#' @return character vector with the names of the .trees files that BEAST2
#'   will produce
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_equal(
#'     get_trees_filenames(get_beastier_path("2_4.xml")),
#'     "test_output_0.trees"
#'   )
#'
#'   expect_equal(
#'     get_trees_filenames(get_beastier_path("anthus_2_4.xml")),
#'     c("Anthus_nd2.trees", "Anthus_aco.trees")
#'   )
#' @export
get_trees_filenames <- function(input_filename) {

  alignment_ids <- get_alignment_ids(input_filename) # nolint internal function
  paste0(alignment_ids, ".trees")
}
