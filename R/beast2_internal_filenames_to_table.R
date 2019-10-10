#' Convert a \code{beast2_internal_filenames} to a table
#' @inheritParams default_params_doc
#' @export
beast2_internal_filenames_to_table <- function(beast2_internal_filenames) { # nolint indeed a long function name, which is fine for an internal function
  # BEAST2 Internal FilenameS
  bifs <- beast2_internal_filenames

  beastier::check_beast2_internal_filenames(bifs)
  data.frame(
    row.names = names(bifs),
    value = unlist(bifs),
    stringsAsFactors = FALSE
  )
}
