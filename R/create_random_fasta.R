#' Create a random FASTA file
#' @inheritParams default_params_doc
#' @param taxa_name_ext the extension of the taxa names
#' @return Nothing, creates a FASTA file
#' @author Richèl J.C. Bilderbeek
#' @examples
#' create_random_fasta(
#'   n_taxa = 5,
#'   sequence_length = 20,
#'   fasta_filename = get_beastier_tempfilename(fileext = ".fas")
#' )
#' @export
create_random_fasta <- function(
  n_taxa,
  sequence_length,
  fasta_filename,
  taxa_name_ext = ""
) {
  if (n_taxa < 2) {
    stop("'n_taxa' must two or more")
  }
  if (sequence_length < 1) {
    stop("'sequence_length' must be one or more")
  }
  if (!assertive::is_a_string(fasta_filename)) {
    stop("'fasta_filename' must be a character string")
  }
  if (fasta_filename == "") {
    stop("'fasta_filename' must have at least one character")
  }
  if (!assertive::is_a_string(taxa_name_ext)) {
    stop("'taxa_name_ext' must be a character string")
  }
  alignments <- beastier::create_random_alignment(
    n_taxa,
    sequence_length,
    taxa_name_ext = taxa_name_ext
  )
  phangorn::write.phyDat(alignments, file = fasta_filename, format = "fasta")
  NULL
}
