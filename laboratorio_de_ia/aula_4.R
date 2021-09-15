#### ---------------------------------------------------------------------------
#### Regras de Associação - Aula 4
####

### Instalação dos pacotes necessários
install.packages('arules',dep=T)
library(arules)
library(datasets)
### Leitura dos dados
dados <- data(Groceries)
inspect(Groceries[1:3])

### Podemos ver a frequência dos 10 primeiros itens: 
itemFrequencyPlot(Groceries, topN=10, type='absolute')

summary(Groceries)

### Agora vamos obter as regras: 
### Primeiramente definimos o Suporte=0,001 e Confiança=0,7 
set.seed (1912) 
rules <- apriori(Groceries, parameter=list(supp = 0.001, conf = 0.7, minlen =2)) 
summary(rules)

###Vamos ver as 5 primeiras regras ordenadas pela confiança:
options(digits=2)
inspect(sort(rules[1:5],by="confidence"))

### Se eu desejar saber o que foi comprado com cerveja, por exemplo 
### (quem compra cerveja compra também quais produtos?) 
set.seed(1912) 
rules <- apriori (data=Groceries, parameter=list(supp=0.001,conf=0.1,minlen=2), 
                  appearance=list(default=' rhs ', lhs ='bottled beer'), 
                  control=list(verbose=F))
inspect(sort(rules, by='confidence', decreasing = T))

### Leitura dos dados
setwd ("C:/Projetos/iaa-ufpr/laboratorio_de_ia/base_de_dados") 
dados <- read.transactions(file="listadecomprasdados.csv",format="basket",sep=";")
inspect(dados[1:4])

### Extrai as regras 
set.seed(1912) 
rules <- apriori(dados, parameter=list(supp = 0.5, conf=0.9, target = "rules")) 
inspect(rules)
