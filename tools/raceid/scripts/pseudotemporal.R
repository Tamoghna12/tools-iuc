#!/usr/bin/env R
VERSION <- "0.1" # nolint

args <- commandArgs(trailingOnly = T) # nolint

if (length(args) != 1) {
     message(paste("VERSION:", VERSION))
     stop("Please provide the config file")
}

suppressWarnings(suppressPackageStartupMessages(require(RaceID)))
source(args[1])

test <- list()
test$side <- 3
test$line <- 3
second <- test
second$cex <- 0.5
second$line <- 2.5


do.pseudotemp <- function(sc) { # nolint
    pdf(out.pdf)
    ltr <- Ltree(sc)
    ltr <- compentropy(ltr)
    ltr <- do.call(projcells, c(ltr, pstc.projc))
    ltr <- do.call(projback, c(ltr, pstc.projb))
    ltr <- lineagegraph(ltr)
    ltr <- do.call(comppvalue, c(ltr, pstc.comppval))
    x <- do.call(compscore, c(ltr, pstc.compscore))
    print(do.call(mtext, c("Compute Score", test)))
    print(do.call(mtext, c(paste0("No. of inter-cluster links / ",
                                  "Delta median entropy of each cluster / ",
                                  "StemID2 score (combination of both)"),
                           second)))
    plotdistanceratio(ltr)
    print(do.call(mtext, c("Cell-to-Cell Distance Ratio", test)))
    print(do.call(mtext, c("Original vs High-dimensional Embedded Space",
                           second)))
    do.call(plotgraph, c(ltr, pstc.plotgraph))
    print(do.call(mtext, c(paste0(c("Lineage Trajectories", rep(" ", 54)),
                                  collapse = ""), test)))
    print(do.call(mtext, c(paste0(c(paste0("Colour = Level of Significance, ",
                                           "Width = Link Score"),
                                    rep(" ", 106)), collapse = ""), second)))
    plotspantree(ltr)
    print(do.call(mtext, c("Minimum Spanning Tree", test)))
    plotspantree(ltr, projections = TRUE)
    print(do.call(mtext, c("Minimum Spanning Tree", test)))
    print(do.call(mtext, c("Cells Projected onto Links", second)))
    test$side <- 4
    test$line <- 0
    plotlinkscore(ltr)
    print(do.call(mtext, c("Link Score", test)))
    projenrichment(ltr)
    print(do.call(mtext, c("Enrichment Ratios", test)))
    dev.off()

    return(ltr)
}

ltr <- do.pseudotemp(in.rdat)


saveRDS(ltr, out.rdat)
