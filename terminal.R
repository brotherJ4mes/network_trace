#!/bin/Rscript
library(rgeos)
library(rgdal)
load('mi_from.Rdata')
load('term_seg.Rdata')

lk_file <- '../shp/mihu_shoreline.shp'
fl_file <- '../shp/mi_fl.shp'
min_order <- 3

fl <- readOGR(fl_file)
lk <- as(readOGR(lk_file), 'SpatialLinesDataFrame')
fl_sel <- fl[fl$order_ > min_order,]


png('figs/full_network.png',width=800, height=1200)
plot(fl,ax=T, lwd=fl$order_, col='lightblue')
plot(lk,add=T,col='black')


png('figs/large.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')

png('figs/term.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
plot(term_seg, lwd=term_seg$order_-min_order+1, col='orange', add=T)

png('figs/tup1.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
tup1 <- from[c(as.character(term_seg$ID))] # terminal up 1 list
tup1ids <- as.numeric(unlist(tup1))
flup1<-fl[match(tup1ids,fl$ID),]
plot(flup1, lwd=flup1$order_-min_order+1, col='orange', add=T)

png('figs/tup2.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
tup2 <- from[c(as.character(flup1$ID))] # terminal up 2 list
tup2ids <- as.numeric(unlist(tup2))
flup2<-fl[match(tup2ids,fl$ID),]
plot(flup2, lwd=flup2$order_-min_order+1, col='orange', add=T)


png('figs/tup3.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
tup3 <- from[c(as.character(flup2$ID))] # terminal up 2 list
tup3ids <- as.numeric(unlist(tup3))
flup3<-fl[match(tup3ids,fl$ID),]
plot(flup3, lwd=flup3$order_-min_order+1, col='orange', add=T)

png('figs/tup4.png',width=800, height=1200)
plot(fl_sel,ax=T, lwd=fl_sel$order_-min_order+1, col='lightblue')
plot(lk,add=T,col='black')
tup4 <- from[c(as.character(flup3$ID))] # terminal up 2 list
tup4ids <- as.numeric(unlist(tup4))
flup4<-fl[match(tup4ids,fl$ID),]
plot(flup4, lwd=flup4$order_-min_order+1, col='orange', add=T)
graphics.off()





