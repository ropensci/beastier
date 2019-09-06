#' Get the BEAST2 version
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'   expect_equal(get_beast2_version(), "2.6.0")
#' }
#' @export
get_beast2_version <- function(
  beast2_path = get_default_beast2_path()
) {
  if (is_win_bin_path(beast2_path)) {
   stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  if (!file.exists(beast2_path)) {
    stop(
      "'beast2_path' must be the full path ",
      "of either 'beast' or 'launcher.jar'. ",
      "Both not found at path '", beast2_path, "'"
    )
  }

  # Create the command
  testit::assert(length(beast2_path) == 1)
  cmds <- create_beast2_version_cmd(beast2_path)
  beautier::check_file_exists(cmds[1], "cmds[1]")
  output <- system2(
    cmds[1],
    args = cmds[-1],
    stdout = TRUE,
    stderr = TRUE
  )

  substring(output, 2)
}
