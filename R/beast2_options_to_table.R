#' Convert a \code{beast2_options} to a table
#' @inheritParams default_params_doc
#' @return a \link[tibble]{tibble} with two columns, called `parameter`
#' and `value`. Each `parameter` is the name of the element of the
#' `beast2_options` structure, where the `value` on the same row holds
#' the value of that parameter
#' @examples
#' beast2_options_to_table(create_beast2_options())
#' @author Richèl J.C. Bilderbeek
#' @export
beast2_options_to_table <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  tibble::tibble(
    parameter = names(beast2_options),
    value = unlist(beast2_options)
  )
}
