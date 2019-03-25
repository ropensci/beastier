#' Check if the input is a valid number of threads.
#'
#' Will \link{stop} if not.
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_silent(check_n_threads(1))
#'   expect_silent(check_n_threads(2))
#'   expect_silent(check_n_threads(NA))
#'
#'   expect_error(check_n_threads(-1))
#'   expect_error(check_n_threads("nonsense"))
#'   expect_error(check_n_threads(c(1, 2)))
#'   expect_error(check_n_threads(c()))
#'   expect_error(check_n_threads(NULL))
#' @export
check_n_threads <- function(n_threads) {
  if (length(n_threads) != 1) {
    stop(
      "'n_threads' should be one value.\n",
      "Actual number of values: ", length(n_threads)
    )
  }
  if (beautier::is_one_na(n_threads)) return()
  if (!is.numeric(n_threads)) {
    stop(
      "'n_threads' should be one NA or one non-zero positive value.\n",
      "Actual value: ", n_threads
    )
  }
  if (n_threads <= 0) {
    stop(
      "'n_threads' should be one NA or one non-zero positive value.\n",
      "Actual value: ", n_threads
    )
  }
}
