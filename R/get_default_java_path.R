#' Obtains the default path to the Java executable
#' @return the default path to the Java executable
#' @author Richel J.C. Bilderbeek
#' @export
get_default_java_path <- function() {
  #java_path <- "C:/Program Files (x86)/Java/jre1.8.0_181/bin/java.exe"
  # java2 <- "/Users/Gebruiker/Documents/R/win-library/3.5/rJava/java"
  # if (.Platform$OS.type == "unix") {
  #   java_path <- "java"
  # }
  # java_path
  #
  rJava::.jinit()
  java_path <- rJava::.jcall( 'java/lang/System', 'S', 'getProperty', 'java.home' )
  file.exists(java_path)
  java_path
}
