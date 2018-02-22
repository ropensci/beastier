#' Get the default BEAST2 jar file's path
#' @export
#' @examples
#'   testit::assert(file.exists(get_default_beast2_jar_path()))
get_default_beast2_jar_path <- function() {
  "~/Programs/beast/lib/beast.jar"
}
