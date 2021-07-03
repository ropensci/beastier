library(testthat)
library(beastier)

# Make sure no temp files are left undeleted
beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()

test_check("beastier")

beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()
