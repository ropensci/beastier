#' Save a NEXUS file as a FASTA file
#' @param nexus_filename name of an existing NEXUS file
#' @param fasta_filename name of the FASTA file to be created
#' @export
save_nexus_as_fasta <- function(
  nexus_filename,
  fasta_filename
) {
  ape::write.FASTA(
    ape::as.DNAbin(ape::read.nexus.data(nexus_filename)),
    file = fasta_filename
  )
}
