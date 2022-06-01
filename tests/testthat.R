library(testthat)
library(beastier)

beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

test_check("beastier")

beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()
