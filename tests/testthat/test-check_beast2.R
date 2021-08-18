test_that("use", {
  if (is_beast2_installed()) {
    expect_silent(check_beast2())
  } else {
    expect_error(check_beast2())
  }
  expect_error(check_beast2(beast2_path = "abs.ent"))
})
