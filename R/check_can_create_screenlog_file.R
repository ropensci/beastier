#' Internal function
#'
#' Check if the MCMC's screenlog file can be created.
#' Will \link{stop} if not
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if the MCMC's screenlog file cannot be created.
#' @author Richèl J.C. Bilderbeek
#' @export
check_can_create_screenlog_file <- function( # nolint indeed a long function name
  beast2_options
) {
  # Extract the screenlog file
  check_true(file.exists(beast2_options$input_filename))
  text <- readr::read_lines(beast2_options$input_filename, progress = FALSE)
  screenlog_line <- stringr::str_subset(
    string = text,
    pattern = "<logger id=\"screenlog\""
  )
  check_true(length(screenlog_line) == 1)
  matches <- stringr::str_match(
    string = screenlog_line,
    pattern = "fileName=\\\"([:graph:]+)\\\" "
  )
  check_true(ncol(matches) == 2)
  screenlog_filename <- matches[1, 2]

  if (is.na(screenlog_filename)) return()
  if (file.exists(screenlog_filename)) {
     file.remove(screenlog_filename)
     return()
  }

  tryCatch(
    check_can_create_file(
      filename = screenlog_filename, overwrite = FALSE
    ),
    error = function(e) {
      stop("Cannot create screenlog file '", screenlog_filename, "'")
    }
  )
  invisible(beast2_options)
}
