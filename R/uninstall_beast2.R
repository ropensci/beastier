#' Deprecated function to uninstall BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files are installed.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/launcher.jar}
#' @author Richèl J.C. Bilderbeek
#' @export
uninstall_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  os = rappdirs::app_dir()$os,
  verbose = FALSE
) {
  stop(
    "'beastier::uninstall_beast2' is deprecated, \n",
    "as it violated CRAN policy. \n",
    " \n",
    "To uninstall BEAST2 from R, do: \n",
    " \n",
    "remotes::install_github(\"richelbilderbeek/beastierinstall\") \n",
    "beastierinstall::uninstall_beast2() \n"
  )
}
