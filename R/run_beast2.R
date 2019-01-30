#' Run BEAST2
#' @inheritParams default_params_doc
#' @return The text sent to STDOUT and STDERR.
#'   It will create the files with names
#'   \code{output_log_filename}, \code{output_trees_filenames}
#'   and \code{output_state_filenames}
#' @export
#' @examples
#'   output_log_filename <- tempfile(fileext = ".log")
#'   output_trees_filenames <- tempfile(fileext = ".trees")
#'   output_state_filename <- tempfile(fileext = ".xml.state")
#'
#'   output <- run_beast2(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     output_log_filename = output_log_filename,
#'     output_trees_filenames = output_trees_filenames,
#'     output_state_filename = output_state_filename
#'   )
#'
#'   testit::assert(length(output) > 40)
#'   testit::assert(file.exists(output_log_filename))
#'   testit::assert(file.exists(output_trees_filenames))
#'   testit::assert(file.exists(output_state_filename))
#'
#' @author Richel J.C. Bilderbeek
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
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  if (is_win_bin_path(beast2_path)) {
    stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  check_input_filename(input_filename) # nolint internal function
  check_beast2_path(beast2_path) # nolint internal function
  check_input_filename_validity( # nolint internal function
    input_filename = input_filename,
    beast2_path = beast2_path,
    verbose = verbose
  )

  if (file.exists(output_log_filename) && overwrite == FALSE) {
    stop("Will not overwrite 'output_log_filename' ('",
      output_log_filename, "') with 'overwrite' is FALSE"
    )
  }
  if (file.exists(output_trees_filenames) && overwrite == FALSE) {
    stop("Will not overwrite 'output_trees_filenames' ('",
      output_trees_filenames, "') with 'overwrite' is FALSE"
    )
  }

  # These are files created by BEAST2
  beast_log_filename <- create_default_log_filename(
    input_filename = input_filename,
    beast2_path = beast2_path,
    verbose = verbose
  )
  if (file.exists(beast_log_filename) && overwrite == FALSE) {
    stop("Cannot overwrite the .log file created by BEAST2 ('",
      beast_log_filename, "') with 'overwrite' is FALSE"
    )
  }
  beast_trees_filename <- create_default_trees_filenames(
    input_filename = input_filename,
    beast2_path = beast2_path,
    verbose = verbose
  )
  if (file.exists(beast_trees_filename) && overwrite == FALSE) {
    stop("Cannot overwrite the .trees files created by BEAST2 ('",
      beast_trees_filename, "') with 'overwrite' is FALSE"
    )
  }

  check_rng_seed(rng_seed)

  alignment_ids <- get_alignment_ids(input_filename) # nolint internal function

  if (length(output_trees_filenames) != length(alignment_ids)) {
    stop(
      "'output_trees_filenames' must have as much elements as ",
      "'input_filename' has alignments. 'output_trees_filenames' has ",
      length(output_trees_filenames), " elements, 'input_filename' has ",
      length(alignment_ids), " alignments"
    )
  }

  testit::assert(length(input_filename) == 1)
  testit::assert(length(output_state_filename) == 1)
  testit::assert(length(rng_seed) == 1)
  testit::assert(length(n_threads) == 1)
  testit::assert(length(use_beagle) == 1)
  testit::assert(length(overwrite) == 1)
  testit::assert(length(beast2_path) == 1)

  cmd <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_path
  )

  if (verbose == TRUE) {
    print(paste("cmd:", paste0(cmd, collapse = " ")))
  }

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


  if (!file.exists(output_log_filename)) {
    from <- create_default_log_filename(
      input_filename = input_filename,
      beast2_path = beast2_path,
      verbose = verbose
    )
    testit::assert(file.exists(from))
    file.rename(from = from, to = output_log_filename)
  }
  for (i in seq_along(output_trees_filenames)) {
    to <- output_trees_filenames[i]
    if (!file.exists(to)) {
      from <- create_default_trees_filenames(
        input_filename = input_filename,
        beast2_path = beast2_path,
        verbose = verbose
      )[i]
      testit::assert(file.exists(from))
      file.rename(from = from, to = to)
    }
  }
  if (verbose) {
    print(paste0("output_log_filename ('", output_log_filename, "'): ",
      file.exists(output_log_filename))
    )
    print(paste0("output_state_filename ('", output_state_filename, "'): ",
      file.exists(output_state_filename))
    )
    print(paste0("output_trees_filenames ('", output_trees_filenames, "'): ",
      file.exists(output_trees_filenames))
    )
  }
  testit::assert(file.exists(output_log_filename))
  testit::assert(file.exists(output_state_filename))
  testit::assert(files_exist(output_trees_filenames)) # nolint internal function
  output
}
