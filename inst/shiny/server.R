library(shiny)
library(Marine)
library(leaflet)

shinyServer(function(input, output, session) {
  vesselChosen <- filterVesselsServer("main")

  # TODO maybe wrap in module displayVesselInfo
  observeEvent(vesselChosen(), ignoreInit = TRUE, {
    shiny.semantic::showNotification(
      sprintf("Ship name: %s, destination: %s",
              vesselChosen()$SHIPNAME,
              vesselChosen()$DESTINATION)
    )
  })

  showOnMapServer("main", vesselChosen)
})
