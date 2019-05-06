library(beastier)

testit::assert(is_beast2_installed())

# All input and output files will be local
input_filename <- basename(tempfile(fileext = ".xml"))
output_log_filename <- basename(tempfile(fileext = ".log"))
output_trees_filename <- basename(tempfile(fileext = ".trees"))
output_state_filename <- basename(tempfile(fileext = ".xml.state"))
beast2_working_dir <- basename(tempfile(pattern = "beast_working_dir_"))

# Create input file locally
file.copy(from = get_beastier_path("2_4.xml"), to = input_filename)

run_beast2_from_options(
  create_beast2_options(
    input_filename = input_filename,
    output_log_filename = output_log_filename,
    output_trees_filenames = output_trees_filename,
    output_state_filename = output_state_filename,
    beast2_working_dir = beast2_working_dir

  )
)
