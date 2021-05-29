#' Create a temporary filename for the BEAST2 XML filename
#' @export
create_temp_input_filename <- function() {
  beastier::get_beastier_tempfilename(
    pattern = "beast2_", fileext = ".xml"
  )
}
