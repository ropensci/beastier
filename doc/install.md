# Install

This page described how to install `beastier`.

## Install `beastier`

`beastier` is not on CRAN yet. The simplest way now is to install `beastier` with the `devtools` R package:

```
devtools::install_github("richelbilderbeek/beastier")
```

`beastier` assumes that `beautier` is also installed. Do so:

```
devtools::install_github("richelbilderbeek/beautier")
```

`beastier` assumes that BEAST2 is installed. To install BEAST2, from R do:

```{r}
library(beastier)
install_beast2()
```

This will download and extract BEAST2 to:

OS|Full path
---|---
Linux|`~/.local/share/beast`
Windows|`C:/Users/<username>/Local/beast`
