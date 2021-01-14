library(data.table)
library(magrittr)

ships <- fread("inst/extdata/ships.csv")

# solution taken from
# https://stackoverflow.com/questions/60944443/calculate-euclidean-distance-between-points-with-rolling-function-in-data-table

# make sure observations are sorted by time
setorder(ships, SHIP_ID, DATETIME)

# calculate distance
ships[, distance := sqrt((LAT - shift(LAT))^2 + (LON - shift(LON))^2), by = SHIP_ID]

# select only observation with maximum distance by ship
# warning: this also selects the latest observation, to achieve it table should be firstly sorted ascending by date
setorder(ships, SHIP_ID, -DATETIME)
shipsMax <- ships[, .SD[which.max(distance)], by = SHIP_ID]

# > ships %>% pull(SHIP_ID) %>% unique() %>% length()
# [1] 1210
# this is to be investigated
