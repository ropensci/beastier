library(testthat)
library(beastier)

file.remove(
  list.files(rappdirs::user_cache_dir(appname = "beautier"), full.names = TRUE)
)
file.remove(
  list.files(rappdirs::user_cache_dir(appname = "beastier"), full.names = TRUE)
)

test_check("beastier")

testthat::expect_equal(
  0,
  length(list.files(rappdirs::user_cache_dir(appname = "beautier")))
)

testthat::expect_equal(
  0,
  length(list.files(rappdirs::user_cache_dir(appname = "beastier")))
)
