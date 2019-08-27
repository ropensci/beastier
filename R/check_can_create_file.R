#' Check that a file can be created at a certain path.
#'
#' Will \link{stop} if not. Will \link{stop} if the file already exists.
#' Does so by creating an empty file at the path,
#' and then deleting it.
#' @param filename file that may or may not be created
#' @author Richèl J.C. Bilderbeek
#' @export
check_can_create_file <- function(filename) {
  if (file.exists(filename)) {
    stop(
      "Cannot check if a file can be created ",
      "if the desired file already exists. \n",
      "Filename: ", filename
    )
  }
  tryCatch(
    suppressWarnings(
      writeLines(text = "check_can_create_file testing text", con = filename)
    ),
    error = function(e) {} # nolint indeed does nothing
  )
  if (!file.exists(filename)) {
    stop(
      "Cannot create a file at location ", filename
    )
  }
  file.remove(filename)
  if (file.exists(filename)) {
    stop(
      "Cannot delete the temporory file createdat location ", filename
    )
  }
}
