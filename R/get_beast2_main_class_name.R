#' Get the BEAST2 main class name.
#'
#' One way to fix the error
#' \code{no main manifest attribute}
#' is to specify the main class name.
#' @export
get_beast2_main_class_name <- function() {
  "beast.app.beastapp.BeastLauncher"
}
