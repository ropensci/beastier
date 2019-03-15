context("gives_beast2_warning")

test_that("use, bin", {

  if (!is_beast2_installed()) {
    skip("BEAST2 not installed. Testing from CRAN?")
  }

  testit::assert(is_beast2_installed())

  # Binary works under Unix, fails under Windows (see 'abuse' section below)
  if (rappdirs::app_dir()$os == "unix") {
    expect_true(
      gives_beast2_warning(
        filename = get_beastier_path("beast2_warning.xml"),
        beast2_path = get_default_beast2_bin_path()
      )
    )
  }
})

test_that("use, jar", {

  if (!is_beast2_installed()) {
    skip("BEAST2 not installed. Testing from CRAN?")
  }

  testit::assert(is_beast2_installed())

  if (rappdirs::app_dir()$os == "unix") {
    # No idea why this only work under UNIX
    expect_false(
      gives_beast2_warning(
        filename = get_beastier_path("2_4.xml"),
        beast2_path = get_default_beast2_jar_path()
      )
    )
  }

  expect_true(
    gives_beast2_warning(
      filename = get_beastier_path("beast2_warning.xml"),
      beast2_path = get_default_beast2_jar_path()
    )
  )

  expect_output(
    gives_beast2_warning(
      filename = get_beastier_path("beast2_warning.xml"),
      verbose = TRUE
    )
  )
  if (rappdirs::app_dir()$os != "mac") {
    expect_false(
      gives_beast2_warning(
        beautier:::get_beautier_paths("2_4.xml")
      )
    )
  }
})

test_that("abuse", {

  expect_error(
    gives_beast2_warning("abs.ent"),
    "'filename' must be the name of an existing file. "
  )

  expect_error(
    gives_beast2_warning(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "abs.ent"
    ),
    paste0(
      "'beast2_path' must be the full path of either 'beast' or 'beast.jar'. ",
      "Both not found at path 'abs.ent'"
    )
  )

  # Binary fails under Windows, but works under Unix (see 'use' section above)
  if (rappdirs::app_dir()$os == "win") {
    expect_error(
      gives_beast2_warning(
        filename = get_beastier_path("beast2_warning.xml"),
        beast2_path = get_default_beast2_bin_path()
      ),
      "Cannot use the Windows executable BEAST2.exe in scripts"
    )
  }

})
