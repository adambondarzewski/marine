#' Title
#'
#' @param id
#' @param vasselsTypes
#'
#' @return
#' @export
#'
#' @examples
filterVasselsInput <- function(id, vasselsTypes) {
  ns <- NS(id)

  tagList(
    selectInput(ns("vasselType"), "Vassel type", choices = vasselsTypes),
    uiOutput(ns("nameControl"))
  )
}

# Module server function
#' Title
#'
#' @param id
#'
#' @return
#' @export
filterVasselsServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      ns <- session$ns

      output$nameControl <- renderUI({
        ns <- session$ns

        req(input$vasselType)
        vasselsCurrent <- vasselsPerType[[input$vasselType]]
        selectInput(ns("vasselName"), "Vassel name", "")
      })

      observeEvent(input$vasselType,
                   ignoreNULL = TRUE, {
        req(input$vasselType)
        vasselsCurrent <- vasselsPerType[[input$vasselType]]
        updateSelectInput(session, "vasselName", choices = vasselsCurrent)
      })
    }
  )
}
