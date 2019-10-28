#' Print a \code{beast2_internal_filenames} as a table
#' @inheritParams default_params_doc
#' @export
print_beast2_internal_filenames <- function( # nolint indeed a long function name, which is fine for internal function
  beast2_internal_filenames
) {
  # Shorthand name for BEAST2 Internal FilenameS
  bifs <- beast2_internal_filenames

  beastier::check_beast2_internal_filenames(bifs)
  df <- beastier::beast2_internal_filenames_to_table(bifs)
  cat(knitr::kable(df), sep = "\n")
}
