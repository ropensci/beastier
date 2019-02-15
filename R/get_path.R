#' Get the full path of a file in the \code{inst/extdata} folder
#' @param filename the file's name, without the path
#' @return the full path to the filename. Will \code{stop} if the file
#'   is absent in the \code{inst/extdata} folder
#' @author Richèl J.C. Bilderbeek
#' @seealso for more files, use \code{\link{get_beastier_paths}}
#' @examples
#'   testit::assert(
#'     is.character(get_beastier_path("beast2_example_output.log"))
#'   )
#'   testit::assert(
#'     is.character(get_beastier_path("beast2_example_output.trees"))
#'   )
#'   testit::assert(
#'     is.character(get_beastier_path("beast2_example_output.xml"))
#'   )
#'   testit::assert(
#'     is.character(get_beastier_path("beast2_example_output.xml.state"))
#'   )
#' @export
get_beastier_path <- function(filename) {

  full <- system.file("extdata", filename, package = "beastier")
  if (!file.exists(full)) {
    stop("'filename' must be the name of a file in 'inst/extdata'")
  }
  full
}
