#' Would these lines of text, when written to a file,
#'   result in a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param lines lines of text
#' @param method the method to check. Can be 'deep' or 'fast'.
#'   The 'deep' method uses BEAST2 to validate the complete file.
#'   The 'fast' method uses some superficial tests (for example: if all
#'   IDs are unique)
#' @return TRUE if the text is valid, FALSE if not
#' @author Richèl J.C. Bilderbeek
#' @seealso Use \code{\link{is_beast2_input_file}} to check a file
#' @examples
#' if (is_beast2_installed() && is_on_ci()) {
#'   are_beast2_input_lines(get_beastier_path("anthus_2_4.xml"))
#' }
#' @export
are_beast2_input_lines <- function(
  lines,
  verbose = FALSE,
  method = ifelse(is_on_ci(), "deep", "fast"),
  beast2_path = get_default_beast2_path()
) {
  if (!method %in% c("deep", "fast")) {
    stop("'method' must be \"deep\" or \"fast\", value was '", method, "'")
  }
  if (method == "deep") {
    filename <- beastier::get_beastier_tempfilename()
    dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)
    beastier::save_lines(filename = filename, lines = lines)
    is_valid <- beastier::are_beast2_input_lines_deep(
      lines = lines,
      verbose = verbose,
      beast2_path = beast2_path
    )
    file.remove(filename)
    return(is_valid)
  } else {
    testit::assert(method == "fast")
    return(
      beastier::are_beast2_input_lines_fast(lines) # nolint internal function
    )
  }
}



#' Would these lines of text, when written to a file,
#'   result in a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param lines lines of text
#' @return TRUE if the text is valid, FALSE if not
#' @author Richèl J.C. Bilderbeek
#' @seealso Use \code{\link{is_beast2_input_file}} to check a file
#' @examples
#' if (is_beast2_installed() && is_on_ci()) {
#'   beast2_filename <- get_beastier_path("anthus_2_4.xml")
#'   text <- readLines(beast2_filename)
#'   are_beast2_input_lines_deep(text)
#' }
#' @export
are_beast2_input_lines_deep <- function(
  lines,
  verbose = FALSE,
  beast2_path = get_default_beast2_path()
) {
  filename <- beastier::create_temp_input_filename()
  dir.create(dirname(filename), recursive = TRUE, showWarnings = FALSE)
  beastier::save_lines(filename = filename, lines = lines)
  is_valid <- beastier::is_beast2_input_file(
    filename = filename,
    verbose = verbose,
    beast2_path = beast2_path
  )
  file.remove(filename)
  is_valid
}

#' Would these lines of text, when written to a file,
#'   result in a valid BEAST2 input file?
#' @param lines lines of text
#' @return TRUE if the text is valid, FALSE if not
#' @author Richèl J.C. Bilderbeek
#' @seealso Use \code{\link{is_beast2_input_file}} to check a file
#' @examples
#'
#' beast2_filename <- get_beastier_path("anthus_2_4.xml")
#' text <- readLines(beast2_filename)
#'
#' # TRUE
#' are_beast2_input_lines_fast(text)
#' @export
are_beast2_input_lines_fast <- function(
  lines
) {
  beastier::has_unique_ids(lines)
}
