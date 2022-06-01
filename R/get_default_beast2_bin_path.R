#' Get the default BEAST2 binary file (\code{beast}, that is) path
#' @inheritParams default_params_doc
#' @return the default BEAST2 binary file's path
#' @seealso Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed.
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this location.
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed()) {
#'   get_default_beast2_bin_path()
#' }
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
get_default_beast2_bin_path <- function(
  beast2_folder = get_default_beast2_folder(),
  os = rappdirs::app_dir()$os
) {
  beastier::check_os(os)
  # Windows has uppercase folder name
  beast_foldername <- "BEAST"
  if (os != "win") {
    beast_foldername <- "beast"
  }
  beast2_bin_raw_path <- file.path(
    beast2_folder,
    beast_foldername,
    "BEAST.exe"
  )
  if (os != "win") {
    beast2_bin_raw_path <- file.path(
      beast2_folder,
      beast_foldername,
      "bin",
      "beast"
    )
  }
  normalizePath(beast2_bin_raw_path, mustWork = FALSE)
}
