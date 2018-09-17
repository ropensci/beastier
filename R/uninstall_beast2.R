#' Uninstall BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files are installed.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
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
