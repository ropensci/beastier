#' Run BEAST2
#' @inheritParams default_params_doc
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the file with name \code{output_state_filenames}
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'   beast2_options <- create_beast2_options(
#'     input_filename = get_beastier_path("2_4.xml")
#'   )
#'   run_beast2_from_options(beast2_options)
#'   file.remove(beast2_options$output_state_filename)
#'   remove_beaustier_folders()
#' }
#' check_empty_beaustier_folders()
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
  beastier::check_can_create_treelog_file(beast2_options)
  beastier::check_can_create_screenlog_file(beast2_options)
  beastier::check_can_create_tracelog_file(beast2_options)
  ##############################################################################
  # Create the folders needed
  ##############################################################################

  beautier::create_beautier_tempfolder()
  beastier::create_beastier_tempfolder()
  beastier::create_beast2_input_file_folder(beast2_options)
  beastier::create_beast2_state_output_file_folder(beast2_options)
  beastier::create_beast2_treelog_folder(beast2_options)
  beastier::create_beast2_screenlog_folder(beast2_options)
  beastier::create_beast2_tracelog_folder(beast2_options)
  ##############################################################################
  # Create the BEAST2 command
  ##############################################################################
  cmd <- beastier::create_beast2_run_cmd_from_options(
    beast2_options = beast2_options
  )

  if (beast2_options$verbose) {
    message(paste("cmd:", paste0(cmd, collapse = " ")))
  }

  # Create the folder for the treelog and tracelog
  beautier_tempfolder <- dirname(beautier::get_beautier_tempfilename())
  if (beast2_options$verbose) {
    message(
      "Creating the beautier temprary folder '", beautier_tempfolder, "'",
      "for BEAST2 tracelog, treelog and screenlog files"
    )
  }
  dir.create(
    beautier_tempfolder,
    showWarnings = FALSE,
    recursive = TRUE
  )

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
  stdout_filename <- beastier::get_beastier_tempfilename(
    pattern = "stdout_", fileext = ".log"
  )
  stderr_filename <- beastier::get_beastier_tempfilename(
    pattern = "stderr_", fileext = ".log"
  )
  dir.create(dirname(stdout_filename), showWarnings = FALSE, recursive = TRUE)
  error_code <- system2(
    command = cmd[1],
    args = cmd[-1],
    stdout = stdout_filename,
    stderr = stderr_filename
  )
  stdout_lines <- readr::read_lines(stdout_filename, progress = FALSE)
  stderr_lines <- readr::read_lines(stderr_filename, progress = FALSE)
  file.remove(stdout_filename)
  file.remove(stderr_filename)
  if (error_code != 0) {
    stop(
      "BEAST2 run failed. \n",
      "error_code: ", error_code, " \n",
      "cmd: '", paste0(cmd, collapse = " "), "' \n",
      "stderr_lines: \n", paste0(stderr_lines, collapse = " \n"),
      "stdout_lines: \n", paste0(stdout_lines, collapse = " \n")
    )
  }

  if (beast2_options$verbose) {
    message("error_code: ", error_code)
    message("stdout: \n", paste0(stdout_lines, collapse = "\n"))
    message("stderr: \n", paste0(stderr_lines, collapse = "\n"))
  }

  output <- c(stdout_lines, stderr_lines)

  ##############################################################################
  # The files as created by BEAST2
  ##############################################################################
  # This is only true if there has been one sampling event in the MCMC
  if (!file.exists(beast2_options$output_state_filename)) {
    stop(
      "BEAST2 state file not created in a fresh run. \n",
      "Command '", paste0(cmd, collapse = " "), "' failed. ",
      "'beast2_options$output_state_filename': '",
        beast2_options$output_state_filename, "'\n",
      "Maybe no permission to write at that location? \n",
      " \n",
      "Output: \n", paste0(output, collapse = " \n")
    )
  }
  output
}
