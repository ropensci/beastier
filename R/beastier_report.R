#' Create a \link{beastier} report, to be used when reporting bugs
#' @author Richèl J.C. Bilderbeek
#' @export
beastier_report <- function(
  folder_name = get_default_beast2_folder(),
  os = rappdirs::app_dir()$os,
  beast2_folder = get_default_beast2_folder()
) {
  kat <- function(x) message(x, sep = "\n")
  kat("***********")
  kat("* beastier *")
  kat("***********")
  kat(paste0("OS: ", os))
  kat(paste0("folder_name: ", folder_name))
  beast2_path <- beastier::get_default_beast2_path(folder_name = folder_name)
  kat(paste0("beast2_path: ", beast2_path))
  kat(paste0("beast2_folder: ", beast2_folder))
  kat("****************")
  kat("* Dependencies *")
  kat("****************")
  kat(paste0("beautier version: ", utils::packageVersion("beautier")))
  kat(paste0("beastier version: ", utils::packageVersion("beastier")))
  kat("**********")
  kat("* BEAST2 *")
  kat("**********")
  kat(paste0("Java version: ", beastier::get_java_version()))
  kat(
    paste0(
      "Is BEAST2 installed: ",
      beastier::is_beast2_installed(folder_name = folder_name)
    )
  )
  if (beastier::is_beast2_installed(folder_name = folder_name)) {
    kat(
      paste0(
        "BEAST2 version: ",
        beastier::get_beast2_version(beast2_path = beast2_path)
      )
    )
    kat(
      paste0(
        "BEAST2 default path (aka 'beast2_folder'): ",
        beastier::get_default_beast2_bin_path(beast2_folder = beast2_folder)
      )
    )
  }
  kat("****************")
  kat("* session info *")
  kat("****************")
  message(paste0(devtools::session_info(), collapse = "\n"))
}
