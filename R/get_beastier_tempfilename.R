#' Get a temporary filename
#'
#' Get a temporary filename, similar to \link{tempfile},
#' except that it always writes to a temporary folder
#' named \link{beastier}.
#' @note this function is added to make sure no temporary
#' cache files are left undeleted
#' @param pattern	a non-empty character vector
#'   giving the initial part of the name.
#' @param fileext	a non-empty character vector
#'   giving the file extension
#' @return name for a temporary file
#' @export
get_beastier_tempfilename <- function(
  pattern = "file",
  fileext = ""
) {
  normalizePath(
    tempfile(
      pattern = pattern,
      tmpdir = beastier::get_beastier_folder(),
      fileext = fileext
    ),
    mustWork = FALSE
  )
}
