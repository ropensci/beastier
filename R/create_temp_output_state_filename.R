#' Create a temporary file for the BEAST2 XML output file that
#' stores its state 
#' @export
create_temp_output_state_filename <- function() {
  file.path(
    rappdirs::user_cache_dir(),
    basename(
      tempfile(pattern = "beast2_", fileext = ".xml.state")
    )
  )
}