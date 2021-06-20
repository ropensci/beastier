library(testthat)
library(beastier)

# Make sure no temp files are left undeleted
beautier::clear_beautier_cache()
beautier::check_empty_beautier_folder()
clear_beastier_cache()
check_empty_beastier_folder()

test_check("beastier")

beautier::check_empty_beautier_folder()
check_empty_beastier_folder()
