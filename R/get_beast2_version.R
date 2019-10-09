#' Get the BEAST2 version
#' @inheritParams default_params_doc
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
  cmds <- beastier::create_beast2_version_cmd(beast2_path)
  beautier::check_file_exists(cmds[1], "cmds[1]")
  output <- NA

  tryCatch({
      output <- system2(
        cmds[1],
        args = cmds[-1],
        stdout = TRUE,
        stderr = TRUE
      )
    },
    warning = function(e) {
      stop(
        "Unknown warning emitted", "\n",
        "\n",
        "Warning message: ", e$message, "\n",
        "\n",
        "Java version: ", get_java_version(), "\n",
        "\n",
        "Tip: try running the command indicated by the warning message ",
          "in a terminal. \n",
        "\n",
        "Known problems: \n",
        "\n",
        "'no main manifest attribute': \n",
        "  * call 'get_beast2_version' with 'get_default_beast2_bin_path()':\n",
        "  \n",
        "    get_beast2_version(get_default_beast2_bin_path()) \n",
        "  \n",
        "  * upgrade to a newer BEAST2 version: \n",
        "  \n",
        "    upgrade_beast2() \n",
        "  \n",
        "  * downgrade to an older Java version"
      )
    }
  )
  # When doing
  #
  # ./beast -version                                                            # nolint this is not commented code: it is proper documentation
  #
  # output can be:
  #
  #
  # [java, -Xms8g, -Xms256m, -Djava.library.path=/usr/local/lib:/usr/java/packages/lib:/usr/lib/x86_64-linux-gnu/jni:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/lib/jni:/lib:/usr/lib, -cp, ::/home/richel/.beast/2.5/BEASTLabs/lib/BEASTlabs.addon.jar:/home/richel/.beast/2.5/NS/lib/NS.addon.jar:/home/richel/.beast/2.5/MODEL_SELECTION/lib/MODEL_SELECTION.addon.jar:/home/richel/.beast/2.5/BEAST/lib/beast.jar:/home/richel/.beast/2.5/BEAST/lib/beast.src.jar, beast.app.beastapp.BeastMain, -version] # nolint indeed a long line
  # v2.5.2
  last_lines <- output[length(output)]

  substring(last_lines, 2)
}
