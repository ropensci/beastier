test_that("minimal use", {
  expect_silent(clear_beastier_cache())
})

test_that("create file", {
  beastier_cache_folder_name <- dirname(get_beastier_tempfilename())

  filename <- get_beastier_tempfilename()
  dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)
  readr::write_lines("irrelevant", file = filename)
  expect_equal(1, length(list.files(beastier_cache_folder_name)))
  expect_silent(clear_beastier_cache())
  expect_equal(0, length(list.files(beastier_cache_folder_name)))
})

test_that("create dir", {
  beastier_cache_folder_name <- dirname(get_beastier_tempfilename())

  folder_name <- get_beastier_tempfilename()
  dir.create(folder_name, showWarnings = FALSE, recursive = TRUE)
  expect_equal(2, length(list.dirs(beastier_cache_folder_name)))
  expect_silent(clear_beastier_cache())
  expect_equal(0, length(list.dirs(beastier_cache_folder_name)))
})
