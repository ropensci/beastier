#' Run BEAST2
#' @inheritParams default_params_doc
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   beast2_options <- create_beast2_options(
#'     input_filename = get_beastier_path("2_4.xml")
#'   )
#'
#'   expect_false(file.exists(beast2_options$output_state_filename))
#'
#'   output <- run_beast2_from_options(beast2_options)
#'
#'   expect_true(length(output) > 40)
#'   expect_true(file.exists(beast2_options$output_state_filename))
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
run_beast2_from_options <- function(
  beast2_options = create_beast2_options()
) {
  beastier::check_beast2_options(beast2_options)

  if (beast2_options$verbose) {
    beastier::print_beast2_options(beast2_options)
  }

  if (is_win_bin_path(beast2_options$beast2_path)) {
   stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  ##############################################################################
  # Deduce the full paths of the input and output files
  ##############################################################################
  # Beast2 Internal FilenameS
  bifs <- beastier::create_beast2_internal_filenames(beast2_options)

  if (beast2_options$verbose) {
    beastier::print_beast2_internal_filenames(bifs, show_exist = FALSE)
  }
  ##############################################################################
  # Check files
  ##############################################################################
  beastier::check_input_filename(bifs$input_filename_full)
  beastier::check_beast2_path(beast2_options$beast2_path)
  check_beast2_options_do_not_overwrite_existing_files( # nolint beastier function
    beast2_options = beast2_options,
    beast2_internal_filenames = bifs
  )

  check_input_filename_validity( # nolint internal function
    input_filename = bifs$input_filename_full,
    beast2_path = beast2_options$beast2_path,
    verbose = beast2_options$verbose
  )

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
      "Cannot create working directory '",
      beast2_options$beast2_working_dir, "' \n",
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
  if (beast2_options$verbose) {
    beastier::print_beast2_internal_filenames(bifs, show_exist = TRUE)
  }
  if (!file.exists(bifs$output_state_filename_full)) {
    stop(
      "BEAST2 state file not created. \n",
      "Relative path, from 'beast2_options': '",
        beast2_options$output_state_filename,"'\n",
      "Full path: '", bifs$output_state_filename_full,"'\n",
      "Maybe no permission to write at that location?"
    )
  }
  beautier::check_file_exists(
    bifs$output_state_filename_full, "output_state_filename_full"
  )

  output
}
