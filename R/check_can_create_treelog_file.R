#' Internal function
#'
#' Check if the MCMC's treelog file can be created.
#' Will \link{stop} if not
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if the MCMC's treelog file is absent and cannot be created.
#' @author Richèl J.C. Bilderbeek
#' @export
check_can_create_treelog_file <- function(
  beast2_options
) {
  # Extract the treelog file
  testthat::expect_true(file.exists(beast2_options$input_filename))
  treelog_filename <- beastier::extract_treelog_filename_from_beast2_input_file(
    input_filename = beast2_options$input_filename
  )

  if (file.exists(treelog_filename)) {
     file.remove(treelog_filename)
     return(invisible(beast2_options))
  }

  tryCatch(
    beastier::check_can_create_file(
      filename = treelog_filename, overwrite = FALSE
    ),
    error = function(e) {
      stop("Cannot create treelog file '", treelog_filename, "'")
    }
  )
  invisible(beast2_options)
}
