#' Creates the terminal command to run BEAST2
#' @param input_filename name of the BEAST2 input file
#'   (usually has a \code{.xml} extension)
#' @param output_state_filename name of the BEAST2 output file that
#'   stores the state
#'   (usually has a \code{.xml.state} extension)
#' @param overwrite_state_file set to TRUE to overwrite the file with name
#'   \code{output_state_filename} if it already exists
#' @param beast_jar_path name of the BEAST2 jar file
#'   (usually has a \code{.jar} extension)
#' @author Richel J.C. Bilderbeek
create_beast2_cmd_run <- function(
  input_filename,
  output_state_filename,
  overwrite_state_file = TRUE,
  beast_jar_path = "~/Programs/beast/lib/beast.jar"
) {
  cmd <- paste(
    "java -jar",
    beast_jar_path,
    "-statefile",
    output_state_filename)
  if (overwrite_state_file == TRUE) {
    cmd <- paste(cmd, "-overwrite")
  }
  cmd <- paste(cmd, input_filename)
  cmd
}
