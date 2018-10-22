# FAQ

 1. `beastier` in [academia](#academia) 
 2. `beastier` and [BEAST2](#BEAST2)
 3. `beastier` [development](#development) 
 4. `beastier` [technical](#technical)
 5. `beastier` [misc](#misc)

## [academia](#academia)

`beastier` in [academia](#academia).

### 1.1 How do I reference to this work?

Cite:

 * Bilderbeek, Richel J.C., Etienne, Rampal S., "babette: BEAUti 2, BEAST2 and Tracer for R". bioRxiv 271866; doi: https://doi.org/10.1101/271866

### 1.2 What are the FASTA files?

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.

Thanks to Paul van Els.

## [BEAST2](#BEAST2)

`beastier` and [BEAST2](#BEAST2).

### 2.1 How to install BEAST2?

```
beastier::install_beast2()
```

### 2.2 Which version of BEAUti do you use as a guideline?

Version 2.5.0, as can be found in the [install_beast2](https://github.com/richelbilderbeek/beastier/blob/master/R/install_beast2.R) function.

## [development](#development) 

`beastier` [development](#development).

### 3.1 How can I indicate a feature that I miss?

Submit an Issue.

### 3.2 How can I submit code?

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting code'

### 3.3 How can I submit a bug?

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting bugs' 

### 3.4 How can I indicate something else?

Submit an Issue. Or send an email to Richel Bilderbeek.

## [technical](#technical)

`beastier` technical questions.

### 4.1 Why doesn't `beastier` support calling the Windows BEAST2.exe file?

The goal of `beastier` is to call BEAST2 from R scripts.
The Windows `BEAST2.exe` executable starts a graphical user interface.
An R script should be silent, without pop-ups. 
Therefore, calling the Windows `BEAST2.exe` executable is disallowed.

If this changes, you are encouraged to inform me, by either an Issue
or an email.

### 4.2 Installing Java under Bionic

The `.travis.yml` file shows a Trusty install:

```
 - sudo apt-get install -qq oracle-java8-installer # Java 8
 - sudo apt-get install oracle-java8-set-default
```

On Bionic, I assume the same can be achieved with:


```
  - sudo add-apt-repository -y ppa:webupd8team/java 
  - sudo apt-get update -qq
  - sudo apt-get install oracle-java8-installer
  - sudo apt-get install oracle-java8-set-default
``

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

```
convert hippo.png -fuzz 15% -fill white -opaque white hippo_mono_background.png
convert hippo_mono_background.png -background white -alpha remove hippo_mono_background_2.png
```
