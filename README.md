# beastier

<!-- markdownlint-disable MD013 -->

[![Peer Review Status](https://badges.ropensci.org/209_status.svg)](https://github.com/ropensci/onboarding/issues/209)
[![CRAN version](http://www.r-pkg.org/badges/version/beastier)](https://cran.r-project.org/package=beastier)
[![CRAN total downloads](http://cranlogs.r-pkg.org/badges/grand-total/beastier)]( https://CRAN.R-project.org/package=beastier)
[![CRAN downloads per month](http://cranlogs.r-pkg.org/badges/beastier)](https://CRAN.R-project.org/package=beastier)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![DOI](https://zenodo.org/badge/115617629.svg)](https://zenodo.org/badge/latestdoi/115617629)

Branch   |[![GitHub Actions logo](man/figures/GitHubActions.png)](https://github.com/ropensci/beautier/actions)|[![Codecov logo](man/figures/Codecov.png)](https://www.codecov.io)
---------|-----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------
`master` |![R-CMD-check](https://github.com/ropensci/beastier/workflows/R-CMD-check/badge.svg?branch=master)   |[![codecov.io](https://codecov.io/github/ropensci/beastier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beastier/branch/master)
`develop`|![R-CMD-check](https://github.com/ropensci/beastier/workflows/R-CMD-check/badge.svg?branch=develop)  |[![codecov.io](https://codecov.io/github/ropensci/beastier/coverage.svg?branch=develop)](https://codecov.io/github/ropensci/beastier/branch/develop)

<!-- markdownlint-enable MD013 -->

`beastier` is an R package to run BEAST2.

![beastier logo](man/figures/beastier_logo.png)

`beastier` is part of the [`babette`](https://github.com/ropensci/babette)
package suite:

* [`beautier`](https://github.com/ropensci/beautier)
  creates BEAST2 input (`.xml`) files.
* [`beastier`](https://github.com/ropensci/beastier) runs BEAST2
* [`mauricer`](https://github.com/ropensci/mauricer): install BEAST2 packages
* [`tracerer`](https://github.com/ropensci/tracerer)
  pastes BEAST2 output (`.log`, `.trees`, etc) files.

Related R packages:

* [`beastierinstall`](https://github.com/richelbilderbeek/beastierinstall):
  Install and uninstall BEAST2
* [`beastier_on_windows`](https://github.com/richelbilderbeek/beastier_on_windows):
  Verify that `beastier` works on the Windows operating system
* [`lumier`](https://github.com/ropensci/lumier):
  Shiny app to help create the function call needed

## Install BEAST2

Due to CRAN policy, beastier cannot install BEAST2.
As a workaround, the non-CRAN
[`beastierinstall`](https://github.com/richelbilderbeek/beastierinstall)
can be used.

To install BEAST2:

```r
remotes::install_github("richelbilderbeek/beastierinstall")
beastierinstall::install_beast2()
```

## Example for `v2.1`

Run BEAST2:

```r
output_state_filename <- "out.state"

run_beast2(
  input_filename = get_beastier_path("2_4.xml"),
  output_state_filename = output_state_filename
)
```

This will create the files as specified in the `2_4.xml` BEAST2 input file.

## Example for `v2.0.25`

```r
output_log_filename <- "out.log"
output_trees_filename <- "out.trees"
output_state_filename <- "out.state"

run_beast2(
  input_filename = get_beastier_path("2_4.xml"),
  output_log_filename = output_log_filename,
  output_trees_filenames = output_trees_filename,
  output_state_filename = output_state_filename
)
```

Note that in this version, the filenames for the `.log`
and `.trees` files could be specified. This is unneeded:
the `2_4.xml` BEAST2 input file specifies where these files will be stored:

```text
<?xml [...]?><beast [...]>

[...]

<run [...]>

    [...]

    <logger id="tracelog" fileName="test_output_0.log" [...]>
        [...]
    </logger>

    [...]

    <logger id="treelog.t:[...]" fileName="$(tree).trees" [...]>
        [...]
    </logger>
</run>
</beast>
```

When using `beautier`, this can be specified in `create_mcmc`:

```r
create_mcmc(
  tracelog = create_tracelog(
    filename = "my_trace.log"
  ),
  treeslog = create_treeslog(
    filename = "my_trees.trees"
  )
)
```

## [Install](doc/install.md)

See [install](doc/install.md).

## [FAQ](doc/faq.md)

See [FAQ](doc/faq.md)

## Missing features/unsupported

`beastier` cannot do everything `BEAST2` can.

* Remove: install BEAST2, use [`beastierinstall`](https://github.com/richelbilderbeek/beastierinstall)
* Experimental: Continue a BEAST2 run
* Untested: Setup BEAGLE

## There is a feature I miss

See [CONTRIBUTING](CONTRIBUTING.md), at `Submitting use cases`

## I want to collaborate

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting code'

## I think I have found a bug

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting bugs'

## There's something else I want to say

Sure, just add an Issue. Or send an email.

## External links

* [BEAST2 GitHub](https://github.com/CompEvol/beast2)

## Dependencies

<!-- markdownlint-disable MD013 -->

Branch                     |[![GitHub Actions logo](man/figures/GitHubActions.png)](https://github.com/ropensci/beautier/actions)              |[![Codecov logo](man/figures/Codecov.png)](https://www.codecov.io)
---------------------------|-------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
`beautier` `master`        |![R-CMD-check](https://github.com/ropensci/beautier/workflows/R-CMD-check/badge.svg?branch=master)                 |[![codecov.io](https://codecov.io/github/ropensci/beautier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beautier/branch/master)
`beautier` `develop`       |![R-CMD-check](https://github.com/ropensci/beautier/workflows/R-CMD-check/badge.svg?branch=develop)                |[![codecov.io](https://codecov.io/github/ropensci/beautier/coverage.svg?branch=develop)](https://codecov.io/github/ropensci/beautier/branch/develop)
`beastierinstall` `master` |![R-CMD-check](https://github.com/richelbilderbeek/beastierinstall/workflows/R-CMD-check/badge.svg?branch=master)  |[![codecov.io](https://codecov.io/github/richelbilderbeek/beastierinstall/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beastierinstall/branch/master)
`beastierinstall` `develop`|![R-CMD-check](https://github.com/richelbilderbeek/beastierinstall/workflows/R-CMD-check/badge.svg?branch=develop) |[![codecov.io](https://codecov.io/github/richelbilderbeek/beastierinstall/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/beastierinstall/branch/develop)

<!-- markdownlint-enable MD013 -->

Branch                         |[![AppVeyor logo](man/figures/AppVeyor.png)](https://ci.appveyor.com/project/richelbilderbeek/beastier_on_windows/)
-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
`beastier_on_windows` `master` |[![Build status](https://ci.appveyor.com/api/projects/status/ralex9sdnnxlwbgx/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier-on-windows/branch/master)
`beastier_on_windows` `develop`|[![Build status](https://ci.appveyor.com/api/projects/status/ralex9sdnnxlwbgx/branch/develop?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier-on-windows/branch/develop)

## Files used by continuous integration scripts

Filename                              |Descriptions
--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
[mlc_config.json](mlc_config.json)    |Configuration of the link checker, use `markdown-link-check --config mlc_config.json --quiet docs/**/*.md` to do link checking locally
[.spellcheck.yml](.spellcheck.yml)    |Configuration of the spell checker, use `pyspelling -c .spellcheck.yml` to do spellcheck locally
[.wordlist.txt](.wordlist.txt)        |Whitelisted words for the spell checker, use `pyspelling -c .spellcheck.yml` to do spellcheck locally
[.markdownlint.jsonc](.markdownlint.jsonc)|Configuration of the markdown linter, use `markdownlint "**/*.md"` to do markdown linting locally. The name of this file is a default name.
[.markdownlintignore](.markdownlintignore)|Files ignored by the markdown linter, use `markdownlint "**/*.md"` to do markdown linting locally. The name of this file is a default name.

## References

Article about `babette`:

* Bilderbeek, Richèl JC, and Rampal S. Etienne. "`babette`:
  BEAUti 2, BEAST 2 and Tracer for R." Methods in Ecology and
  Evolution (2018). <https://doi.org/10.1111/2041-210X.13032>

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:

* Van Els, Paul, and Heraldo V. Norambuena.
  "A revision of species limits in Neotropical pipits Anthus
  based on multilocus genetic and vocal data." Ibis.

[![ropensci_footer](https://ropensci.org/public_images/ropensci_footer.png)](https://ropensci.org)
