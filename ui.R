library(shiny)
require(htmltab)

## Initialization
  require(htmltab)
  {## get dax components names
    
    tabledata.url <- "https://en.wikipedia.org/wiki/DAX"
    DAX.components = htmltab(doc = tabledata.url, which=3, rm_nodata_cols = F)
    DAX.components.Symbol = paste0( DAX.components[['Ticker symbol']], '.DE')
    names(DAX.components.Symbol) =  paste0( DAX.components[['Company']], ' (', DAX.components[['Prime Standard industry group']] ,')' )
    
  } # {## get dax components names
# end: ## Initialization

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title.
  headerPanel("DAX stock vs DAX"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view. The helpText function is also used to 
  # include clarifying text. Most notably, the inclusion of a 
  # submitButton defers the rendering of output until the user 
  # explicitly clicks the button (rather than doing it immediately
  # when inputs change). This is useful if the computations required
  # to render output are inordinately time-consuming.
  sidebarPanel(
    
    selectInput("stock_id", "DAX Stock:",
                DAX.components.Symbol),
    
    # textInput("stock_id", "Type in stock ID to fetch data from Yahoo", "BAS.DE"),
    
    # Specification of range within an interval
    helpText("Specify Range (in % of data)"),
    sliderInput("range", "Range:",
                min = 0, max = 100, value = c(0,100)),

    helpText("Load Stockdata from Yahoo")
    
    # submitButton("Update View")
  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations. Note the use of the h4 function to provide
  # an additional header above each output section.
  mainPanel(
    
    tabsetPanel(
      tabPanel(
        "Timeseries", 
          plotOutput("timeseries")
        ),
      
      tabPanel("Boxplot",
               plotOutput("boxplot")
      ),
      
      tabPanel("Histograms",
          plotOutput("histogram.stockdata"),
          plotOutput("histogram.GDAXI")
      )
      
    )
    
  )
))