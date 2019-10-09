#' Check if the \code{beast2_options} will not overwrite
#' existing files, when the 'overwrite' options is set to \code{FALSE}
#'
#' Will \link{stop} if a file is threatened to be overwritten
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_options_do_not_overwrite_existing_files <- function( # nolint indeed a long function name, which is fine for internal functions
  beast2_options,
  beast2_internal_filenames
) {
  beastier::check_beast2_options(beast2_options)
  beastier::check_beast2_internal_filenames(beast2_internal_filenames)
  if (beast2_options$overwrite) return()
  testit::assert(beast2_options$overwrite == FALSE)

  bifs <- beast2_internal_filenames

  if (file.exists(bifs$output_log_filename_full)) {
    stop("Will not overwrite 'output_log_filename' ('",
      bifs$output_log_filename_full, "') with 'overwrite' is FALSE"
    )
  }
  if (any(file.exists(bifs$output_trees_filenames_full))) {
    stop("Will not overwrite 'output_trees_filenames' ('",
      bifs$output_trees_filenames_full, "') with 'overwrite' is FALSE"
    )
  }
  if (file.exists(bifs$output_state_filename_full)) {
    stop("Will not overwrite 'output_state_filename' ('",
      bifs$output_state_filename_full, "') with 'overwrite' is FALSE"
    )
  }
}
