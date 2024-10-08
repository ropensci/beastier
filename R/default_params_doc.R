#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param beast2_bin_path name of the BEAST2 binary file
#' (usually simply \code{beast}).
#' Use \link{get_default_beast2_bin_path} to get
#' the default BEAST binary file's path
#' @param beast2_folder the folder where the BEAST2 is installed.
#' Note that this is not the folder where the BEAST2 executable
#' is installed: the BEAST2 executable is in a subfolder.
#' Use \link{get_default_beast2_folder} to get the default BEAST2
#' folder.
#' Use \link{get_default_beast2_bin_path} to get the full path to
#' the default BEAST2 executable.
#' @param beast2_jar_path name of the BEAST2 jar file
#' (usually has a \code{.jar} extension).
#' Use \link{get_default_beast2_jar_path} to get
#' the default BEAST jar file's path
#' @param beast2_options a set of BEAST2 options,
#' that are the R equivalent of the BEAST2 command-line options,
#' as can be created by \link{create_beast2_options}
#' @param beast2_optionses list of one or more \code{beast2_options}
#' structures,
#' as can be created by \link{create_beast2_options}.
#' Use of reduplicated plural to achieve difference with
#' \code{beast2_options}
#' @param beast2_path name of either a BEAST2 binary file
#' (usually simply \code{beast})
#' or a BEAST2 jar file
#' (usually has a \code{.jar} extension).
#' Use \link{get_default_beast2_bin_path} to get
#' the default BEAST binary file's path
#' Use \link{get_default_beast2_jar_path} to get
#' the default BEAST jar file's path
#' @param beast2_version the version of BEAST2. By
#' default, this is the version as returned by
#' \link{get_default_beast2_version}
#' @param beast2_working_dir a folder where BEAST2 can work in
#' isolation.
#' For each BEAST2 run, a new subfolder is created in that folder.
#' Within this folder, BEAST2 is allowed to create all of its output files,
#' without the risk of overwriting existing ones, allowing
#' BEAST2 to run in multiple parallel processes.
#' @param beastier_folder the path to
#' the \link{beastier} temporary files folder
#' @param beautier_folder temporary folder used by \link[beautier]{beautier}
#' @param clock_model a \code{beautier} clock model
#' @param clock_models a list of one or more \code{beautier} clock models
#' @param crown_age the crown age of the phylogeny
#' @param crown_ages the crown ages of the phylogenies. Set to NA
#' if the crown age needs to be estimated
#' @param fasta_filename a FASTA filename.
#' @param fasta_filenames One or more FASTA filenames.
#' @param fixed_crown_age determines if the phylogeny's crown age is
#' fixed. If FALSE, crown age is estimated by BEAST2. If TRUE,
#' the crown age is fixed to the crown age
#' of the initial phylogeny.
#' @param fixed_crown_ages one or more booleans to determine if the
#' phylogenies' crown ages are fixed.
#' If FALSE, crown age is estimated by BEAST2. If TRUE,
#' the crown age is fixed to the crown age
#' of the initial phylogeny.
#' @param initial_phylogenies one or more MCMC chain's initial phylogenies.
#' Each one set to NA will result in BEAST2 using a random phylogeny. Else
#' the phylogeny is assumed to be of class \code{ape::phylo}.
#' @param input_filename the name of a BEAST2 input XML file.
#' This file usually has an \code{.xml} extension.
#' Use \link{create_temp_input_filename} to create a temporary
#' filename with that extension.
#' @param mcmc one \code{beautier} MCMC
#' @param misc_options one \code{beautier} misc_options object
#' @param n_taxa The number of taxa
#' @param n_threads the number of computational threads to use.
#' Use \link{NA} to use the BEAST2 default of 1.
#' @param os name of the operating system,
#' must be \code{unix} (Linux, Mac) or \code{win} (Windows)
#' @param output_filename Name of the XML parameter file created by this
#' function. BEAST2 uses this file as input.
#' @param output_log_filename name of the .log file to create
#' @param output_trees_filenames one or more names for .trees file to create.
#' There will be one .trees file created per alignment in the input
#' file. The number of alignments must equal the number of .trees
#' filenames, else an error is thrown. Alignments are sorted alphabetically
#' by their IDs
#' @param output_state_filename name of the \code{.xml.state} file to create.
#' Use \link{create_temp_state_filename} to create a temporary
#' filename with that extension.
#' @param overwrite if TRUE: overwrite the \code{.log}
#' and \code{.trees} files if one of these exists.
#' If FALSE, BEAST2 will not be started if
#' \itemize{
#'   \item{the \code{.log} file exists}
#'   \item{the \code{.trees} files exist}
#'   \item{the \code{.log} file created by BEAST2 exists}
#'   \item{the \code{.trees} files created by BEAST2 exist}
#' }
#' @param rename_fun a function to rename a filename,
#' as can be checked by \link[beautier]{check_rename_fun}. This function should
#' have one argument, which will be a filename or \link{NA}. The
#' function should \link{return} one filename (when passed one filename) or
#' one \link{NA} (when passed one \link{NA}).
#' Example rename functions are:
#' \itemize{
#'   \item \link[beautier]{get_remove_dir_fun} get a function
#'     that removes the directory
#'     paths from the filenames, in effect turning these into local files
#'   \item \link[beautier]{get_replace_dir_fun} get a function
#'     that replaces the directory
#'     paths from the filenames
#'   \item \link[beautier]{get_remove_hex_fun} get a function that
#'     removes the hex string from filenames.
#'     For example, \code{tracelog_82c1a522040.log} becomes \code{tracelog.log}
#' }
#' @param rng_seed the random number generator seed of the BEAST2 run.
#' Must be a non-zero positive integer value or \link{NA}.
#' If \code{rng_seed} is \link{NA}, BEAST2 will pick a random seed
#' @param sequence_length a DNA sequence length, in base pairs
#' @param site_model a \code{beautier} site model
#' @param site_models one or more \code{beautier} site models
#' @param tree_prior a \code{beautier} tree prior
#' @param tree_priors one or more \code{beautier} tree priors
#' @param use_beagle use BEAGLE if present
#' @param verbose if TRUE, additional information is displayed, that
#' is potentially useful in debugging
#' @return Nothing. This is an internal function that does nothing
#' @author Richèl J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#' \code{@noRd}. This is not done, as this will disallow all
#' functions to find the documentation parameters
default_params_doc <- function(
  beast2_bin_path,
  beast2_folder,
  beast2_jar_path,
  beast2_options, beast2_optionses,
  beast2_path,
  beast2_version,
  beast2_working_dir,
  beastier_folder,
  beautier_folder,
  clock_model, clock_models,
  crown_age, crown_ages,
  fasta_filename, fasta_filenames,
  fixed_crown_age,
  fixed_crown_ages,
  initial_phylogenies,
  input_filename,
  mcmc,
  misc_options,
  n_taxa,
  n_threads,
  os,
  output_filename,
  output_log_filename,
  output_state_filename,
  output_trees_filenames,
  overwrite,
  rename_fun,
  rng_seed,
  sequence_length,
  site_model, site_models,
  tree_prior, tree_priors,
  use_beagle,
  verbose
) {
  # Nothing
}
