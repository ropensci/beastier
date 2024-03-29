#' Get the full paths of files in the \code{inst/extdata} folder
#' @param filenames the files' names, without the path
#' @return the filenames' full paths. Will \code{stop} if a file
#'   is absent in the \code{inst/extdata} folder
#' @author Richèl J.C. Bilderbeek
#' @seealso for one file, use \code{\link{get_beastier_path}}
#' @examples
#' get_beastier_paths(
#'   c(
#'     "beast2_example_output.log",
#'     "beast2_example_output.trees",
#'     "beast2_example_output.xml",
#'     "beast2_example_output.xml.state"
#'   )
#' )
#' @export
get_beastier_paths <- function(filenames) {

  for (i in seq_along(filenames)) {
    filenames[i] <- get_beastier_path(filenames[i])
  }

  filenames
}
