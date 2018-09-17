#' Install BEAST2
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put. The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @return Nothing. Will install BEAST2
#' @examples
#'   install_beast2()
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
  if (!os %in% c("win","unix")) {
    stop("'os' must be either 'win' or 'unix")
  }
  if (verbose == TRUE) {
    print(paste("Operating system:", os))
  }
  dir.create(path = folder_name,  showWarnings = FALSE, recursive = TRUE)
  url <- get_default_beast2_download_url(os = os)
  if (verbose == TRUE) {
    print(paste("Download from URL:", url))
  }
  tgz_filename <- basename(url)
  local_path <- file.path(folder_name, tgz_filename)
  utils::download.file(
    url = url,
    destfile = local_path
  )
  testit::assert(file.exists(local_path))
  utils::untar(
    tarfile = local_path,
    exdir = path.expand(folder_name),
    verbose = TRUE
  )

  jar_file_path <- file.path(folder_name, "beast", "lib", "beast.jar")
  if (verbose == TRUE) {
    print(paste("BEAST2 installed at", jar_file_path))
  }
  testit::assert(file.exists(jar_file_path))
}
