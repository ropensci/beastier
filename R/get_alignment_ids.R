#' Get the alignment ID from a file with one alignment
#' @param xml_filename name of a BEAST2 XML input filename
#' @return one or more alignment IDs
#' @examples
#' check_empty_beaustier_folders()
#'
#' # test_output_0
#' get_alignment_ids_from_xml_filename(get_beastier_path("2_4.xml"))
#' # c("anthus_aco","anthus_nd2")
#' get_alignment_ids_from_xml_filename(get_beastier_path("anthus_15_15.xml"))
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
get_alignment_ids_from_xml_filename <- function( # nolint indeed a long function name, but I preferred to keep it: a normal user should use 'get_alignment_ids'
  xml_filename
) {

  if (!file.exists(xml_filename)) {
    stop("'xml_filename' must be the name of an existing file")
  }

  xml <- xml2::read_xml(xml_filename)
  xml_data <- xml2::xml_find_all(xml, ".//data")
  ids <- xml2::xml_attr(xml_data, "id")
  ids
}
