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
  beast2_path = get_default_beast2_path()
) {
  if (is_jar_path(beast2_path)) {
    create_beast2_validate_cmd_jar(
      input_filename = input_filename,
      beast2_jar_path = beast2_path
    )
  } else {
    testit::assert(is_bin_path(beast2_path)) # nolint internal function
    create_beast2_validate_cmd_bin(
      input_filename = input_filename,
      beast2_bin_path = beast2_path
    )
  }
}

#' Creates the terminal command to validate a BEAST2 input file
#' using a call to the \code{beast.jar} file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   cmds <- create_beast2_validate_cmd_jar(
#'     input_filename = "input.xml"
#'   )
#'   testit::assert(length(cmds) == 5)
#'   testit::assert(cmds[1] == "java")
#'   testit::assert(cmds[2] == "-jar")
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_validate_cmd_jar <- function(
  input_filename,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  testit::assert(file.exists(beast2_jar_path))
  testit::assert(is_jar_path(beast2_jar_path)) # nolint internal function
  cmds <- c(
    get_default_java_path(),
    "-jar",
    paste0("\"", beast2_jar_path, "\""),
    "-validate",
    paste0("\"", input_filename, "\"")
  )
  testit::assert(file.exists(cmds[1]))
  cmds
}

#' Creates the terminal command to validate a BEAST2 input file
#' using a call to the \code{beast.jar} file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   cmds <- create_beast2_validate_cmd_bin(
#'     input_filename = "input.xml"
#'   )
#'   testit::assert(length(cmds) == 3)
#'   testit::assert(cmds[2] == "-validate")
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_validate_cmd_bin <- function(
  input_filename,
  beast2_bin_path = get_default_beast2_bin_path()
) {
  testit::assert(file.exists(beast2_bin_path))
  testit::assert(is_bin_path(beast2_bin_path)) # nolint internal function
  cmds <- c(
    beast2_bin_path,
    "-validate",
    input_filename #paste0("\"", input_filename, "\"")
  )
  testit::assert(file.exists(cmds[1]))
  cmds
}
