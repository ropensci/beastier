library(testthat)
library(beastier)

# Make sure no temp files are left undeleted
# beastierinstall::clear_beautier_cache(); beastierinstall::clear_beastier_cache() # nolint
beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()

test_check("beastier")

beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()
