#' Creates the terminal command to validate a BEAST2 input file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed() && beautier::is_on_ci()) {
#'   create_beast2_validate_cmd(
#'     input_filename = "input.xml"
#'   )
#' }
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
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
    check_true(is_bin_path(beast2_path))
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
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed() && beautier::is_on_ci()) {
#'   create_beast2_validate_cmd_jar(
#'     input_filename = "input.xml"
#'   )
#' }
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_validate_cmd_jar <- function(
  input_filename,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  beautier::check_file_exists(beast2_jar_path, "beast2_jar_path")
  check_true(is_jar_path(beast2_jar_path))
  cmds <- c(
    get_default_java_path(),
    "-cp",
    add_quotes_if_has_spaces(beast2_jar_path),
    get_beast2_main_class_name(),
    "-validate",
    add_quotes_if_has_spaces(input_filename)
  )
  # The executable must be runnable. This means that it should not have quotes
  check_true(file.exists(cmds[1]))
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
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed() && beautier::is_on_ci()) {
#'   create_beast2_validate_cmd_bin(
#'     input_filename = "input.xml"
#'   )
#' }
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_validate_cmd_bin <- function(
  input_filename,
  beast2_bin_path = get_default_beast2_bin_path()
) {
  beautier::check_file_exists(beast2_bin_path, "beast2_bin_path")
  check_true(is_bin_path(beast2_bin_path))
  cmds <- c(
    beast2_bin_path,
    "-validate",
    add_quotes_if_has_spaces(input_filename)
  )
  # The executable must be runnable. This means that it should not have quotes
  check_true(file.exists(cmds[1]))
  cmds
}
