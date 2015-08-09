library(shiny)

shinyUI(pageWithSidebar(
  headerPanel(""),
  sidebarPanel(

    sliderInput("range", "Select range of keywords to view:",
                min = 1, max = 500, value = c(1,25)),
    radioButtons("radio", "Select value to plot:",
                 choices = list("Cost per click" = 1, "Clicks" = 2, "Click-through-rate" = 3,  
                                "Total revenue" = 4), selected = 1),

    radioButtons("radio2", "Select secondary value for bar color:",
                 choices = list("Cost per click" = 1, "Clicks" = 2, "Click-through-rate" = 3,  
                                "Total revenue" = 4), selected = 1),
    submitButton(text = "Update Chart", icon = NULL),
    tags$br("Using this app:"),
    tags$ol(
      tags$li("The Keywords are ranked from highest to lowest based on the variable selected in Step 2.  
              Chose the range of keywords that you want to see on the chart. 
              Recommendation is to choose a maximum of 50 keywords or the labels will become illegible."), 
      tags$li("Choose the variable that is plotted by the length of the bars in the chart."), 
      
      tags$li("Select another variable and the colors of the bars will indicate the magnitude of this second variable. 
              A lighter blue indicates a higher value."), 
      tags$li("Press 'Update this Chart' to see the new chart based on your selections.")
    )
    
  ),
  mainPanel(
    h1("Search Keywords Explorer"),
    HTML("Use this tool to explore performance of  paid search terms. Data is from the "),
    tags$a(href="https://code.google.com/p/open-advertising-dataset/", "Open Advertising Dataset"),
    HTML("July 2012 - February 2013."),
    plotOutput('newHist'),
    tags$p(""),
    tags$b("About this application: "),
    HTML("This application was written in R using the Shiny package for Web interactivity.
         The source code for this application is available at
         <a href='https://github.com/alexheat/SearchExplorer/'>https://github.com/alexheat/SearchExplorer/</>."),
    tags$p(""),
    tags$p(""),
    tags$p(""),
    tags$p(""),
    tags$p("")
  )
))