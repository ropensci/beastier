#' Check if the MCMC's treelog file can be created.
#' Will \link{stop} if not
#' @inheritParams default_params_doc
#' @export
check_can_create_treelog_file <- function(
  beast2_options
) {
  # Extract the treelog file
  testthat::expect_true(file.exists(beast2_options$input_filename))
  text <- readr::read_lines(beast2_options$input_filename)
  treelog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"treelog.t:"
  )
  testthat::expect_equal(length(treelog_line), 1)
  matches <- stringr::str_match(
    string = treelog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )
  testthat::expect_equal(ncol(matches), 2)
  treelog_filename <- matches[1, 2]

  if (file.exists(treelog_filename)) return()

  tryCatch(
    beastier::check_can_create_file(filename = treelog_filename, overwrite = FALSE),
    error = function(e) {
      stop("Cannot create treelog file '", treelog_filename, "'")
    }
  )
}
