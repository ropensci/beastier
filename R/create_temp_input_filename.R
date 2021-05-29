#' Create a temporary filename for the BEAST2 XML filename
#' @export
create_temp_input_filename <- function() {
  file.path(
    rappdirs::user_cache_dir(),
    basename(
      get_beastier_tempfilename(pattern = "beast2_", fileext = ".xml")
    )
  )
}
