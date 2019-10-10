#' Remove a file if it is present
#' @param filename name of a file
#' @export
remove_file_if_present <- function(filename) {
  testit::assert(length(filename) == 1)
  if (file.exists(filename)) {
    file.remove(filename)
  }
}

#' Remove a file if it is present
#' @param filename one or more names of files
#' @export
remove_files_if_present <- function(filenames) {
  for (filename in filenames) {
    beastier::remove_file_if_present(filename)
  }
}
