
#' Este script acompanha o "Exercício 1: Visualizando dados do Global Cancer Observatory (GCO)"
#' da disciplina Ciência de Dados Aplicada à Saúde (Código: IAA019)

################################################################################
### Load libraries
################################################################################
library(TreeAndLeaf) # Pacote Bioconductor
library(RedeR) # Pacote Bioconductor
library(RColorBrewer)  # Pacote CRAN
library(igraph)  # Pacote CRAN
# library(readxl)

################################################################################
### Load data
################################################################################
header1 <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence_v2.csv", 
                      sep=",", header = F, nrows = 1)
header1 <- as.character(header1)
header2 <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence_v2.csv", 
                      sep=",", header = F, nrows = 1, skip = 1)
header2 <- as.character(header2)
header2[header2=="NA"]<- ""
header1 <- paste(header1,header2)
cancer <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence_v2.csv", 
                     sep=",", header = F, stringsAsFactors = F, skip = 2)
colnames(cancer) <- header1
colnames(cancer)
# [1] "Population"                                  "Annual.population.2020"                     
# [3] "Annual.population.2040"                      "Number.of.new.cases.2020"                   
# [5] "Number.of.new.cases.2040"                    "Change.in.number.of.cases"                  
# [7] "Change.in.number.of.cases.due.to.population"

class(cancer)
"data.frame"

head(cancer)
# Population Annual.population.2020 Annual.population.2040 Number.of.new.cases.2020 Number.of.new.cases.2040
# 1                      Africa              670719755             1037977445                   186598                   346587
# 2                        Asia             2266988920             2549164928                  1026171                  1416478
# 3                      Europe              387178922              375235808                   531086                   568439
# 4 Latin America and Caribbean              332333579              377868643                   210100                   314356
# 5            Northern America              186289122              206885514                   281591                   343676
# 6                     Oceania               21314480               26418428                    25873                    35935
# Change.in.number.of.cases Change.in.number.of.cases.due.to.population
# 1                      85.7                                        85.7
# 2                      38.0                                        38.0
# 3                       7.0                                         7.0
# 4                      49.6                                        49.6
# 5                      22.0                                        22.0
# 6                      38.9                                        38.9

################################################################################
### Do some pre-processing
################################################################################
# Adjusting 'Change in number of cases ' varible
cancer[[header1[6]]] <- gsub("+","",cancer[[header1[6]]] , fixed = T)
cancer[[header1[6]]] <- gsub("%","",cancer[[header1[6]]]  , fixed = T)
cancer[[header1[6]]] <- as.numeric(cancer[[header1[6]]] )

# Adjusting 'Change in number of cases due to population ' varible
cancer[[header1[7]]] <- gsub("+","",cancer[[header1[7]]] , fixed = T)
cancer[[header1[7]]] <- gsub("%","",cancer[[header1[7]]]  , fixed = T)
cancer[[header1[7]]] <- as.numeric(cancer[[header1[7]]] )

# Adjusting 'Change in risk ' varible
cancer[[header1[8]]] <- gsub("+","",cancer[[header1[8]]] , fixed = T)
cancer[[header1[8]]] <- gsub("%","",cancer[[header1[8]]]  , fixed = T)
cancer[[header1[8]]] <- as.numeric(cancer[[header1[8]]] )

# Adjusting 'NumberOfNewCases2020' varible (set per 1000 cases)
cancer$`Number of new cases 2020` <- cancer$`Number of new cases 2020`/1000

# Adjusting 'Number.of.new.cases.2040' varible (set per 1000 cases)
cancer$`Number of new cases 2040` <- cancer$`Number of new cases 2040`/1000

# Setting rownames by 'Population'
rownames(cancer) <- cancer$Population
cancer <- cancer[,-1]
# Exclude the last raw, "Totals"
cancer <- cancer[-nrow(cancer),]

# Set as numeric matrix
cancer <- as.matrix(cancer)

################################################################################
### Visualizing a dendrogram
################################################################################
dendrocancer <- dist(cancer)
dendrocancer <- hclust(dendrocancer)
plot(dendrocancer)

################################################################################
### Visualizing a graph
################################################################################

# Converting
ig_cancer <- treeAndLeaf(dendrocancer)

# Mapping the data into the igraph object
ig_cancer <- att.mapv(g = ig_cancer, dat = as.data.frame(cancer), refcol = 0)

# Setting attributes

#---Node color
pal <- brewer.pal(9, "Reds") # Colours
ig_cancer <- att.setv(g = ig_cancer, from = "Number of new cases 2040",
                      to = "nodeColor", cols = pal, nquant = 5)
#---Node size
ig_cancer <- att.setv(g = ig_cancer, from = "Change in number of cases ",
                      to = "nodeSize", xlim = c(50, 120, 1), nquant = 5)
#---Font size
V(ig_cancer)$nodeFontSize[V(ig_cancer)$isLeaf] <- 50

# Loading RedeR (a Java interface)
rdp <- RedPort()
calld(rdp)
resetd(rdp)

# Plotting a tree-and-leaf
addGraph(obj = rdp, g = ig_cancer)

# Adding legends
addLegend.color(obj = rdp, ig_cancer,
                title = "NumberOfNewCases2040 (.10^3)",
                position = "topright",
                ftsize = 11) # Set font size to 11
addLegend.size(obj = rdp, ig_cancer,
               title = "ChangeInNumberOfCases (%)",
               position = "bottomleft",
               ftsize = 11)


