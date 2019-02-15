#' \code{beastier}: A package to call BEAST2.
#'
#' \code{beastier} allows to call BEAST2, a popular
#' Bayesian phylogenetics tool, using
#' an R interface. 'beastier' closely follows the interface
#' of BEAST2, including its default settings.
#'
#' @examples
#'   beast2_options <- create_beast2_options(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     output_log_filename = tempfile(fileext = ".log"),
#'     output_trees_filenames = tempfile(fileext = ".trees"),
#'     output_state_filename = tempfile(fileext = ".xml.state")
#'   )
#'
#'   output <- run_beast2_from_options(beast2_options)
#'
#'   testit::assert(length(output) > 40)
#'   testit::assert(file.exists(beast2_options$output_log_filename))
#'   testit::assert(file.exists(beast2_options$output_trees_filenames))
#'   testit::assert(file.exists(beast2_options$output_state_filename))
#'
#' @seealso
#' These are packages associated with \code{beastier}:
#' \itemize{
#'   \item{
#'     The package \code{beautier} can create
#'     BEAST2 input files from R
#'   }
#'   \item{
#'     The package \code{tracerer} can parse
#'     BEAST2 output files from R
#'   }
#'   \item{
#'     The package \code{babette} combines the
#'     functionality of \code{beautier},
#'     \code{beastier} and \code{tracerer}
#'     into a single workflow
#'   }
#' }
#' @docType package
#' @name beastier
NULL
