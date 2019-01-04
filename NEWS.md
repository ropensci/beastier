# News

Newest versions at top.

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

  * Tagged for [the academic article about babette](https://github.com/ropensci/babette_article)

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
