library(shiny)
library(semantic.dashboard)
library(shinyjs)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    dashboardHeader(title = "Basic dashboard"),
    dashboardSidebar(sidebarMenu(
        menuItem(tabName = "home", text = "Home", icon = icon("home")),
        menuItem(tabName = "another", text = "Another Tab", icon = icon("heart"))
    )),
    dashboardBody(... =
                      useShinyjs(),
                  fluidRow(
                      showOnMapOutput("main")
                  ),
                  fluidRow(
                      vesselInfoOutput("main")
                  ),
                  fluidRow(
                      filterVesselsInput("main", vesselsTypes)
                  )
    )))
