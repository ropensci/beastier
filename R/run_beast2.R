#' Run BEAST2
#' @inheritParams default_params_doc
#' @param output_log_filename name of the .log file to create
#' @param output_trees_filenames one or more names for .trees file to create.
#'   There will be one .trees file created per alignment in the input
#'   file. The number of alignments must equal the number of .trees
#'   filenames, else an error is thrown. Alignments are sorted alphabetically
#'   by their IDs
#' @param output_state_filename name of the .xml.state file to create
#' @param n_threads number of threads to use
#' @param use_beagle use BEAGLE if present
#' @return Nothing. It will create the files with names
#'   \code{output_log_filename}, \code{output_trees_filenames}
#'   and \code{output_state_filenames}
#' @export
#' @examples
#'   output_log_filename <- "out.log"
#'   output_trees_filenames <- "out.trees"
#'   output_state_filename <- "out.state"
#'
#'   run_beast2(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     output_log_filename = output_log_filename,
#'     output_trees_filenames = output_trees_filenames,
#'     output_state_filename = output_state_filename
#'   )
#'
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

  if (!is.na(rng_seed) && !(rng_seed > 0)) {
    stop("'rng_seed' should be NA or non-zero positive")
  }

  alignment_ids <- get_alignment_ids(input_filename) # nolint internal function

  if (length(output_trees_filenames) != length(alignment_ids)) {
    stop(
      "'output_trees_filenames' must have as much elements as ",
      "'input_filename' has alignments. 'output_trees_filenames' has ",
      length(output_trees_filenames), " elements, 'input_filename' has ",
      length(alignment_ids), " alignments"
    )
  }

  cmd <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_path
  )

  if (.Platform$OS.type == "unix") {
    if (!verbose) {
      cmd <- paste(cmd, "1>/dev/null 2>/dev/null")
    }
  }

  cmds <- strsplit(x = cmd, " ")
  exit_code <- system2(
    command = cmds[[1]][1],
    args = cmds[[1]][-1],
    stdout = NULL,
    stderr = NULL
  )

  testit::assert(exit_code == 0)
  testit::assert(file.exists(output_state_filename))

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
  testit::assert(file.exists(output_log_filename))
  testit::assert(files_exist(output_trees_filenames)) # nolint internal function
  testit::assert(file.exists(output_state_filename))
}
