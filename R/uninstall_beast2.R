#' Uninstall BEAST2
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @export
uninstall_beast2 <- function(folder_name = get_default_beast2_folder()) {
  if (!is_beast2_installed(folder_name)) {
    stop("Cannot uninstall absent BEAST2 at")
  }
  # STUB
  file.remove(file.path(folder_name, "beast", "bin", "beast"))
  file.remove(file.path(folder_name, "beast", "lib", "beast.jar"))
}
