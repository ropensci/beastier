#' Creates the terminal command to validate a BEAST2 input file
#' @param input_filename name of the BEAST2 input file
#'   (usually has a \code{.xml} extension)
#' @param beast2_jar_path name of the BEAST2 jar file
#'   (usually has a \code{.jar} extension).
#'   Use \link{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_validate_cmd <- function(
  input_filename,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  paste("java -jar", beast2_jar_path, "-validate", input_filename)

}