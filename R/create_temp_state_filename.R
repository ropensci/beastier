#' Create a temporary file for the BEAST2 XML output file that
#' stores its state.
#' @return a temporary filename, that starts with `beast2_`
#' and has extension `.xml.state`
#' @examples
#' check_empty_beaustier_folders()
#'
#' create_temp_state_filename()
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_temp_state_filename <- function() {
  beastier::get_beastier_tempfilename(
    pattern = "beast2_",
    fileext = ".xml.state"
  )
}
