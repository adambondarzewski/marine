library(shiny)
library(Marine)

shinyServer(function(input, output) {
    filterVesselsServer("main")
})
