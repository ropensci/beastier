#' Get the .trees filenames that BEAST2 will produce
#' @inheritParams default_params_doc
#' @return character vector with the names of the .trees files that BEAST2
#'   will produce
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' get_trees_filenames(get_beastier_path("2_4.xml"))
#' get_trees_filenames(get_beastier_path("anthus_2_4.xml"))
#'
#' check_empty_beaustier_folders()
#' @export
get_trees_filenames <- function(input_filename) {

  alignment_ids <- beastier::get_alignment_ids_from_xml_filename(
    xml_filename = input_filename
  )
  paste0(alignment_ids, ".trees")
}
