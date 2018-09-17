#' Checks if BEAST2 is installed
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files are put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @return TRUE if BEAST2 is installed
#' @author Richel J.C. Bilderbeek
#' @export
is_beast2_installed <- function(
  folder_name = get_default_beast2_folder()
) {
  bin_exists <- file.exists(file.path(folder_name, "beast", "bin", "beast"))
  jar_exists <- file.exists(file.path(folder_name, "beast", "lib", "beast.jar"))
  testit::assert(bin_exists == jar_exists)
  jar_exists
}
