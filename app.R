library(shinydashboard)
library(shiny)
library(dplyr)
library(ggplot2)
library(ggrepel)
require(grid)
require(png)

# set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# sidebar info
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("HOME", tabName = "dge", icon = icon("home")),
    menuItem("Univariate Analysis", tabName = "gsea", icon = icon("th")),
    menuItem("Bivariate Analysis", tabName = "kegg", icon = icon("th")),
    menuItem("Multivariate Analysis", tabName = "pathview", icon = icon("th")),
    menuItem("Principal Component Analysis", tabName = "pathview", icon = icon("th"))
  )
  
)

# main page for visualization
body <- dashboardBody(
  tabItems(
    
    ##################################################
    # Differential gene expression tab
    ##################################################
    tabItem(tabName = "dge",
            fluidRow(
              column(width = 9, 
                     box(width = NULL, status = "primary", plotOutput("heatmap1"))
              ),
              
              column(width = 3,
                     box(width = NULL, status = "primary", height = 130, selectInput("heatmaps", "Heatmap Type:", c(1,3))),
                     box(width = NULL, status = "primary", sliderInput("slider1", "Number of observations:", 1000, 500, 5000 )),
                     box(width = NULL, status = "primary", height = 130, selectInput("gene1", "Select Gene to Count:", c(2,3)))
              )
            )
    ),
    
    ##################################################
    # Gene set enrichment analysis tab
    ##################################################
    tabItem(tabName = "gsea",
            fluidRow(
              column(width = 12, 
                     box(width = NULL, status = "primary", plotOutput("gse_dotplot", height = 500))
              )
            )
    )
  )
)


# Put them together into a dashboardPage
ui <- dashboardPage(
  dashboardHeader(title = "RNA-Seq Pipeline Results Visualization"),
  sidebar,
  body
)

server <- function(input, output) {
  ##################################################
  # Differential gene expression tab
  ##################################################

  # Ma plots
  output$plotMA1 <- renderPlot({
    data <- deseq_result[seq_len(input$slider1),]
    #plot
  })
  
}

shinyApp(ui, server, options = list(launch.browser = TRUE))