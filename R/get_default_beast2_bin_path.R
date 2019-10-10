#' Get the default BEAST2 binary file (\code{beast}, that is) path
#' @inheritParams default_params_doc
#' @return the default BEAST2 binary file's path
#' @seealso Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed.
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this location.
#' @examples
#'   if (is_beast2_installed() && rappdirs::app_dir()$os == "unix") {
#'     testit::assert(
#'       grepl(
#'         "beast/bin/beast",
#'         get_default_beast2_bin_path()
#'       )
#'     )
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
get_default_beast2_bin_path <- function(
  os = rappdirs::app_dir()$os
) {
  beastier::check_os(os)
  # Windows has uppercase folder name
  beast_foldername <- "BEAST"
  if (os != "win") {
    beast_foldername <- "beast"
  }
  beast2_bin_raw_path <- file.path(
    rappdirs::user_data_dir(),
    beast_foldername,
    "BEAST.exe"
  )
  if (os != "win") {
    beast2_bin_raw_path <- file.path(
      rappdirs::user_data_dir(),
      beast_foldername,
      "bin",
      "beast"
    )
  }
  normalizePath(beast2_bin_raw_path, mustWork = FALSE)
}
