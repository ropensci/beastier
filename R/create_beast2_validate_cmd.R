#' Creates the terminal command to validate a BEAST2 input file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   cmds <- create_beast2_validate_cmd(
#'     input_filename = "input.xml"
#'   )
#'   testit::assert(cmds[1] == "java")
#'   testit::assert(cmds[2] == "-jar")
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_validate_cmd <- function(
  input_filename,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  c(
    "java",
    "-jar",
    paste0("\"", beast2_jar_path, "\""),
    "-validate",
    paste0("\"", input_filename, "\"")
  )
}
