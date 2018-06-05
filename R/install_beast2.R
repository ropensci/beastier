#' Install BEAST2
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put. The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @param verbose show debug info
#' @examples
#'   install_beast2()
#'   testit::assert(file.exists(get_default_beast2_jar_path()))
#' @author Richel J.C. Bilderbeek
#' @export
install_beast2 <- function(
  folder_name = rappdirs::user_data_dir(),
  verbose = FALSE
) {
  dir.create(path = folder_name,  showWarnings = FALSE, recursive = TRUE)
  tgz_filename <- "BEAST.v2.5.0.Linux.tgz"
  url <- paste0(
    "https://github.com/CompEvol/beast2/releases/download/v2.5.0/",
    tgz_filename
  )
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
