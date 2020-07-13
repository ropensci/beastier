test_that("use", {
  if (!is_beast2_installed()) return()

  # Versions mismatch: the binary from
  # https://github.com/CompEvol/beast2/releases/download/v2.6.0/BEAST.v2.6.0.Linux.tgz # nolint indeed long URL
  # (notice the v2.6.0) really returns 'v2.6.1'
  # upon a ./beast/bin/beast -version
  expect_match(
    get_beast2_version(),
    "2\\.6\\.[[:digit:]]"
  )
})

test_that("abuse", {
  if (!is_beast2_installed()) return()

  expect_error(
    get_beast2_version(
      beast2_path = "abs.ent"
    ),
    "'beast2_path' must be the full path of either 'beast' or 'launcher.jar'"
  )
})

test_that("cannot ", {
  if (!is_beast2_installed()) return()

  win_bin_path <- "BEAST.exe"
  testit::assert(is_win_bin_path(win_bin_path))
  expect_error(
    get_beast2_version(
      beast2_path = win_bin_path
    ),
    "Cannot use the Windows executable BEAST2.exe in scripts"
  )
})
