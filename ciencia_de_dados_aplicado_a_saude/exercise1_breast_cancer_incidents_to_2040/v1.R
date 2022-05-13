
# Exercício 1: Visualizando dados do Global Cancer Observatory (GCO)

################################################################################
### Load libraries
################################################################################
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("TreeAndLeaf")
BiocManager::install("RedeR")

library("TreeAndLeaf")
library("RedeR")
library(RColorBrewer)  # Pacote CRAN
library(igraph)  # Pacote CRAN
# library(readxl)

################################################################################
### Load data
################################################################################
cancer <- read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence.csv", 
                     sep=",", header = T, stringsAsFactors = F)
colnames(cancer)

class(cancer)
"data.frame"

head(cancer)


################################################################################
### Do some pre-processing
################################################################################

# Adjusting 'NumberOfNewCases2020' varible (set per 1000 cases)
cancer$Number.of.new.cases.2020 <- cancer$Number.of.new.cases.2020/1000

# Adjusting 'Number.of.new.cases.2040' varible (set per 1000 cases)
cancer$Number.of.new.cases.2040 <- cancer$Prediction.in.2040/1000

# Setting rownames by 'Population'
rownames(cancer) <- cancer$Label
cancer <- cancer[,-1]
# Exclude the last raw, "Totals"
cancer <- cancer[-nrow(cancer),]

# Set as numeric matrix
cancer <- as.matrix(cancer)

head(cancer)

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
ig_cancer <- att.setv(g = ig_cancer, from = "Prediction.in.2040",
                      to = "nodeColor", cols = pal, nquant = 5)
#---Node size
ig_cancer <- att.setv(g = ig_cancer, from = "Change",
                      to = "nodeSize", xlim = c(50, 120, 1), nquant = 5)
#---Font size
V(ig_cancer)$nodeFontSize[V(ig_cancer)$isLeaf] <- 20

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
plot(ig_cancer)


















install.packages("RColorBrewer")
library(RColorBrewer)
teste = read.table(file = "./NCdata-estimated-number-of-new-cases-from-2020-to-2040-incidence.csv", 
                   sep=",", header = T, stringsAsFactors = F)
mydata <- data.frame(teste)
data(mydata)
par(mfrow=c(2,3))
hist(VADeaths,breaks=10, col=brewer.pal(3,"Set3"),main="Set3 3 colors")
hist(VADeaths,breaks=3 ,col=brewer.pal(3,"Set2"),main="Set2 3 colors")
hist(VADeaths,breaks=7, col=brewer.pal(3,"Set1"),main="Set1 3 colors")
hist(VADeaths,,breaks= 2, col=brewer.pal(8,"Set3"),main="Set3 8 colors")
hist(VADeaths,col=brewer.pal(8,"Greys"),main="Greys 8 colors")
hist(VADeaths,col=brewer.pal(8,"Greens"),main="Greens 8 colors")

