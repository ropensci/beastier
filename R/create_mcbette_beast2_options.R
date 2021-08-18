#' Create a `beast2_options` structure for the `mcbette` R package
#'
#' Create a `beast2_options` structure to be used for the
#' `mcbette` R package, which is a package that allows one to do 
#' model comparison.
#' The generated filenames indicating `mcbette` usage,
#' as well as the correct BEAST2 binary/executable type
#' @inheritParams default_params_doc
#' @return a `beast2_options` structure suitable to be used 
#' by the `mcbette` R package,
#' which is a \link{list} of all function arguments,
#' of which all elements are checked (by \link{check_beast2_options})
#' @seealso to create a regular (that is, not intended
#' for model comparison) BEAST2 options structure,
#' use  \link{create_beast2_options}
#' @examples
#' create_mcbette_beast2_options()
#' @author Richèl J.C. Bilderbeek
#' @export
create_mcbette_beast2_options <- function(
  input_filename = beastier::create_temp_input_filename(),
  output_state_filename = beastier::create_temp_state_filename(),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_bin_path = beastier::get_default_beast2_bin_path(),
  verbose = FALSE
) {
  testit::assert(beastier::is_bin_path(beast2_bin_path))
  beastier::create_beast2_options(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_bin_path,
    verbose = verbose
  )
}
