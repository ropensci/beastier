#' Upgrade BEAST2.
#'
#' Will \link{stop} if BEAST2 is not installed
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'   expect_equal(get_beast2_version(), "2.6.0")
#' }
upgrade_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  os = rappdirs::app_dir()$os
) {
  if (!is_beast2_installed(folder_name = folder_name, os = os)) {
    stop(
      "BEAST2 is not installed, so cannot upgrade.\n",
      "\n",
      "Tip: use 'beastier::install_beast2()'"
    )
  }
  uninstall_beast2()
  install_beast2()
}
