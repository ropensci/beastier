#' Install BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/launcher.jar}
#' @return Nothing. Will install BEAST2
#' @examples
#'   library(testthat)
#'
#'   if (is_on_ci()) {
#'
#'     if (!is_beast2_installed()) {
#'       install_beast2()
#'     }
#'     expect_true(file.exists(get_default_beast2_path()))
#'     expect_true(file.exists(get_default_beast2_bin_path()))
#'     expect_true(file.exists(get_default_beast2_jar_path()))
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
install_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  verbose = FALSE,
  os = rappdirs::app_dir()$os
) {
  check_os(os = os) # nolint internal function
  # Windows    : BEAST/lib/beast.jar                                            # nolint
  # Non-Windows: beast/lib/launcher.jar                                         # nolint
  jar_file_path <- file.path(folder_name, "BEAST", "lib", "beast.jar")
  if (os != "win") {
    jar_file_path <- file.path(folder_name, "beast", "lib", "launcher.jar")
  }
  if (file.exists(jar_file_path)) {
    stop("BEAST2 already installed")
  }
  if (verbose == TRUE) {
    print(paste("Operating system:", os))
  }
  dir.create(path = folder_name, showWarnings = FALSE, recursive = TRUE)
  url <- get_default_beast2_download_url(os = os) # nolint internal function
  if (verbose == TRUE) {
    print(paste("Download from URL:", url))
  }
  # archive_filename is a .tar.gz for Linux and a .zip for Windows
  archive_filename <- basename(url)
  local_path <- file.path(folder_name, archive_filename)
  utils::download.file(
    url = url,
    destfile = local_path
  )
  beautier::check_file_exists(local_path, "local_path")
  if (os != "win") {
    # Linux has a tar file
    utils::untar(
      tarfile = local_path,
      exdir = path.expand(folder_name),
      verbose = verbose
    )
  } else {
    # Windows has a zip file
    testit::assert(os == "win")
    utils::unzip(
      zipfile = local_path,
      exdir = path.expand(folder_name)
    )
  }
  beautier::check_file_exists(jar_file_path, "BEAST2 .jar path")
  if (verbose == TRUE) {
    print(paste("BEAST2 installed at", jar_file_path))
  }
}
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
  check_os(os)
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
  "https://github.com/CompEvol/beast2/releases/download/v2.6.0/BEAST.v2.6.0.Linux.tgz" # nolint URL can be long
}

#' Get the BEAST2 download URL for Windows
#' @return the URL where BEAST2 can be downloaded from
#' @author Richèl J.C. Bilderbeek
#' @noRd
get_default_beast2_download_url_win <- function() { # nolint internal functions may be long
  "https://github.com/CompEvol/beast2/releases/download/v2.6.0/BEAST.v2.6.0.Windows.zip" # nolint URL can be long
}
install_beast2()
