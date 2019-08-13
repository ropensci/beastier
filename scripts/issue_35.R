remotes::install_github("thijsjanzen/nodeSub")
library(nodeSub)
library(tidyverse)

model = "shared" # "shared", "independent", "conditional"
cat("model = ",model, "\n")

# args = commandArgs(trailingOnly=TRUE)
sim_number = 1 # as.numeric(args[[1]])

focal_node_time <- sim_number / 10

work_dir <- getwd()

cat("work_dir = ", work_dir,"\n")

rnd_seed = sim_number * 13 + focal_node_time * 5 + 5
cat(rnd_seed,"\n")

set.seed(rnd_seed)

branch_rate <- 0.1
node_rate <- 0.1
seq_len <- 1000


for(r in 1:10) {

  input_tree <- TreeSim::sim.bd.taxa(n = 100, numbsim = 1, lambda = 1, mu = 0)[[1]]

  sim_regular <- function(phy, rate, root_sequence) {
    nodeSub::sim_normal(x = phy, l = seq_len, rootseq = root_sequence, rate = rate)
  }

  regular_model <- sim_regular

  cat("simulating nodesub alignment\n")

  target_alignment <- c()
  if(model == "shared") {
    target_alignment <- nodeSub::sim_dual_parent(phy = input_tree,
                                                 rate1 = branch_rate,
                                                 rate2 = branch_rate,
                                                 l = seq_len,
                                                 node_time = focal_node_time)
  }

  if(model == "independent") {
    target_alignment <- nodeSub::sim_dual_independent(phy = input_tree,
                                                      rate1 = branch_rate,
                                                      rate2 = branch_rate,
                                                      l = seq_len,
                                                      node_time = focal_node_time)
  }
  if(model == "conditional") {
    target_alignment <- nodeSub::sim_dual_linked(phy = input_tree,
                                                 rate = branch_rate,
                                                 node_mut_rate_double = branch_rate ^ 2,
                                                 l = seq_len,
                                                 node_time = focal_node_time)
  }

  cat("inferring alternative trees\n")
  alt_trees <- nodeSub::infer_phylogeny(target_alignment$alignment,
                               "alternative",
                               inference_model = beautier::create_inference_model(
                                 site_model = beautier::create_jc69_site_model(),
                                 clock_model = beautier::create_strict_clock_model(),
                                 tree_prior = beautier::create_yule_tree_prior(),
                                 mcmc = beautier::create_mcmc(chain_length = 1e7,
                                                              store_every = 5000)),
                               burnin = 0.1,
                               working_dir = work_dir)


  cat("simulating comparable JC alignment\n")
  comp_alignment <- nodeSub::create_equal_alignment(input_tree = input_tree,
                                                    focal_alignment = target_alignment$alignment,
                                                    root_sequence = target_alignment$root_seq,
                                                    alt_model = sim_regular)

  cat("inferring reference trees\n")

  # now, let's infer phylogenies
  reference_trees <- nodeSub::infer_phylogeny(comp_alignment$alignment,
                                     "reference",
                                     inference_model = beautier::create_inference_model(
                                       site_model = beautier::create_jc69_site_model(),
                                       clock_model = beautier::create_strict_clock_model(),
                                       tree_prior = beautier::create_yule_tree_prior(),
                                       mcmc = beautier::create_mcmc(chain_length = 1e7,
                                                                    store_every = 5000)),
                                     burnin = 0.1,
                                     working_dir = work_dir)

  cat("calculating reference stats\n")
  reference_stats <- nodeSub::calc_sum_stats(reference_trees$all_trees,
                                             input_tree, verbose = TRUE)

  cat("calculating alternative stats\n")
  alt_stats <- nodeSub::calc_sum_stats(alt_trees$all_trees,
                                       input_tree, verbose = TRUE)

  cat("generating output and writing to file\n")

  diff_ref <- as.matrix(reference_stats$differences)
  diff_alt <- as.matrix(alt_stats$differences)


  reference_stats$stats$method <- "reference"
  reference_stats$differences$method <- "reference"
  alt_stats$stats$method <- "nodesub"
  alt_stats$differences$method <- "nodesub"



  all_stats <- rbind(reference_stats$stats, alt_stats$stats)
  all_stats$node_time <- focal_node_time
  all_stats$replicate <- r


  all_differences <- rbind(reference_stats$differences, alt_stats$differences)
  all_differences$node_time <- focal_node_time
  all_differences$replicate <- r

  write_tsv(all_stats, path = paste0("stats_",sim_number,".txt"))
  write_tsv(all_differences, path = paste0("diffs_",sim_number,".txt"))
}
