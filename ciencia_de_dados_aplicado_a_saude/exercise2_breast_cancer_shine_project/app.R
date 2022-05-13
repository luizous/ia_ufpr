###
### Exercício 2 - Criando uma App Shiny
###

library(shiny)

################################################################################
### Load data
################################################################################
file_string <- "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence.csv"

header1 <- read.table(file = file_string, 
                      sep=",", header = F, nrows = 1)
header1 <- as.character(header1)
header2 <- read.table(file = file_string, 
                      sep=",", header = F, nrows = 1, skip = 1)
header2 <- as.character(header2)
header2[header2=="NA"]<- ""
header1 <- paste(header1,header2)
cancer <- read.table(file = file_string, 
                     sep=",", header = F, stringsAsFactors = F, skip = 2)
colnames(cancer) <- header1
colnames(cancer)

class(cancer)
"data.frame"

head(cancer)


################################################################################
### Pre-processing
################################################################################
# Adjusting 'Change in number of cases' varible
cancer[[header1[6]]] <- gsub("+","",cancer[[header1[6]]], fixed = T)
cancer[[header1[6]]] <- gsub("%","",cancer[[header1[6]]], fixed = T)
cancer[[header1[6]]] <- as.numeric(cancer[[header1[6]]] )

# Adjusting 'Change in number of cases due to population' varible
cancer[[header1[7]]] <- gsub("+","",cancer[[header1[7]]], fixed = T)
cancer[[header1[7]]] <- gsub("%","",cancer[[header1[7]]], fixed = T)
cancer[[header1[7]]] <- as.numeric(cancer[[header1[7]]])

# Adjusting 'Change in risk' varible
cancer[[header1[8]]] <- gsub("+","",cancer[[header1[8]]], fixed = T)
cancer[[header1[8]]] <- gsub("%","",cancer[[header1[8]]], fixed = T)
cancer[[header1[8]]] <- as.numeric(cancer[[header1[8]]])

# Set as numeric matrix
cancer <- as.matrix(cancer)

# Remove "Totals"
cancer <- cancer[-nrow(cancer),]

head(cancer)

# Set cancer data into data frame
data = data.frame(cancer)
data$Number.of.new.cases.2020 <- as.numeric(as.character(data$Number.of.new.cases.2020))
data$Number.of.new.cases.2040 <- as.numeric(as.character(data$Number.of.new.cases.2040))

# Create a clean data frame 
switch_df <- data.frame(
  cases.2020=c(data$Number.of.new.cases.2020),
  cases.2040=c(data$Number.of.new.cases.2040),
  year=c("2020","2040","2020","2040","2020","2040","2020","2040","2020","2040","2020","2040"),
  region=c(data$Population)
)

switch_df


################################################################################
### Shiny App
################################################################################
# Use a fluid Bootstrap layout
ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Estimated number of new cases from 2020 to 2040, Incidence, Breast Cancer, Both sexes, age [0-85+] by Region"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Region", 
                  choices=unique(switch_df$region)),
      hr(),
      helpText("Data from GCO (2022) Global Cancer Observatory.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("plot")  
    )
    
  )
)


# Define a server for the Shiny app
server <- function(input, output) {
  
  reactive_data = reactive({
    selected = input$region
    return(switch_df[switch_df$region==selected,])
    
  })
  data = data.frame(Population=sample(1:20,10),Households = sample(1:20,10), year=sample(c(2000,2010),10,replace=T))
  
  # Fill in the spot we created for a plot
  output$plot <- renderPlot({
    
    library(RColorBrewer)
    color <- brewer.pal(5, "Spectral")
    our_data <- reactive_data()
    
    # Render a barplot
    barplot(colSums(our_data[,c("cases.2020","cases.2040")]),
            main=input$region,
            ylab="Number of Cases",
            xlab="Year",
            col = color)
  })
}

shinyApp(ui = ui, server = server)