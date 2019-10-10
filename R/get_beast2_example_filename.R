#' Get the full path of a BEAST2 example file
#'
#' Will \link{stop} if the filename is not a BEAST2 example file
#'
#' @inheritParams default_params_doc
#' @export
get_beast2_example_filename <- function(
  filename,
  beast2_folder = get_default_beast2_folder()
) {
  filenames <- beastier::get_beast2_example_filenames(
    beast2_folder = beast2_folder
  )
  index <- which(filename == basename(filenames))
  if (length(index) == 0) {
    stop(
      "Cannot find BEAST2 example file with name '", filename, "'. \n",
      "Tip: use 'get_beast2_example_filenames()' ",
        "to see all BEAST2 example files"
    )
  }
  filenames[index]
}
