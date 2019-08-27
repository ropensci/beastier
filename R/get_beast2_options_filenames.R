#' Extract the filenames from a \code{beast2_options}
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' beast2_options <- beastier::create_beast2_options()
#' filenames <- get_beast2_options_filenames(beast2_options)
#' expect_true(beast2_options$input_filename %in% filenames)
#' expect_true(beast2_options$output_log_filename %in% filenames)
#' expect_true(beast2_options$output_trees_filenames %in% filenames)
#' expect_true(beast2_options$output_state_filename %in% filenames)
#' @export
get_beast2_options_filenames <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  c(
    beast2_options$input_filename,
    beast2_options$output_log_filename,
    beast2_options$output_trees_filenames,
    beast2_options$output_state_filename
  )
}
