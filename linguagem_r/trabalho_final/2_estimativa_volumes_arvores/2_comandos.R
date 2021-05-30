### ----------------------------------------------------------------------------
###
### UNIVERSIDADE FEDERAL DO PARANA
### Especializacao em Inteligencia Artificial Aplicada
### IAA004 - Linguagem R
### Luiza Ruivo Marinho
###
### ----------------------------------------------------------------------------

### ----------------------------------------------------------------------------
### 2 - Estimativa de Volumes de Árvores
###

## Adiciona o pacote caret pra fazer o particionamento dos dados
install.packages("caret")
library("caret")

## Carregar o arquivo Volumes.csv (http://www.razer.net.br/datasets/Volumes.csv)
getwd()
dataset <- read.csv("/Projects/ia_ufpr/linguagem_r/trabalho_final/2_estimativa_volumes_arvores/Volumes.csv", 
                    header = TRUE, sep = ';', dec = ',')

# Visualozar os dados
head(dataset)
#     NR    DAP    HT       HP      VOL
# 1   1     34.0   27.00    1.80    0.8971441
# 2   2     41.5   27.95    2.75    1.6204441
# 3   3     29.6   26.35    1.15    0.8008181
# 4   4     34.3   27.15    1.95    1.0791682
# 5   5     34.5   26.20    1.00    0.9801112
# 6   6     29.9   27.10    1.90    0.9067022

## Eliminar a coluna NR, que só apresenta um número sequencial
dataset <- dataset[-1]
head(dataset)
#     DAP     HT        HP      VOL
# 1   34.0    27.00     1.80    0.8971441
# 2   41.5    27.95     2.75    1.6204441
# 3   29.6    26.35     1.15    0.8008181
# 4   34.3    27.15     1.95    1.0791682
# 5   34.5    26.20     1.00    0.9801112
# 6   29.9    27.10     1.90    0.9067022

## Criar partição de dados: treinamento 80%, teste 20%
indexes <- createDataPartition(dataset$VOL, p = 0.80, list = FALSE)

## Usando o pacote "caret", treinar os modelos: 
## Random Forest (rf), SVM (svmRadial), 
## Redes Neurais (neuralnet) e o modelo alométrico de SPURR
training <- dataset[indexes,]
test <- dataset[-indexes,]

set.seed(0)
rf <- train(VOL ~., data = training, method = 'rf',
            trControl = trainControl('cv', number = 10), preProcess = c('center', 'scale')) # RandomForest
svm <- train(VOL ~., data = training, method = 'svmRadial',
             trControl = trainControl('cv', number = 10), preProcess = c('center', 'scale')) # SVM
nn <- train(VOL ~ ., data = training, method = 'neuralnet', linear.output = TRUE, threshold = 0.1,
            trControl = trainControl('cv', number = 10), preProcess = c('center', 'scale')) # RNA

## O modelo alométrico é dado por: Volume = b0 + b1 * dap2 * H
alom <- nls(VOL ~ b0 + b1 * DAP * DAP * HT, training, start = list(b0 = 0.5, b1 = 0.5)) # SPURR

## Predições nos dados de teste
predict.rf <- predict(rf, test)
predict.svm <- predict(svm, test)
predict.nn <- predict(nn, test)
predict.alom <- predict(alom, test)

## Crie funções e calcule as seguintes métricas entre a predição e os dados observados
# Coeficiente de determinação: R^2
r2 <- function(observations, predictions) {
  return (1 - (sum((test$VOL - predictions) ^ 2) / sum((test$VOL - mean(test$VOL)) ^ 2)))
}

syx <- function(observations, predictions) {
  return (sqrt((sum((test$VOL - predictions) ^ 2) / (length(test$VOL) - 2))))
}

syx_percent <- function(observations, predictions) {
  return (syx(observations, predictions) / mean(test$VOL) * 100)
}

# Calcula métricas para o modelo baseado em Random Forest
rf_r2 <- r2(test$VOL, predict.rf)
rf_syx <- syx(test$VOL, predict.rf)
rf_syx_percent <- syx_percent(test$VOL, predict.rf)

# Calcula métricas para o modelo baseado em SVM
svm_r2 <- r2(test$VOL, predict.svm)
svm_syx <- syx(test$VOL, predict.svm)
svm_syx_percent <- syx_percent(test$VOL, predict.svm)

# Calcula métricas para o modelo baseado em Neural Network
nn_r2 <- r2(test$VOL, predict.nn)
nn_syx <- syx(test$VOL, predict.nn)
nn_syx_percent <- syx_percent(test$VOL, predict.nn)

# Calcula métricas para o modelo alométrico de Spurr
alom_r2 <- r2(test_data$VOL, predict.alom)
alom_syx <- syx(test_data$VOL, predict.alom)
alom_syx_percent <- syx_percent(test_data$VOL, predict.alom)

## Análise do modelo final
data.frame('RF' = c(rf_r2, rf_syx, rf_syx_percent),
           'SVM' = c(svm_r2, svm_syx, svm_syx_percent),
           'NN' = c(nn_r2, nn_syx, nn_syx_percent),
           'ALOM' = c(alom_r2, alom_syx, alom_syx_percent), 
           row.names = c('$R^2$', 'Syx','Sxy%'))
#         RF           SVM          NN           ALOM
# $R^2$   0.8180272    0.6470441    0.8400591    0.9319330
# Syx     0.2213733    0.3083061    0.2075400    0.1353912
# Sxy%    15.8802745   22.1164298   14.8879408   9.7123257

## Salvar esse script
setwd("C:/Projects/ia_ufpr/linguagem_r/trabalho_final/2_estimativa_volumes_arvores")
getwd()
save(final_model, file="volumes_arvores_commands.RData")