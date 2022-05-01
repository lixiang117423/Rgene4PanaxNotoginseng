rm(list = ls())

library(tidyverse)

load("../sanqi-wrky/results/9-rnaseq/FPKM.all.RData")

df_id <- data.table::fread("results/18.unique.id.txt", header = FALSE) %>%
  dplyr::mutate(V1 = stringr::str_replace(V1, ".t\\d{0,2}", ""))

sample.info <- sample.info %>%
  dplyr::filter(group == "人参链格孢侵染")

df_plot <- fpkm.all %>%
  dplyr::filter(gene %in% df_id$V1) %>%
  dplyr::select(gene, sample.info$run) %>%
  tibble::column_to_rownames(var = "gene") %>%
  pheatmap:::scale_rows() %>%
  dplyr::filter(SRR13853792 != "NaN")

anno_col <- sample.info %>%
  dplyr::select(run) %>%
  dplyr::mutate(Treatment = rep(c("CK", "Alternaria panax"), each = 3)) %>%
  tibble::column_to_rownames(var = "run")

treatment.col <- c("#ff5900", "#00b76d")
names(treatment.col) <- unique(anno_col$Treatment)

col <- list(Treatment = treatment.col)

ggheatmap::ggheatmap(df_plot,
                     cluster_rows = TRUE,
                     cluster_cols = TRUE,
                     text_show_rows = FALSE,
                     text_show_cols = FALSE,
                     annotation_cols = anno_col,
                     annotation_color = col
) + labs(title = "A")


# save plot
ggsave(
  filename = "figures/3A.heatmap.png",
  width = 6, height = 5, dpi = 500, bg = "white"
)

ggsave(
  filename = "figures/3A.heatmap.tiff",
  width = 6, height = 5, dpi = 500, bg = "white"
)
ggsave(
  filename = "figures/3A.heatmap.pdf",
  width = 6, height = 5, dpi = 500, bg = "white"
)