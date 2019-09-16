#' Run BEAST2
#' @inheritParams default_params_doc
#' @export
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   beast2_options <- create_beast2_options(
#'     input_filename = get_beastier_path("2_4.xml")
#'   )
#'
#'   expect_false(file.exists(beast2_options$output_log_filename))
#'   expect_false(file.exists(beast2_options$output_trees_filenames))
#'   expect_false(file.exists(beast2_options$output_state_filename))
#'
#'   output <- run_beast2_from_options(beast2_options)
#'
#'   expect_true(length(output) > 40)
#'   expect_true(file.exists(beast2_options$output_log_filename))
#'   expect_true(file.exists(beast2_options$output_trees_filenames))
#'   expect_true(file.exists(beast2_options$output_state_filename))
#' }
#' @author Richèl J.C. Bilderbeek
run_beast2_from_options <- function(
  beast2_options = create_beast2_options()
) {
  check_beast2_options(beast2_options) # nolint beastier function

  if (beast2_options$verbose) {
    print_beast2_options(beast2_options)
  }

  if (is_win_bin_path(beast2_options$beast2_path)) {
   stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  ##############################################################################
  # Deduce the full paths of the input and output files
  ##############################################################################
  # Beast2 Internal FilenameS
  bifs <- create_beast2_internal_filenames(
    beast2_options
  )

  if (beast2_options$verbose) {
    print_beast2_internal_filenames(bifs, show_exist = FALSE)
  }
  ##############################################################################
  # Check files
  ##############################################################################
  check_input_filename(bifs$input_filename_full) # nolint beastier function
  check_beast2_path(beast2_options$beast2_path) # nolint beastier function
  check_beast2_options_do_not_overwrite_existing_files( # nolint beastier function
    beast2_options = beast2_options,
    beast2_internal_filenames = bifs
  )
  # It is fine that these files existed, as they existed in the
  # temporary BEAST2 working directory.
  remove_file_if_present(bifs$actual_log_filename) # nolint beastier function
  remove_files_if_present(bifs$actual_trees_filenames) # nolint beastier function

  testit::assert(!file.exists(bifs$actual_log_filename))
  testit::assert(all(!file.exists(bifs$actual_trees_filenames)))

  check_input_filename_validity( # nolint internal function
    input_filename = bifs$input_filename_full,
    beast2_path = beast2_options$beast2_path,
    verbose = beast2_options$verbose
  )

  alignment_ids <- get_alignment_ids_from_xml_filename( # nolint internal function
    bifs$input_filename_full
  )

  if (length(beast2_options$output_trees_filenames) != length(alignment_ids)) {
    stop(
      "'output_trees_filenames' must have as much elements as ",
      "'input_filename' has alignments. 'output_trees_filenames' has ",
      length(beast2_options$output_trees_filenames), " elements, ",
      "'input_filename' has ", length(alignment_ids), " alignments"
    )
  }

  ##############################################################################
  # Store old wd, create and change to beast2_working_dir
  ##############################################################################
  cur_wd <- getwd()
  # Move working directory to temporary folder
  # Do not warning if the folder already exists, unless when being verbose
  dir.create(
    beast2_options$beast2_working_dir,
    showWarnings = FALSE, recursive = TRUE
  )

  # Although 'dir.create' creates folders recursively,
  # it only has the user's permission. As the user
  # is not running as root, it cannot create root folders
  if (!dir.exists(beast2_options$beast2_working_dir)) {
    dir.create(
      beast2_options$beast2_working_dir,
      showWarnings = TRUE, recursive = TRUE
    )
    stop(
      "Cannot create working directory '", beast2_options$beast2_working_dir, "' \n",
      "Maybe no permission to create it there? \n"
    )
  }
  # This will fail if the temp_wd cannot be created
  tryCatch(
    setwd(beast2_options$beast2_working_dir),
    error = function(e) {
      stop(
        "Cannot set working directory to '",
          beast2_options$beast2_working_dir, "' \n",
        "Maybe no permission to change to that location?\n",
        "Error message: ", e$message, " \n"
      )
    }
  )

  ##############################################################################
  # Create the BEAST2 command
  ##############################################################################
  testit::assert(length(bifs$input_filename_full) == 1)
  testit::assert(length(beast2_options$output_state_filename) == 1)
  testit::assert(length(beast2_options$rng_seed) == 1)
  testit::assert(length(beast2_options$n_threads) == 1)
  testit::assert(length(beast2_options$use_beagle) == 1)
  testit::assert(length(beast2_options$overwrite) == 1)
  testit::assert(length(beast2_options$beast2_path) == 1)

  cmd <- beastier::create_beast2_run_cmd(
    input_filename = bifs$input_filename_full,
    output_state_filename = bifs$output_state_filename_full,
    rng_seed = beast2_options$rng_seed,
    n_threads = beast2_options$n_threads,
    use_beagle = beast2_options$use_beagle,
    overwrite = beast2_options$overwrite,
    beast2_path = beast2_options$beast2_path
  )

  if (beast2_options$verbose == TRUE) {
    print(paste("cmd:", paste0(cmd, collapse = " ")))
  }

  # Create the folder to hold the file, without warning if it's already present
  dir.create(
    path = dirname(bifs$output_state_filename_full),
    recursive = TRUE,
    showWarnings = FALSE
  )

  ##############################################################################
  # Run BEAST2
  ##############################################################################
  output <- system2(
    command = cmd[1],
    args = cmd[-1],
    stdout = TRUE,
    stderr = TRUE
  )
  if (length(output) == 1) {
    stop(
      "Command '", paste0(cmd, collapse = " "), "' failed ",
      "with error '", output, "'"
    )
  }

  # Copying done, back to original working directory
  setwd(cur_wd)

  ##############################################################################
  # The files as created by BEAST2
  ##############################################################################
  if (!file.exists(bifs$actual_log_filename)) {
    stop(
      "BEAST2 .log file not created at '", bifs$actual_log_filename, "' \n",
      "Maybe no permission to write at that location?"
    )
  }

  # Copy to target, will overwrite if this was desired
  beautier::check_file_exists(bifs$actual_log_filename, "actual_log_filename")
  # Create the folder to hold the file, without warning if it's already present
  dir.create(
    path = dirname(beast2_options$output_log_filename),
    recursive = TRUE,
    showWarnings = FALSE
  )
  check_can_create_file(beast2_options$output_log_filename, overwrite = beast2_options$overwrite) # nolint beautier function
  file.rename(from = bifs$actual_log_filename, to = beast2_options$output_log_filename)

  for (i in seq_along(beast2_options$output_trees_filenames)) {
    to <- beast2_options$output_trees_filenames[i]
    actual_trees_filename <- bifs$actual_trees_filenames[i]
    beautier::check_file_exists(actual_trees_filename, "actual_trees_filename")
    # Create the folder to hold the file,
    # without warning if it's already present
    dir.create(
      path = dirname(to),
      recursive = TRUE,
      showWarnings = FALSE
    )
    check_can_create_file(to, overwrite = beast2_options$overwrite) # nolint beautier function
    file.rename(from = actual_trees_filename, to = to)
  }

  if (beast2_options$verbose) {
    print_beast2_internal_filenames(bifs, show_exist = TRUE)
  }

  beautier::check_file_exists(beast2_options$output_log_filename, "output_log_filename")
  beautier::check_file_exists(
    bifs$output_state_filename_full, "output_state_filename_full"
  )
  testit::assert(all(file.exists(beast2_options$output_trees_filenames)))

  output
}
