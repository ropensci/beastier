#' Would these lines of text, when written to a file,
#'   result in a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param lines lines of text
#' @param method the method to check. Can be 'deep' or 'fast'.
#'   The 'deep' method uses BEAST2 to validate the complete file.
#'   The 'fast' method uses some superficial tests (for example: if all
#'   IDs are unique)
#' @return TRUE if the text is valid, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{is_beast2_input_file}} to check a file
#' @examples
#'   beast2_filename <- get_path("anthus_2_4.xml")
#'   text <- readLines(beast2_filename)
#'   testit::assert(are_beast2_input_lines(text))
#' @export
are_beast2_input_lines <- function(
  lines,
  verbose = FALSE,
  method = ifelse(lumier:::is_on_travis(), "deep", "fast")
) {
  if (!method %in% c("deep", "fast")) {
    stop("'method' must be \"deep\" or \"fast\", value was '", method, "'")
  }
  if (method == "deep") {
    filename <- tempfile()
    save_lines(filename = filename, lines = lines) # nolint internal function
    return(
      are_beast2_input_lines_deep(lines = lines, verbose = verbose)
    )
  } else {
    testit::assert(method == "fast")
    return(
      are_beast2_input_lines_fast(lines) # nolint internal function
    )
  }
}



#' Would these lines of text, when written to a file,
#'   result in a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param lines lines of text
#' @return TRUE if the text is valid, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{is_beast2_input_file}} to check a file
#' @examples
#'   beast2_filename <- get_path("anthus_2_4.xml")
#'   text <- readLines(beast2_filename)
#'   testit::assert(lumier:::are_beast2_input_lines_deep(text))
are_beast2_input_lines_deep <- function(
  lines,
  verbose = FALSE
) {
  filename <- tempfile()
  save_lines(filename = filename, lines = lines) # nolint internal function
  is_beast2_input_file(
    filename = filename,
    verbose = verbose
  )
}

#' Would these lines of text, when written to a file,
#'   result in a valid BEAST2 input file?
#' @param lines lines of text
#' @return TRUE if the text is valid, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{is_beast2_input_file}} to check a file
#' @examples
#'   beast2_filename <- get_path("anthus_2_4.xml")
#'   text <- readLines(beast2_filename)
#'   testit::assert(lumier:::are_beast2_input_lines_fast(text))
are_beast2_input_lines_fast <- function(
  lines
) {
  has_unique_ids(lines) # nolint internal function
}
