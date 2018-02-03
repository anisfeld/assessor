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


data <- read_csv("./Downloads/zd.csv")


d <- data %>% mutate("Percentage African-American or Hispanic"=paste0(round(black+hispanic, 3)*100, "%"),
                      "Median Sale Price" = paste0("$", value),
                      "Median Household Income" = paste0("$", round(medhinc, -2)),
                      "Final Market Value Ratio" = round(ratio,3),
                      "First pass Market Value Raio" = round(ratio1,3),
                      "Number of Homes Sold" = N
                                      ) %>% View
write_csv(d, 'geo_export_byshortzip_after2010_edit_aa_20180203.csv')





class(zd)
names(zips)

install.packages("leaflet")
