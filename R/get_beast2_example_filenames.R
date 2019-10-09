#' Get a list with the full paths of all
#' BEAST2 example filenames
#' @inheritParams default_params_doc
#' @return a list with the full paths of all
#' BEAST2 example filenames
#' @export
get_beast2_example_filenames <- function(
  folder = get_default_beast2_folder()
) {
  beast2_folder <- file.path(folder, "beast")
  testit::assert(dir.exists(beast2_folder))
  examples_folder <- file.path(beast2_folder, "examples")
  testit::assert(dir.exists(examples_folder))
  list.files(
    path = examples_folder,
    full.names = TRUE,
    recursive = TRUE
  )
}
