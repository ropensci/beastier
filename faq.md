# FAQ

## How to install BEAST2?

```
beastier::install_beast2()
```

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

 * Bilderbeek, Richel J.C., Etienne, Rampal S., "babette: BEAUti 2, BEAST2 and Tracer for R". bioRxiv 271866; doi: https://doi.org/10.1101/271866

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
The hippo is drawn by Jose Scholten, who kindly allowed her work to
be used for free, by attribution.

## How did you convert the fuzzy white background to one single color?

```
convert hippo.png -fuzz 15% -fill white -opaque white hippo_mono_background.png
convert hippo_mono_background.png -background white -alpha remove hippo_mono_background_2.png
```