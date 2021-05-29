### ----------------------------------------------------------------------------
###
### UNIVERSIDADE FEDERAL DO PARAN??
### Especializa????o em Intelig??ncia Artificial Aplicada
### IAA004 - Linguagem R
### Luiza Ruivo Marinho
###
### ----------------------------------------------------------------------------

### ----------------------------------------------------------------------------
### 1 - Pesquisa com Dados de Satelite (Satellite)
###

## Instalar o pacote do modelo de trainamento RamdomForest
install.packages("randomForest")
library(randomForest)

## Instalar o pacote mlbench para obter o banco de dados
install.packages("mlbench")
library(mlbench)

## Instalar pacote caret para usar a funcao createDataPartition()
install.packages("caret")
library("caret")

## Instalar o pacote e1071 para o treinamento dos modelos
install.packages("e1071")
library("e1071")

## Carregqr o dataset com o banco de dados Satellite
data(Satellite)
dataset <- Satellite

## Criar bases de treino e teste
## Particiona a bases em treino (80%) e teste (20%)
indices <- createDataPartition(dataset$classes, p=0.80,
                               list=FALSE)
treino <- dataset[indices,]
teste <- dataset[-indices,]

## Treinar com as bases de treino
set.seed(0)

rf <- train(classes~., data=treino, method="rf") # RamdomForest
svm <- train(classes~., data=treino, method="svmRadial") # SVM
rna <- train(classes~., data=treino, method="nnet",
               trace=FALSE) # RNA

## Aplicar modelos treinados na base de teste
predict.rf <- predict(rf, teste)
predict.svm <- predict(svm, teste)
predict.rna <- predict(rna, teste)

## Verificar a quantidade de amostras de cada classe na base de teste
table(teste$classes)
# resultado:
#
# red soil         cotton crop       grey soil      damp grey soil    vegetation stubble 
# 306              140               271            125               141 
#
# very damp grey soil 
# 301 


## Criar as matrizes de confusao e comparar os resultados
confusionMatrix(predict.rf, teste$classes)  # 0.9245
confusionMatrix(predict.svm, teste$classes) # 0.9112
confusionMatrix(predict.rna, teste$classes) # 0.7874


# Treinar o modelo final com todos os dados e fazer a predicaoo na base completa
print(rf)

final_model <- randomForest(classes~., data=dataset, mtry=2, importance=TRUE)

final_predict <- predict(final_model, dataset)

confusionMatrix(final_predict, dataset$classes)

## Salvar modelo final
saveRDS(final_model, "rf_satellite_final_model.rds")

## Salvar esse script
setwd("C:/Projects/ia_ufpr/linguagem_r/trabalho_final/1_pesquisa_dados_satelite")
getwd()
save(final_model, file="satellite_commands.RData")

