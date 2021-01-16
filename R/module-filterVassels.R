#' Title
#'
#' @param id
#' @param vesselsTypes
#'
#' @return
#' @export
#'
#' @examples
filterVesselsInput <- function(id, vesselsTypes) {
  ns <- NS(id)

  tagList(
    selectInput(ns("vesselType"), "vessel type", choices = vesselsTypes),
    uiOutput(ns("nameControl"))
  )
}

# Module server function
#' Title
#'
#' @param id
#'
#' @return data.table; row of data corresponding to chosen vessel
#' @export
filterVesselsServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      ns <- session$ns

      output$nameControl <- renderUI({
        ns <- session$ns

        req(input$vesselType)
        vesselsCurrent <- vesselsPerType[[input$vesselType]]
        selectInput(ns("vesselName"), "vessel name", "")
      })

      observeEvent(input$vesselType,
                   ignoreNULL = TRUE, {
        req(input$vesselType)
        vesselsCurrent <- vesselsPerType[[input$vesselType]]
        updateSelectInput(session, "vesselName", choices = vesselsCurrent)
      })
    }
  )
}
