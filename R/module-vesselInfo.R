#' Title
#'
#' @param id
#'
#' @return
#' @export
vesselInfoOutput <- function(id) {
  ns <- NS(id)
  tags$h1(uiOutput(ns("vesselInfo")))
}

#' Title
#'
#' @param id
#' @param vesselRowMax
#'
#' @return
#' @export
vesselInfoServer <- function(id, vesselRowMax) {
  moduleServer(
    id,
    function(input, output, session) {
      output$vesselInfo <-renderUI({

        if (isTruthy(vesselRowMax()$SHIPNAME)) {
          ns <- session$ns
          tagList(sprintf("Ship name: %s", vesselRowMax()$SHIPNAME),
                  tags$br(),
                  sprintf("Maximum sailed distance between consecutive observations: %s meters", round(vesselRowMax()$distance, 1))
          )
        } else {
          NULL
        }
      })
    }
  )
}
