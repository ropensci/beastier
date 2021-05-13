#' Run BEAST2
#' @inheritParams default_params_doc
#' @examples
#' if (is_beast2_installed() && is_on_ci()) {
#'   beast2_options <- create_beast2_options(
#'     input_filename = get_beastier_path("2_4.xml")
#'   )
#'   run_beast2_from_options(beast2_options)
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

  if (beastier::is_win_bin_path(beast2_options$beast2_path)) {
   stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  ##############################################################################
  # Check files
  ##############################################################################
  beastier::check_input_filename(beast2_options$input_filename)
  beastier::check_beast2_path(beast2_options$beast2_path)
  beastier::check_beast2_options_do_not_overwrite_existing_files(beast2_options)
  beastier::check_input_filename_validity(beast2_options)
  beastier::check_can_create_dir_for_state_output_file(beast2_options)
  beastier::check_can_create_state_output_file(beast2_options)

  ##############################################################################
  # Create the BEAST2 command
  ##############################################################################
  cmd <- beastier::create_beast2_run_cmd_from_options(
    beast2_options = beast2_options
  )

  if (beast2_options$verbose) {
    message(paste("cmd:", paste0(cmd, collapse = " ")))
  }

  # Create the folder to hold the file, without warning if it's already present
  output_folder <- dirname(beast2_options$output_state_filename)
  if (beast2_options$verbose) {
    message(
      "Creating folder '", output_folder, "'",
      "for BEAST2 .xml.state output file"
    )
  }
  dir.create(
    path = output_folder,
    recursive = TRUE,
    showWarnings = FALSE
  )
  # This assumpion should have been proven to be valid
  # by check_can_create_dir_for_state_output_file
  testthat::expect_true(dir.exists(output_folder))

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
  # This is only true if there has been one sampling event in the MCMC
  if (1 == 1) {
    testthat::expect_true(
      file.exists(
        normalizePath(beast2_options$output_state_filename, mustWork = FALSE)
      ),
      info = paste0(
        "BEAST2 state file not created. \n",
        "Command '", paste0(cmd, collapse = " "), "' failed. ",
        "Relative path, from 'beast2_options': '",
          beast2_options$output_state_filename, "'\n",
        "Full path: '", beast2_options$output_state_filename, "'\n",
        "Normalized full path: '",
          normalizePath(beast2_options$output_state_filename, mustWork = FALSE),
          "'\n",
        "Maybe no permission to write at that location?"
      )
    )
  }
  output
}
