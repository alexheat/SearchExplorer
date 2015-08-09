library(shiny)
library(UsingR)
library("ggplot2")
library("dplyr")
library("Rcell")

keywords <- read.csv("keywords.csv")
keywords <- keywords[-1,]
keywords$Clicks <- keywords$Clicks/1000
keywords$Revenue <- keywords$Clicks * keywords$CPC

shinyServer(
  function(input, output) {
    output$newHist <- renderPlot({
      lower <- input$range[1]
      upper <- input$range[2]
      
      # plot data (y axis) based on user selection
      if (input$radio==1) { 
        keywords <- arrange(keywords, CPC)
        keywords$Keyword <- revFactor(factor(keywords$Keyword, levels = keywords$Keyword))
        keywords <- arrange(keywords, desc(CPC))
        chartValue <- "CPC"
        chartTitle <- "Cost per Click"
        yaxisLabel <- "Cost per Click (GBP)"
        
      } else if (input$radio==2) {
        
        keywords <- arrange(keywords, Clicks)
        keywords$Keyword <- revFactor(factor(keywords$Keyword, levels = keywords$Keyword))
        keywords <- arrange(keywords, desc(Clicks))
        chartValue <- "Clicks"
        chartTitle <- "Total Clicks"
        yaxisLabel <- "Total Clicks (thousands)"
        
      } else if (input$radio==3) {
        keywords <- arrange(keywords, CTR)
        keywords$Keyword <- revFactor(factor(keywords$Keyword, levels = keywords$Keyword))
        keywords <- arrange(keywords, desc(CTR))
        chartValue <- "CTR"
        chartTitle <- "Click-through Rate"
        yaxisLabel <- "Click-through Rate"
        
      } else if (input$radio==4) {
        keywords <- arrange(keywords, Revenue)
        keywords$Keyword <- revFactor(factor(keywords$Keyword, levels = keywords$Keyword))
        keywords <- arrange(keywords, desc(Revenue))
        chartValue <- "Revenue"
        chartTitle <- "Total Revenue"
        yaxisLabel <- "Total Revenue GPB (millions)"
      }
      
      # plot data (y axis) based on user selection
      if (input$radio2==1) { 
        barColor <- "CPC"
        
      } else if (input$radio2==2) {
        barColor <- "Clicks"
        
      } else if (input$radio2==3) {
        barColor <- "CTR"
        
      } else if (input$radio2==4) {
        barColor <- "Revenue"
      }
      
      ggplot(data=keywords[upper:lower,], aes_string(x="Keyword", y=chartValue, fill=barColor)) +
        geom_bar(stat="identity") +
        ggtitle(chartTitle) +
        ylab(yaxisLabel) + xlab(NULL) +
        #scale_y_sqrt(chartValue) +
        theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5, size = 12))      

        })
    
  }
)


# You can access the value of the widget with input$action, e.g.
# output$value <- renderPrint({ input$action })