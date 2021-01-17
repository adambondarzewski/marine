#' Title
#'
#' @param id
#'
#' @return
#' @export
showOnMapOutput <- function(id) {
  ns <- NS(id)
  leaflet::leafletOutput(ns("vesselLongestPath"))
}

#' Title
#'
#' @param id
#' @param vesselRowMax
#'
#' @return
#' @export
showOnMapServer <- function(id, vesselRowMax) {
  moduleServer(
    id,
    function(input, output, session) {

      output$vesselLongestPath <- leaflet::renderLeaflet({
        req(vesselRowMax)
        req(vesselRowMax())
        vesselRowMaxVar <- vesselRowMax()
        leaflet::leaflet() %>%
          addProviderTiles(providers$Stamen.TonerLite,
                           options = providerTileOptions(noWrap = TRUE)
          ) %>%
          leaflet::addMarkers(lng = vesselRowMaxVar$LON, lat = vesselRowMaxVar$LAT) %>%
          leaflet::addMarkers(lng = vesselRowMaxVar$LON_PREV, lat = vesselRowMaxVar$LAT_PREV)
      })
    }
  )
}
