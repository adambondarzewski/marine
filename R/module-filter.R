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
#' @return data.table; data corresponding to chosen vessel or NULL in case input is not ready
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

      out <- reactive({
        if (isTruthy(input$vesselName)) {
          vesselsTable %>% dplyr::filter(SHIPNAME == input$vesselName)
        } else {
          NULL
        }
      })

      return(out)
    }
  )
}
