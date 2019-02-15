#' Checks if BEAST2 is installed
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files are put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @return TRUE if BEAST2 is installed
#' @author Richèl J.C. Bilderbeek
#' @export
is_beast2_installed <- function(
  folder_name = get_default_beast2_folder(),
  os = rappdirs::app_dir()$os
) {
  check_os(os = os) # nolint internal function
  jar_file_path <- file.path(folder_name, "BEAST", "lib", "beast.jar")
  if (os != "win") {
    jar_file_path <- file.path(folder_name, "beast", "lib", "beast.jar")
  }
  bin_file_path <- file.path(folder_name, "BEAST", "BEAST.exe")
  if (os != "win") {
    bin_file_path <- file.path(folder_name, "beast", "bin", "beast")
  }

  bin_exists <- file.exists(bin_file_path)
  jar_exists <- file.exists(jar_file_path)
  testit::assert(bin_exists == jar_exists)
  jar_exists
}
