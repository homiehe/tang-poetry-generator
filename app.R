library(shiny)
library(jiebaR)
library(jiebaRD)
library(tidyverse)

tagger <- worker("tag")

ci <- read.csv(file="tangshijiegou.csv") %>% as.matrix() %>% as.vector()

cixing_total <- read.csv("cixing.csv") %>% as.matrix() %>% as.vector()

write_tangshi <- function(m){
  empty <- ""
  for (i in 1:length(m)){
    temp_file <- ci[cixing_total == attributes(m)$names[i]]
    temp_file <- temp_file[nchar(temp_file) == nchar(m[i])]
    empty <- paste0(empty, sample(temp_file,1))
  }
  
  result <- paste0(substr(empty, 1,5), ",", substr(empty,5,9),".", 
                   substr(empty, 10,14), ",", substr(empty, 15,19),".")
  result
}



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Tang poetry generator"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        textInput("txt", "请输入一首五言绝句:", "向晚意不適，驅車登古原。夕陽無限好，只是近黃昏。"),
        actionButton("goButton", "Go!"),
        helpText("")
      ),
      # Show a plot of the generated distribution
      mainPanel(
        verbatimTextOutput("txtout")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  cipai <- eventReactive(input$goButton, {
    tagger <= input$txt
  })
    
  n <- eventReactive(input$goButton, {
    input$ran
  })
  
   output$txtout <- renderText({
     write_tangshi(cipai())
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

