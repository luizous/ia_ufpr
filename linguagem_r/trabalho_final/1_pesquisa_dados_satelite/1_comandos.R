### ----------------------------------------------------------------------------
###
### UNIVERSIDADE FEDERAL DO PARANA
### Especializacao em Inteligencia Artificial Aplicada
### IAA004 - Linguagem R
### Luiza Ruivo Marinho
###
### ----------------------------------------------------------------------------

### ----------------------------------------------------------------------------
### 1 - Pesquisa com Dados de Satelite (Satellite)
###

# Instalar o pacote do modelo de trainamento RandomForest:
install.packages("randomForest")
library(randomForest)

# Instalar o pacote mlbench para obter o banco de dados:
install.packages("mlbench")
library(mlbench)

# Instalar pacote caret para usar a funcao createDataPartition():
install.packages("caret")
library("caret")

# Instalar o pacote e1071 para o treinamento dos modelos:
install.packages("e1071")
library("e1071")

# Carregar o dataset com o banco de dados Satellite:
data(Satellite)
dataset <- Satellite

# Criar bases de treino e teste e particionar a bases em treino (80%) e teste (20%):
indexes <- createDataPartition(dataset$classes, p=0.80,
                               list=FALSE)
training <- dataset[indexes,]
test <- dataset[-indexes,]

## Treinar com as bases de treino:
set.seed(0)

rf <- train(classes~., data=training, method="rf") # RamdomForest
svm <- train(classes~., data=training, method="svmRadial") # SVM
rna <- train(classes~., data=training, method="nnet", trace=FALSE) # RNA

## Aplicar modelos treinados na base de teste:
predict.rf <- predict(rf, test)
predict.svm <- predict(svm, test)
predict.rna <- predict(rna, test)

## Verificar a quantidade de amostras de cada classe na base de teste:
frequency <- table(dataset$classes)
frequency_rel <- prop.table(frequency)
data.frame('Classe'= names(frequency),
           'Frequência'= as.vector(frequency),
           'Relativa'= as.vector(frequency_rel),
           'Porcentagem'= as.vector(frequency_rel) * 100)
#                Classe    Frequência     Relativa    Porcentagem
# 1            red soil       1533        0.2382284    23.82284
# 2         cotton crop        703        0.1092463    10.92463
# 3           grey soil       1358        0.2110334    21.10334
# 4      damp grey soil        626        0.0972805     9.72805
# 5  vegetation stubble        707        0.1098679    10.98679
# 6 very damp grey soil       1508        0.2343434    23.43434


## Criar as matrizes de confusao e comparar os resultados
confusionMatrix(predict.rf, test$classes)  # Accuracy: 0.9245
# Confusion Matrix and Statistics
# 
# Reference
# Prediction            red soil cotton crop grey soil damp grey soil vegetation stubble very damp grey soil
# red soil                 299           0         4              0                  7                   0
# cotton crop                0         136         0              1                  0                   0
# grey soil                  4           1       260             22                  0                   4
# damp grey soil             0           0         5             87                  0                  12
# vegetation stubble         3           3         1              0                124                   4
# very damp grey soil        0           0         1             15                 10                 281
# 
# Overall Statistics
# 
# Accuracy : 0.9245          
# 95% CI : (0.9086, 0.9383)
# No Information Rate : 0.2383          
# P-Value [Acc > NIR] : < 2.2e-16       
# 
# Kappa : 0.9064          
# 
# Mcnemar's Test P-Value : NA              
# 
# Statistics by Class:
# 
#                      Class: red soil Class: cotton crop Class: grey soil Class: damp grey soil Class: vegetation stubble
# Sensitivity                   0.9771             0.9714           0.9594               0.69600                   0.87943
# Specificity                   0.9888             0.9991           0.9694               0.98533                   0.99038
# Pos Pred Value                0.9645             0.9927           0.8935               0.83654                   0.91852
# Neg Pred Value                0.9928             0.9965           0.9889               0.96780                   0.98520
# Prevalence                    0.2383             0.1090           0.2111               0.09735                   0.10981
# Detection Rate                0.2329             0.1059           0.2025               0.06776                   0.09657
# Detection Prevalence          0.2414             0.1067           0.2266               0.08100                   0.10514
# Balanced Accuracy             0.9829             0.9853           0.9644               0.84067                   0.93490
#                      Class: very damp grey soil
# Sensitivity                              0.9336
# Specificity                              0.9736
# Pos Pred Value                           0.9153
# Neg Pred Value                           0.9795
# Prevalence                               0.2344
# Detection Rate                           0.2188
# Detection Prevalence                     0.2391
# Balanced Accuracy                        0.9536

