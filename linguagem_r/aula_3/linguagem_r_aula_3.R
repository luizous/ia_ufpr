### 
### funções básicas
lista <- rnorm(10)
lista
# > [1] -1.1955941 -0.5444413 -0.5513766  0.3436931 -0.2592434 -2.2130703  0.4817388
# > [8]  0.4004476  0.3054380 -1.6481838

mean(lista)
# > [1] -0.4880592

median(lista)
# > [1] -0.4018423

weighted.mean(lista, c(1:10))
# > [1] -0.4417385

sd(lista)
# > [1] 0.938859

min(lista)
# > [1] -2.21307

max(lista)
# > [1] -2.21307

quantile(lista)
# >        0%        25%        50%        75%       100% 
# > -2.2130703 -1.0345397 -0.4018423  0.3341294  0.4817388

summary(lista)
# >    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# > -2.2131 -1.0345 -0.4018 -0.4881  0.3341  0.4817


### amplitude 
x <- c(22, 7, 19, 8, 9, 19, 10)
range(x)
# [1]  7 22

diff(range(x))
# [1] 15


### desvio padrão
sd(x)
# > [1] 6.294366


### coeficiente de variação
sd(x)/mean(x)*100
# > [1] 46.87294


### frequências relativas e porcentagens
x <- c(22, 7, 19, 8, 9, 19, 10)
prop.table(x)
# > [1] 0.23404255 0.07446809 0.20212766 0.08510638 0.09574468 0.20212766 0.10638298
# prop.table(x)*100
# > [1] 23.404255  7.446809 20.212766  8.510638  9.574468 20.212766 10.638298

### criar uma tabela de frequência
grupoA <- rep("Grupo A", sample(1:100, 1))
grupoB <- rep("Grupo B", sample(1:100, 1))
grupoC <- rep("Grupo C", sample(1:100, 1))
grupos <- sample(c(grupoA, grupoB, grupoC))

table(grupos)

# > Grupo A   Grupo B   Grupo C 
# > 3         8         60

## IRIS
### usando a base de dados IRIS que contém dados de várias espécies de uma flor
head(iris)

# > Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# > 1          5.1         3.5          1.4         0.2  setosa
# > 2          4.9         3.0          1.4         0.2  setosa
# > 3          4.7         3.2          1.3         0.2  setosa
# > 4          4.6         3.1          1.5         0.2  setosa
# > 5          5.0         3.6          1.4         0.2  setosa
# > 6          5.4         3.9          1.7         0.4  setosa

### frequência
table(iris$Species)

# > setosa     versicolor  virginica 
# > 50         50          50

### descobrir a frequência conforme uma condição
table(iris$Sepal.Length>5.0)
# > FALSE  TRUE 
# > 32     118 

### classes de frequencias
dados <- c(38, 15, 43, 85, 36, 15, 96, 35, 20, 29, 76,
           39, 18, 14, 37, 39, 68, 63, 96, 86, 45, 89, 94, 60, 73, 60, 59,
           73, 52, 32)
summary(dados)

# > Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
# > 14.00   35.25    48.50     52.83   73.00      96.00

interv <- seq(0, 100, 25)
interv
# > [1]   0  25  50  75 100

classes <- c("0-24", "25-49", "50-74", "75-100")
table(cut(dados, breaks=interv, right=FALSE,
          labels=classes))
# > 0-24  25-49   50-74   75-100 
# > 5     10      8       7

### ----------------------------------------------------------------------------
###
### gráficos
dados <- c(38, 15, 43, 85, 36, 15, 96, 35, 20, 29, 76, 39, 18,
           14, 37, 39, 68, 63, 96, 86, 45, 89, 94, 60, 73, 60, 59, 73, 52, 32)
interv <- seq(0,100,25)
classes <- c("0-24", "25-49", "50-74", "75-100")
t <- table(cut(dados, breaks=interv, right=FALSE,
                 labels=classes))
plot(t, xlab="Classe", ylab="Frequência")

### histograma
lista <- rnorm(100)
hist(lista)

dados <- c(38, 15, 43, 85, 36, 15, 96, 35, 20, 29, 76, 39,
           18, 14, 37, 39, 68, 63, 96, 86, 45, 89, 94, 60, 73, 60, 59, 73,
           52, 32)
