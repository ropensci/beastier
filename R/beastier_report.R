#' Create a \link{beastier} report, to be used when reporting bugs
#' @export
beastier_report <- function() {
  kat <- function(x) cat(x, sep = "\n")
  kat("***********")
  kat("* beastier *")
  kat("***********")
  kat(paste0("OS: ", rappdirs::app_dir()$os))
  kat("****************")
  kat("* Dependencies *")
  kat("****************")
  kat(paste0("beautier version: ", utils::packageVersion("beautier")))
  kat(paste0("beastier version: ", utils::packageVersion("beastier")))
  kat("**********")
  kat("* BEAST2 *")
  kat("**********")
  kat(paste0("Java version: ", beastier::get_java_version()))
  kat(paste0("Is BEAST2 installed: ", beastier::is_beast2_installed()))
  if (beastier::is_beast2_installed()) {
    kat(paste0("BEAST2 version: ", beastier::get_beast2_version()))
    kat(
      paste0(
        "BEAST2 default path: ",
        beastier::get_default_beast2_bin_path()
      )
    )
  }
  kat("****************")
  kat("* session info *")
  kat("****************")
  message(paste0(devtools::session_info(), collapse = "\n"))
}
