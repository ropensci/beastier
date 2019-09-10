#' Creates the terminal command to version a BEAST2 input file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   if (is_beast2_installed() && is_on_ci()) {
#'     cmds <- create_beast2_version_cmd()
#'     testit::assert(cmds[2] == "-jar")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_version_cmd <- function(
  beast2_path = get_default_beast2_path()
) {
  if (is_jar_path(beast2_path)) {
    create_beast2_version_cmd_jar(
      beast2_jar_path = beast2_path
    )
  } else {
    testit::assert(is_bin_path(beast2_path)) # nolint internal function
    create_beast2_version_cmd_bin(
      beast2_bin_path = beast2_path
    )
  }
}

#' Creates the terminal command to version a BEAST2 input file
#' using a call to the \code{launcher.jar} file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   if (is_beast2_installed() && is_on_ci()) {
#'     cmds <- create_beast2_version_cmd_jar()
#'     testit::assert(length(cmds) == 4)
#'     testit::assert(cmds[2] == "-jar")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_version_cmd_jar <- function(
  beast2_jar_path = get_default_beast2_jar_path()
) {
  beautier::check_file_exists(beast2_jar_path, "beast2_jar_path")
  testit::assert(is_jar_path(beast2_jar_path)) # nolint internal function
  cmds <- c(
    get_default_java_path(),
    "-jar",
    paste0("\"", beast2_jar_path, "\""),
    "-version"
  )
  beautier::check_file_exists(cmds[1], "cmds[1]")
  cmds
}

#' Creates the terminal command to version a BEAST2 input file
#' using a call to the \code{launcher.jar} file
#' @inheritParams default_params_doc
#' @return a character vector, of which the first element
#'   is the command (\code{java}, in this case),
#'   and the others are arguments (\code{-jar}, in this case, followed
#'   by more arguments.
#' @examples
#'   if (is_beast2_installed() && is_on_ci()) {
#'     cmds <- create_beast2_version_cmd_bin()
#'     testit::assert(length(cmds) == 2)
#'     testit::assert(cmds[2] == "-version")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_version_cmd_bin <- function(
  beast2_bin_path = get_default_beast2_bin_path()
) {
  beautier::check_file_exists(beast2_bin_path, "beast2_bin_path")
  testit::assert(is_bin_path(beast2_bin_path)) # nolint internal function
  cmds <- c(
    beast2_bin_path,
    "-version"
  )
  beautier::check_file_exists(cmds[1], "cmds[1]")
  cmds
}
