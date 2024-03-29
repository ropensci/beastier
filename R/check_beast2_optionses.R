#' Check if the \code{beast2_options} is a valid BEAST2 options object.
#'
#' Calls \code{stop} if the BEAST2 option object is invalid
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \code{stop} if the BEAST2 option object is invalid
#' @seealso Use \link{create_beast2_options} to create a valid
#'   BEAST2 options object
#' @examples
#' check_empty_beaustier_folders()
#'
#' check_beast2_optionses(list(create_beast2_options()))
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
check_beast2_optionses <- function(
  beast2_optionses
) {
  if (!is.list(beast2_optionses)) {
    stop("'beast2_optionses' must be a list")
  }
  for (i in seq_along(beast2_optionses)) {
    # Stub with too simple error message
    check_beast2_options(beast2_optionses[[i]])
  }
}
