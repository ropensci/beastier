#' Checks if the operating system is supported
#' @inheritParams default_params_doc
#' @return Nothing. Will \link{stop} if the OS is unsupported
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_os("mac")
#' check_os("unix")
#' check_os("win")
#' @export
check_os <- function(os) {
  if (!os %in% c("mac", "unix", "win")) {
    stop("'os' must be either 'mac', 'unix' or 'win'")
  }
}
