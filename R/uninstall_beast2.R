#' Uninstall BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files are installed.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/launcher.jar}
#' @author Richèl J.C. Bilderbeek
#' @examples
#' \dontrun{
#'   uninstall_beast2()
#' }
#' @export
uninstall_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  os = rappdirs::app_dir()$os,
  verbose = FALSE
) {
  if (!is_beast2_installed(
    folder_name = folder_name,
    os = os)) {
    stop("Cannot uninstall absent BEAST2 at", folder_name)
  }
  beastier::check_os(os)
  # Windows    : BEAST/lib/beast.jar                                            # nolint
  # Non-Windows: beast/lib/launcher.jar                                         # nolint
  jar_file_path <- file.path(folder_name, "BEAST", "lib", "beast.jar")
  if (os != "win") {
    jar_file_path <- file.path(folder_name, "beast", "lib", "launcher.jar")
  }
  bin_file_path <- file.path(folder_name, "BEAST", "BEAST.exe")
  if (os != "win") {
    bin_file_path <- file.path(folder_name, "beast", "bin", "beast")
  }
  testthat::expect_true(file.exists(jar_file_path))
  testthat::expect_true(file.exists(bin_file_path))
  if (isTRUE(verbose)) {
    print(paste0("Uninstalling BEAST2 from '", folder_name, "'"))
  }
  unlink(folder_name, recursive = TRUE)
}
