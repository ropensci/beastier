#' Removes files if and only if present
#' @param filenames names of the files to be removed
#' @return nothing, removes those files that are present
#' @examples
#'   # Can safely delete absent files
#'   beastier:::remove_files("abs.ent")
#'
#'   # Create a file
#'   filename <- "pres.ent"
#'   file.copy(from = get_beastier_path("anthus_2_4.xml"), to = filename)
#'   testit::assert(file.exists(filename))
#'
#'   # Can safely delete a mix of present and absent files
#'   beastier:::remove_files(c("abs.ent", filename))
#'   testit::assert(!file.exists(filename))
#' @author Richel J.C. Bilderbeek
remove_files <- function(filenames) {
  for (filename in filenames) {
    if (file.exists(filename)) file.remove(filename)
  }
}
