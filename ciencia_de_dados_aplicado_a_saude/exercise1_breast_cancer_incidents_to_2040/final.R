
# Exercício 1: Visualizando dados do Global Cancer Observatory (GCO)

################################################################################
### Load libraries
################################################################################
library(TreeAndLeaf) # Pacote Bioconductor
library(RedeR) # Pacote Bioconductor
library(RColorBrewer)  # Pacote CRAN
library(igraph)  # Pacote CRAN
library(SummarizedExperiment) # Pacote Bioconductor
library(ComplexHeatmap) # Pacote Bioconductor
library(circlize) # Pacote CRAN
library(RColorBrewer)  # Pacote CRAN
library(survival)  # Pacote CRAN
library(survminer)  # Pacote CRAN


################################################################################
### Load data
################################################################################
header1 <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence.csv", 
                      sep=",", header = F, nrows = 1)
header1 <- as.character(header1)
header2 <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence.csv", 
                      sep=",", header = F, nrows = 1, skip = 1)
header2 <- as.character(header2)
header2[header2=="NA"]<- ""
header1 <- paste(header1,header2)
cancer <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence.csv", 
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

# Setting rownames by 'Population'
rownames(cancer) <- cancer$Population
cancer <- cancer[,-1]
# Exclude the last raw, "Totals"
cancer <- cancer[-nrow(cancer),]

# Set as numeric matrix
cancer <- as.matrix(cancer)
head(cancer)


################################################################################
### Estimated number of cases of breasts cancer in 2040, Incidence, 
### Both sexes, age [0-85+] 
################################################################################
# Load library
library(ggplot2)

df_cancer_1 <- data.frame(cancer)
df_first_graph <- data.frame(
  category=c(rownames(df_cancer_1)),
  count=c(df_cancer_1$Number.of.new.cases.2040)
)
df_first_graph

# Compute percentages
df_first_graph$fraction = df_first_graph$count / sum(df_first_graph$count)

# Compute the cumulative percentages (top of each rectangle)
df_first_graph$ymax = cumsum(df_first_graph$fraction)

# Compute the bottom of each rectangle
df_first_graph$ymin = c(0, head(df_first_graph$ymax, n=-1))

# Compute a good label
df_first_graph$label <- paste0(df_first_graph$category, "\n Cases: ", df_first_graph$count)

df_first_graph$labelPosition <- (df_first_graph$ymax + df_first_graph$ymin) / 2

# Make the plot
ggplot(df_first_graph, aes(ymax=ymax, ymin=ymin, xmax=5, xmin=4, fill=category)) +
  geom_rect() + 
  geom_label(x=4.8, aes(y=labelPosition, label=label), size=4) +
  scale_fill_brewer(palette=4) +
  coord_polar(theta="y") +
  xlim(c(3, 5)) +
  theme_void() +
  theme(legend.position = "none")


################################################################################
### Estimated number of new cases from 2020 to 2040, Incidence, Breast Cancer, 
### Both sexes, age [0-85+]
################################################################################
# Libraries

library(scales)
library(dplyr)

df_cancer_2 <- data.frame(cancer)
df_cancer_2

#####
###### Africa
#####
africa_2020 <- df_cancer_2[1,3]
africa_2020

africa_2040 <- df_cancer_2[1,4]
africa_2040

# Create data
africa_df <- data.frame(
  name=c("2020","2040") ,  
  value=c(africa_2020, africa_2040)
)

# Barplot
ggplot(africa_df, aes(x=name, y=value, fill=name)) + 
  labs(title="Africa") + 
  geom_bar(stat = "identity", colour = "gray", position = "stack") +
  scale_fill_manual(values = c("#F0CB35", "#C02425")) +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::comma, breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(axis.text = element_text(size=10, colour='black'), 
        plot.title = element_text(face = "bold", lineheight = 0.9, size = 18,hjust = 0.5))

#####
###### Asia
#####
asia_2020 <- df_cancer_2[2,3]
asia_2020

asia_2040 <- df_cancer_2[2,4]
asia_2040

# Create data
asia_df <- data.frame(
  name=c("2020","2040") ,  
  value=c(asia_2020, asia_2040)
)

# Barplot
ggplot(asia_df, aes(x=name, y=value, fill=name)) + 
  labs(title="Asia") + 
  geom_bar(stat = "identity", colour = "gray", position = "stack") +
  scale_fill_manual(values = c("#4B79A1", "#283E51")) +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::comma, breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(axis.text = element_text(size=10, colour='black'), 
        plot.title = element_text(face = "bold", lineheight = 0.9, size = 18,hjust = 0.5))



#####
###### Europe
#####
europa_2020 <- df_cancer_2[3,3]
europa_2020

europa_2040 <- df_cancer_2[3,4]
europa_2040

# Create data
europa_df <- data.frame(
  name=c("2020","2040") ,  
  value=c(europa_2020, europa_2040)
)

# Barplot
ggplot(europa_df, aes(x=name, y=value, fill=name)) + 
  labs(title="Europe") + 
  geom_bar(stat = "identity", colour = "gray", position = "stack") +
  scale_fill_manual(values = c("#6A9113", "#141517")) +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::comma, breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(axis.text = element_text(size=10, colour='black'), 
        plot.title = element_text(face = "bold", lineheight = 0.9, size = 18,hjust = 0.5))


