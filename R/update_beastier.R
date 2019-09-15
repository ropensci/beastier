#' Update all beastier dependencies, by installing their
#' latests versions
#' @author Richèl J.C. Bilderbeek
#' @export
update_beastier <- function() {
  repo_names <- c("ropensci/beautier", "ropensci/tracerer")
  for (repo_name in repo_names) {
    remotes::install_github(
      repo_name,
      quiet = TRUE,
      dependencies = TRUE,
      upgrade = "always"
    )
  }
}
