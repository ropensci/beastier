#' Get the full paths of files in the 'inst/extdata' folder
#' @param filenames the files' names, without the path
#' @return the filenames' full paths
#' @author Richel J.C. Bilderbeek
#' @seealso for one file, use \code{\link{get_path}}
#' @examples
#'   testit::assert(
#'     length(
#'       get_paths(
#'         c(
#'           "beast2_example_output.log",
#'           "beast2_example_output.trees",
#'           "beast2_example_output.xml",
#'           "beast2_example_output.xml.state"
#'         )
#'       )
#'      ) == 4
#'    )
#' @export
get_paths <- function(filenames) {

  for (i in seq_along(filenames)) {
    filenames[i] <- get_path(filenames[i]) # nolint internal function
  }

  filenames
}
