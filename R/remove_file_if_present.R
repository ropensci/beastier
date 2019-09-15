#' Remove a file if it is present
#' @noRd
remove_file_if_present <- function(filename) {
  if (file.exists(filename)) {
    file.remove(filename)
  }
}