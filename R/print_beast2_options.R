#' Pretty-print a \code{beast2_options}
#' @inheritParams default_params_doc
#' @export
print_beast2_options <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  df <- beastier::beast2_options_to_table(beast2_options)
  cat(knitr::kable(df), sep = "\n")
}
