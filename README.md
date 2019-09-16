# beastier

[![Peer Review Status](https://badges.ropensci.org/209_status.svg)](https://github.com/ropensci/onboarding/issues/209)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/beastier)](https://cran.r-project.org/package=beastier)
[![](http://cranlogs.r-pkg.org/badges/grand-total/beastier)]( https://CRAN.R-project.org/package=beastier)
[![](http://cranlogs.r-pkg.org/badges/beastier)](https://CRAN.R-project.org/package=beastier)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![DOI](https://zenodo.org/badge/115617629.svg)](https://zenodo.org/badge/latestdoi/115617629)

Branch   |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)                                                         |[![AppVeyor logo](pics/AppVeyor.png)](https://www.appveyor.com)                                                                                                                           |[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---------|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------
`master` |[![Build Status](https://travis-ci.org/ropensci/beastier.svg?branch=master)](https://travis-ci.org/ropensci/beastier) |[![Build status](https://ci.appveyor.com/api/projects/status/ralex9sdnnxlwbgx/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier-on-windows/branch/master)|[![codecov.io](https://codecov.io/github/ropensci/beastier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beastier/branch/master)
`develop`|[![Build Status](https://travis-ci.org/ropensci/beastier.svg?branch=develop)](https://travis-ci.org/ropensci/beastier)|None                                                                                                                                                                                      |[![codecov.io](https://codecov.io/github/ropensci/beastier/coverage.svg?branch=develop)](https://codecov.io/github/ropensci/beastier/branch/develop)

`beastier` is an R package to run BEAST2.

![beastier logo](pics/beastier_logo.png)

`beastier` is part of the [`babette`](https://github.com/ropensci/babette) package suite:

 * [`beautier`](https://github.com/ropensci/beautier) creates BEAST2 input (`.xml`) files.
 * [`beastier`](https://github.com/ropensci/beastier) runs BEAST2
 * [`mauricer`](https://github.com/ropensci/mauricer): install BEAST2 packages
 * [`tracerer`](https://github.com/ropensci/tracerer) pastes BEAST2 output (`.log`, `.trees`, etc) files.

Related R packages:

 * [`beastier_on_windows`](https://github.com/richelbilderbeek/beastier_on_windows): Verify that `beastier` works on the Windows operating system
 * [`lumier`](https://github.com/ropensci/lumier): Shiny app to help create the function call needed

## Example

```
output_log_filename <- "out.log"
output_trees_filename <- "out.trees"
output_state_filename <- "out.state"

run_beast2(
  input_filename = get_beastier_path("2_4.xml"),
  output_log_filename = output_log_filename,
  output_trees_filenames = output_trees_filename,
  output_state_filename = output_state_filename
)

testit::assert(file.exists(output_log_filename))
testit::assert(file.exists(output_trees_filename))
testit::assert(file.exists(output_state_filename))
```

## [Install](doc/install.md)

See [install](doc/install.md).

## [FAQ](doc/faq.md)

See [FAQ](doc/faq.md)

## Missing features/unsupported

`beastier` cannot do everything `BEAST2` can. 

Here are some missing or (yet) unsupported features:

 * Continue a BEAST2 run
 * Setup BEAGLE

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

## References

Article about `babette`:

 * Bilderbeek, Richèl JC, and Rampal S. Etienne. "`babette`: BEAUti 2, BEAST 2 and Tracer for R." Methods in Ecology and Evolution (2018). https://doi.org/10.1111/2041-210X.13032

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.

[![ropensci_footer](https://ropensci.org/public_images/ropensci_footer.png)](https://ropensci.org)

