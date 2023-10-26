#' Deprecated function to upgrade BEAST2.
#' @inheritParams default_params_doc
#' @return Nothing.
#' A deprecation message using \link{stop} will be triggered
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/launcher.jar}
#' @author Richèl J.C. Bilderbeek
upgrade_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  os = rappdirs::app_dir()$os
) {
  stop(
    "'beastier::upgrade_beast2' is deprecated, \n",
    "as it violated CRAN policy. \n",
    " \n",
    "To upgrade BEAST2 from R, do: \n",
    " \n",
    "remotes::install_github(\"richelbilderbeek/beastierinstall\") \n",
    "beastierinstall::upgrade_beast2() \n"
  )
}
