#' Create the default \code{.trees} filenames
#' @param input_filename the name of a BEAST2 input XML file
#' @author: Richel J.C. Bilderbeek
create_default_trees_filenames <- function(
  input_filename,
  beast2_jar_path,
  verbose
) {
  check_input_filename(input_filename)
  check_beast2_jar_path(beast2_jar_path)
  check_input_filename_validity(
    input_filename = input_filename,
    beast2_jar_path = beast2_jar_path,
    verbose = verbose
  )

  testit::assert(file.exists(input_filename))
  testit::assert(file.exists(beast2_jar_path))
  testit::assert(
    is_beast2_input_file( # nolint internal function
      input_filename,
      beast2_jar_path = beast2_jar_path
    )
  )
  alignment_ids <- get_alignment_ids(input_filename) # nolint internal function
  paste0(alignment_ids, ".trees")
}
