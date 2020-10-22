test_that("install at non-standard location", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()


  folder_name <- tempfile()
  beast_jar_path <- file.path(folder_name, "beast", "lib", "launcher.jar")
  testit::assert(!file.exists(beast_jar_path))

  expect_output(
    install_beast2(
      folder_name = folder_name,
      verbose = TRUE
    ),
    "BEAST2 installed at"
  )
  expect_true(file.exists(beast_jar_path))
  expect_true(is_beast2_installed(folder_name = folder_name))
})

test_that("install twice must throw", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()

  folder_name <- tempfile()
  if (!is_beast2_installed(folder_name = folder_name)) {
    install_beast2(folder_name = folder_name)
  }
  expect_error(
    install_beast2(folder_name = folder_name),
    "BEAST2 already installed"
  )
})

test_that("install at non-standard location with first version", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()


  folder_name <- tempfile()
  beast_jar_path <- file.path(folder_name, "beast", "lib", "launcher.jar")
  beast2_version <- "2.4.7"
  # Can install ...
  install_beast2(folder_name, beast2_version = beast2_version)
  # ... but getting the version cannot be done
  # expect_equal(beast2_version, get_beast2_version(beast_jar_path)) # nolint code to demo this does not work
})

test_that("install at non-standard location with v2.6.2", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()
  folder_name <- tempfile()
  beast2_version <- "2.6.2"
  install_beast2(folder_name, beast2_version = beast2_version)
  beast2_path <- file.path(folder_name, "beast", "lib", "launcher.jar")
  expect_equal(beast2_version, get_beast2_version(beast2_path))
})

test_that("install must be silent", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()

  folder_name <- tempfile(pattern = "beastier")
  expect_silent(install_beast2(folder_name = folder_name))
})
