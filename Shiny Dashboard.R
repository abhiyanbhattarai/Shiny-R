
#Package Installation
#Install shiny
#install.packages("shiny")

#Install shinydashboard
#install.packages("shinydashboard")


#Install ggplot2 to plot differnt graphs
#install.packages("ggplot2")

#Install ggcorrplot to plot correlation between different attributes
#install.packages("ggcorrplot")


#Import Packages
library(shiny)
library(ggplot2)
library(shinydashboard)
library("ggcorrplot")

#Read the data from csv file
data <- read.csv('winequality-white.csv')

#Getting the correlation information
corr <- round(cor(data), 1)

#function to plot box-plot
rw_boxplot <- function (variable1, varName = '',
                        variable2, varName1 = '') {
  
  boxplot <- ggplot(aes(x = factor(variable1), y = variable2), 
                    data=data) +
    geom_boxplot(color = 'black', fill = "lightblue") +
    labs(x = varName, y = varName1)
  plot(boxplot)
}

#Dashboard heading
header <- dashboardHeader(title = 'DashBoard ')
sidebarMenu <- dashboardSidebar(
  sidebarMenu(
    menuItem("White Wine", tabName = "dashboard", icon = icon('dashboard'))
  )
)

#Variable declaration for dash body
frow1 <- fluidRow(
  mainPanel(
    tabsetPanel(
      tabPanel("Bar", plotOutput("bar")),
      tabPanel("Box Plot", plotOutput("box")),
      tabPanel("Correlation", plotOutput("corr"))
     
    )
  )
)
  
frow3 <- fluidRow(
  sidebarLayout(
    
    # Define the input controls
    sidebarPanel(
      sliderInput("quality", "Quality:", min = 3, max = 9, value = 5)
    ),
    
    # Define the main panel
    mainPanel(
      textOutput("result")
    )
  )
)
frow2 <- fluidRow(
  sidebarLayout(
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("var", "Choose a variable to plot:", names(data))
    ),
    
    # Define the main panel
    mainPanel(
      # Add a plot of the selected variable
      plotOutput("plot")
    )
  )
)
 
#Dashboard body 
body <- dashboardBody(frow1,frow2,frow3)

#Dashboard page
ui <- dashboardPage(title = 'Dashboard',header,sidebarMenu, body, skin = 'red')

#Getting server function in shiny r
server <- function(input,output) {
  output$plot <- renderPlot({
    ggplot(data, aes_string(x=input$var)) +
      geom_histogram(aes(fill=..count..), alpha=0.5) +
      scale_fill_gradient(low="red", high="blue")
    
  })
  # create reactive scatter plot
  output$scatter <- renderPlot({
    ggplot(data, aes(x=alcohol, y=quality, color=factor(quality))) +
      geom_point() +
      geom_smooth(method="lm", se=FALSE)
  })
  
  # create line plot
  output$box <- renderPlot({
    rw_boxplot(data$quality, varName = 'Quality', data$alcohol, 
               varName1 = 'Alcohol')
  })
  
  # create bar plot
  output$bar <- renderPlot({
    ggplot( data, aes(x = quality)) +
      geom_bar(color="white", fill="#3366FF")+
      ggtitle('Quality distribution')+
      xlab('Quality')+
      theme(plot.title = element_text(size=12))
  })
  #create correlation plot
  output$corr <- renderPlot({
    ggcorrplot(corr, hc.order = TRUE, type = "lower",
               lab = TRUE)
  })
  #calculating average alcohol count in quality
  output$result <- renderText({
    filtered_data <- data[data$quality == input$quality,]
    #getting average
    avg_alcohol <- mean(filtered_data$alcohol)
    #pasting the avg value
    paste("The average alcohol content for wines with a quality of",input$quality, "is", avg_alcohol)
  })
}

shinyApp(ui,server)