#' Get the default BEAST2 jar file's path
#' @inheritParams default_params_doc
#' @return the default BEAST2 jar file's path
#' @seealso Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed.
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this location.
#' @examples
#'   library(testthat)
#'
#'   if (is_beast2_installed() && rappdirs::app_dir()$os == "unix") {
#'     expect_true(
#'       grepl(
#'         "beast/lib/launcher.jar",
#'         get_default_beast2_jar_path()
#'       )
#'     )
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
get_default_beast2_jar_path <- function(
  os = rappdirs::app_dir()$os
) {
  beastier::check_os(os = os)
  # Windows    : BEAST/lib/beast.jar                                            # nolint
  # Non-Windows: beast/lib/launcher.jar                                         # nolint
  beast_foldername <- "BEAST"
  if (os != "win") {
    beast_foldername <- "beast"
  }
  launcher_name <- "beast.jar"
  if (os != "win") {
    launcher_name <- "launcher.jar"
  }

  normalizePath(
    file.path(
      rappdirs::user_data_dir(),
      beast_foldername,
      "lib",
      launcher_name
    ),
    mustWork = FALSE
  ) # nolint internal function
}
