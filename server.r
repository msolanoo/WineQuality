library(shiny)
WineData <- read.csv("winequality.csv", header=T)
WineData$Wine.Type <- factor(WineData$Wine.Type, labels = c("Red Wine", "White Wine"))

  shinyServer(function(input, output, session) {
    
    output$data_table<-renderTable({
      head(WineData,20)
    })
        
  formulaText <- reactive({
    paste( input$variable , " ~ Wine.Type ")
  })

  formulaTextPoint <- reactive({
    paste("quality ~", input$variable)
  })

  fit <- reactive({
    lm(as.formula(formulaTextPoint()), data=WineData)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$caption2 <- renderText({
    formulaTextPoint()
  })
  
  output$QualityBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = WineData)
  })

  output$fit <- renderPrint({
    summary(fit())
  })
  
  output$QualityPlot <- renderPlot({
    with(WineData, {
      plot(as.formula(formulaTextPoint()))
      abline(fit(), col=2)
    })
  })

    
})
