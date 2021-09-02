test_that("use, bin", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

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
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

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

  expect_message(
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
    "File 'filename' not found. Could not find file with path 'abs.ent'"
  )

  expect_error(
    gives_beast2_warning(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "abs.ent"
    ),
    paste0(
      "'beast2_path' must be the full path of either 'beast' or 'launcher.jar'. ", # nolint indeed a long line
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
