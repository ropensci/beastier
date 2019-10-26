#' Create a temporary filename for the BEAST2 XML filename
#' @export
create_temp_input_filename <- function() {
  file.path(
    rappdirs::user_cache_dir(),
    basename(
      tempfile(pattern = "beast2_", fileext = ".xml")
    )
  )
}