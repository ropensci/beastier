#' Pretty-print a `beast2_options`
#' @inheritParams default_params_doc
#' @return Nothing. Will display the `beast2_options` using \link{cat}.
#' @examples
#' check_empty_beaustier_folders()
#'
#' print_beast2_options(create_beast2_options())
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
print_beast2_options <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  df <- beastier::beast2_options_to_table(beast2_options)
  cat(knitr::kable(df), sep = "\n")
}
