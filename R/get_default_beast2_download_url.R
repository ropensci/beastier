#' Get the default BEAST2 download URL,
#' which depends on the operating system
#' @return the URL where BEAST2 can be downloaded from
#' @author Richel J.C. Bilderbeek
#' @noRd
get_default_beast2_download_url <- function(
  os = rappdirs::app_dir()$os
) {
  testit::assert(os == "win" || os == "unix")
  url <- get_default_beast2_download_url_win() # nolint internal function
  if (os == "unix") {
    url <- get_default_beast2_download_url_linux() # nolint internal function
  }
  url
}

#' Get the BEAST2 download URL for Linux
#' @return the URL where BEAST2 can be downloaded from
#' @author Richel J.C. Bilderbeek
#' @noRd
get_default_beast2_download_url_linux <- function() { # nolint internal functions may be long
  "https://github.com/CompEvol/beast2/releases/download/v2.5.0/BEAST.v2.5.0.Linux.tgz" # nolint URL can be long
}

#' Get the BEAST2 download URL for Windows
#' @return the URL where BEAST2 can be downloaded from
#' @author Richel J.C. Bilderbeek
#' @noRd
get_default_beast2_download_url_win <- function() { # nolint internal functions may be long
  "https://github.com/CompEvol/beast2/releases/download/v2.5.0/BEAST.v2.5.0.Windows.zip" # nolint URL can be long
}
