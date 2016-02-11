library(shiny)


shinyUI(navbarPage("Iris Linear Regression", theme = "bootstrap.min.css",
  
            
             
 tabPanel("Application",
  sidebarPanel(
    selectInput('xcol', 'X Variable', colnames(iris[1:4])),
    selectInput('ycol', 'Y Variable', colnames(iris[1:4]),
                selected=names(iris)[[2]]),
    radioButtons("species", "By Species",
                 c(levels(iris$Species),"all")),
    checkboxInput("checkbox", label = "Add Regression Line", value = FALSE),
    br()
    
    
  ),
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("Plot",
                         fluidRow(
                           column(10,
                                  tags$h1("                  ")
                           )),
                         plotOutput("plot1")
                    ),
                tabPanel("Summary", 
                         fluidRow(
                           column(10,
                                  tags$h1("                  ")
                           )),
                         verbatimTextOutput("summary")
                         
                         ) ,
                                                                                
                tabPanel("Photo",
                         fluidRow(
                           column(10,
                                  tags$h1("                  ")
                           )),
                         fluidRow(
                           column(5,
                                  uiOutput("wikisource")
                                  
                           ),
                           column(4,
                                  
                                  tags$small(
                                    textOutput("help"),
                                    style="font-family: 'Lobster', cursive;
                                    font-weight: 100; line-height: 1.1; 
                                    color: #4d3a7d; font-size: small;"
                                    
                                  )
                           )
                         )

                )
                
        
               
                
                
                )
    
    
  
    
    )),
 
 tabPanel("About",includeHTML("Help.html"))
 
 
 
))