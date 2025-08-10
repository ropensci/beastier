test_that("use for unique IDs", {

  line_1 <- "<parameter id=\"RealParameter.1\" ...</parameter>"
  line_2 <- "<parameter id=\"RealParameter.2\" ...</parameter>"
  expect_true(has_unique_ids(c(line_1, line_2)))
  expect_false(has_unique_ids(c(line_1, line_1)))

})
