context("get_default_beast2_download_url")

test_that("use", {

  expect_equal(
    "https://github.com/CompEvol/beast2/releases/download/v2.5.2/BEAST.v2.5.2.Linux.tgz", # nolint URL can be long
    get_default_beast2_download_url_linux()
  )

  expect_equal(
    "https://github.com/CompEvol/beast2/releases/download/v2.5.2/BEAST.v2.5.2.Windows.zip", # nolint URL can be long
    get_default_beast2_download_url_win()
  )

  linux_url <- get_default_beast2_download_url_linux()
  win_url <- get_default_beast2_download_url_win()
  default_url <- get_default_beast2_download_url()

  expect_true(default_url == linux_url || default_url == win_url)
})
