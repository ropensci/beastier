#' Install BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @return Nothing. Will install BEAST2
#' @examples
#'   if (!is_beast2_installed()) {
#'     install_beast2()
#'   }
#'   testit::assert(file.exists(get_default_beast2_path()))
#'   testit::assert(file.exists(get_default_beast2_bin_path()))
#'   testit::assert(file.exists(get_default_beast2_jar_path()))
#' @author Richel J.C. Bilderbeek
#' @export
install_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  verbose = FALSE,
  os = rappdirs::app_dir()$os
) {
  check_os(os = os) # nolint internal function
  jar_file_path <- file.path(folder_name, "BEAST", "lib", "beast.jar")
  if (os == "unix") {
    jar_file_path <- file.path(folder_name, "beast", "lib", "beast.jar")
  }
  if (file.exists(jar_file_path)) {
    stop("BEAST2 already installed")
  }
  if (verbose == TRUE) {
    print(paste("Operating system:", os))
  }
  dir.create(path = folder_name,  showWarnings = FALSE, recursive = TRUE)
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
  testit::assert(file.exists(local_path))
  if (os == "unix") {
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
  if (verbose == TRUE) {
    print(paste("BEAST2 installed at", jar_file_path))
  }
  testit::assert(file.exists(jar_file_path))
}
