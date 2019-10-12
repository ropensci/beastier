#' Create a list with the internally used BEAST2 filenames
#' @inheritParams default_params_doc
#' @return a list with the internally used BEAST2 filenames
#' @examples
#' library(testthat)
#'
#' beast2_options <- create_beast2_options(
#'   input_filename = get_beastier_path("2_4.xml")
#' )
#' if (is_beast2_installed()) {
#'   beast2_internal_filenames <- create_beast2_internal_filenames(
#'     beast2_options
#'   )
#'   bif_names <- names(beast2_internal_filenames)
#'   expect_true("input_filename_full" %in% bif_names)
#'   expect_true("actual_log_filename" %in% bif_names)
#'   expect_true("actual_trees_filenames" %in% bif_names)
#'   expect_true("output_log_filename_full" %in% bif_names)
#'   expect_true("output_trees_filenames_full" %in% bif_names)
#'   expect_true("output_state_filename_full" %in% bif_names)
#' }
#' @export
create_beast2_internal_filenames <- function(beast2_options) { # nolint indeed a long function name, which is fine for internal function

  # BEAST2 Internally-used FilenameS
  bifs <- list()
  ##############################################################################
  # input_filename_full
  ##############################################################################
  bifs$input_filename_full <- beast2_options$input_filename
  if (basename(beast2_options$input_filename) ==
    beast2_options$input_filename
  ) {
    bifs$input_filename_full <- file.path(
      getwd(), beast2_options$input_filename
    )
  }

  ##############################################################################
  # Intermediate, these are files created by BEAST2, if there is
  # a folder for them
  ##############################################################################
  # actual_log_filename
  ##############################################################################
  bifs$actual_log_filename <- file.path(
    beast2_options$beast2_working_dir,
    basename(
      create_default_log_filename(
        input_filename = bifs$input_filename_full,
        beast2_path = beast2_options$beast2_path
      )
    )
  )

  # Do not warning if the folder already exists, unless when being verbose
  dir.create(
    dirname(bifs$actual_log_filename), showWarnings = FALSE, recursive = TRUE
  )

  ##############################################################################
  # actual_trees_filenames
  ##############################################################################
  bifs$actual_trees_filenames <- NA
  for (i in seq_along(beast2_options$output_trees_filenames)) {
    bifs$actual_trees_filenames[i] <- file.path(
      beast2_options$beast2_working_dir,
      basename(
        create_default_trees_filenames(
          input_filename = bifs$input_filename_full,
          beast2_path = beast2_options$beast2_path,
          verbose = beast2_options$verbose
        )[i]
      )
    )
    # Do not warning if the folder already exists, unless when being verbose
    dir.create(
      dirname(bifs$actual_trees_filenames[i]),
      showWarnings = FALSE, recursive = TRUE
    )
  }

  ##############################################################################
  # output_log_filename_full
  ##############################################################################
  bifs$output_log_filename_full <- beast2_options$output_log_filename
  if (basename(beast2_options$output_log_filename) ==
      beast2_options$output_log_filename
    ) {
    bifs$output_log_filename_full <- file.path(
      getwd(), beast2_options$output_log_filename
    )
  }
  # Do not warning if the folder already exists, unless when being verbose
  dir.create(
    dirname(bifs$output_log_filename_full),
    showWarnings = FALSE, recursive = TRUE
  )

  ##############################################################################
  # output_trees_filenames_full
  ##############################################################################
  bifs$output_trees_filenames_full <- beast2_options$output_trees_filenames
  for (i in seq_along(beast2_options$output_trees_filenames_full)) {
    if (basename(beast2_options$output_trees_filenames[i]) ==
        beast2_options$output_trees_filenames[i]
    ) {
      bifs$output_trees_filenames_full[i] <- file.path(
        getwd(), beast2_options$output_trees_filenames[i]
      )
    }
    # Do not warning if the folder already exists, unless when being verbose
    dir.create(
      dirname(bifs$output_trees_filenames_full[i]),
      showWarnings = FALSE, recursive = TRUE
    )
  }

  ##############################################################################
  # output_state_filename_full
  ##############################################################################
  bifs$output_state_filename_full <- beast2_options$output_state_filename
  if (basename(beast2_options$output_state_filename) ==
      beast2_options$output_state_filename
  ) {
    bifs$output_state_filename_full <- file.path(
      getwd(), beast2_options$output_state_filename
    )
  }
  # Do not warning if the folder already exists, unless when being verbose
  dir.create(
    dirname(bifs$output_state_filename_full),
    showWarnings = FALSE, recursive = TRUE
  )

  bifs
}
