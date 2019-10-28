#' Remove a file if it is present
#' @param filename name of a file
#' @export
remove_file_if_present <- function(filename) {
  assertive::assert_is_a_string(filename)
  testit::assert(length(filename) == 1)
  if (file.exists(filename)) {
    file.remove(filename)
  }
}
