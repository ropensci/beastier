# beastier

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![AppVeyor logo](pics/AppVeyor.png)](https://www.appveyor.com)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/beastier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beastier)|[![Build status](https://ci.appveyor.com/api/projects/status/tny9jb7jkwbfamm2/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beastier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beastier/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/beastier.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/beastier)|[![Build status](https://ci.appveyor.com/api/projects/status/tny9jb7jkwbfamm2/branch/develop?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier/branch/develop)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beastier/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/beastier/branch/develop)

`beastier` is an R package to run BEAST2.

![beastier logo](pics/beastier_logo.png)

`beastier` is part of the [babette](https://github.com/richelbilderbeek/babette) package suite:

 * [beautier](https://github.com/richelbilderbeek/beautier) creates BEAST2 input (`.xml`) files.
 * [beastier](https://github.com/richelbilderbeek/beastier) runs BEAST2
 * [tracerer](https://github.com/richelbilderbeek/tracerer) pastes BEAST2 output (`.log`, `.trees`, etc) files.

## Examples

See [examples](examples.md).

## Install `beastier`

If you use the `devtools` R package, this is easy:

```
devtools::install_github("richelbilderbeek/beastier")
```

`beastier` assumes that BEAST2 is installed.

To install BEAST2, from R do:

```{r}
library(beastier)
install_beast2()
```

This will download and extract BEAST2 to:

OS|Full path
---|---
Linux|`~/.local/share/beast/bin/beast.jar`
Windows|`C:/Users/<username>/Local/beast/bin/beast.jar`

## FAQ

See [FAQ](faq.md)

## Missing features/unsupported

`beastier` cannot do everything `BEAST2` can. 

Here are some missing or (yet) unsupported features:

 * Validate a BEAST2 input file
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

 * Bilderbeek, Richel J.C., Etienne, Rampal S., "babette: BEAUti 2, BEAST2 and Tracer for R". bioRxiv 271866; doi: https://doi.org/10.1101/271866

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.


