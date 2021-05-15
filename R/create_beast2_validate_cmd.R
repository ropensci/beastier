#' Creates the terminal command to validate a BEAST2 input file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   if (is_beast2_installed() && is_on_ci()) {
#'     cmds <- create_beast2_validate_cmd(
#'       input_filename = "input.xml"
#'     )
#'     testit::assert(cmds[2] == "-cp")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_validate_cmd <- function(
  input_filename,
  beast2_path = get_default_beast2_path()
) {
  if (beastier::is_jar_path(beast2_path)) {
    create_beast2_validate_cmd_jar(
      input_filename = input_filename,
      beast2_jar_path = beast2_path
    )
  } else {
    testit::assert(beastier::is_bin_path(beast2_path))
    create_beast2_validate_cmd_bin(
      input_filename = input_filename,
      beast2_bin_path = beast2_path
    )
  }
}

#' Creates the terminal command to validate a BEAST2 input file
#' using a call to the \code{launcher.jar} file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   if (is_beast2_installed() && is_on_ci()) {
#'     cmds <- create_beast2_validate_cmd_jar(
#'       input_filename = "input.xml"
#'     )
#'     testit::assert(length(cmds) == 6)
#'     testit::assert(cmds[2] == "-cp")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_validate_cmd_jar <- function(
  input_filename,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  beautier::check_file_exists(beast2_jar_path, "beast2_jar_path")
  testit::assert(beastier::is_jar_path(beast2_jar_path))
  cmds <- c(
    beastier::get_default_java_path(),
    "-cp",
    beastier::add_quotes_if_has_spaces(beast2_jar_path),
    beastier::get_beast2_main_class_name(),
    "-validate",
    beastier::add_quotes_if_has_spaces(input_filename)
  )
  # The executable must be runnable. This means that it should not have quotes
  testthat::expect_true(file.exists(cmds[1]))
  cmds
}

#' Creates the terminal command to validate a BEAST2 input file
#' using a call to the \code{launcher.jar} file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   if (is_beast2_installed() && is_on_ci()) {
#'     cmds <- create_beast2_validate_cmd_bin(
#'       input_filename = "input.xml"
#'     )
#'     testit::assert(length(cmds) == 3)
#'     testit::assert(cmds[2] == "-validate")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_validate_cmd_bin <- function(
  input_filename,
  beast2_bin_path = get_default_beast2_bin_path()
) {
  beautier::check_file_exists(beast2_bin_path, "beast2_bin_path")
  testit::assert(beastier::is_bin_path(beast2_bin_path))
  cmds <- c(
    beast2_bin_path,
    "-validate",
    beastier::add_quotes_if_has_spaces(input_filename)
  )
  # The executable must be runnable. This means that it should not have quotes
  testthat::expect_true(file.exists(cmds[1]))
  cmds
}
