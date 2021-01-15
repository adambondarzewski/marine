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
    selectInput("vasselType", "Vassel type", choices = vasselsTypes),
    uiOutput(ns("vasselNameControl"))
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

      # observe(input$vasselType, {
      #   req(input$vasselType)
      #   shinyjs::enable(shiny::NS("vasselName"))
      # })

      output$vasselNameControl <- renderUI({
        ns <- session$ns

        # req(input$vasselType)
        # vasselsCurrent <- vasselsPerType[[input$vasselType]]
        shinyjs::disabled(
          selectInput(ns("vasselName"), "Vassel name", c("a", "b"))
        )
      })
    }
  )
}
