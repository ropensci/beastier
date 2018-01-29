#' Run BEAST2
#' @param input_filename the name of a BEAST2 input XML file
#' @param verbose show more (debug) output
#' @param beast_jar_path the path of \code{beast.jar}
#' @export
#' @author Richel J.C. Bilderbeek
run_beast2 <- function(
  input_filename,
  output_log_filename = "out.log",
  output_trees_filenames = "out.trees",
  output_state_filename = "out.xml.state",
  beast_jar_path = "~/Programs/beast/lib/beast.jar",
  verbose = FALSE
) {
  if (!file.exists(input_filename)) {
    stop(
      "'input_filename' must be the name of an existing file. ",
      "File '", input_filename, "' not found"
    )
  }
  if (!file.exists(beast_jar_path)) {
    stop(
      "'beast_jar_path' must be the name of an existing file. ",
      "File '", beast_jar_path, "' not found"
    )
  }
  if (!is_beast2_input_file(input_filename, beast_jar_path = beast_jar_path)) {
    stop(
      "'input_filename' must be a valid BEAST2 XML file",
      "File '", input_filename, "' is not a valid BEAST2 file",
      is_beast2_input_file( # nolint internal function
        input_filename,
        verbose = verbose,
        beast_jar_path = beast_jar_path)
    )
  }

  alignment_ids <- get_alignment_ids(input_filename)

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

  # Run BEAST2 to measure posterior
  remove_files(
    c(output_state_filename, beast_log_filename, beast_trees_filenames))
  testthat::expect_false(files_exist(
    c(output_state_filename, beast_log_filename, beast_trees_filenames)))
  cmd <- paste(
    "java -jar", beast_jar_path,
    " -statefile ", output_state_filename,
    " -overwrite", input_filename
  )
  if (!verbose) {
    cmd <- paste(cmd, "1>/dev/null 2>/dev/null")
  }
  exit_code <- system(cmd, intern = FALSE)

  if (verbose) {
    print(paste("beast exited with error code", exit_code))
    print(paste("beast_log_filename:", beast_log_filename))
    print(paste("beast_trees_filenames:", beast_trees_filenames))
    print(paste("output_state_filename:", output_state_filename))
    print(paste("file.exists(beast_log_filename):", file.exists(beast_log_filename)))
    print(paste("file.exists(beast_trees_filenames):", file.exists(beast_trees_filenames)))
    print(paste("file.exists(output_state_filename):", file.exists(output_state_filename)))
  }
  # If these are absent, BEAST2 could not parse the input file
  testit::assert(file.exists(output_state_filename))
  testit::assert(file.exists(beast_log_filename))
  testit::assert(file.exists(beast_trees_filenames))

  file.copy(from = beast_log_filename, to = output_log_filename, overwrite = TRUE)
  for (i in seq_along(output_trees_filenames)) {
    from <- beast_trees_filenames[i]
    to <- output_trees_filenames[i]
    file.copy(from = from, to = to, overwrite = TRUE)
  }

  file.remove(beast_log_filename)
  file.remove(beast_trees_filenames)
}
