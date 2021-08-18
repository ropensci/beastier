#' Deprecated function to install BEAST2
#'
#' This function is deprecated as it violated CRAN policy.
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/launcher.jar}
#' @return Nothing. Gives a deprecation message using \link{stop}.
#' @author Richèl J.C. Bilderbeek
#' @export
install_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  beast2_version = beastier::get_default_beast2_version(),
  verbose = FALSE,
  os = rappdirs::app_dir()$os
) {
  stop(
    "'beastier::install_beast2' is deprecated, \n",
    "as it violated CRAN policy. \n",
    " \n",
    "To install BEAST2 from R, do: \n",
    " \n",
    "remotes::install_github(\"richelbilderbeek/beastierinstall\") \n",
    "beastierinstall::install_beast2() \n"
  )
}
