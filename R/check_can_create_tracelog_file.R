#' Check if the MCMC's tracelog file can be created.
#' Will \link{stop} if not.
#' If the file already exists, it is assumed that a new file can be created
#' @inheritParams default_params_doc
#' @export
check_can_create_tracelog_file <- function(
  beast2_options
) {
  # Extract the tracelog file
  testthat::expect_true(file.exists(beast2_options$input_filename))
  text <- readr::read_lines(beast2_options$input_filename)
  tracelog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"tracelog\""
  )
  testthat::expect_equal(length(tracelog_line), 1)
  matches <- stringr::str_match(
    string = tracelog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )
  testthat::expect_equal(ncol(matches), 2)
  tracelog_filename <- matches[1, 2]

  if (file.exists(tracelog_filename)) return()

  tryCatch(
    beastier::check_can_create_file(filename = tracelog_filename, overwrite = FALSE),
    error = function(e) {
      stop(
        "Cannot create tracelog file '", tracelog_filename, "'",
        " in path '", getwd(), "'",
        "Error: ", e$message
      )
    }
  )
}
