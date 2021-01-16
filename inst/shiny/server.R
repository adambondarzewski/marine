library(shiny)
library(Marine)

shinyServer(function(input, output) {
    filterVasselsServer("main")
})
