library(shiny)
library(semantic.dashboard)
library(shinyjs)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    header = dashboardHeader(tags$h1("The longest vessels trips"), class = "left"),
    sidebar = NULL,
    body = dashboardBody(
        fluidRow(
            vesselInfoOutput("main")
            ),
        fluidRow(
            showOnMapOutput("main")
            ),
        fluidRow(
            filterVesselsInput("main", vesselsTypes)
        )
    )))
