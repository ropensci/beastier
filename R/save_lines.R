#' Save text (a container of strings) to a file
#' @param filename filename of the file to have the text written to
#' @param lines lines of text to be written to file
#' @return Nothing. Will save the lines to file
#' @author Richèl J.C. Bilderbeek
#' @examples
#' text <- c("hello", "world")
#' filename <- get_beastier_tempfilename()
#' save_lines(filename = filename, lines = text)
#' file.remove(filename)
#' @export
save_lines <- function(filename, lines) {
  my_file <- file(filename)
  writeLines(lines, my_file)
  close(my_file)
}
