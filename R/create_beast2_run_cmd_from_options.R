#' Creates the terminal command to run BEAST2 from a \code{beast2_options}
#' @inheritParams default_params_doc
#' @return a character vector with the command and
#'   arguments to call BEAST2
#' @examples
#'   if (is_beast2_installed()) {
#'     cmds <- create_beast2_run_cmd_from_options(
#'       input_filename = "input.xml",
#'       output_state_filename = "output.xml.state",
#'       beast2_path = get_default_beast2_jar_path()
#'     )
#'     testit::assert(cmds[2] == "-cp")
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_run_cmd_from_options <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  testit::assert(file.exists(beast2_options$beast2_path))
  testit::assert(file.exists(beastier::get_default_java_path()))
  testit::assert(beautier::is_one_bool(beast2_options$use_beagle))
  cmds <- NULL
  if (beastier::is_jar_path(beast2_options$beast2_path)) {
    cmds <- c(
      beastier::get_default_java_path(),
      "-cp",
      shQuote(beast2_options$beast2_path),
      beastier::get_beast2_main_class_name()
    )
    testit::assert(file.exists(cmds[1]))
    # Cannot do: testit::assert(file.exists(cmds[3]))
    # because that path is quotes
    # and file.exists does not know what to do with that
  } else {
    testit::assert(beastier::is_bin_path(beast2_options$beast2_path))
    cmds <- beast2_options$beast2_path
    testit::assert(file.exists(cmds[1]))
  }
  if (!beautier::is_one_na(beast2_options$rng_seed)) {
    cmds <- c(cmds, "-seed")
    cmds <- c(cmds, beast2_options$rng_seed)
  }
  if (!beautier::is_one_na(beast2_options$n_threads)) {
    cmds <- c(cmds, "-threads")
    cmds <- c(cmds, beast2_options$n_threads)
  }
  if (beast2_options$use_beagle == TRUE) {
    cmds <- c(cmds, "-beagle")
  }
  cmds <- c(cmds, "-statefile")
  cmds <- c(
    cmds,
    paste0("\"", normalizePath(beast2_options$output_state_filename, mustWork = FALSE), "\"")
  )
  testit::assert(file.exists(cmds[1]))
  if (beast2_options$overwrite == TRUE) {
    cmds <- c(cmds, "-overwrite")
  }
  testit::assert(file.exists(cmds[1]))
  cmds <- c(
    cmds,
    paste0("\"", normalizePath(beast2_options$input_filename, mustWork = FALSE), "\"")
  )
  testit::assert(file.exists(cmds[1]))
  cmds
}
