# Install

This page described how to install `beastier`.

## Install `rJava`

If you have problems installing rJava, [Duck](http://www.duckduckgo.com) or [view my rJava notes](rjava.md).

## Install BEAST2

Due to CRAN policy, beastier cannot install BEAST2.
As a workaround, the non-CRAN `beastierinstall` can be used.

To install BEAST2:

```
remotes::install_github("richelbilderbeek/beastierinstall")
beastierinstall::install_beast2()
```

This will download and extract BEAST2 to:

OS     |Full path
-------|----------------------------------
Linux  |`~/.local/share/beast`
macOS  |`~/.local/share/beast`
Windows|`C:/Users/<username>/Local/beast`

## Install `beastier`

### CRAN version

### Stable development

`beastier` is not on CRAN yet. The simplest way now is to install `beastier` with the `devtools` R package:

```
remotes::install_github("ropensci/beastier")
```

`beastier` assumes that `beautier` and `tracerer` are also installed. Do so:

```
remotes::install_github("ropensci/beautier")
remotes::install_github("ropensci/tracerer")
```

`beastier` assumes that BEAST2 is installed.
