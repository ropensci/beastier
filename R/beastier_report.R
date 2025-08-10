#' Creates a \link{beastier} report
#'
#' Creates a \link{beastier} report, to be used when reporting bugs.
#' Uses \link{message}
#' @inheritParams default_params_doc
#' @return No return value, the information will be shown using \link{message}
#' @examples
#' check_empty_beaustier_folders()
#'
#' beastier_report()
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
beastier_report <- function(
  beast2_folder = beastier::get_default_beast2_folder(),
  os = rappdirs::app_dir()$os
) {
  message("***********")
  message("* beastier *")
  message("***********")
  message("OS: ", os)
  message("beast2_folder: ", beast2_folder)
  beast2_path <- beastier::get_default_beast2_path(
    beast2_folder = beast2_folder
  )
  message("beast2_path: ", beast2_path)
  message("****************")
  message("* Dependencies *")
  message("****************")
  message("beautier version: ", utils::packageVersion("beautier"))
  message("beastier version: ", utils::packageVersion("beastier"))
  message("**********")
  message("* BEAST2 *")
  message("**********")
  message("Java version: ", get_java_version())
  message(
    "Is BEAST2 installed: ",
    beastier::is_beast2_installed(folder_name = beast2_folder)
  )
  if (beastier::is_beast2_installed(folder_name = beast2_folder)) {
    message(
      "BEAST2 version: ",
      beastier::get_beast2_version(beast2_path = beast2_path)
    )
    message(
      "BEAST2 default path: ",
      beastier::get_default_beast2_bin_path(beast2_folder = beast2_folder)
    )
  }
  message("****************")
  message("* session info *")
  message("****************")
  message(paste0(sessioninfo::session_info(), collapse = "\n"))
}
