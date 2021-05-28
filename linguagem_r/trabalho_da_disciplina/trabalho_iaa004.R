### ----------------------------------------------------------------------------
###
### IAA004 - Linguagem R
### Trabalho da Disciplina
### Luiza Ruivo Marinho
###
### ----------------------------------------------------------------------------

### ----------------------------------------------------------------------------
### 1 - Pesquisa com Dados de Sat??lite (Satellite)
###

## Instalar o pacote do modelo de trainamento RamdomForest
install.packages("randomForest")

## Instalar o pacote mlbench para obter o banco de dados
install.packages("mlbench")
library(mlbench)

## Instalar o pacote e1071 para o treinamento dos modelos
install.packages("e1071")

## Carregqr o dataset com o banco de dados Satellite
data(Satellite)
dataset <- Satellite
head(dataset)

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


## Criar as matrizes de confus??o e comparar os resultados
confusionMatrix(predict.rf, teste$classes)  # Accuracy: 0.919
confusionMatrix(predict.svm, teste$classes) # Accuracy: 0.9143
confusionMatrix(predict.rna, teste$classes) # Accuracy: 0.5374

## Salvar os modelos
setwd("C:/Projects/ia_ufpr/linguagem_r/trabalho_da_disciplina")
getwd()
save(rf, file="rf.RData")
save(svm, file="svm.RData")
save(rna, file="rna.RData")

saveRDS()
readRDS()

# Treinar um novo modelo completo
print(rf)
final_model <- randomForest(type="C-svc", classes~., data=dataset, kernel="rbfdot",
                      C=1.0, kpar=list(sigma=0.01173596))
final_predict.rf <- predict(final_model, dataset)
confusionMatrix(final_predict.rf, dataset$classes)
saveRDS(final_model, "satellite_rf.rds")