#' Do a minimal BEAST2 run
#'
#' To achieve this, \link{run_beast2_from_options} is called.
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the files with name \code{output_state_filename}
#' @export
#' @examples
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   do_minimal_run()
#'
#' }
#' @author Richèl J.C. Bilderbeek
do_minimal_run <- function() {
  folder <- file.path(rappdirs::user_cache_dir(),
    basename(
      tempfile(pattern = "beastier_minimal_run_")
    )
  )
  beastier::run_beast2_from_options(
    beastier::create_beast2_options(
      input_filename = beastier::get_beastier_path("2_4.xml"),
      output_state_filename = file.path(folder, "out.xml.state"),
      rng_seed = 314,
      beast2_path = beastier::get_default_beast2_path()
    )
  )
}
