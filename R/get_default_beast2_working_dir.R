#' Get the path to the default BEAST2 working directory
#' @seealso use \link{clear_beast2_working_dir} to clear the BEAST2
#' working directory
#' @export
get_default_beast2_working_dir <- function() {
  file.path(
    rappdirs::user_cache_dir(),
    "beastier"
  )
}
