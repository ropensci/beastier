#' Checks if BEAST2 is installed
#' @return TRUE if BEAST2 is installed
#' @author Richel J.C. Bilderbeek
#' @export
is_beast2_installed <- function() {
  bin_exists <- file.exists(get_default_beast2_bin_path())
  jar_exists <- file.exists(get_default_beast2_jar_path())
  testit::assert(bin_exists == jar_exists)
  jar_exists
}
