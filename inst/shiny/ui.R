library(shiny)
library(semantic.dashboard)

# Define UI for application that draws a histogram
    shinyUI(dashboardPage(
        dashboardHeader(title = "Basic dashboard"),
        dashboardSidebar(sidebarMenu(
            menuItem(tabName = "home", text = "Home", icon = icon("home")),
            menuItem(tabName = "another", text = "Another Tab", icon = icon("heart"))
        )),
        dashboardBody(
            fluidRow(
                box(plotOutput("plot1", height = 250)),
                box(
                    title = "Controls",
                    sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
            )
        )))
