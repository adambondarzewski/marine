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
#' @param vesselChosen
#'
#' @return
#' @export
showOnMapServer <- function(id, vesselChosen) {
  moduleServer(
    id,
    function(input, output, session) {

      output$vesselLongestPath <- leaflet::renderLeaflet({
        req(vesselChosen)
        req(vesselChosen())
        vesselChosenVar <- vesselChosen()
        leaflet::leaflet() %>%
          addProviderTiles(providers$Stamen.TonerLite,
                           options = providerTileOptions(noWrap = TRUE)
          ) %>%
          leaflet::addMarkers(lng = vesselChosenVar$LON, lat = vesselChosenVar$LAT) %>%
          leaflet::addMarkers(lng = vesselChosenVar$LON_PREV, lat = vesselChosenVar$LAT_PREV)
      })
    }
  )
}
