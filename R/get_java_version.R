#' Get the Java version
#' @return the Java version
#' @author Richèl J.C. Bilderbeek
#' @examples
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'   get_java_version()
#' }
#' @export
get_java_version <- function() {
  rJava::.jinit()
  rJava::.jcall("java/lang/System", "S", "getProperty", "java.runtime.version")
}
