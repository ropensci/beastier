#' Do a minimal BEAST2 run
#'
#' To achieve this, \link{run_beast2_from_options} is called.
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the files with name \code{output_state_filename}
#' @export
#' @examples
#' if (is_beast2_installed() && beautier::is_on_ci()) {
#'   do_minimal_run()
#' }
#' @author Richèl J.C. Bilderbeek
do_minimal_run <- function() {
  output_state_filename <- get_beastier_tempfilename()
  run_beast2_from_options(
    create_beast2_options(
      input_filename = get_beastier_path("2_4.xml"),
      output_state_filename = output_state_filename,
      rng_seed = 314,
      beast2_path = get_default_beast2_path()
    )
  )
  file.remove(output_state_filename)
}
