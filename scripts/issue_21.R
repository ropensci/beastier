library(beastier)

testit::assert(is_beast2_installed())

# All input and output files will be local
input_filename <- basename(get_beastier_tempfilename(fileext = ".xml"))
output_state_filename <- basename(get_beastier_tempfilename(fileext = ".xml.state"))

# Create input file locally
file.copy(from = beastier::get_beastier_path("2_4.xml"), to = input_filename)

run_beast2_from_options(
  create_beast2_options(
    input_filename = input_filename,
    output_state_filename = output_state_filename
  )
)
