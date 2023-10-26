#' Internal function
#'
#' Create the folder for the BEAST2 tracelog file
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_tracelog_folder <- function(beast2_options) {
  # Extract the tracelog file
  testthat::expect_true(file.exists(beast2_options$input_filename))
  tracelog_filename <- extract_tracelog_filename_from_beast2_input_file( # nolint indeed a long line
    input_filename = beast2_options$input_filename
  )
  dir.create(
    dirname(tracelog_filename),
    showWarnings = FALSE,
    recursive = TRUE
  )
  testthat::expect_true(
    dir.exists(dirname(tracelog_filename))
  )
  invisible(beast2_options)
}
