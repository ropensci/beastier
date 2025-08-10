# News

Newest versions at top.

<!-- markdownlint-disable MD024 -->
<!-- markdownlint-disable MD025 -->

# beastier 2.5.2 (unreleased)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Corrected format in names in `DESCRIPTION`, thanks Kurt Hornik

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.5.1 (2024-06-5)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Update email address of maintainer

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.5 (2023-11-07)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Remove dependency on 'assertive'

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.12 (2023-09-25)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Use new CITATION style
- Did `usethis::use_package_doc()`

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.11 (2022-08-11)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- 'is_on_ci' is now 'beautier::is_on_ci'

# beastier 2.4.10 (2022-06-16)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Add 'remove_beaustier_folders' to delete both the 'beautier'
  and 'beastier' temporary folders
- Add 'check_empty_beaustier_folders' to check that
  both the 'beautier' and 'beastier' temporary folders are empty

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.9 (2022-06-03)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Also deletes the temporary 'beastier' folder

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.8 (2021-09-19)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- `check_empty_beastier_folder` works under Windows

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.7 (2021-09-06)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Allow to use treelog, screenlog and tracelog filenames in absent
    sub-sub-subfolders, fixes babette bug

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.6 (only released on CRAN)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Improved documentation, thanks Julia Haider

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.5 (2021-08-18)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Improved error handling
- Less whitespace in `beastier_report`

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.4 (2021-08-17)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Produces no undeleted temporary files

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.3 (2021-07-09)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- `check_can_create_file` creates folder if needed

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.2 (2021-06-04)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Tested to work on Windows

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4.1 (2021-05-30)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Cleans up all created temporary files

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.4 (2021-05-22)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- `install_beast2`, `upgrade_beast2`, `uninstall_beast2` are deprecated,
    as these violated CRAN policy. Thanks to Brian Ripley for sharing!
    The deprecation message will point users to the non-official
    `beastierinstall` package at `https://github.com/richelbilderbeek/beastierinstall`
- Removed deprecated function `update_beastier`

# beastier 2.3.1 (2021-05-15)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- Can correctly call BEAST2 when spaces in
    (1) BEAST2 bin filename,
    (2) BEAST2 jar filename,
    (3) BEAST2 input filename
    (4) BEAST2 state output filename.
    Thanks Jason Griffiths

## DEPRECATED AND DEFUNCT

- None

# beastier 2.3 (2021-05-14)

## NEW FEATURES

- Add `continue_beast2` to continue a BEAST2 run

## MINOR IMPROVEMENTS

- Builds on GitHub Actions
- Added `is_on_github_actions` to detect the GitHub Actions environment
- `is_on_ci` detects the GitHub Actions environment

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- `update_beastier`: gives deprecation message

# beastier 2.2.1 (2020-10-31)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- `get_default_beast2_jar_path` allows for a custom folder name
- `install_beast2` is silent by default
- `install_beast2` and `uninstall_beast2` give more information when
    verbose

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.2 (2020-10-16)

## NEW FEATURES

- Add 'create_mcbette_beast2_options'

## MINOR IMPROVEMENTS

- No `testthat` tests in code examples

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.1.3 (2020-08-05)

## NEW FEATURES

- Add `rename_beast2_options_filenames`
- Add `get_beast2_options_filenames`
- Allow tildes in file paths, for example `~/beast2.xml`
- Add `beastier_report` to help create a bug report
- Can `install_beast2` for a specific version

## MINOR IMPROVEMENTS

