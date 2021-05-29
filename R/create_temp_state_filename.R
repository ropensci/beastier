#' Create a temporary file for the BEAST2 XML output file that
#' stores its state.
#' @export
create_temp_state_filename <- function() {
  beastier::get_beastier_tempfilename(
    pattern = "beast2_",
    fileext = ".xml.state"
  )
}
