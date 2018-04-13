#' Install BEAST2
#' @param folder_name name of the folder where the BEAST2 files will
#'   be put. The name of the BEAST2 jar file will be at
#'   \code{[folder_name]/beast/lib/beast.jar}
#' @examples
#'   folder_name <- "~/my_folder/beast2"
#'   install_beast2(folder_name)
#'   beast2_jar_path <- paste0(folder_name, "/beast/lib/beast.jar")
#'   testit::assert(file.exists(beast2_jar_path))
#' @author Richel J.C. Bilderbeek
#' @note This function only tested to work under GNU/Linux
#' @export
install_beast2 <- function(folder_name) {
  dir.create(path = folder_name,  showWarnings = FALSE, recursive = TRUE)
  tgz_filename <- "BEAST.v2.4.8.Linux.tgz"
  url <- paste0(
    "https://github.com/CompEvol/beast2/releases/download/v2.4.8/",
    tgz_filename
  )
  local_path <- path.expand(paste0(folder_name, "/", tgz_filename))
  utils::download.file(
    url = url,
    destfile = local_path
  )
  testit::assert(file.exists(local_path))
  utils::untar(
    tarfile = local_path,
    exdir = path.expand(paste0(folder_name)),
    verbose = TRUE
  )
}