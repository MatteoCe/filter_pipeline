#!/usr/bin/Rscript

packages <- c("tidyverse")
install.packages(setdiff(packages, rownames(installed.packages())))
library(tidyverse)

tab <- read.table(file="fastq_prefilter/dataset_prefilter/quality_log/stats_maxee")
tab_length <- read.table(file="fastq_prefilter/dataset_prefilter/quality_log/stats_length")

ma <- max(tab_length$V2)

ma_x <- max(tab_length$V1)

si = ma/100

joined <- dplyr::full_join(tab, tab_length, by="V1")

p <- ggplot(joined, aes(x=V1)) +
	scale_x_continuous(breaks=seq(0,ma_x,50)) +
	scale_y_continuous(name = "Number of reads", sec.axis = sec_axis( trans=~./si, name="Percentage of sequences kept")) +
	geom_bar(stat='identity', aes(y=V2.y, colour="Number of reads")) +
	geom_line(aes(y=V2.x*si, colour="1")) +
	geom_line(aes(y=V3.x*si, colour="0.5")) +
	geom_line(aes(y=V4.x*si, colour="0.25")) +
	geom_line(aes(y=V5*si, colour="0.1"))

ggsave("fastq_prefilter/dataset_prefilter/quality_log/maxee_plot.png", plot = p,device = png(), path = NULL,scale = 1, width = 10, height = 7, dpi = 300, limitsize = TRUE)
dev.off()
