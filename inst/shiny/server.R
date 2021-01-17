library(shiny)
library(Marine)
library(leaflet)

shinyServer(function(input, output, session) {
  vesselsTableFiltered <- filterVesselsServer("main")

  vesselRowMax <- reactive({
    if (isTruthy(vesselsTableFiltered())) {
      vesselsTableFiltered() %>% calculateGeographicalDistanceVectorized() %>%
        selectRowWithLargestDistance()
    } else {
      vesselsTableFiltered()
    }

  })

  # TODO maybe wrap in module displayVesselInfo
  observeEvent(vesselRowMax(), ignoreInit = TRUE, {
    shiny.semantic::showNotification(
      sprintf("Ship name: %s, destination: %s",
              vesselRowMax()$SHIPNAME,
              vesselRowMax()$DESTINATION)
    )
  })

  showOnMapServer("main", vesselRowMax)
})
