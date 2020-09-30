#!/bin/Rscript
# this script 
rtlink_file <- 'routelink_mich.nc'

# ======== generate "from" variable =============
# read stuff in
ncid <- nc_open(rtlink_file)
to <- ncvar_get(ncid,'to')
comid <- ncvar_get(ncid,'link')
names(to) <- comid
# allocate from 
from <- vector('list',length=length(to)) 
names(from) <- names(to)
print('tracing network upstream...')
for (id in names(to)){ from[[id]]<-names(to[to %in% id]) }
save(from, file='mi_from.Rdata')


# ===== find/generate terminal segments  =============
lk_file <- '../shp/mihu_shoreline.shp'
fl_file <- '../shp/mi_fl.shp'
min_order <- 3
# find flowlines that intersect the shoreline (terminal segments)
fl <- readOGR(fl_file)
lk <- as(readOGR(lk_file), 'SpatialLinesDataFrame')
fl_sel <- fl[fl$order_ > min_order,]
isterm <- gIntersects(fl_sel, lk, byid=T); 
term_seg <- fl_sel[c(isterm),]; 
save(term_seg, file='term_seg.Rdata')



