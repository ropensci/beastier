#' Uninstall BEAST2
#' @author Richel J.C. Bilderbeek
#' @export
uninstall_beast2 <- function(folder_name) {
  if (!is_beast2_installed(folder_name)) {
    stop("Cannot uninstall absent BEAST2 at")
  }
  # STUB
  file.remove(file.path(folder_name, "bin", "beast"))
  file.remove(file.path(folder_name, "lib", "beast.jar"))
}