confusionMatrix(predict.svm, test$classes) # Accuracy: 0.9112
# Confusion Matrix and Statistics
# 
# Reference
# Prediction            red soil cotton crop grey soil damp grey soil vegetation stubble very damp grey soil
# red soil                 299           0         4              0                  4                   0
# cotton crop                1         136         0              1                  1                   0
# grey soil                  3           1       261             29                  0                   6
# damp grey soil             0           0         5             81                  0                  23
# vegetation stubble         3           3         0              0                127                   6
# very damp grey soil        0           0         1             14                  9                 266
# 
# Overall Statistics
# 
# Accuracy : 0.9112          
# 95% CI : (0.8943, 0.9262)
# No Information Rate : 0.2383          
# P-Value [Acc > NIR] : < 2.2e-16       
# 
# Kappa : 0.8902          
# 
# Mcnemar's Test P-Value : NA              
# 
# Statistics by Class:
# 
#                      Class: red soil Class: cotton crop Class: grey soil Class: damp grey soil Class: vegetation stubble
# Sensitivity                   0.9771             0.9714           0.9631               0.64800                   0.90071
# Specificity                   0.9918             0.9974           0.9615               0.97584                   0.98950
# Pos Pred Value                0.9739             0.9784           0.8700               0.74312                   0.91367
# Neg Pred Value                0.9928             0.9965           0.9898               0.96255                   0.98777
# Prevalence                    0.2383             0.1090           0.2111               0.09735                   0.10981
# Detection Rate                0.2329             0.1059           0.2033               0.06308                   0.09891
# Detection Prevalence          0.2391             0.1083           0.2336               0.08489                   0.10826
# Balanced Accuracy             0.9845             0.9844           0.9623               0.81192                   0.94511
#                      Class: very damp grey soil
# Sensitivity                              0.8837
# Specificity                              0.9756
# Pos Pred Value                           0.9172
# Neg Pred Value                           0.9648
# Prevalence                               0.2344
# Detection Rate                           0.2072
# Detection Prevalence                     0.2259
# Balanced Accuracy                        0.9297

confusionMatrix(predict.rna, test$classes) # Accuracy: 0.7874
# Confusion Matrix and Statistics
# 
# Reference
# Prediction            red soil cotton crop grey soil damp grey soil vegetation stubble very damp grey soil
# red soil                 301           1         6              0                 12                   0
# cotton crop                0         124         0              0                  1                   0
# grey soil                  4           0       231             71                  2                  53
# damp grey soil             0           0         0              0                  0                   0
# vegetation stubble         1          15         1              4                122                  15
# very damp grey soil        0           0        33             50                  4                 233
# 
# Overall Statistics
# 
# Accuracy : 0.7874         
# 95% CI : (0.764, 0.8095)
# No Information Rate : 0.2383         
# P-Value [Acc > NIR] : < 2.2e-16      
# 
# Kappa : 0.7338         
# 
# Mcnemar's Test P-Value : NA             
# 
# Statistics by Class:
# 
#                      Class: red soil Class: cotton crop Class: grey soil Class: damp grey soil Class: vegetation stubble
# Sensitivity                   0.9837            0.88571           0.8524               0.00000                   0.86525
# Specificity                   0.9806            0.99913           0.8717               1.00000                   0.96850
# Pos Pred Value                0.9406            0.99200           0.6399                   NaN                   0.77215
# Neg Pred Value                0.9948            0.98619           0.9567               0.90265                   0.98313
# Prevalence                    0.2383            0.10903           0.2111               0.09735                   0.10981
# Detection Rate                0.2344            0.09657           0.1799               0.00000                   0.09502
# Detection Prevalence          0.2492            0.09735           0.2812               0.00000                   0.12305
# Balanced Accuracy             0.9821            0.94242           0.8620               0.50000                   0.91688
#                      Class: very damp grey soil
# Sensitivity                              0.7741
# Specificity                              0.9115
# Pos Pred Value                           0.7281
# Neg Pred Value                           0.9295
# Prevalence                               0.2344
# Detection Rate                           0.1815
# Detection Prevalence                     0.2492
# Balanced Accuracy                        0.8428


