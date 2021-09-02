#' Internal function
#'
#' Create the folder for the BEAST2 screenlog file
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_screenlog_folder <- function(beast2_options) {
  # Extract the screenlog file
  testthat::expect_true(file.exists(beast2_options$input_filename))
  screenlog_filename <- beastier::extract_screenlog_filename_from_beast2_input_file(
    input_filename = beast2_options$input_filename
  )
  dir.create(
    dirname(screenlog_filename),
    showWarnings = FALSE,
    recursive = TRUE
  )
  testthat::expect_true(
    dir.exists(dirname(screenlog_filename))
  )
  invisible(beast2_options)
}
