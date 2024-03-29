% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_mcbette_beast2_options.R
\name{create_mcbette_beast2_options}
\alias{create_mcbette_beast2_options}
\title{Create a `beast2_options` structure for the `mcbette` R package}
\usage{
create_mcbette_beast2_options(
  input_filename = create_temp_input_filename(),
  output_state_filename = create_temp_state_filename(),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_bin_path = get_default_beast2_bin_path(),
  verbose = FALSE
)
}
\arguments{
\item{input_filename}{the name of a BEAST2 input XML file.
This file usually has an \code{.xml} extension.
Use \link{create_temp_input_filename} to create a temporary
filename with that extension.}

\item{output_state_filename}{name of the \code{.xml.state} file to create.
Use \link{create_temp_state_filename} to create a temporary
filename with that extension.}

\item{rng_seed}{the random number generator seed of the BEAST2 run.
Must be a non-zero positive integer value or \link{NA}.
If \code{rng_seed} is \link{NA}, BEAST2 will pick a random seed}

\item{n_threads}{the number of computational threads to use.
Use \link{NA} to use the BEAST2 default of 1.}

\item{use_beagle}{use BEAGLE if present}

\item{overwrite}{if TRUE: overwrite the \code{.log}
and \code{.trees} files if one of these exists.
If FALSE, BEAST2 will not be started if
\itemize{
  \item{the \code{.log} file exists}
  \item{the \code{.trees} files exist}
  \item{the \code{.log} file created by BEAST2 exists}
  \item{the \code{.trees} files created by BEAST2 exist}
}}

\item{beast2_bin_path}{name of the BEAST2 binary file
(usually simply \code{beast}).
Use \link{get_default_beast2_bin_path} to get
the default BEAST binary file's path}

\item{verbose}{if TRUE, additional information is displayed, that
is potentially useful in debugging}
}
\value{
a `beast2_options` structure suitable to be used
by the `mcbette` R package,
which is a \link{list} of all function arguments,
of which all elements are checked (by \link{check_beast2_options})
}
\description{
Create a `beast2_options` structure to be used for the
`mcbette` R package, which is a package that allows one to do
model comparison.
The generated filenames indicating `mcbette` usage,
as well as the correct BEAST2 binary/executable type
}
\examples{
check_empty_beaustier_folders()

create_mcbette_beast2_options()

check_empty_beaustier_folders()
}
\seealso{
to create a regular (that is, not intended
for model comparison) BEAST2 options structure,
use  \link{create_beast2_options}
}
\author{
Richèl J.C. Bilderbeek
}
