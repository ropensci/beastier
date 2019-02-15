#' Save text (a container of strings) to a file
#' @param filename filename of the file to have the text written to
#' @param lines lines of text to be written to file
#' @return Nothing. Will save the lines to file
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   text <- c("hello", "world")
#'   beastier:::save_lines(filename = "test.txt", lines = text)
#'   testit::assert(file.exists("test.txt"))
#' @noRd
save_lines <- function(filename, lines) {
  my_file <- file(filename)
  writeLines(lines, my_file)
  close(my_file)
}
