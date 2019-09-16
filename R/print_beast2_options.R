#' Pretty-print a \code{beast2_options}
#' @export
print_beast2_options <- function(beast2_options) {
  check_beast2_options(beast2_options) # nolint beastier function
  cat(
    paste0(
      "input_filename: ", beast2_options$input_filename, " \n",
      "output_log_filename: ", beast2_options$output_log_filename, " \n",
      "output_trees_filenames: ", beast2_options$output_trees_filenames, " \n",
      "output_state_filename: ", beast2_options$output_state_filename
    )
  )

}
