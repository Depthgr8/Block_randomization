# This script is the source for a web app to plot block randomization

library(shiny)
library(psych)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Block randomization in R"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("trials",
                     "Number of trials:",
                     min = 1,
                     max = 300,
                     value = 150),
         sliderInput("blocks",
                     "Number of blocks:",
                     min = 1,
                     max = 10,
                     value = 3),
         sliderInput("cases",
                     "Number of cases:",
                     min = 1,
                     max = 4,
                     value = 2)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x <- input$blocks
      y <- input$trials
      condition <-  block.random( n= input$trials,c(block = input$blocks,drug = 2))
      # draw the histogram with the specified number of bins
      plot(condition[,2], condition[,3], col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

