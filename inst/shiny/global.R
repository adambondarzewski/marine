library(magrittr)
library(dplyr)
library(Marine)

dirUnzipped <- tempdir()
unzip(zipfile = system.file(package = "Marine", "extdata/vessels.zip"),
      junkpaths = TRUE,
      exdir = dirUnzipped)

vesselsTable <- data.table::fread(file.path(dirUnzipped, "vessels.csv"))

# solution taken from
# https://stackoverflow.com/questions/60944443/calculate-euclidean-distance-between-points-with-rolling-function-in-data-table

# make sure observations are sorted by time
data.table::setorder(vesselsTable, SHIP_ID, DATETIME)

# extend table to keep also coordinates of previous point
vesselsTable %<>% addLastCoordinates()

vesselsTypes <- vesselsTable %>%
  dplyr::pull(ship_type) %>%
  base::unique()


vesselsPerType <- lapply(vesselsTypes, function(x, tableIn) {
  tableIn %>%
    filter(ship_type == x) %>%
    pull(SHIPNAME) %>%
    unique()
}, tableIn = vesselsTable)

names(vesselsPerType) <- vesselsTypes

# TODO maybe replace global variables with getters (functions)

# > vesselTable %>% pull(SHIP_ID) %>% unique() %>% length()
# [1] 1210
# this is to be investigated
