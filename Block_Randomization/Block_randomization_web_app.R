# Documentation -----------------------------------------------------------

# Shiny web app to produce block randomization trials
# Author: Deepak Sharma
# Computer Programmer, JPNATC - AIIMS
# Date: 28 March, 2017

# Import libraries --------------------------------------------------------

library(shiny)
library(psych)

# User interface ----------------------------------------------------------

ui <- fluidPage(
  titlePanel('Block randomization in R'),
    sidebarLayout(
      sidebarPanel(
          h3("Instructions"),
          h6("For 150 trials enter trials = 150"),
          h6("Factor = Desired block trials / number of cases"),
          h6("Example: To produce a block of 6 trials"),
          h6("Enter factor = 3 and cases = 2, since 3 * 2 = 6 "),
          textInput("trials", "Number of trials ","150"),
          textInput("factor", "Number of factor ","3"),
          textInput("cases", "Number of cases ","2"),
          radioButtons("filetype", "Save as ", choices = c("txt", "csv", "tsv")),
          downloadButton('trials', 'Download trials')
          ),
          mainPanel(tableOutput('table')
      )
    )
)

# Server ------------------------------------------------------------------

server <- function(input, output){
  datasetInput <- reactive({
    condition <- block.random(as.numeric(input$trials), c(as.numeric(input$factor), as.numeric(input$cases)))
    output <- data.frame(condition)
    colnames(output) <- c("Block", "to_be_discarded", "Case")
    data <- output[,-2]
    })
    output$table <- renderTable({
      datasetInput()
  })

  output$trials <- downloadHandler(
    filename = function() {
      paste(input$filetype, sep = ".")
    },
  
# Write content in file    
  content = function(file) {
    sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t","txt" = " ")
    write.table(datasetInput(), file, sep = sep, row.names = FALSE)
    }
  )
}

# Run application ---------------------------------------------------------

shinyApp(ui = ui, server = server)

