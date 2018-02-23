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
#' @param overwrite_state_file set to TRUE to overwrite the file with name
#'   \code{output_state_filename} if it already exists
#' @param verbose show more (debug) output
#' @param beast2_jar_path the path of \code{beast.jar}.
#'   Use \link{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @export
#' @examples
#'   output_log_filename <- "out.log"
#'   output_trees_filename <- "out.trees"
#'   output_state_filename <- "out.state"
#'
#'   run_beast2(
#'     input_filename = get_path("2_4.xml"),
#'     output_log_filename = output_log_filename,
#'     output_trees_filenames = output_trees_filename,
#'     output_state_filename = output_state_filename
#'   )
#'
#'   testit::assert(file.exists(output_log_filename))
#'   testit::assert(file.exists(output_trees_filename))
#'   testit::assert(file.exists(output_state_filename))
#'
#' @author Richel J.C. Bilderbeek
run_beast2 <- function(
  input_filename,
  output_log_filename = "out.log",
  output_trees_filenames = get_trees_filenames(input_filename),
  output_state_filename = "out.xml.state",
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite_state_file = TRUE,
  beast2_jar_path = get_default_beast2_jar_path(),
  verbose = FALSE
) {
  if (!file.exists(input_filename)) {
    stop(
      "'input_filename' must be the name of an existing file. ",
      "File '", input_filename, "' not found"
    )
  }
  if (!file.exists(beast2_jar_path)) {
    stop(
      "'beast2_jar_path' must be the name of an existing file. ",
      "File '", beast2_jar_path, "' not found"
    )
  }
  if (
    !is_beast2_input_file(input_filename, beast2_jar_path = beast2_jar_path)
  ) {
    stop(
      "'input_filename' must be a valid BEAST2 XML file",
      "File '", input_filename, "' is not a valid BEAST2 file",
      is_beast2_input_file( # nolint internal function
        input_filename,
        verbose = verbose,
        beast2_jar_path = beast2_jar_path)
    )
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

  # BEAST2 output file, containing the posterior parameter estimates
  beast_log_filename <- paste0(sort(alignment_ids)[1], ".log")

  # BEAST2 output file, containing the posterior phylogenies
  beast_trees_filenames <- paste0(alignment_ids, ".trees")

  # Run BEAST2
  remove_files(
    c(output_state_filename, beast_log_filename, beast_trees_filenames))
  testthat::expect_false(files_exist(
    c(output_state_filename, beast_log_filename, beast_trees_filenames)))
  cmd <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite_state_file = TRUE,
    beast2_jar_path = beast2_jar_path
  )
  if (!verbose) {
    cmd <- paste(cmd, "1>/dev/null 2>/dev/null")
  }
  exit_code <- system(cmd, intern = FALSE)

  testit::assert(exit_code == 0)
  testit::assert(file.exists(output_state_filename))
  testit::assert(file.exists(beast_log_filename))
  testit::assert(file.exists(beast_trees_filenames))

  if (beast_log_filename != output_log_filename) {
    file.copy(from = beast_log_filename, to = output_log_filename,
      overwrite = TRUE)
    file.remove(beast_log_filename)
  }

  testit::assert(length(beast_trees_filenames)
    == length(output_trees_filenames))

  for (i in seq_along(beast_trees_filenames)) {
    from <- beast_trees_filenames[i]
    to <- output_trees_filenames[i]
    if (from != to) {
      file.copy(from = from, to = to, overwrite = TRUE)
      file.remove(from)
    }
  }

  testit::assert(file.exists(output_log_filename))
  testit::assert(files_exist(output_trees_filenames)) # nolint internal function
  testit::assert(file.exists(output_state_filename))
}
