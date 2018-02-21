#' Creates the terminal command to validate a BEAST2 input file
#' @param input_filename name of the BEAST2 input file
#'   (usually has a \code{.xml} extension)
#' @param beast_jar_path name of the BEAST2 jar file
#'   (usually has a \code{.jar} extension)
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_validate_cmd <- function(
  input_filename,
  beast_jar_path = "~/Programs/beast/lib/beast.jar"
) {
  paste("java -jar", beast_jar_path, "-validate", input_filename)

}
