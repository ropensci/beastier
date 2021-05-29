# Can beastier run on Peregrine?
# Issue 38, Issue #38

# R script to test if beastier runs on peregrine

# Copied from peregrine
get_pff_tempdir <- function() {
  dirname <- file.path(
    rappdirs::user_cache_dir(),
    basename(get_beastier_tempfilename())
  )
  dirname
}

# Copied from peregrine
get_pff_get_beastier_tempfilename <- function(
  pattern = "pff_",
  pff_tmpdir = get_pff_tempdir(),
  fileext = ""
) {
  filename <- get_beastier_tempfilename(
    pattern = pattern,
    tmpdir = pff_tmpdir,
    fileext = fileext
  )
  testit::assert(!file.exists(filename))
  filename
}

inference_model <- beautier::create_inference_model(
  site_model = beautier::create_jc69_site_model(),
  clock_model = beautier::create_strict_clock_model(),
  tree_prior = beautier::create_yule_tree_prior(),
  mcmc = beautier::create_mcmc(chain_length = 3e3)
)

beast2_input_filename <- get_pff_get_beastier_tempfilename(pattern = "in_", fileext = ".xml")

beautier::create_beast2_input_file_from_model(
  input_filename = beautier::get_fasta_filename(),
  output_filename = beast2_input_filename,
  inference_model = inference_model
)

beast2_options <- beastier::create_beast2_options(
  input_filename = beast2_input_filename,
  output_state_filename = get_pff_get_beastier_tempfilename(pattern = "out_", fileext = ".state.xml"),
  beast2_path = beastier::get_default_beast2_bin_path(),
  verbose = TRUE
)

beastier::run_beast2_from_options(beast2_options = beast2_options)
