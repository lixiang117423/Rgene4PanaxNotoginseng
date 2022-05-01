library(ggplot2)

present = read.table(file="24.selected.pep.new.aligned.phy_present_coverage.txt", header=T)
present = data.frame(present)

png(file="24.selected.pep.new.aligned.phy_present_coverage.png", height=600, width=600)
ggplot(present, aes(coverage)) + geom_histogram() + scale_x_continuous(limits = c(-5, 6577.2))
dev.off()

