### ----------------------------------------------------------------------------
###
### UNIVERSIDADE FEDERAL DO PARANA
### Especializacao em Inteligencia Artificial Aplicada
### IAA007 - Laboratório de IA
### Luiza Ruivo Marinho
###
### ----------------------------------------------------------------------------
install.packages("e1071")
install.packages("caret")
library("caret")

install.packages("klaR")
library(klaR)

### ----------------------------------------------------------------------------
### 2. Classificação
###

#### -------------------------------
#### 2.1 Câncer de Mama
####

### ----------------------------------------------------------------------------
### 3. Agrupamento
###

#### -------------------------------
#### 3.1 Irís
####
data(iris)
dados <- iris
View(dados)

#### Gráfico com os dados (ver imagem_1)
library(ggplot2)
ggplot(dados, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

#### Executa o Kmeans
set.seed(1912)
irisCluster <- kmeans(iris[, 3:4], 3)
irisCluster

table(irisCluster$cluster,iris$Species)

#### Cria um arquivo com todos os registros e mais os clusters de cada um
resultado <- cbind(dados,irisCluster$cluster)
resultado

#### -------------------------------
#### 3.2 Móveis
####
setwd ("C:/Projetos/iaa-ufpr/laboratorio_de_ia/base_de_dados") 
dados <- read.csv("moveisdados.csv ") 
View(dados)

set.seed (1912) 
cluster.results <- kmodes(dados, 10, iter.max = 10, weighted = FALSE) 
cluster.results

resultado <- cbind(dados, cluster.results$cluster) 
resultado

#### -------------------------------
#### 3.3 Câncer de Mama
####

#### -------------------------------
#### 3.4 Veículo
####
dados <- read.xlsx("C:\Projetos\iaa-ufpr\laboratorio_de_ia\veiculosdados",
                   1, sheetName = NULL, rowIndex = NULL, startRow = NULL,
                   endRow = NULL, colIndex = NULL, as.data.frame = TRUE,
                   header = TRUE, colClasses = NA, keepFormulas = FALSE, encoding = "unknown")
View(dados)


#### -------------------------------
#### 3.5 Banco
####
setwd ("C:/Projetos/iaa-ufpr/laboratorio_de_ia/base_de_dados") 
banco <- read.csv("bancodados.csv ") 
View(banco)

set.seed (1912) 
cluster.results <- kmodes(banco, 5, iter.max = 10, weighted = FALSE) 
cluster.results

resultado_banco <- cbind(banco, cluster.results$cluster) 
resultado_banco

### ----------------------------------------------------------------------------
### 4. Regras de Associação
###

#### -------------------------------
#### 4.1 Lista de Compras
####

#### -------------------------------
#### 4.2 Musculação
####

  