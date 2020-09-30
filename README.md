This repo serves as an example of how to work with and trace the National Water Model (NWM) stream network 

## definitions, requirements:
	
`features` are streams and lakes in the NWM

`feature_ids (FIDs)` are the unique identifiers for features

Dependencies: R, rgdal, rgeos (maybe?)

Input files: 
- `route_link.nc`                      			      can be obtained from NWM DOMAIN files (a.k.a. hydrofabric)
- shapefile containing flowlines (fl); the actual network     TODO: where did I get this?
- shapefile containing shoreline data     		      BYOSL (bring your own shoreline; make sure proj matches fl)
	

## program sequence
1. `preprocess.R`
	- generates the upstream network ("from") based on the downstream network ("to") provided by route_link.nc; this takes a while
	- identifies the terminal stream segments based on the intsersection of flowlines and shoreline polygon

2. `terminal.R`
	- illustrates how to use the output of `preprocess.R`
	- contains a function to iteratively trace up "from" based on starting

