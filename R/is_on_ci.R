#' Deprecated function, use \link[beautier]{is_on_appveyor}
#' @return TRUE if run on AppVeyor, FALSE otherwise
#' @author Richèl J.C. Bilderbeek
#' @export
is_on_appveyor <- function() {
  stop("Deprecated function, use 'beautier::is_on_appveyor'")
}

#' Deprecated function, use \link[beautier]{is_on_travis}
#' @return TRUE if run on Travis CI, FALSE otherwise
#' @author Richèl J.C. Bilderbeek
#' @export
is_on_travis <- function() {
  stop("Deprecated function, use 'beautier::is_on_travis'")
}

#' Deprecated function, use \link[beautier]{is_on_ci}
#' @return TRUE if run on AppVeyor or Travis CI, FALSE otherwise
#' @author Richèl J.C. Bilderbeek
#' @export
is_on_ci <- function() {
  stop("Deprecated function, use 'beautier::is_on_ci'")
}
