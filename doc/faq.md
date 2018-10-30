# FAQ

## How to install BEAST2?

```
beastier::install_beast2()
```

## Which version of BEAUti do you use as a guideline?

Version 2.5.0, as can be found in the [install_beast2](https://github.com/richelbilderbeek/beastier/blob/master/R/install_beast2.R) function.

## How can I indicate a feature that I miss?

Submit an Issue.

## How can I submit code?

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting code'

## How can I submit a bug?

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting bugs' 

## How can I indicate something else?

Submit an Issue. Or send an email to Richel Bilderbeek.

## How do I reference to this work?

Cite:

```
Bilderbeek, Richèl JC, and Rampal S. Etienne. "babette: BEAUti 2, BEAST 2 and Tracer for R." Methods in Ecology and Evolution (2018).
```

or

```
@article{bilderbeek2018babette,
  title={babette: BEAUti 2, BEAST 2 and Tracer for R},
  author={Bilderbeek, Richèl JC and Etienne, Rampal S},
  journal={Methods in Ecology and Evolution},
  year={2018},
  publisher={Wiley Online Library}
}
```

## What is the idea behind the logo?

The logo consists of a rough redraw of Beast, 
a fictional character from Marvel Comics, 
and the R logo. 

## What are the FASTA files?

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.

Thanks to Paul van Els.

## Why the logo?

Initially, the logo was a low-tech remake of Beast, from Marvel.
To prevent problems with Marvel, a different logo was picked.

The current logo shows a hippo, 'quite a formidable beast', also shown
intimidatingly big for the R logo. 
The hippo is drawn by Jose Scholte, who kindly allowed her work to
be used for free, by attribution.

## Installing Java under Bionic

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

## How did you convert the fuzzy white background to one single color?

```
convert hippo.png -fuzz 15% -fill white -opaque white hippo_mono_background.png
convert hippo_mono_background.png -background white -alpha remove hippo_mono_background_2.png
```