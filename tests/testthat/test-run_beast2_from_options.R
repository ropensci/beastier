context("test-run_beast2_from_options")

test_that("use", {

  expect_silent(
    run_beast2_from_options(
      input_filename = get_beastier_path("2_4.xml")
    )
  )
})

test_that("abuse", {
  expect_error(
    run_beast2_from_options(input_filename = "abs.ent")
  )
})
