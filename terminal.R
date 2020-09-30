#!/bin/Rscript
# this script reads in:
# 1.R data from preprocess.R, 2.shoreline spPolygon, 3.stream network spLines
# then traces up the stream network from the terminal segments and generates pltos
# author: James Kessler (james.kessler@noaa.gov)
# July 2020
# new comment

library(rgeos)
library(rgdal)

# load R objects genereated by preprocess.R
load('mi_from.Rdata')  # load "from" list which contains the upstream FID(s) for each feature
load('term_seg.Rdata') # load "term_seg" spatialLines which contain the terminal stream segments (e.g. those entering Lk Mich)

# user settings 
lk_file <- '../shp/mihu_shoreline.shp'  # lake shoreline (spatialPolygon)
fl_file <- '../shp/mi_fl.shp'           # network flowlines (spatialLines)
min_order <- 3  # the minimum order of streams to plot


# read in files and select flowlines above minimum order
fl <- readOGR(fl_file)
lk <- as(readOGR(lk_file), 'SpatialLinesDataFrame')
fl_sel <- fl[fl$order_ > min_order,]


# function to find upstream flowline objects (which contain feature_ids)
findUpstream <- function(ids){ 
	# input: an array of feature ids
	# output: the flowline objects 1 connection upstream
	upStrings <- from[c(as.character(ids))]
	upIds <- as.numeric(unlist(upStrings))
	upFl <- fl[match(upIds, fl$ID),] 
}


tup1 <- findUpstream(term_seg$ID) # trace up network from terminal streams by 1
tup2 <- findUpstream(tup1$ID)     # ` ` by 2
tup3 <- findUpstream(tup2$ID)     # ` ` by 3
tup4 <- findUpstream(tup3$ID)     # ` ` by 4



# make plots
# plot the entire network
png('figs/full_network.png',width=800, height=1200)
plot(fl,ax=T, lwd=fl$order_, col='lightblue')
plot(lk,add=T,col='black')

# plot the "major" network (above min thresh)
png('figs/large.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')

# plot the terminal stream segments
png('figs/term.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
plot(term_seg, lwd=term_seg$order_-min_order+1, col='orange', add=T)

# plot the stream segments up 1 from terminal segs
png('figs/tup1.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
plot(tup1, lwd=tup1$order_-min_order+1, col='orange', add=T)

# plot the stream segments up 2 from terminal segs
png('figs/tup2.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
plot(tup2, lwd=tup2$order_-min_order+1, col='orange', add=T)

# ...
png('figs/tup3.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
plot(tup3, lwd=tup3$order_-min_order+1, col='orange', add=T)

png('figs/tup4.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
plot(tup4, lwd=tup4$order_-min_order+1, col='orange', add=T)
graphics.off()





