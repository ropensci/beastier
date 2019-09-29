#' Get the default BEAST2 download URL,
#' which depends on the operating system
#' @return the URL where BEAST2 can be downloaded from
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_true(
#'     grepl(
#'       "https://github.com/CompEvol/beast2/releases/download",
#'       get_default_beast2_download_url()
#'     )
#'   )
#'
#'   if (rappdirs::app_dir()$os == "unix") {
#'     expect_true(
#'       grepl(
#'         "BEAST.v[0-9\\.]+.Linux.tgz",
#'         get_default_beast2_download_url()
#'       )
#'     )
#'   }
#' @noRd
get_default_beast2_download_url <- function( # nolint internal functions may be long
  os = rappdirs::app_dir()$os
) {
  check_os(os) # nolint internal function
  url <- get_default_beast2_download_url_win() # nolint internal function
  if (os != "win") {
    url <- get_default_beast2_download_url_linux() # nolint internal function
  }
  url
}

#' Get the BEAST2 download URL for Linux
#' @return the URL where BEAST2 can be downloaded from
#' @author Richèl J.C. Bilderbeek
#' @noRd
get_default_beast2_download_url_linux <- function() { # nolint internal functions may be long
  "https://github.com/CompEvol/beast2/releases/download/v2.6.1/BEAST.v2.6.1.Linux.tgz" # nolint URL can be long
}

#' Get the BEAST2 download URL for Windows
#' @return the URL where BEAST2 can be downloaded from
#' @author Richèl J.C. Bilderbeek
#' @noRd
get_default_beast2_download_url_win <- function() { # nolint internal functions may be long
  "https://github.com/CompEvol/beast2/releases/download/v2.6.1/BEAST.v2.6.1.Windows.zip" # nolint URL can be long
}
