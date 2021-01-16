library(shiny)
library(Marine)

shinyServer(function(input, output, session) {
  vesselChosen <- filterVesselsServer("main")

  observeEvent(vesselChosen(), ignoreInit = TRUE, {
    shiny.semantic::toast(
      vesselChosen()$SHIPNAME
    )
  })
})
