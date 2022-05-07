knitr::opts_chunk$set(echo = TRUE)
if(!require(magrittr)) install.packages("magrittr", repos = "http://cran.us.r-project.org")
if(!require(rvest)) install.packages("rvest", repos = "http://cran.us.r-project.org")
if(!require(readxl)) install.packages("readxl", repos = "http://cran.us.r-project.org")
if(!require(dplyr)) install.packages("dplyr", repos = "http://cran.us.r-project.org")
if(!require(maps)) install.packages("maps", repos = "http://cran.us.r-project.org")
if(!require(ggplot2)) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
if(!require(reshape2)) install.packages("reshape2", repos = "http://cran.us.r-project.org")
if(!require(shiny)) install.packages("shiny", repos = "http://cran.us.r-project.org")
if(!require(ggiraph)) install.packages("ggiraph", repos = "http://cran.us.r-project.org")
if(!require(RColorBrewer)) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")

## Importing, exploring and cleaning the data
library(magrittr)
library(rvest)
url <- "https://www.nationsonline.org/oneworld/country_code_list.htm"
iso_codes <- url %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="Country-Codes-A-C"]') %>%
  html_table()
iso_codes <- iso_codes[[1]][, -1]
iso_codes <- iso_codes[!apply(iso_codes, 1, function(x){all(x == x[1])}), ]
names(iso_codes) <- c("Country", "ISO2", "ISO3", "UN")
head(iso_codes)

# library(readxl)
url <- "https://www.un.org/en/development/desa/population/publications/dataset/fertility/wfr2012/Data/Data_Sources/TABLE%20A.8.%20%20Percentage%20of%20childless%20women%20and%20women%20with%20parity%20three%20or%20higher.xlsx"
destfile <- "dataset_childlessness.xlsx"
download.file(url, destfile, quiet = TRUE, mode = "wb")
childlessness_data <- read_excel(destfile)
head(childlessness_data)


cols <- which(grepl("childless", childlessness_data[2, ]))
childlessness_data <- childlessness_data[-c(1:3), c(1, 3, cols:(cols + 2))]
names(childlessness_data) <- c("Country", "Period", "35-39", "40-44", "45-49")
head(childlessness_data)


gender_index_data <- read.csv("https://s3.amazonaws.com/datascope-ast-datasets-nov29/datasets/743/data.csv")
head(gender_index_data)


library(dplyr)
gender_index_data["RecentYear"] <- apply(gender_index_data, 1, function(x){as.numeric(x[max(which(!is.na(x)))])})
gender_index_data <- gender_index_data[gender_index_data$Subindicator.Type == "Rank", ] %>% 
  select(-Subindicator.Type, -Indicator.Id)
names(gender_index_data) <- c("ISO3", "Country", "Indicator", as.character(c(2006:2016, 2018)), "RecentYear")
head(gender_index_data)


library(maps)
library(ggplot2)
world_data <- ggplot2::map_data('world')
world_data <- fortify(world_data)
head(world_data)


old_names <- c("Bolivia (Plurinational State of)", "Cabo Verde", "China, Hong Kong Special Administrative Region",
               "China, Macao Special Administrative Region", "Congo", "Democratic People's Republic of Korea",
               "Democratic Republic of the Congo", "Iran (Islamic Republic of)", "Lao People's Democratic Republic",
               "Micronesia (Federated States of)", "Republic of Korea", "Republic of Moldova", "Saint Vincent and the Grenadines",
               "State of Palestine", "Syrian Arab Republic", "The former Yugoslav Republic of Macedonia",
               "United Kingdom of Great Britain and Northern Ireland", "United Republic of Tanzania",
               "United States Virgin Islands", "Venezuela (Bolivarian Republic of)")
