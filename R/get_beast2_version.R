#' Get the BEAST2 version
#' @inheritParams default_params_doc
#' @return the BEAST2 version
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed() && beautier::is_on_ci()) {
#'   get_beast2_version()
#' }
#'
#' check_empty_beaustier_folders()
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
  check_true(length(beast2_path) == 1)
  cmds <- create_beast2_version_cmd(beast2_path)
  beautier::check_file_exists(cmds[1], "cmds[1]")
  output <- NA

  if (1 == 2) {
    # Old, as of 2025-02-21
    output <- system2(
      cmds[1],
      args = cmds[-1],
      stdout = TRUE,
      stderr = TRUE
    )
  }

  # Running
  #
  #   /usr/lib/jvm/java-21-openjdk-amd64/bin/java -cp /home/richel/.local/share/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher -version
  #
  # Gives output:
  #
  # [java, -Djava.library.path=/usr/java/packages/lib:/usr/lib/x86_64-linux-gnu/jni:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/lib/jni:/lib:/usr/lib, -cp, ::/home/richel/.beast/2.5/BEAST/lib/beast.jar:/home/richel/.beast/2.5/BEAST/lib/beast.src.jar, beast.app.beastapp.BeastMain, -version]

  output <- system2(
    cmds[1],
    args = cmds[-1],
    stdout = TRUE,
    stderr = TRUE
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
