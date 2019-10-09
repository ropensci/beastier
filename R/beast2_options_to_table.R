#' Convert a \code{beast2_options} to a table
#' @inheritParams default_params_doc
#' @export
beast2_options_to_table <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  data.frame(
    row.names = names(beast2_options),
    value = unlist(beast2_options)
  )
}
