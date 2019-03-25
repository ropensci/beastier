#' Checks if the operating system is supported
#' @inheritParams default_params_doc
#' @return nothing. Will stop if the OS is unsupported
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_silent(check_os("mac"))
#'   expect_silent(check_os("unix"))
#'   expect_silent(check_os("win"))
#'
#'   expect_error(check_os("android"))
#'   expect_error(check_os("n64"))
#'   expect_error(check_os("nds"))
#'   expect_error(check_os("nes"))
#'   expect_error(check_os("snes"))
#'
#'   expect_error(check_os(NA))
#'   expect_error(check_os(NULL))
#'   expect_error(check_os(""))
#'   expect_error(check_os(c()))
#' @export
check_os <- function(os) {
  if (!os %in% c("mac", "unix", "win")) {
    stop("'os' must be either 'mac', 'unix' or 'win'")
  }
}
