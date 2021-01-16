library(data.table)
library(magrittr)
library(dplyr)
library(Marine)

dirUnzipped <- tempdir()
unzip(zipfile = system.file(package = "Marine", "extdata/vessels.zip"),
      junkpaths = TRUE,
      exdir = dirUnzipped)

vesselsTableInitial <- fread(file.path(dirUnzipped, "vessels.csv"))

# solution taken from
# https://stackoverflow.com/questions/60944443/calculate-euclidean-distance-between-points-with-rolling-function-in-data-table

# make sure observations are sorted by time
setorder(vesselsTableInitial, SHIP_ID, DATETIME)

# calculate distance
vesselsTableInitial[, distance := sqrt((LAT - shift(LAT))^2 + (LON - shift(LON))^2), by = SHIP_ID]

# select only observation with maximum distance by ship
# warning: this also selects the latest observation, to achieve it table should be firstly sorted ascending by date
setorder(vesselsTableInitial, SHIP_ID, -DATETIME)
vesselsTable <- vesselsTableInitial[, .SD[which.max(distance)], by = SHIP_ID]

vesselsTypes <- vesselsTableInitial %>%
  dplyr::pull(ship_type) %>%
  base::unique()


vesselsPerType <- lapply(vesselsTypes, function(x, tableIn) {
  tableIn %>%
    filter(ship_type == x) %>%
    pull(SHIPNAME) %>%
    unique()
}, tableIn = vesselsTableInitial)

names(vesselsPerType) <- vesselsTypes

# TODO maybe replace global variables with getters (functions)

# > vesselTable %>% pull(SHIP_ID) %>% unique() %>% length()
# [1] 1210
# this is to be investigated
