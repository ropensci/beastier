context("gives_beast2_warning")

test_that("use", {

  testit::assert(is_beast2_installed())

  # Binary works under Unix, fails under Windows (see 'abuse' section below)
  if (rappdirs::app_dir()$os == "unix") {
    expect_true(
      gives_beast2_warning(
        filename = beastier:::get_beastier_path("beast2_warning.xml"),
        beast2_path = get_default_beast2_bin_path()
      )
    )
  }

  # Jar
  testthat::expect_true(
    gives_beast2_warning(
      filename = beastier:::get_beastier_path("beast2_warning.xml"),
      beast2_path = get_default_beast2_jar_path()
    )
  )

  testthat::expect_output(
    gives_beast2_warning(
      filename = beastier:::get_beastier_path("beast2_warning.xml"),
      verbose = TRUE
    )
  )
  testthat::expect_false(
    gives_beast2_warning(
      beautier:::get_beautier_paths("2_4.xml")
    )
  )
})

test_that("abuse", {

  testthat::expect_error(
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
        filename = beastier:::get_beastier_path("beast2_warning.xml"),
        beast2_path = get_default_beast2_bin_path()
      ),
      "Cannot use the Windows exectuable BEAST2.exe is scripts"
    )
  }

})
