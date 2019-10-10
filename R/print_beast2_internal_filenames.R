#' Print a \code{beast2_internal_filenames} as a table
#' @inheritParams default_params_doc
#' @param show_exist if TRUE, a column is added to indicate each
#' file's existence
#' @export
print_beast2_internal_filenames <- function( # nolint indeed a long function name, which is fine for internal function
  beast2_internal_filenames,
  show_exist = FALSE
) {
  # Shorthand name for BEAST2 Internal FilenameS
  bifs <- beast2_internal_filenames

  beastier::check_beast2_internal_filenames(bifs)
  df <- beastier::beast2_internal_filenames_to_table(bifs)
  if (show_exist) {
    df$exists <- file.exists(df$value)
  }
  cat(knitr::kable(df), sep = "\n")
}
