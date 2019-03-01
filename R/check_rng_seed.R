#' Check if the input is a valid RNG seed.
#'
#' Will \link{stop} if not.
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
check_rng_seed <- function(rng_seed) {
  if (length(rng_seed) != 1) {
    stop(
      "'rng_seed' should be one value.\n",
      "Actual length: ", length(rng_seed)
    )
  }
  if (!is_one_na(rng_seed) && !is.numeric(rng_seed)) {
    stop(
      "'rng_seed' should be one NA or one non-zero positive value.\n",
      "Actual value: ", rng_seed
    )
  }
  if (!is_one_na(rng_seed) && !(rng_seed > 0)) {
    stop(
      "'rng_seed' should be one NA or one non-zero positive value.\n",
      "Actual value: ", rng_seed
    )
  }
}
