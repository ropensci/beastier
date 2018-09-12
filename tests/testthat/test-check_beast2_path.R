context("check_beast2_path")

test_that("use", {
  expect_error(
    check_beast2_path("abs.ent"),
    paste0(
      "'beast2_path' must be the name of an existing file. ",
      "File 'abs.ent' not found"
    )
  )
})
