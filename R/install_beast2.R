#' Install BEAST2

#' Installs BEAST2 of the default
#' version (see \link{get_default_beast2_version}), but another version
#' can also be specified
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put.
#'   The name of the BEAST2 binary file will be at
#'   \code{[folder_name]/beast/bin/beast}
#'   The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/launcher.jar}
#' @return Nothing. Will install BEAST2
#' @examples
#' \dontrun{
#'   install_beast2()
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
install_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  beast2_version = beastier::get_default_beast2_version(),
  verbose = FALSE,
  os = rappdirs::app_dir()$os
) {
  beastier::check_os(os)
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
  url <- beastier::get_default_beast2_download_url(
    beast2_version = beast2_version,
    os = os
  )
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

  # Linux uses a tar file, Windows uses a zip file
  extract_function_linux <- pryr::partial(
    utils::untar,
    tarfile = local_path,
    exdir = path.expand(folder_name),
    verbose = verbose
  )
  extract_function_win <- pryr::partial(
    utils::unzip,
    zipfile = local_path,
    exdir = path.expand(folder_name)
  )
  extract_function <- extract_function_win
  if (os != "win") {
    extract_function <- extract_function_linux
  }
  extract_function()
  beautier::check_file_exists(jar_file_path, "BEAST2 .jar path")
  if (verbose == TRUE) {
    print(paste("BEAST2 installed at", jar_file_path))
  }
}