hist(dados, xlab="Valores", ylab="Frequência", main="Meu
Histograma")

### gráfico de dispersão
x <- rnorm(100)
y <- rnorm(100)
plot(x, y)

n_dados <- 100
v_temp <- sample(0:45, n_dados, replace=T)
v_altitude <- sample(0:1200, n_dados, replace=T)
df <- data.frame(temperatura=v_temp,
                   altitude=v_altitude)
plot(df$altitude, df$temperatura)

### gráfico de linhas
x <- 1:20
y <- rnorm(20)
plot(x, y, type="l")

n_dados <- 100
v_temp <- sample(0:45, n_dados, replace=T)
v_obs <- 1:n_dados
df <- data.frame(observacao=v_obs, temperatura=v_temp)
plot(df$observacao, df$temperatura, type="l")

### com linha média
plot(df$observacao, df$temperatura, type="l")
abline(h=mean(df$temperatura), col="red")

### gráfico de linhas 
grupoA <- rep("Grupo A", 30)
grupoB <- rep("Grupo B", 20)
grupoC <- rep("Grupo C", 9)
grupos <- c(grupoA, grupoB, grupoC)
grupos <- table(grupos)
plot(grupos)

### gráfico de barras
n_dados <- 100
v_temp <- sample(0:45, n_dados, replace=T)
v_obs <- 1:n_dados
df <- data.frame(observacao=o_obs, temperatura=v_temp)
barplot(df$temperatura)

### ----------------------------------------------------------------------------
###
### salvar em arquivo
pdf(file="teste.pdf")
n_dados <- 100
v_temp <- sample(0:45, n_dados, replace=T)
v_obs <- 1:n_dados
df <- data.frame(observacao=o_obs, temperatura=v_temp)
barplot(df$temperatura)
dev.off()

### salvar em png
pdf(file="aula3.png", )
n_dados <- 100
v_temp <- sample(0:45, n_dados, replace=T)
v_obs <- 1:n_dados
df <- data.frame(observacao=o_obs, temperatura=v_temp)
barplot(df$temperatura)
dev.off()

### ----------------------------------------------------------------------------
###
### regressão
x <- c(40, 30, 30, 25, 50, 60, 65, 10, 15, 20, 55, 40, 35, 30)
y <- c(1000, 1500, 1200, 1800, 800, 1000, 500, 3000, 2500, 2000, 800, 1500,
         2000, 2000)
modelo <- lm(y ~ x)
modelo

# Call:
#   lm(formula = y ~ x)
# 
# Coefficients:
#   (Intercept)            x  
#       2933.60       -38.56  

### obter sumarização do modelo
summary(modelo)

# Call:
#   lm(formula = y ~ x)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -576.94 -196.81   29.71  203.48  451.95 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 2933.597    213.781  13.722 1.07e-08 ***
#   x            -38.555      5.414  -7.121 1.21e-05 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 325.3 on 12 degrees of freedom
# Multiple R-squared:  0.8086,	Adjusted R-squared:  0.7927 
# F-statistic: 50.71 on 1 and 12 DF,  p-value: 1.212e-05

### predição de novos valores
novos <- data.frame(x=c(10, 20, 30))
predict(modelo, novos)
# 1         2         3 
# 2548.046  2162.494  1776.942

resid(modelo)
# 1          2          3          4          5          6          7          8          9         10         11         12 
# -391.39040 -276.94211 -576.94211 -169.71796 -205.83869  379.71301   72.48887  451.95448  144.73033 -162.49381  -13.06284  108.60960 
#
# 13         14 
# 415.83375  223.05789 

## exerc�cio 1
x <- c(6.5,5.8,7.8,8.1,10.4,12.3,13.1,17.4,20.1,24.5,25.5,27.1)
y <- c(1.4,1.5,1.7,1.9,2.1,2.2,2.4,3.2,3.7,4.2,4.8,5.2)

# gr�fico de disper��o com reta
df <- data.frame(x, y)
plot(df$x, df$y)
abline(h=mean(df$y), col="red")

# gr�fico de res�duos
modelo <- lm(y ~ x)
plot(resid(modelo))


