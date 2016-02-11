

lookupcolors <- c(virginica="green",versicolor="blue",setosa="red",all="species")
lookupwikisourse <- c(versicolor="https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Blue_Flag%2C_Ottawa.jpg/220px-Blue_Flag%2C_Ottawa.jpg",
                      virginica="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Iris_virginica.jpg/220px-Iris_virginica.jpg",
                      setosa="https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Kosaciec_szczecinkowaty_Iris_setosa.jpg/220px-Kosaciec_szczecinkowaty_Iris_setosa.jpg")

library(shiny)
shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    if(input$species=="all"){
      iris[, c(input$xcol, input$ycol)]
    } else {
        iris[which(iris$Species == input$species), c(input$xcol, input$ycol)] 
      
      }
    
  })
  
  
  
  model <- reactive({
    
    y = selectedData()[,2]
    x = selectedData()[,1]
    
    lm(y~x)
     
  })
  
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    
    if(input$species!="all") {
     plot(selectedData(),
          pch = 20, cex = 3,
          col = lookupcolors[input$species])
        
        if(input$checkbox)
           abline(model())
         legend(x="topleft","(x,y)", unique(input$species) , col=lookupcolors[input$species],pch=1)
      
    } else {
      
       plot(selectedData(),
           pch = 20, cex = 3,
           col = iris$Species )
           if(input$checkbox)
             abline(model())
             legend(x="topleft","(x,y)",unique(iris$Species),col=1:length(iris$Species),pch=1)
    }
          
  })
  
  output$summary <- renderPrint({
    print(paste("Regression Results For:",input$ycol, " ~ ", input$xcol, " Specices - ", input$species)) 
    summary(model())
   
  })
  
  output$help <- renderText({
    
    paste( 
     toupper(
       
     input$species), 
       " " ,sub(input$ycol,pattern = "\\.",replacement = " "), " ~ ", sub(input$xcol,pattern = "\\.", replacement = " "))

 
  })
  
  output$wikisource <- renderUI({
    
    if(input$species!="all") {
       link <-  paste("<a href=",lookupwikisourse[input$species], "> <img src=", lookupwikisourse[input$species], 


     "  height=250, width=250></a>") 
        
       HTML(link)
    } else {
       link =c()
       for( i in c(1:3)) {
         link[i] <-  paste("<p><a href=",lookupwikisourse[i], "> <img src=", lookupwikisourse[i], 
                         
                         
                         "  height=150, width=150></a> </p>
                         <p>",
                         names(lookupwikisourse[i]),
                         "</p> <hr>") 
         
         
       }  
      
      
        
         HTML(paste(link[1],link[2], link[3]))
      
      
      
    }
    
  })
  
 
  
})




  

  