#' Check there are no files in the default \link{beastier} folder
#'
#' Check there are no files in the default \link{beastier} folder.
#' The goal is to make sure no temporary files are left undeleted.
#' Will \link{stop} if there are files in the \link{beastier} folder
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if there are files in the \link{beastier} folder
#' @author Richèl J.C. Bilderbeek
#' @export
check_empty_beastier_folder <- function(
  beastier_folder = get_beastier_folder()
) {
  if (!dir.exists(beastier_folder)) return(invisible(beastier_folder))
  dirs <- normalizePath(list.dirs(beastier_folder))
  dirs <- dirs[dirs != normalizePath(beastier_folder, mustWork = FALSE)]

  if (length(dirs) != 0) {
    stop(
      "Folders found in beastier folder. \n",
      "beastier_folder: ", beastier_folder, " \n",
      "length(list.dirs(beastier_folder)): ", length(dirs), " \n",
      "head(list.dirs(beastier_folder)): ",
      paste(utils::head(dirs), collapse = ",")
    )
  }
  filenames <- list.files(beastier_folder, full.names = TRUE, recursive = TRUE)
  if (length(filenames) != 0) {
    stop(
      "Files found in beastier folder. \n",
      "beastier_folder: ", beastier_folder, " \n",
      "length(list.files(beastier_folder))): ", length(filenames), " \n",
      "head(list.files(beastier_folder)): ",
      paste(utils::head(filenames), collapse = ",")
    )
  }
  if (dir.exists(beastier_folder)) {
    stop("'beastier' folder found at ", beastier_folder)
  }
  invisible(beastier_folder)
}
