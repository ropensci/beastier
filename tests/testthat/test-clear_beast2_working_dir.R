test_that("use", {
  beast2_working_dir <- get_default_beast2_working_dir()
  n_folders_before <- length(list.files(beast2_working_dir))
  n_folders_before
  testit::assert(n_folders_before >= 0)
  clear_beast2_working_dir(beast2_working_dir = beast2_working_dir)
  n_folders_after <- length(list.files(beast2_working_dir))
  expect_equal(n_folders_after, 0)
})

test_that("abuse", {

  expect_error(
    clear_beast2_working_dir(beast2_working_dir = "/home"),
    "BEAST2 working directory must end with folder name 'beastier'"
  )
})
