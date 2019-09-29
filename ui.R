library(shiny)
library(shinythemes)

shinyUI(fluidPage(
    theme=shinytheme("cyborg"),
    
    titlePanel("Victims of Road Accidents in Mediterranean Countries"),
    sidebarLayout(
        sidebarPanel(
            
            selectInput("Choose","Select",
                        c(Country="C_Plot",Year="Y_Plot")
            ),
            conditionalPanel(
                condition="input.Choose=='C_Plot'",
                selectInput(
                    "geo","Country:-",
                    c("Algeria","Egypt","Israel","Jordan","Lebanon","Morocco")),
                radioButtons("radio","Radio buttons",
                             c("Summary" = "summary", "Table" = "table"))
                
            ),
            conditionalPanel(
                condition="input.Choose=='Y_Plot'", sliderInput('time','Year Slider(Automatic)',
                                                                value = 2000, min =2005, max =2017,animate = TRUE),
                radioButtons("radio","Radio buttons",
                             c("Summary" = "summary", "Table" = "table"))
            )),
        mainPanel(
            
            fluidRow(
                plotOutput("plot"),
                conditionalPanel(
                    condition = "input.radio == 'summary'",verbatimTextOutput("summary")),
                conditionalPanel(
                    condition = "input.radio == 'table'", tableOutput("table")))
            
        ))
))
