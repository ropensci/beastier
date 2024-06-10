# Install

This page described how to install `beastier`.

## Install `rJava`

If you have problems installing rJava,
[Duck](http://www.duckduckgo.com) or
[view my rJava notes](rjava.md).

## Install BEAST2

Due to CRAN policy, beastier cannot install BEAST2.
As a workaround, the non-CRAN `beastierinstall` can be used.

To install BEAST2:

```r
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

`beastier` is on CRAN:

```r
install.packages("beastier")
```
