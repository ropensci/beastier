context("check_beast2_path")

test_that("use", {
  expect_error(
    check_beast2_path("abs.ent"),
    "File 'beast2_path' not found. Could not find file with path 'abs.ent'"
  )
})