# Treinar o modelo final com todos os dados e fazer a predicao na base completa
print(rf)
# Random Forest 
# 
# 5151 samples
# 36 predictor
# 6 classes: 'red soil', 'cotton crop', 'grey soil', 'damp grey soil', 'vegetation stubble', 'very damp grey soil' 
# 
# No pre-processing
# Resampling: Bootstrapped (25 reps) 
# Summary of sample sizes: 5151, 5151, 5151, 5151, 5151, 5151, ... 
# Resampling results across tuning parameters:
#   
#   mtry  Accuracy   Kappa    
# 2    0.9054192  0.8827752
# 19    0.9054027  0.8828494
# 36    0.8976296  0.8732268
# 
# Accuracy was used to select the optimal model using the largest value.
# The final value used for the model was mtry = 2.

final_model <- randomForest(classes~., data=dataset, mtry=2, importance=TRUE)

final_predict <- predict(final_model, dataset)

confusionMatrix(final_predict, dataset$classes)
# Confusion Matrix and Statistics
# 
# Reference
# Prediction            red soil cotton crop grey soil damp grey soil vegetation stubble very damp grey soil
# red soil                1533           0         0              0                  0                   0
# cotton crop                0         703         0              0                  0                   0
# grey soil                  0           0      1358              0                  0                   0
# damp grey soil             0           0         0            626                  0                   0
# vegetation stubble         0           0         0              0                707                   0
# very damp grey soil        0           0         0              0                  0                1508
# 
# Overall Statistics
# 
# Accuracy : 1          
# 95% CI : (0.9994, 1)
# No Information Rate : 0.2382     
# P-Value [Acc > NIR] : < 2.2e-16  
# 
# Kappa : 1          
# 
# Mcnemar's Test P-Value : NA         
# 
# Statistics by Class:
# 
#                      Class: red soil Class: cotton crop Class: grey soil Class: damp grey soil Class: vegetation stubble
# Sensitivity                   1.0000             1.0000            1.000               1.00000                    1.0000
# Specificity                   1.0000             1.0000            1.000               1.00000                    1.0000
# Pos Pred Value                1.0000             1.0000            1.000               1.00000                    1.0000
# Neg Pred Value                1.0000             1.0000            1.000               1.00000                    1.0000
# Prevalence                    0.2382             0.1092            0.211               0.09728                    0.1099
# Detection Rate                0.2382             0.1092            0.211               0.09728                    0.1099
# Detection Prevalence          0.2382             0.1092            0.211               0.09728                    0.1099
# Balanced Accuracy             1.0000             1.0000            1.000               1.00000                    1.0000
#                      Class: very damp grey soil
# Sensitivity                              1.0000
# Specificity                              1.0000
# Pos Pred Value                           1.0000
# Neg Pred Value                           1.0000
# Prevalence                               0.2343
# Detection Rate                           0.2343
# Detection Prevalence                     0.2343
# Balanced Accuracy                        1.0000

## Analise o resultado:
# A partir das predições feitas é possível afirmar que o modelo RandomForest teve a 
# maior acurácia (0.9245). E, observando o modelo final gerado, a matriz de confusão 
# alcançou 1 de acurácia, o máximo de acurácia que é possível atingir.

# Salvar modelo final:
saveRDS(final_model, "rf_satellite_final_model.rds")

# Salvar esse script:
setwd("C:/Projects/ia_ufpr/linguagem_r/trabalho_final/1_pesquisa_dados_satelite")
getwd()
save(final_model, file="satellite_commands.RData")

