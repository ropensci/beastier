#' Check if the input is a valid RNG seed.
#'
#' Will \link{stop} if not.
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if the RNG seed is invalid
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' # Numbers from 1 and higher are valid RNG seeds
#' check_rng_seed(1)
#' check_rng_seed(2)
#' # Also NA is a valid RNG seed
#' check_rng_seed(NA)
#'
#' check_empty_beaustier_folders()
#' @export
check_rng_seed <- function(rng_seed) {
  if (length(rng_seed) != 1) {
    stop(
      "'rng_seed' should be one value.\n",
      "Actual length: ", length(rng_seed)
    )
  }
  if (beautier::is_one_na(rng_seed)) return()
  if (!is.numeric(rng_seed)) {
    stop(
      "'rng_seed' should be one NA or one non-zero positive value. \n",
      "Actual value: ", rng_seed
    )
  }
  beautier::check_true(beautier::is_one_int(rng_seed))
  if (rng_seed <= 0) {
    stop(
      "'rng_seed' should be one NA or one non-zero positive value.\n",
      "Actual value: ", rng_seed
    )
  }
}
