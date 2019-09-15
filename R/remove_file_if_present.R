#' Remove a file if it is present
#' @noRd
remove_file_if_present <- function(filename) {
  testit::assert(length(filename) == 1)
  if (file.exists(filename)) {
    file.remove(filename)
  }
}

#' Remove a file if it is present
#' @noRd
remove_files_if_present <- function(filenames) {
  for (filename in filenames) {
    remove_file_if_present(filename)
  }
}
