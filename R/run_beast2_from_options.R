#' Run BEAST2
#' @inheritParams default_params_doc
#' @examples
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   beast2_options <- create_beast2_options(
#'     input_filename = get_beastier_path("2_4.xml")
#'   )
#'
#'   file.exists(beast2_options$output_state_filename))
#'
#'   output <- run_beast2_from_options(beast2_options)
#'
#'   length(output) > 40)
#'   file.exists(beast2_options$output_state_filename))
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
    beastier::print_beast2_internal_filenames(bifs)
  }
  ##############################################################################
  # Check files
  ##############################################################################
  beastier::check_input_filename(bifs$input_filename_full)
  beastier::check_beast2_path(beast2_options$beast2_path)
  beastier::check_beast2_options_do_not_overwrite_existing_files(
    beast2_options = beast2_options,
    beast2_internal_filenames = bifs
  )

  check_input_filename_validity( # nolint internal function
    input_filename = bifs$input_filename_full,
    beast2_path = beast2_options$beast2_path,
    verbose = beast2_options$verbose
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
    input_filename = path.expand(bifs$input_filename_full),
    output_state_filename = path.expand(bifs$output_state_filename_full),
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
  # If the output is only 1 line, this will probably be an error message
  testthat::expect_true(
    length(output) != 1,
    info = paste0(
      "Command '", paste0(cmd, collapse = " "), "' failed ",
      "with error '", output, "'"
    )
  )

  ##############################################################################
  # The files as created by BEAST2
  ##############################################################################
  testthat::expect_true(
    file.exists(bifs$output_state_filename_full),
    info = paste0(
      "BEAST2 state file not created. \n",
      "Relative path, from 'beast2_options': '",
        beast2_options$output_state_filename, "'\n",
      "Full path: '", bifs$output_state_filename_full, "'\n",
      "Maybe no permission to write at that location?"
    )
  )

  output
}