new_names <- c("Bolivia", "Cape Verde", "Hong Kong, SAR China", "Macao, SAR China", "Congo (Brazzaville)",
               "Korea (North)", "Congo, (Kinshasa)", "Iran, Islamic Republic of", "Lao PDR", "Micronesia, Federated States of",
               "Korea (South)", "Moldova", "Saint Vincent and Grenadines", "Palestinian Territory", "Syrian Arab Republic (Syria)",
               "Macedonia, Republic of", "United Kingdom", "Tanzania, United Republic of", "Virgin Islands, US", "Venezuela (Bolivarian Republic)")
for (i in 1:length(old_names)){
  childlessness_data$Country[childlessness_data$Country == old_names[i]] <- new_names[i]
}
old_names <- c("French Southern and Antarctic Lands", "Antigua", "Barbuda", "Saint Barthelemy", "Brunei", "Ivory Coast",
               "Democratic Republic of the Congo", "Republic of Congo", "Falkland Islands", "Micronesia", "UK", 
               "Heard Island", "Cocos Islands", "Iran", "Nevis", "Saint Kitts", "South Korea", "Laos", "Saint Martin",
               "Macedonia", "Pitcairn Islands", "North Korea", "Palestine", "Russia", "South Sandwich Islands",
               "South Georgia", "Syria", "Trinidad", "Tobago", "Taiwan", "Tanzania", "USA", "Vatican", "Grenadines",
               "Saint Vincent", "Venezuela", "Vietnam", "Wallis and Fortuna")
new_names <- c("French Southern Territories", rep("Antigua and Barbuda", 2), "Saint-Barthélemy",
               "Brunei Darussalam", "Côte d'Ivoire", "Congo, (Kinshasa)", "Congo (Brazzaville)", 
               "Falkland Islands (Malvinas)", "Micronesia, Federated States of", "United Kingdom",
               "Heard and Mcdonald Islands", "Cocos (Keeling) Islands", "Iran, Islamic Republic of",
               rep("Saint Kitts and Nevis", 2), "Korea (South)", "Lao PDR", "Saint-Martin (French part)",
               "Macedonia, Republic of", "Pitcairn", "Korea (North)", "Palestinian Territory", "Russian Federation",
               rep("South Georgia and the South Sandwich Islands", 2), 
               "Syrian Arab Republic (Syria)", rep("Trinidad and Tobago", 2), "Taiwan, Republic of China",
               "Tanzania, United Republic of", "United States of America", "Holy See (Vatican City State)",
               rep("Saint Vincent and Grenadines", 2), "Venezuela (Bolivarian Republic)", "Viet Nam", "Wallis and Futuna Islands")

for (i in 1:length(old_names)) {
  world_data$region[world_data$region == old_names[i]] <- new_names[i]
}

  
childlessness_data['ISO3'] <- iso_codes$ISO3[match(childlessness_data$Country, iso_codes$Country)]
world_data["ISO3"] <- iso_codes$ISO3[match(world_data$region, iso_codes$Country)]


library(reshape2)
childlessness_melt <- melt(childlessness_data, id = c("Country", "ISO3", "Period"), 
                           variable.name = "Indicator", value.name = "Value")
childlessness_melt$Value <- as.numeric(childlessness_melt$Value)
gender_index_melt <- melt(gender_index_data, id = c("ISO3", "Country", "Indicator"), 
                          variable.name = "Period", value.name = "Value")


childlessness_melt["DataType"] <- rep("Childlessness", nrow(childlessness_melt))
gender_index_melt["DataType"] <- rep("Gender Gap Index", nrow(gender_index_melt))
df <- rbind(childlessness_melt, gender_index_melt)
df[] <- lapply(df, as.character)
df$Value <- as.numeric(df$Value)


