#' Create a temporary filename for the BEAST2 XML filename
#' @return a temporary filename, that starts with `beast2_`
#' and has extension `.xml`
#' @examples
#' check_empty_beaustier_folders()
#'
#' create_temp_input_filename()
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_temp_input_filename <- function() {
  beastier::get_beastier_tempfilename(
    pattern = "beast2_", fileext = ".xml"
  )
}
