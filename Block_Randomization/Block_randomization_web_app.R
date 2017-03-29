# Documentation -----------------------------------------------------------

# Web app to produce block randomization trials
# Author: Deepak Sharma
# Computer Programmer, JPNATC - AIIMS
# Date: 28 March, 2017

# Import libraries --------------------------------------------------------

library(shiny)
library(psych)

# User interface ----------------------------------------------------------

ui <- fluidPage(
  titlePanel("Block randomization in R"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "trials",
        "Number of trials:",
        min = 1,
        max = 300,
        value = 150
      ),
      sliderInput(
        "blocks",
        "Number of blocks:",
        min = 1,
        max = 10,
        value = 3
      ),
      sliderInput(
        "cases",
        "Number of cases:",
        min = 1,
        max = 4,
        value = 2
      ),
      downloadButton('downloadData', 'Download')
    ),
    
    # Show result table
    mainPanel(tableOutput("filetable"))
    
  ))


# Server ------------------------------------------------------------------

server <- function(input, output)
{
  output$filetable <- renderTable({
    condition <-
      block.random(n = input$trials, c(block = input$blocks, drug = input$cases))
    output <- data.frame(condition)
    colnames(output) <- c("Block", "to_be_discarded", "Case")
    data <- output[,-2]
  })
  data <- mtcars
  output$table <- renderTable({
    datasetInput()
  })
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("trials", '.txt', sep='')},
    content = function (file){
      write.csv(data,file)
    }
  )
}

# Run application ---------------------------------------------------------

shinyApp(ui = ui, server = server)

