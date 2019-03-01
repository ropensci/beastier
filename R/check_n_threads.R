#' Check if the input is a valid RNG seed.
#'
#' Will \link{stop} if not.
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
check_n_threads <- function(n_threads) {
  if (length(n_threads) != 1) {
    stop(
      "'n_threads' should be one value.\n",
      "Actual number of values: ", length(n_threads)
    )
  }
  if (!is_one_na(n_threads) && !is.numeric(n_threads)) {
    stop(
      "'n_threads' should be one NA or one non-zero positive value.\n",
      "Actual value: ", n_threads
    )
  }
  if (!is_one_na(n_threads) && !(n_threads > 0)) {
    stop(
      "'n_threads' should be one NA or one non-zero positive value.\n",
      "Actual value: ", n_threads
    )
  }
}
