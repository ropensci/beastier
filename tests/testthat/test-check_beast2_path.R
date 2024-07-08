test_that("use", {
  expect_silent(
    check_beast2_path(get_beastier_path("some path that exists TODO"))
  )
})

test_that("abuse", {
  expect_error(
    check_beast2_path("abs.ent"),
    "File 'beast2_path' not found. Could not find file with path 'abs.ent'"
  )
})
