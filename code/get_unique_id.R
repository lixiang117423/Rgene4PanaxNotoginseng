rm(list = ls())

library(tidyverse)

args <- commandArgs(T)

data.table::fread("results/14-r_gene_id_list", header = FALSE) %>% 
  dplyr::mutate(id = stringr::str_sub(V1, 1, args[1])) %>% 
  dplyr::select(id) %>% 
  dplyr::distinct_all() %>% 
  data.table::fwrite(file = "results/15-ubique.r.gene.id", row.names = FALSE, col.names = FALSE)
