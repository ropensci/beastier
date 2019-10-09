#' Obtains the default path to the Java executable
#' @inheritParams default_params_doc
#' @return the default path to the Java executable
#' @author Richèl J.C. Bilderbeek
#' @export
get_default_java_path <- function(
  os = rappdirs::app_dir()$os
) {
  beastier::check_os(os = os)
  rJava::.jinit()
  java_folder <- rJava::.jcall(
    "java/lang/System", "S", "getProperty", "java.home"
  )
  testit::assert(dir.exists(java_folder))
  java_path <- file.path(java_folder, "bin", "java.exe")
  if (os != "win") {
    java_path <- file.path(java_folder, "bin", "java")
  }
  testit::assert(file.exists(java_path))
  normalizePath(java_path)
}