#####
###### Latin America and Caribbean
#####
latin_2020 <- df_cancer_2[4,3]
latin_2020

latin_2040 <- df_cancer_2[4,4]
latin_2040

# Create data
latin_df <- data.frame(
  name=c("2020","2040") ,  
  value=c(latin_2020, latin_2040)
)

# Barplot
ggplot(latin_df, aes(x=name, y=value, fill=name)) + 
  labs(title="Latin America and Caribbean") + 
  geom_bar(stat = "identity", colour = "gray", position = "stack") +
  scale_fill_manual(values = c("#267871", "#136a8a")) +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::comma, breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(axis.text = element_text(size=10, colour='black'), 
        plot.title = element_text(face = "bold", lineheight = 0.9, size = 18,hjust = 0.5))




#####
###### Northern America
#####
northern_america_2020 <- df_cancer_2[4,3]
northern_america_2020

northern_america_2040 <- df_cancer_2[4,4]
northern_america_2040

# Create data
northern_america_df <- data.frame(
  name=c("2020","2040") ,  
  value=c(northern_america_2020, northern_america_2040)
)

# Barplot
ggplot(northern_america_df, aes(x=name, y=value, fill=name)) + 
  labs(title="Northern America") + 
  geom_bar(stat = "identity", colour = "gray") +
  scale_fill_manual(values = c("#ff0084", "#33001b")) +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::comma, breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(axis.text = element_text(size=10, colour='black'), 
        plot.title = element_text(face = "bold", lineheight = 0.9, size = 18,hjust = 0.5))

#####
###### Oceania 
#####
oceania_2020 <- df_cancer_2[4,3]
oceania_2020

oceania_2040 <- df_cancer_2[4,4]
oceania_2040

# Create data
oceania_df <- data.frame(
  name=c("2020","2040") ,  
  value=c(oceania_2020, oceania_2040)
)

# Barplot
ggplot(oceania_df, aes(x=name, y=value, fill=name)) + 
  labs(title="Oceania") + 
  geom_bar(stat = "identity", colour = "gray") +
  scale_fill_manual(values = c("#6441A5", "#2a0845")) +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::comma, breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(axis.text = element_text(size=10, colour='black'), 
        plot.title = element_text(face = "bold", lineheight = 0.9, size = 18,hjust = 0.5))



################################################################################
### Estimated number of cases from 2020 to 2040, Breast Cancer, Females, 
### Both sexes, age [0-85+]
################################################################################
library(ggplot2)
library(dplyr)

file_string <- "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-females.csv"
header1 <- read.table(file = file_string, sep=",", header = F, nrows = 1)
header1 <- as.character(header1)

cancer <- read.table(file = file_string, sep=",", header = F, stringsAsFactors = F)
colnames(cancer) <- header1
colnames(cancer)

class(cancer)
"data.frame"

head(cancer)

cancer[[header1[1]]] <- gsub(",","",cancer[[header1[1]]], fixed = T)
cancer[[header1[1]]] <- gsub(" Females","",cancer[[header1[1]]], fixed = T)
cancer <- cancer[-c(1), ]
cancer

df_cancer_5 <- data.frame(
  year=c("2020", "2020", "2020", "2020", "2020", "2020",
         "2025", "2025", "2025", "2025", "2025", "2025",
         "2030", "2030", "2030", "2030", "2030", "2030",
         "2035", "2035", "2035", "2035", "2035", "2035",
         "2040", "2040", "2040", "2040", "2040", "2040"),
  count=c(cancer[1,2], cancer[2,2], cancer[3,2], cancer[4,2], cancer[5,2], cancer[6,2],
          cancer[1,3], cancer[2,3], cancer[3,3], cancer[4,3], cancer[5,3], cancer[6,3],
          cancer[1,4], cancer[2,4], cancer[3,4], cancer[4,4], cancer[5,4], cancer[6,4],
          cancer[1,5], cancer[2,5], cancer[3,5], cancer[4,5], cancer[5,5], cancer[6,5],
          cancer[1,6], cancer[2,6], cancer[3,6], cancer[4,6], cancer[5,6], cancer[6,6])*1000000,
  region=c(cancer[1,1], cancer[2,1], cancer[3,1], cancer[4,1], cancer[5,1], cancer[6,1],
           cancer[1,1], cancer[2,1], cancer[3,1], cancer[4,1], cancer[5,1], cancer[6,1],
           cancer[1,1], cancer[2,1], cancer[3,1], cancer[4,1], cancer[5,1], cancer[6,1],
           cancer[1,1], cancer[2,1], cancer[3,1], cancer[4,1], cancer[5,1], cancer[6,1],
           cancer[1,1], cancer[2,1], cancer[3,1], cancer[4,1], cancer[5,1], cancer[6,1])
)
df_cancer_5$count <- as.numeric(as.character(df_cancer_5$count))
df_cancer_5$year <- as.numeric(as.character(df_cancer_5$year))
df_cancer_5

# stacked area chart
ggplot(df_cancer_5, aes(x=year, y=count, fill=region, order = dplyr::desc(region))) + 
  geom_area() +
  scale_y_continuous(breaks=pretty_breaks(10)) + 
  labs(x="Year", y="Cases") + 
  theme(legend.title= element_blank())