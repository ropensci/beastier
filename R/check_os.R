#' Checks if the operating system is supported
#' @inheritParams default_params_doc
#' @return nothing. Will stop if the OS is unsupported
#' @author Richel J.C. Bilderbeek
check_os <- function(os) {
  if (!os %in% c("mac", "unix", "win")) {
    stop("'os' must be either 'mac', 'unix' or 'win'")
  }
}
