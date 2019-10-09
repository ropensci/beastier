#' Clear the BEAST2 working directory.
#'
#' This function will remove all folders in the BEAST2 working directory,
#' resulting in an empty BEAST2 working directory.
#'
#' To assure one cannot accidentally delete important folders,
#' there are some checks on the name of the supplied \code{beast2_working_dir}
#' @inheritParams default_params_doc
#' @seealso use \link{get_default_beast2_working_dir} to get the path
#' to the default BEAST2 working directory
#' @export
clear_beast2_working_dir <- function(
  beast2_working_dir = get_default_beast2_working_dir()
) {
  if (basename(beast2_working_dir) != "beastier") {
    stop(
      "BEAST2 working directory must end with folder name 'beastier', \n",
      "for example '", get_default_beast2_working_dir(), "'. \n",
      "Actual value: '", beast2_working_dir, "'. \n",
      "Tip: use 'get_default_beast2_working_dir()'"
    )
  }
  folders <- list.files(beast2_working_dir, full.names = TRUE)
  unlink(folders, recursive = TRUE)
}
