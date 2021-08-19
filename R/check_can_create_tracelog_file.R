#' Internal function to check if the MCMC's tracelog file can be created.
#'
#' Check if the MCMC's tracelog file can be created.
#' Will \link{stop} if not.
#' If the tracelog file already exists,
#' it is assumed that a new file can be created,
#' by overwriting the existing one.
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if the MCMC's tracelog file is absent and cannot be created.
#' @author Richèl J.C. Bilderbeek
#' @export
check_can_create_tracelog_file <- function(
  beast2_options
) {
  testthat::expect_true(file.exists(beast2_options$input_filename))
  tracelog_filename <- beastier::extract_tracelog_filename_from_beast2_input_file( # nolint indeed a long internal function name
    input_filename = beast2_options$input_filename
  )

  if (file.exists(tracelog_filename)) {
     file.remove(tracelog_filename)
     return()
  }

  tryCatch(
    beastier::check_can_create_file(
      filename = tracelog_filename, overwrite = FALSE
    ),
    error = function(e) {
      stop(
        "Cannot create tracelog file '", tracelog_filename, "'",
        " in path '", getwd(), "'",
        "Error: ", e$message
      )
    }
  )
  invisible(beast2_options)
}