- Enable MacOS build again

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.1.2 (2020-01-06)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Documentation at [rOpenSci](https://docs.ropensci.org/beastier) to
    shows pictures

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.1.1 (2019-12-02)

## NEW FEATURES

- Add vignettes
  
## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.1 (2019-10-27)

## NEW FEATURES

- Follows `beautier` v2.3 interface
  
## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- The function arguments `beast2_output_log_filename`
    and `beast2_output_trees_filename` have become obsolete. Use
    `create_tracelog()$filename` and `create_treelog()$filename` as
    part of an MCMC instead
- The function argument `beast2_working_dir` is obsoleted, because it
    no longer served a purpose. Use `setwd` to set the working directory

# beastier 2.0.25 (2019-10-10)

## NEW FEATURES

- Add `get_beast2_example_filenames` to get the
    full paths of all the BEAST2 example files
- Add `get_beast2_example_filename` to get the
    full path of a BEAST2 example file
- Add `get_default_beast2_working_dir` to get the full path of
    the default BEAST2 working directory
- Add `clear_beast2_working_dir` to clear the BEAST2 working directory
  
## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.24 (2019-09-30)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Do not check if `beast2_path` still/already exists in `check_beast2_options`

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.23 (2019-09-29)

## NEW FEATURES

- Use BEAST2 main class name when calling the jar file,
    to fix the 'no main manifest attribute' error

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.22 (2019-09-16)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Add `update_beastier` to update the `beastier` dependencies
- Lowered cyclomatic complexity, thanks @lintr-bot

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.21 (2019-09-10)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- `create_beast2_options` checks that the filenames are not in the same
    folder as the BEAST2 working directory

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.20 (2019-08-27)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Added `get_beast2_options_filenames` to obtain the filenames in a
    `beast2_options`

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.19 (2019-08-23)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- `check_beast2_options` checks for duplicate filenames

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.18 (2019-08-14)

## NEW FEATURES

- Install BEAST2 `v2.6.0`, instead of `v2.5.2`

## MINOR IMPROVEMENTS

- Can create files in sub-sub-subfolders
- Builds on Travis CI distribution 'Bionic'
- Add `are_identical_alignments`
- Add `is_alignment`

## BUG FIXES

- RNG seed is checked to be a whole number (Issue #35, thanks @thijsjanzen)

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.17

This version never had a formal release.

# beastier 2.0.16

This version never had a formal release.

# beastier 2.0.15 (2019-06-01)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Simplified `run_beast2`
- Improved error checking and logging in `run_beast2`
- Will overwrite files if requested (which is by default)
- Removed example code that assumed all Linuxes have `/home/username`,
    thanks to Brian Ripley

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.14 (2019-05-27)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Add `SystemRequirements` field to `DESCRIPTION`

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.13 (2019-05-14)

## NEW FEATURES

- Install BEAST2 `v2.5.2`, instead of `v2.5.1`
- Can call `run_beast2`/`run_beast2_from_options` in parallel

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.12 (2019-04-08)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Package builds successfully without BEAST2 installed

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.11 (2019-03-27)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- `get_default_beast2_bin_path` is silent if BEAST2 is absent
- Package builds successfully without BEAST2 installed

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.10 (2019-03-26)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Passes tests without BEAST2 installed

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.9 (2019-03-26)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Pass local CRAN tests
- Shortened examples' runtime

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.8 (2019-03-26)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Fix spelling error

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.7 (2019-03-26)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Documentation examples work on macOS

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.6 (2019-03-25)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Whitelist 'Schmirl'

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.5 (2019-03-25)

## NEW FEATURES

- CRAN and rOpenSci release candidate

## MINOR IMPROVEMENTS

- Implemented feedback from CRAN, thanks Martina Schmirl:
  - In DESCRIPTION, use `'R'` for programs
  - In DESCRIPTION, use four spaces
  - In DESCRIPTION, remove the redundant '... from R' in title
  - In DESCRIPTION, use only `GPL-3` instead of also adding the file `LICENSE`
  - Add examples to all functions

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0.1 (2019-03-15)

## NEW FEATURES

- CRAN and rOpenSci release candidate

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 2.0 (2019-01-04)

## NEW FEATURES

- GitHub repository is owned by `ropensci`

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 1.5.2 (2018-10-30)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Tested to work under macOS

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 1.5.1 (2018-10-26)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Made up-to-date with newer version of `beautier`

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 1.5 (2018-09-12)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Instead of supplying a BEAST2 `.jar` path
    (using the argument `beast2_jar_path`), one
    can now also supply the BEAST2 binary path.

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- All parameters named `beast2_jar_path` are now called `beast2_path`

# beastier 1.4.4 (2018-08-05)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- None

## BUG FIXES

- `run_beast2` had a parameter called `overwrite_state_file`, which is renamed
    to `overwrite` and states if the `.log` file and `.trees` files will be overwritten,
    like BEAST2 does. This is a bug fix, as the obsolete parameter name did not
    prevent the state file being overwritten.

## DEPRECATED AND DEFUNCT

- Calling `run_beast2` with a parameter called `overwrite_state_file` is obsolete.
    Use the parameter `overwrite` instead.

# beastier 1.4.3 (2018-05-17)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Tagged for [the academic article about `babette`](https://github.com/richelbilderbeek/babette_article)

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

# beastier 1.4.2 (2018-04-05)

## NEW FEATURES

- None

## MINOR IMPROVEMENTS

- Follow all [rOpenSci packaging guidelines](https://github.com/ropensci/onboarding/blob/master/packaging_guide.md)

## BUG FIXES

- None

## DEPRECATED AND DEFUNCT

- None

<!-- markdownlint-enable MD024 -->
<!-- markdownlint-enable MD025 -->
