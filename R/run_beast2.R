#' Run BEAST2
#' @param input_filename the name of a BEAST2 input XML file
#' @param verbose show more (debug) output
#' @param beast_jar_path the path of \code{beast.jar}
#' @export
#' @author Richel J.C. Bilderbeek
run_beast2 <- function(
  input_filename,
  output_log_filename = "out.log",
  output_trees_filename = "out.trees",
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
      is_beast2_input_file(input_filename, verbose = verbose, beast_jar_path = beast_jar_path) # nolint internal function
    )
  }

  base_filename <- basename(input_filename)
  # BEAST2 output file, containing the posterior parameter estimates
  beast_log_filename <- paste0(base_filename, ".log")
  # BEAST2 output file, containing the posterior phylogenies
  beast_trees_filename <- paste0(base_filename, ".trees")
  # BEAST2 output file, containing the final MCMC state
  beast_state_filename <- paste0(base_filename, ".xml.state")

  # Run BEAST2 to measure posterior
  remove_files(
    c(beast_state_filename, beast_log_filename, beast_trees_filename))
  testthat::expect_false(files_exist(
    c(beast_state_filename, beast_log_filename, beast_trees_filename)))
  cmd <- paste(
    "java -jar", beast_jar_path,
    " -statefile ", beast_state_filename,
    " -overwrite", input_filename
  )
  if (!verbose) {
    cmd <- paste(cmd, "1>/dev/null 2>/dev/null")
  }
  system(cmd, intern = FALSE)
  # If these are absent, BEAST2 could not parse the input file
  testit::assert(file.exists(beast_state_filename))
  testit::assert(file.exists(beast_log_filename))
  testit::assert(file.exists(beast_trees_filename))
}
