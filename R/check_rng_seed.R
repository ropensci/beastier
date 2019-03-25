#' Check if the input is a valid RNG seed.
#'
#' Will \link{stop} if not.
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_silent(check_rng_seed(1))
#'   expect_silent(check_rng_seed(2))
#'   expect_silent(check_rng_seed(NA))
#'
#'   expect_error(check_rng_seed(0))
#'   expect_error(check_rng_seed(-1))
#'   expect_error(check_rng_seed("nonsense"))
#'   expect_error(check_rng_seed(c(1, 2)))
#'   expect_error(check_rng_seed(c()))
#'   expect_error(check_rng_seed(NULL))
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
      "'rng_seed' should be one NA or one non-zero positive value.\n",
      "Actual value: ", rng_seed
    )
  }
  if (rng_seed <= 0) {
    stop(
      "'rng_seed' should be one NA or one non-zero positive value.\n",
      "Actual value: ", rng_seed
    )
  }
}
