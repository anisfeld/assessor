library(tidyverse)
library(sf)
#library(tidycensus)
library(tigris)
options(tigris_use_cache = TRUE)
options(tigris_class = "sf")
rm(list=ls())
setwd("~/Downloads/")

d <- read_csv('geo_export_byshortzip_after2010.csv')
zips <- tigris::zctas(state = 'IL', starts_with = '60')

zd <- geo_join(zips, d, "ZCTA5CE10", "short_zip", how='inner')


ggplot() + geom_sf(data=zd)

st_write(zips, "zips.")

st_write(zd, "zd.csv", layer_options = "GEOMETRY=AS_WKT", delete_dsn = TRUE)

class(zd)
names(zips)

install.packages("leaflet")
