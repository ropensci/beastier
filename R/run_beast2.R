#' Run BEAST2
#' @inheritParams default_params_doc
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the files with names
#'   \code{output_log_filename}, \code{output_trees_filenames}
#'   and \code{output_state_filenames}
#' @export
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   output_log_filename <- tempfile(fileext = ".log")
#'   output_trees_filenames <- tempfile(fileext = ".trees")
#'   output_state_filename <- tempfile(fileext = ".xml.state")
#'
#'   expect_false(file.exists(output_log_filename))
#'   expect_false(file.exists(output_trees_filenames))
#'   expect_false(file.exists(output_state_filename))
#'
#'   output <- run_beast2(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     output_log_filename = output_log_filename,
#'     output_trees_filenames = output_trees_filenames,
#'     output_state_filename = output_state_filename
#'   )
#'
#'   expect_true(length(output) > 40)
#'   expect_true(file.exists(output_log_filename))
#'   expect_true(file.exists(output_trees_filenames))
#'   expect_true(file.exists(output_state_filename))
#' }
#' @author Richèl J.C. Bilderbeek
run_beast2 <- function(
  input_filename,
  output_log_filename = create_default_log_filename(
    input_filename,
    beast2_path,
    verbose
  ),
  output_trees_filenames = create_default_trees_filenames(
    input_filename,
    beast2_path,
    verbose
  ),
  output_state_filename = tempfile(
    pattern = "beastier_", fileext = ".xml.state"
  ),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_working_dir = tempfile(pattern = "beast2_tmp_folder"),
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  if (is_win_bin_path(beast2_path)) {
    stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  ##############################################################################
  # Deduce the full paths of the input and output files
  ##############################################################################
  if (verbose) {
    print(paste("input_filename:", input_filename))
    print(paste("output_log_filename:", output_log_filename))
    print(paste("output_trees_filenames:", output_trees_filenames))
    print(paste("output_state_filename:", output_state_filename))
  }
  # Input
  input_filename_full <- input_filename
  if (basename(input_filename) == input_filename) {
    input_filename_full <- file.path(getwd(), input_filename)
  }
  # Intermediate, these are files created by BEAST2
  actual_log_filename <- file.path(
    beast2_working_dir,
    basename(
      create_default_log_filename(
        input_filename = input_filename_full,
        beast2_path = beast2_path
      )
    )
  )
  actual_trees_filenames <- NA
  for (i in seq_along(output_trees_filenames)) {
    actual_trees_filenames[i] <- file.path(
      beast2_working_dir,
      basename(
        create_default_trees_filenames(
          input_filename = input_filename_full,
          beast2_path = beast2_path,
          verbose = verbose
        )[i]
      )
    )
  }
  # Output
  output_log_filename_full <- output_log_filename
  if (basename(output_log_filename) == output_log_filename) {
    output_log_filename_full <- file.path(getwd(), output_log_filename)
  }
  output_trees_filenames_full <- output_trees_filenames
  for (i in seq_along(output_trees_filenames_full)) {
    if (basename(output_trees_filenames[i]) == output_trees_filenames[i]) {
      output_trees_filenames_full[i] <- file.path(
        getwd(), output_trees_filenames[i]
      )
    }
  }
  output_state_filename_full <- output_state_filename
  if (basename(output_state_filename) == output_state_filename) {
    output_state_filename_full <- file.path(getwd(), output_state_filename)
  }
  if (verbose) {
    print(paste("input_filename_full:", input_filename_full))
    print(paste("actual_log_filename:", actual_log_filename))
    print(paste("actual_trees_filenames:", actual_trees_filenames))
    print(paste("output_log_filename_full:", output_log_filename_full))
    print(paste("output_trees_filenames_full:", output_trees_filenames_full))
    print(paste("output_state_filename_full:", output_state_filename_full))
  }
  ##############################################################################
  # Check files
  ##############################################################################
  check_input_filename(input_filename_full) # nolint internal function
  check_beast2_path(beast2_path) # nolint internal function
  if (overwrite == FALSE) {
    if (file.exists(output_log_filename_full)) {
      stop("Will not overwrite 'output_log_filename' ('",
        output_log_filename_full, "') with 'overwrite' is FALSE"
      )
    }
    if (any(file.exists(output_trees_filenames_full))) {
      stop("Will not overwrite 'output_trees_filenames' ('",
        output_trees_filenames_full, "') with 'overwrite' is FALSE"
      )
    }
    if (file.exists(output_state_filename_full)) {
      stop("Will not overwrite 'output_state_filename' ('",
        output_state_filename_full, "') with 'overwrite' is FALSE"
      )
    }
  }
  if (file.exists(actual_log_filename)) {
    stop(
      "log file to be created '", actual_log_filename,"' 
      is already present. \n",
      "This should never happen. \n",
      "If you have a reproducible example, please post a bug report at ",
      "https://github.com/ropensci/beastier/issues \n"
    )
  } 
  if (any(file.exists(actual_trees_filenames))) {
    stop(
      "trees file(s) to be created '", actual_trees_filenames,"' 
      is/are already present. \n",
      "This should never happen. \n",
      "If you have a reproducible example, please post a bug report at ",
      "https://github.com/ropensci/beastier/issues \n"
    )
  } 
  testit::assert(!file.exists(actual_log_filename))
  testit::assert(all(!file.exists(actual_trees_filenames)))

  check_rng_seed(rng_seed) # nolint beastier function
  check_input_filename_validity( # nolint internal function
    input_filename = input_filename_full,
    beast2_path = beast2_path,
    verbose = verbose
  )


  alignment_ids <- get_alignment_ids(input_filename_full) # nolint internal function

  if (length(output_trees_filenames) != length(alignment_ids)) {
    stop(
      "'output_trees_filenames' must have as much elements as ",
      "'input_filename' has alignments. 'output_trees_filenames' has ",
      length(output_trees_filenames), " elements, 'input_filename' has ",
      length(alignment_ids), " alignments"
    )
  }

  ##############################################################################
  # Store old wd, create and change to beast2_working_dir
  ##############################################################################
  cur_wd <- getwd()
  # Move working directory to temporary folder
  # Do not warning if the folder already exists, unless when being verbose
  dir.create(beast2_working_dir, showWarnings = verbose, recursive = TRUE)

  # Although 'dir.create' creates folders recursively,
  # it only has the user's permission. As the user
  # is not running as root, it cannot create root folders
  if (!dir.exists(beast2_working_dir)) {
    dir.create(beast2_working_dir, showWarnings = TRUE)
    stop(
      "Cannot create working directory '", beast2_working_dir, "' \n",
      "Maybe no permission to create it there? \n"
    )
  }
  # This will fail if the temp_wd cannot be created
  tryCatch(
    setwd(beast2_working_dir),
    error = function(e) {
      stop(
        "Cannot set working directory to '", beast2_working_dir, "' \n",
        "Maybe no permission to change to that location?\n",
        "Error message: ", e$message, " \n"
      )
    }
  )

  ##############################################################################
  # Create the BEAST2 command
  ##############################################################################
  testit::assert(length(input_filename_full) == 1)
  testit::assert(length(output_state_filename) == 1)
  testit::assert(length(rng_seed) == 1)
  testit::assert(length(n_threads) == 1)
  testit::assert(length(use_beagle) == 1)
  testit::assert(length(overwrite) == 1)
  testit::assert(length(beast2_path) == 1)

  cmd <- beastier::create_beast2_run_cmd(
    input_filename = input_filename_full,
    output_state_filename = output_state_filename_full,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_path
  )

  if (verbose == TRUE) {
    print(paste("cmd:", paste0(cmd, collapse = " ")))
  }


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
  if (!file.exists(actual_log_filename)) {
    stop(
      "BEAST2 .log file not created at '", actual_log_filename, "' \n",
      "Maybe no permission to write at that location?"
    )
  }

  # Copy to target, will overwrite if this was desired
  testit::assert(file.exists(actual_log_filename))
  file.rename(from = actual_log_filename, to = output_log_filename)

  for (i in seq_along(output_trees_filenames)) {
    to <- output_trees_filenames[i]
    actual_trees_filename <- actual_trees_filenames[i]
    testit::assert(file.exists(actual_trees_filename))
    file.rename(from = actual_trees_filename, to = to)
  }

  if (verbose) {
    print("[variable name]: [full path] [exists?]")
    print(paste("Filename:", input_filename_full,
      file.exists(input_filename_full)))
    print(paste("input_filename_full:", input_filename_full))
    print(paste("actual_log_filename:", actual_log_filename,
      file.exists(actual_log_filename)))
    print(paste("actual_trees_filenames:", actual_trees_filenames,
      file.exists(actual_trees_filenames)))
    print(paste("output_log_filename_full:", output_log_filename_full,
      file.exists(output_log_filename_full)))
    print(paste("output_trees_filenames_full:", output_trees_filenames_full,
      file.exists(output_trees_filenames_full)))
    print(paste("output_state_filename_full:", output_state_filename_full,
      file.exists(output_state_filename_full)))
  }

  testit::assert(file.exists(output_log_filename))
  testit::assert(file.exists(output_state_filename_full))
  testit::assert(all(file.exists(output_trees_filenames)))

  output
}
