# extdata

# `beast beast2_error.xml`

File to create a BEAST2 error.

:warning: the BEAST2 NS package must not be installed :warning:

Upon running this file in BEAST2, the output will end with:

```
Error 1017 parsing the xml input file

Class could not be found. Did you mean beast.core.util.ESS?
Perhaps a package required for this class is not installed?

Error detected about here:
  <beast>
      <run id='mcmc' spec='beast.gss.NS'>
```

The error message says it all: one needs to install the BEAST2 NS package.
`beastier` cannot do this (note that `mauricer` can).

## `beast2_warning.xml`

File to create a BEAST2 warning.

Upon running this file in BEAST2, the output will end with:

```
WARNING: StateNode (freqParameter.s:anthus_aco) found that has no effect on posterior!

[...]
Fatal exception: Could not find a proper state to initialise. Perhaps try another seed.
See http://www.beast2.org/2018/07/04/fatal-errors.html for other possible solutions.
[...]
```

The word `WARNING` is used to detect a warning. Regardless of the
fatal exceptions, BEAST2 exits without an error code (i.e. exit code zero).
