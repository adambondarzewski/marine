#' Title
#'
#' @param vesselsTable
#'
#' @return
#' @export
#'
addLastCoordinates <- function(vesselsTable) {
  # make sure observations are in correct order
  data.table::setorder(vesselsTable, SHIP_ID, DATETIME)

  vesselsTable[, LAT_PREV := shift(LAT), by = SHIP_ID]
  vesselsTable[, LON_PREV := shift(LON), by = SHIP_ID]
}

#' Calculate geographical distance betwen two pointsin latitude and longitude in degrees
#'
#' @param lat1 latitude of point 1
#' @param lat2 latitude of point 2
#' @param lon1 longitude of point 1
#' @param lon2 longitude o2 point 2
#'
#' @return numeric; distance in meters
#' @export
#'
#' @examples
#' calculateGeographicalDistance(57.60287, 57.62190, 11.66572, 11.67703)
#'
calculateGeographicalDistance <- function(lon1, lon2, lat1, lat2) {
  geosphere::distm (x = c(lon1, lat1), y = c(lon2, lat2), fun = geosphere::distHaversine)[1,1]
}

#' Table with vessels trips data, columns needed: LON, LON_PREV, LAT, LAT_PREV
#' @import data.table
#' @param vesselsTable
#'
#' @return initial table with additional column distance (numeric)
#' @export
calculateGeographicalDistanceVectorized <- function(vesselsTable) {
  # calculate distance
  out <- data.table::copy(vesselsTable)
  out[, distance := mapply(calculateGeographicalDistance, LON, LON_PREV, LAT, LAT_PREV)][]
  out
  # [] to prevent data.table nonsense described here:
  # https://stackoverflow.com/questions/33195362/data-table-is-not-displayed-on-first-call-after-being-modified-in-a-function/33196350
}

#' Table returned by calculateGeographicalDistanceVectorized function, columns needed: SHIP_ID, DATETIME, distance
#' @import data.table
#' @param vesselsTable
#'
#' @return table with one row corresponding to the longest distance found
#' @export
selectRowWithLargestDistance <- function(vesselsTable) {
  setorder(vesselsTable, SHIP_ID, -DATETIME)
  vesselsTable <- vesselsTable[, .SD[which.max(distance)], by = SHIP_ID]
}
