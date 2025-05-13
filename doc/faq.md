# FAQ

 1. `beastier` in [academia](#academia)
 2. `beastier` and [BEAST2](#beast2)
 3. `beastier` [development](#development)
 4. `beastier` [technical](#technical)
 5. `beastier` [misc](#misc)

## [academia](#academia)

`beastier` in [academia](#academia).

### 1.1 How do I reference to this work?

Cite:

```text
Bilderbeek, Richèl JC, and Rampal S. Etienne. 
"babette: BEAUti 2, BEAST 2 and Tracer for R." 
Methods in Ecology and Evolution (2018).
```

or

```text
@article{bilderbeek2018babette,
  title={babette: BEAUti 2, BEAST 2 and Tracer for R},
  author={Bilderbeek, Richèl JC and Etienne, Rampal S},
  journal={Methods in Ecology and Evolution},
  year={2018},
  publisher={Wiley Online Library}
}
```

### 1.2 What are the FASTA files?

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:

* Van Els, Paul, and Heraldo V. Norambuena.
  "A revision of species limits in Neotropical pipits Anthus
  based on multilocus genetic and vocal data." Ibis.

Thanks to Paul van Els.

## [BEAST2](#beast2)

`beastier` and [BEAST2](#beast2).

### 2.1 How to install BEAST2?

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

### 2.2 Which version of BEAUti do you use as a guideline?

Version 2.6.0, as can be found in the
[install_beast2](https://github.com/ropensci/beastier/blob/main/R/install_beast2.R)
function.

## [development](#development)

`beastier` [development](#development).

### 3.1 How can I indicate a feature that I miss?

Submit an Issue.

### 3.2 How can I submit code?

See [CONTRIBUTING](../CONTRIBUTING.md), at 'Submitting code'

### 3.3 How can I submit a bug?

See [CONTRIBUTING](../CONTRIBUTING.md), at 'Submitting bugs'

### 3.4 How can I indicate something else?

Submit an Issue. Or send an email to Richèl Bilderbeek.

## [technical](#technical)

`beastier` technical questions.

### 4.1 Why doesn't `beastier` support calling the Windows BEAST2.exe file?

The goal of `beastier` is to call BEAST2 from R scripts.
The Windows `BEAST2.exe` executable starts a graphical user interface.
An R script should be silent, without pop-ups.
Therefore, calling the Windows `BEAST2.exe` executable is disallowed.

If this changes, you are encouraged to inform me, by either an Issue
or an email.

### 4.2 Installing Java under A

```bash
sudo apt-get install r-cran-rjava
R CMD javareconf
```

### 4.2 Installing Java under Bionic

The `.travis.yml` file shows a Trusty install:

```text
 - sudo apt-get install -qq oracle-java8-installer # Java 8
 - sudo apt-get install oracle-java8-set-default
```

On Bionic, I assume the same can be achieved with:

```bash
sudo add-apt-repository -y ppa:webupd8team/java 
sudo apt-get update -qq
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
```

### 4.3 Why doesn't `beastier` have 100% code coverage?

Because `beastier` cannot be fully tested for both
Linux and Windows on the same operating system.

Code coverage is measured by
[codecov](https://codecov.io/gh/ropensci/beastier/tree/main/R)
by the Travis CI continuous integration service.
Travis uses Linux.
One can observe all missing code coverage is due to Windows-only functions.

Sure, there are also tests by the AppVeyor continuous integration service.
AppVeyor uses Windows. Would one observe that code coverage report,
one would observe all missing code coverage is due to Linux-only functions.

## [misc](#misc)

`beastier` miscellaneous topics.

### 5.1 Why the logo?

Initially, the logo was a low-tech remake of Beast, from Marvel.
To prevent problems with Marvel, a different logo was picked.

The current logo shows a hippo, 'quite a formidable beast', also shown
intimidatingly big for the R logo.
The hippo is drawn by Jose Scholte, who kindly allowed her work to
be used for free, by attribution.

### 5.2 How did you convert the fuzzy white background to one single color?

```bash
convert hippo.png -fuzz 15% -fill white -opaque white hippo_mono_background.png
convert hippo_mono_background.png -background white -alpha remove hippo_mono_background_2.png
```
