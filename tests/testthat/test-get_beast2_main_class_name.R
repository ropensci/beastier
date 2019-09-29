test_that("use", {
  expect_equal(
    get_beast2_main_class_name(),
    "beast.app.beastapp.BeastLauncher"
  )
})
