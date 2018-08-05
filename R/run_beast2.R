#' Run BEAST2
#' @param input_filename the name of a BEAST2 input XML file
#' @param output_log_filename name of the .log file to create
#' @param output_trees_filenames one or more names for .trees file to create.
#'   There will be one .trees file created per alignment in the input
#'   file. The number of alignments must equal the number of .trees
#'   filenames, else an error is thrown. Alignments are sorted alphabetically
#'   by their IDs
#' @param output_state_filename name of the .xml.state file to create
#' @param rng_seed the RNG seed
#' @param n_threads number of threads to use
#' @param use_beagle use BEAGLE if present
#' @param overwrite if TRUE: overwrite the \code{.log}
#'   and \code{.trees} files if one of these exists.
#'   If FALSE, BEAST2 will not be started if
#'   \itemize{
#'     \item{the \code{.log} file exists}
#'     \item{the \code{.trees} files exist}
#'     \item{the \code{.log} file created by BEAST2 exists}
#'     \item{the \code{.trees} files created by BEAST2 exist}
#'  }
#' @param verbose show more (debug) output
#' @param beast2_jar_path the path of \code{beast.jar}.
#'   Use \link{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
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
    beast2_jar_path,
    verbose
  ),
  output_trees_filenames = create_default_trees_filenames(
    input_filename,
    beast2_jar_path,
    verbose
  ),
  output_state_filename = tempfile(
    pattern = "beastier_", fileext = ".xml.state"
  ),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = FALSE,
  beast2_jar_path = get_default_beast2_jar_path(),
  verbose = FALSE
) {
  check_input_filename(input_filename)
  check_beast2_jar_path(beast2_jar_path)
  check_input_filename_validity(
    input_filename = input_filename,
    beast2_jar_path = beast2_jar_path,
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
    beast2_jar_path = beast2_jar_path,
    verbose = verbose
  )
  if (file.exists(beast_log_filename) && overwrite == FALSE) {
    stop("Cannot overwrite the .log file created by BEAST2 ('",
      beast_log_filename, "') with 'overwrite' is FALSE"
    )
  }
  beast_trees_filename <- create_default_trees_filenames(
    input_filename = input_filename,
    beast2_jar_path = beast2_jar_path,
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

  # Run BEAST2
  #beastier:::remove_files(c(beast_log_filename, beast_trees_filenames))
  #testthat::expect_false(
  #  files_exist(
  #    c(output_state_filename, beast_log_filename, beast_trees_filenames)
  #  )
  #)

  cmd <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_jar_path = beast2_jar_path
  )

  if (.Platform$OS.type == "unix") {
    if (!verbose) {
      cmd <- paste(cmd, "1>/dev/null 2>/dev/null")
    }
  }
  # Message will be posted on Linux: show.output.on.console and invisible
  # should only be used under Windows
  withCallingHandlers(
    suppressMessages(
      exit_code <- system(
        cmd,
        intern = FALSE,
        invisible = !verbose,
        show.output.on.console = !verbose,
        ignore.stdout = !verbose,
        ignore.stderr = !verbose
      )
    )
  )

  testit::assert(exit_code == 0)
  testit::assert(file.exists(output_state_filename))
  #testit::assert(file.exists(beast_log_filename))
  #testit::assert(file.exists(beast_trees_filenames))

  #if (beast_log_filename != output_log_filename) {
  #  file.copy(from = beast_log_filename, to = output_log_filename,
  #    overwrite = TRUE)
  #  file.remove(beast_log_filename)
  #}

  #testit::assert(length(beast_trees_filenames)
  #  == length(output_trees_filenames))

  #for (i in seq_along(beast_trees_filenames)) {
  #  from <- beast_trees_filenames[i]
  #  to <- output_trees_filenames[i]
  #  if (from != to) {
  #    file.copy(from = from, to = to, overwrite = TRUE)
  #    file.remove(from)
  #  }
  #}
  if (!file.exists(output_log_filename)) {
    from <- create_default_log_filename(
      input_filename = input_filename,
      beast2_jar_path = beast2_jar_path,
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
        beast2_jar_path = beast2_jar_path,
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
