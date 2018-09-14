#' Uninstall BEAST2
#' @author Richel J.C. Bilderbeek
#' @export
uninstall_beast2 <- function() {
  if (!is_beast2_installed()) {
    stop("Cannot uninstall absent BEAST2 at")
  }
  # STUB
  file.remove(get_default_beast2_bin_path())
  file.remove(get_default_beast2_jar_path())
}
