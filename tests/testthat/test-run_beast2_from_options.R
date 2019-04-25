context("test-run_beast2_from_options")

test_that("use", {

  if (!is_beast2_installed()) {
    skip("BEAST2 not installed. Testing from CRAN?")
  }

  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = get_beastier_path("2_4.xml")
      )
    )
  )
})

test_that("abuse", {
  expect_error(
    run_beast2_from_options(beast2_options = "abs.ent")
  )
})

test_that("run_beast2 on local file in temp folder", {

  if (!is_beast2_installed()) {
    skip("BEAST2 not installed")
  }

  cur_wd <- getwd()
  tmp_wd <- tempfile(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd)
  setwd(tmp_wd)
  input_filename <- basename(
    tempfile(pattern = "beast2_input_file", fileext = ".xml")
  )
  file.copy(from = get_beastier_path("2_4.xml"), to = input_filename)
  expect_silent(
    run_beast2_from_options(create_beast2_options(input_filename = input_filename))
  )
  setwd(cur_wd)
})

test_that("run_beast2 on full file in temp folder", {

  if (!is_beast2_installed()) {
    skip("BEAST2 not installed")
  }

  cur_wd <- getwd()
  tmp_wd <- tempfile(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd)
  setwd(tmp_wd)
  input_filename <- get_beastier_path("2_4.xml")
  expect_silent(
    run_beast2_from_options(create_beast2_options(input_filename = input_filename))
  )
  setwd(cur_wd)
})
