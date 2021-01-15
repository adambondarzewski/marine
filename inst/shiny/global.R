library(data.table)
library(magrittr)
library(dplyr)
library(Marine)

vasselsTableInitial <- fread(system.file(package = "Marine", "extdata/vassels.csv"))

# solution taken from
# https://stackoverflow.com/questions/60944443/calculate-euclidean-distance-between-points-with-rolling-function-in-data-table

# make sure observations are sorted by time
setorder(vasselsTableInitial, SHIP_ID, DATETIME)

# calculate distance
vasselsTableInitial[, distance := sqrt((LAT - shift(LAT))^2 + (LON - shift(LON))^2), by = SHIP_ID]

# select only observation with maximum distance by ship
# warning: this also selects the latest observation, to achieve it table should be firstly sorted ascending by date
setorder(vasselsTableInitial, SHIP_ID, -DATETIME)
vasselsTable <- vasselsTableInitial[, .SD[which.max(distance)], by = SHIP_ID]

vasselsTypes <- vasselsTableInitial %>%
  dplyr::pull(ship_type) %>%
  base::unique()


vasselsPerType <- lapply(vasselsTypes, function(x, tableIn) {
  tableIn %>%
    filter(ship_type == vasselsTypes[1]) %>%
    pull(SHIPNAME) %>%
    unique()
}, tableIn = vasselsTableInitial)

names(vasselsPerType) <- vasselsTypes

# TODO maybe replace global variables with getters (functions)

# > vasselTable %>% pull(SHIP_ID) %>% unique() %>% length()
# [1] 1210
# this is to be investigated