worldMaps <- function(df, world_data, data_type, period, indicator){
  
  # Function for setting the aesthetics of the plot
  my_theme <- function () { 
    theme_bw() + theme(axis.title = element_blank(),
                       axis.text = element_blank(),
                       axis.ticks = element_blank(),
                       panel.grid.major = element_blank(), 
                       panel.grid.minor = element_blank(),
                       panel.background = element_blank(), 
                       legend.position = "bottom",
                       panel.border = element_blank(), 
                       strip.background = element_rect(fill = 'white', colour = 'white'))
  }
  
  # Select only the data that the user has selected to view
  plotdf <- df[df$Indicator == indicator & df$DataType == data_type & df$Period == period,]
  plotdf <- plotdf[!is.na(plotdf$ISO3), ]
  
  # Add the data the user wants to see to the geographical world data
  world_data['DataType'] <- rep(data_type, nrow(world_data))
  world_data['Period'] <- rep(period, nrow(world_data))
  world_data['Indicator'] <- rep(indicator, nrow(world_data))
  world_data['Value'] <- plotdf$Value[match(world_data$ISO3, plotdf$ISO3)]
  
  # Create caption with the data source to show underneath the map
  capt <- paste0("Source: ", ifelse(data_type == "Childlessness", "United Nations" , "World Bank"))
  
  # Specify the plot for the world map
  library(RColorBrewer)
  library(ggiraph)
  g <- ggplot() + 
    geom_polygon_interactive(data = subset(world_data, lat >= -60 & lat <= 90), color = 'gray70', size = 0.1,
                                    aes(x = long, y = lat, fill = Value, group = group, 
                                        tooltip = sprintf("%s<br/>%s", ISO3, Value))) + 
    scale_fill_gradientn(colours = brewer.pal(5, "RdBu"), na.value = 'white') + 
    labs(fill = data_type, color = data_type, title = NULL, x = NULL, y = NULL, caption = capt) + 
    my_theme()
  
  return(g)
}


library(shiny)
library(ggiraph)
shinyApp(
  
  # Define the UI
  ui = fluidPage(
    
    # App title
    titlePanel("Childlessness and Gender Gap Index Data"),
    
    # Sidebar layout with input and output definitions
    sidebarLayout(
      
      # Sidebar panel for inputs 
      sidebarPanel(
        
        # First input: Type of data
        selectInput(inputId = "data_type",
                    label = "Choose the type of data you want to see:",
                    choices = list("Childlessness" = "Childlessness", "Gender Gap Index" = "Gender Gap Index")),
        
        # Second input (choices depend on the choice for the first input)
        uiOutput("secondSelection"),
        
        # Third input (choices depend on the choice for the first and second input)
        uiOutput("thirdSelection")
        
      ),
      
      # Main panel for displaying outputs
      mainPanel(
        
        # Hide errors
        tags$style(type = "text/css",
                   ".shiny-output-error { visibility: hidden; }",
                   ".shiny-output-error:before { visibility: hidden; }"),
        
        # Output: interactive world map
        girafeOutput("distPlot")
        
      )
    )
  ),
  
  # Define the server
  server = function(input, output) {
    
    # Create the interactive world map
    output$distPlot <- renderGirafe({
      ggiraph(code = print(worldMaps(df, world_data, input$data_type, input$period, input$indicator)))
    })
    
    # Change the choices for the second selection on the basis of the input to the first selection
    output$secondSelection <- renderUI({
      choice_second <- as.list(unique(df$Period[which(df$DataType == input$data_type)]))
      selectInput(inputId = "period", choices = choice_second,
                  label = "Choose the period for which you want to see the data:")
    })
    
    # Change the choices for the third selection on the basis of the input to the first and second selections
    output$thirdSelection <- renderUI({
      lab <- ifelse(input$data_type == "Childlessness", "age group", "indicator")
      choice_third <- as.list(unique(df$Indicator[df$DataType == input$data_type & df$Period == input$period]))
      selectInput(inputId = "indicator", choices = choice_third,
                  label = paste0("Choose the type of ", lab, " you want to explore:"))
    })
  },
   
  options = list(height = 600)
  
)


shinyApp(ui = ui, server = server)