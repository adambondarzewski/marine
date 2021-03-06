library(shiny)
library(Marine)
library(leaflet)

shinyServer(function(input, output, session) {
  vesselsTableFiltered <- filterVesselsServer("main",
                                              vesselsTable = vesselsTable,
                                              vesselsPerType = vesselsPerType)

  vesselRowMax <- reactive({
    if (isTruthy(vesselsTableFiltered())) {
      vesselsTableFiltered() %>% calculateGeographicalDistanceVectorized() %>%
        selectRowWithLargestDistance()
    } else {
      vesselsTableFiltered()
    }

  })

  vesselInfoServer("main", vesselRowMax)
  showOnMapServer("main", vesselRowMax)
})
