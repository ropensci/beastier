#' Create the default \code{.log} filename as will be created by BEAST
#' @inheritParams default_params_doc
#' @return the default \code{.log} filename as will be created by BEAST
#' @author: Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   input_filename <- get_beastier_path("2_4.xml")
#'
#'   if (is_beast2_installed()) {
#'     log_filename <- create_default_log_filename(input_filename)
#'     expect_equal("test_output_0.log", log_filename)
#'   }
#' @export
create_default_log_filename <- function(
  input_filename,
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  check_input_filename(input_filename) # nolint internal function
  check_beast2_path(beast2_path) # nolint internal function
  check_input_filename_validity( # nolint internal function
    input_filename = input_filename,
    beast2_path = beast2_path,
    verbose = verbose
  )

  testit::assert(file.exists(input_filename))
  testit::assert(file.exists(beast2_path))
  testit::assert(
    is_beast2_input_file( # nolint internal function
      input_filename,
      beast2_path = beast2_path
    )
  )
  alignment_ids <- get_alignment_ids(input_filename) # nolint internal function
  paste0(sort(alignment_ids)[1], ".log")
}
