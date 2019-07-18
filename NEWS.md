# News

Newest versions at top.

## beastier 2.0.16 (2019-07-18)

### NEW FEATURES

  * Install BEAST2 `v2.6.0`, instead of `v2.5.2`

### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.15 (2019-06-01)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Simplified `run_beast2`
  * Improved error checking and logging in `run_beast2`
  * Will overwrite files if requested (which is by default)
  * Removed example code that assumed all Linuxes have `/home/username`,
    thanks to Brian Ripley 

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.14 (2019-05-27)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Add `SystemRequirements` field to `DESCRIPTION`

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.13 (2019-05-14)

### NEW FEATURES

  * Install BEAST2 `v2.5.2`, instead of `v2.5.1`
  * Can call `run_beast2`/`run_beast2_from_options` in parallel

### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.12 (2019-04-08)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Package builds successfully without BEAST2 installed

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.11 (2019-03-27)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * `get_default_beast2_bin_path` is silent if BEAST2 is absent
  * Package builds successfully without BEAST2 installed

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.10 (2019-03-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Passes tests without BEAST2 installed

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.9 (2019-03-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Pass local CRAN tests
  * Shortened examples' runtime 

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.8 (2019-03-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Fix spelling error

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.7 (2019-03-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Documentation examples work on macOS

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.6 (2019-03-25)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Whitelist 'Schmirl'

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.5 (2019-03-25)

### NEW FEATURES

  * CRAN and rOpenSci release candidate

### MINOR IMPROVEMENTS

  * Implemented feedback from CRAN, thanks Martina Schmirl:
    * In DESCRIPTION, use `'R'` for programs
    * In DESCRIPTION, use four spaces
    * In DESCRIPTION, remove the redundant '... from R' in title
    * In DESCRIPTION, use only `GPL-3` instead of also adding the file `LICENSE`
    * Add examples to all functions

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0.1 (2019-03-15)

### NEW FEATURES

  * CRAN and rOpenSci release candidate

### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 2.0 (2019-01-04)

### NEW FEATURES

  * GitHub repository is owned by `ropensci`

### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 1.5.2 (2018-10-30)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Tested to work under macOS

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 1.5.1 (2018-10-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Made up-to-date with newer version of `beautier`

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 1.5 (2018-09-12)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Instead of supplying a BEAST2 `.jar` path 
    (using the argument `beast2_jar_path`), one
    can now also supply the BEAST2 binary path.

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * All parameters named `beast2_jar_path` are now called `beast2_path`


## beastier 1.4.4 (2018-08-05)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * `run_beast2` had a parameter called `overwrite_state_file`, which is renamed 
    to `overwrite` and states if the `.log` file and `.trees` files will be overwritten, 
    like BEAST2 does. This is a bug fix, as the obsolete parameter name did not
    prevent the state file being overwritten.

### DEPRECATED AND DEFUNCT

  * Calling `run_beast2` with a parameter called `overwrite_state_file` is obsolete. 
    Use the parameter `overwrite` instead.

## beastier 1.4.3 (2018-05-17)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Tagged for [the academic article about `babette`](https://github.com/ropensci/babette_article)

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## beastier 1.4.2 (2018-04-05)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Follow all [rOpenSci packaging guidelines](https://github.com/ropensci/onboarding/blob/master/packaging_guide.md)

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None
