library(testthat)
library(beastier)

test_check("beastier")

testthat::expect_equal(
  0,
  length(list.files(rappdirs::user_cache_dir(appname = "beautier")))
)

testthat::expect_equal(
  0,
  length(list.files(rappdirs::user_cache_dir(appname = "beastier")))
)
