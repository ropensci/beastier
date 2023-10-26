#' Remove a file if it is present,
#' will do nothing if it is not.
#' @param filename name of a file
#' @return Nothing. Will remove the file if it is presented,
#' will do nothing if it is not.
#' @examples
#' filename <- tempfile()
#' file.create(filename)
#' remove_file_if_present(filename)
#' remove_file_if_present(filename)
#' @author Richèl J.C. Bilderbeek
#' @export
remove_file_if_present <- function(filename) {
  check_true(beautier::is_one_string(filename))
  check_true(length(filename) == 1)
  if (file.exists(filename)) {
    file.remove(filename)
  }
}
