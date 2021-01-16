library(shiny)
library(semantic.dashboard)
library(shinyjs)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    dashboardHeader(title = "Basic dashboard"),
    dashboardSidebar(sidebarMenu(
        menuItem(tabName = "home", text = "Home", icon = icon("home")),
        menuItem(tabName = "another", text = "Another Tab", icon = icon("heart"))
    )),
    dashboardBody(
        useShinyjs(),
        box(
            fluidRow(
                filterVesselsInput("main", vasselsTypes)
            )
        )

    )))
