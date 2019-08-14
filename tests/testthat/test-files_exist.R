test_that("use", {
  filename_1 <- get_beastier_path("beast2_example_output.log")
  filename_2 <- get_beastier_path("beast2_example_output.trees")
  absent <- tempfile()

  expect_true(files_exist(filename_1))
  expect_true(files_exist(filename_2))
  expect_false(files_exist(absent))

  expect_true(files_exist(c(filename_1, filename_2)))
  expect_false(files_exist(c(filename_1, absent)))
  expect_false(files_exist(c(absent, filename_2)))
})
