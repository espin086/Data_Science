library(shiny)

#########################################################
#UI
ui <- pageWithSidebar(headerPanel("Hillary or Trump"),
                      sidebarPanel(
                              #Adding hilary and trump picture
                              img(src='TrumpHillaryPic.png', align = "center",
                                       width = "275px", height = "200px"),
                              #Text input
                              textInput("in.text", "Input Text Here", "This is an example speech. Copy and paste a speech into the panel on the left to get app started.  Please ensure that all text is in a standard format such as x.  You can ensure that text is formatted in this way by using by going to www.examplesite.com"),
                              h6("Created by JJ Espinoza")
                              ),
                      mainPanel(
                              tabsetPanel(type = "tabs", 
                                          tabPanel("Prediction of you text"
                                          ), 
                                          tabPanel("Exploring speeches"
                                          ),
                                          tabPanel("How does this work?"
                                          )
                              )
                      )
                      )
#########################################################
#Server    
server <- function(input, output){
        #Simple return of text
        output$value <- renderText({ input$in.text })
}
#########################################################
#Shiny App Function
shinyApp(ui = ui, server = server)
        