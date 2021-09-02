test_that("use, no file present", {
  filename <- "abs.ent"
  testit::assert(!file.exists(filename))
  expect_silent(remove_file_if_present(filename))
  testit::assert(!file.exists(filename))
})

test_that("use, file present", {
  filename <- get_beastier_tempfilename()
  writeLines(text = "some irrelevant text", con = filename)
  testit::assert(file.exists(filename))
  expect_silent(remove_file_if_present(filename))
  testit::assert(!file.exists(filename))
  expect_silent(check_empty_beastier_folder())
  # beastierinstall::clear_beautier_cache(); beastierinstall::clear_beastier_cache() # nolint
})
