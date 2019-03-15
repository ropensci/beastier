#' Uninstall BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files are installed.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @author Richèl J.C. Bilderbeek
#' @export
uninstall_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  os = rappdirs::app_dir()$os
) {
  if (!is_beast2_installed(
    folder_name = folder_name,
    os = os)) {
    stop("Cannot uninstall absent BEAST2 at", folder_name)
  }
  check_os(os = os) # nolint internal function
  jar_file_path <- file.path(folder_name, "BEAST", "lib", "beast.jar")
  if (os != "win") {
    jar_file_path <- file.path(folder_name, "beast", "lib", "beast.jar")
  }
  bin_file_path <- file.path(folder_name, "BEAST", "BEAST.exe")
  if (os != "win") {
    bin_file_path <- file.path(folder_name, "beast", "bin", "beast")
  }
  testit::assert(file.exists(jar_file_path))
  testit::assert(file.exists(bin_file_path))
  file.remove(jar_file_path)
  file.remove(bin_file_path)
}
