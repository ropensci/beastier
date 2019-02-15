#' Get the alignment ID from a file with one alignment
#' @param xml_filename name of a BEAST2 XML input filename
#' @return one or more alignment IDs
#' @examples
#'  testit::assert(get_alignment_ids(beastier::get_beastier_path("2_4.xml"))
#'    == "test_output_0"
#'  )
#'  testit::assert(
#'    get_alignment_ids(beastier::get_beastier_path("anthus_15_15.xml"))
#'    == c("anthus_aco","anthus_nd2")
#'  )
#'
#' @author Richèl J.C. Bilderbeek
#' @export
get_alignment_ids <- function(
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
