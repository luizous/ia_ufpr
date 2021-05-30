# Linguagem R
**Prof. Dr. Razer Anthom Nizer Rojas Montaño**

Uso da linguagem R e Aplicações em Inteligência Artificial.

## Conteúdo
1. [Aula 1 - Operações, Vetores e Matrizes](#aula1)
2. [Aula 2 - Listas, DataFrames, Arquivos](#aula2)
3. [Aula 3 - Estatística Básica, Gráficos, Regressão, Classificação e Salvando & Finalizando o Modelo](#aula3)

## Aula 1 - Operações, Vetores e Matrizes <a name="aula1"></a>
[Aula 1 - Exercícios em arquivo .R](/linguagem_r/aula_1/linguagem_r_aula1.R)
### Básico - Operações
#### Exercício 1
Rode o console do R e efetue as seguintes operações:
* **(1 + 2 + 3 + 4) / 4**
  ```r
  x <- (1+2+3+4) / 4
  x
  ```

  output:
  ```
  2.5
  ```

* **7 / 2 + 8 . (5 – 3)**
  ```r
  y <- 7/2+8 * (5-3)
  y
  ```

  output:
  ```
  19.5
  ```

* **Divisão entre 7 e 3**
  ```r
  z <- 7/3
  z
  ```

  output:
  ```
  2.333333
  ```

* **Resto da divisão entre 7 e 3**
  ```r
  z <- 7%%3
  z
  ```

  output:
  ```
  1
  ```

* **Parte inteira da divisão entre 7 e 3**
  ```r
  x <- 7%/%3
  x
  ```

  output:
  ```
  2
  ```

* **Volume de um tubo: pi * raio^2 * altura
  Calcular o volume de um tubo de raio 10 e altura 70**
  ```r
  x <- pi * 10^2 * 70
  x
  ```
  
  output:
  ```
  21991.15
  ```

#### Exercício 2
O modelo alométrico de biomassa ajustado para árvores do Cerradão estabelece que a biomassa é dada pela expressão:
  
  `> b = e-1.7953 . d2.2974`

onde 'e' é o número de Euler, 'b' é a biomassa estimada em kg, e 'd' é o diâmetro à altura do peito (dap) em cm.

Já um outro modelo para biomassa das árvores na mesma situação é:
  
  `> ln(b) = -2.6464 + 1.9960 ln(d) + 0.7558 ln(h)`
  
onde 'h' é a altura das árvores em m.

Calcule a biomassa estimada por cada modelo para uma árvore com dap de 15cm e altura de 12m. Coloque a estimativa do modelo alométrico em um objeto chamado biomassa1 e a estimativa do segundo modelo no objeto biomassa2.

Use "exp(1)" para obter o número de Euler.

Mostre e compare as duas estimativas.

Fonte: http://www.lage.ib.usp.br/notar/exercicio.php?exerc=19

```r
biomassa1 <- exp(1) - 1.7953 * (15 * 2.2974)
x <- (-2.6464) + 1.9960 * ln(15) + 0.7558 * ln(12)

cat("Biomassa 1: ", biomassa1)
cat("Biomassa 2: ", x)
```

`Porque quando eu coloco a variável 'x' com o nome de 'biomassa2' dá erro de "Error in cat("Biomassa 2: ", biomassa2) : 
  objeto 'biomassa2' não encontrado"" ???`

output
```
Biomassa 1:  -59.14955
Biomassa 2:  21991.15
```


### Vetores
#### Exercício 1 ❌
Execute os exemplos apresentados nos slides

#### Exercício 2
Dadas as leituras mensais em um medidor de consumo de luz
| Jan | Fev  | Mar | Abr | Mai | Jun | Jul | Ago | Set | Out | Nov | Dez |
|----|----|----|----|----|----|----|----|----|----|----|----|
| 9839  | 10149  | 10486  | 10746  | 11264  | 11684  | 12082  | 12599  | 13004  | 13350  | 13717  | 14052  |

a) Crie um vetor com todas as leituras.
```r
lightConsumption <- c(9839, 10149, 10486, 10746,
                      11264, 11684, 12082, 12599,
                      13004, 13350, 13717, 14052)
lightConsumption 
```

output:
```
[1]  9839 10149 10486 10746 11264 11684 12082 12599 13004
[10] 13350 13717 14052
```

b) Calcule a média das leituras no período
```r
lightConsumptionMean <- mean(lightConsumption)
lightConsumptionMean
```

output:
```
[1] 11914.33
```

c) Calcule o máximo e o mínimo das leituras no período
```r
lightConsumptionMax <- max(lightConsumption)
cat("Light Consumption Max: ", lightConsumptionMax)

lightConsumptionMin <- min(lightConsumption)
cat("Light Consumption Min: ", lightConsumptionMin)
```

output:
```
Light Consumption Max:  14052
Light Consumption Min:  9839
```

d) Ordene as medidas de forma crescente e decrescente
```r
lightConsumptionDecreasing <- lightConsumption[order(lightConsumption, 
                                                     decreasing=TRUE)]
cat("Light Consumption Decreasing: ", lightConsumptionDecreasing)

lightConsumptionCreasing <- lightConsumption[order(lightConsumption)]
cat("Light Consumption Creasing: ", lightConsumptionCreasing)
```

output:
```
Light Consumption Decreasing:  14052 13717 13350 13004 12599 12082 11684 11264 10746 10486 10149 9839> 

Light Consumption Creasing:  9839 10149 10486 10746 11264 11684 12082 12599 13004 13350 13717 14052
```

### Matrizes
#### Exercício 1 ❌
Execute os exemplos apresentados nos slides

#### Exercício 2
A seguir tem-se as distâncias entre quatro cidades da Europa, em Km:

```diff
+ Atenas a Madri: 3949
+ Atenas a Paris: 3000
+ Atenas a Estocolmo: 3927
+ Madri a Paris: 1273
+ Madri a Estocolmo: 3188
+ Paris a Estocolmo: 1827
```

* Crie uma matriz com os valores acima;
* Nesta matriz, a diagonal principal deve conter zeros e o "triângulo" acima da diagonal principal deve conter as mesmas informações do "triângulo" abaixo da diagonal principal;
* Use o nome das cidades como linhas e colunas desta matriz;
* Mostre a matriz.

```r
m <- matrix(c(0, 3949, 3000, 3927, 
              3949, 0, 1273, 3188,
              3000, 1273, 0, 1827,
              3927, 3188, 1827, 0), 
            4, 4)

colnames(m) <- c("Atenas", "Madri", "Paris", "Estocolmo")
rownames(m) <- c("Atenas", "Madri", "Paris", "Estocolmo")

m
```

output:
```
          Atenas Madri Paris Estocolmo
Atenas         0  3949  3000      3927
Madri       3949     0  1273      3188
Paris       3000  1273     0      1827
Estocolmo   3927  3188  1827         0
```

### Fatores e Fórmulas

## Aula 2 - Listas, DataFrames, Arquivos, Programação <a name="aula2"></a>
[Aula 2 - Exercícios em arquivo .R](/linguagem_r/aula_2/linguagem_r_aula2.R)
### Listas
Exemplo
```r
x <- list(1:5, "Z", TRUE, c("a", "b"))
x
```
#### Exercício 1
Sejam os seguintes três vetores

```r
v1 <- c(2005:2016)
v2 <- c(1:12)
v3 <- c(1:31)
```
Defina uma lista chamada datas que, ao ser impressa, seja:

```
$anos
[1] 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016

$meses
[1] 1 2 3 4 5 6 7 8 9 10 11 12

$dias
[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
24 25 26 27 28 29 30 31
``` 

#### Exercício 2
Sejam o seguinte vetor:

```r
v <- c(1,3,4,7,11,18,29)
```

Crie uma lista com os dados x*2, x/2 e sqrt(x)
```r
$`x*2`
```
[1] 2 6 8 14 22 36 58

```r
$`x/2`
```
[1] 0.5 1.5 2.0 3.5 5.5 9.0 14.5

```r
$`sqrt(x)`
```
[1] 1.000000 1.732051 2.000000 2.645751 3.316625 4.242641 5.385165

#### Exercício 3
Dada lista anterior, apresente o seguinte vetor

```r
2.000000 2.645751 3.316625
```

Procure a posição dos dados no vetor e acesse-os. Não é necessário buscar pelos números decimais.

### DataFrames
#### Exercício 1
Crie o seguinte Data Frame

```r
df <- data.frame(letras=letters[1:10], numeros=21:30, valores=rnorm(10))
```

Faça as seguintes pesquisas:

a) Retorne a linha 5;

b) Retorna a coluna 2 (como vetor e como data frame – drop=FALSE);

c) Retorne as colunas 2 e 3;

d) Retorne os elementos da linha 6, mas somente as colunas 1 e 3;

e) Retorne os elementos que possuem na coluna "valores" um valor maior que zero;

f) Retorne os elementos que possuem na coluna "numeros" um valor ímpar;

g) Retorne os elementos que possuem na coluna "valores" um valor maior que zero e na coluna "numeros" um valor par;

h) Retorne os elementos que possuem na coluna "letras" somente os seguintes valores "b", "g", "h".

#### Exercício 2
Criar os data frames df1 e cidades

```r
df1 <- data.frame(nome=c("Razer", "Anthom", "Nizer", "Rojas", "Montaño"),
cidadeId=c(3, 10, 2, 3, 1))

cidades <- data.frame(cidadeId=c(1, 2, 3, 4), cidade=c("Curitiba", "SJP",
"Pinhais", "Colombo"))
```

Executar os merges apresentados:

a) Cross Join

b) Inner Join

c) Outer Join

d) Left Outer Join

e) Right Outer Join

#### Exercício 3
Crie o data frame anterior e execute os comandos, vendo os resultados
* Ordene o data frame por peso;
* Ordene o data frame por sexo e peso, decrescentemente;
* Dê a maior idade nos dados (max);
* Dê a média dos pesos (mean);
* Mostrar as pessoas do sexo feminino que estão na base;
* Contar as pessoas do sexo feminino (nrow).

### Arquivos
#### Exercício 1
Execute os exercícios apresentados nos slides.
#### Exercício 2
Carregue o arquivo http://www.razer.net.br/datasets/Biomassa_REG.csv

#### Exercício 3
Carregue o arquivo http://www.razer.net.br/datasets/fertility.csv

#### Exercício 4
Salve a base de dados IRIS (data frame iris) usando os seguintes formatos:
a. Separador "**", ponto decimal ".", sem os nomes das linhas e o cabeçalho de colunas, com aspas nos campos string;

b. CSV com ponto decimal ",", sem os nomes das linhas, com o cabeçalho de colunas e sem aspas nos campos string.

### Programação
#### Exercício 1
Escreva um laço que varre os números de 1 a 7 e imprime seus quadrados, usando o comando print().
* Usando laços, varra uma lista de números aleatórios gerados por rnorm(), mas pare se o número encontrado for mais que 1.
* Usando laços, varra uma lista de números aleatórios gerados por rnorm(), mas use o comando next para pular os números negativos;
* Use laços aninhados para criar a matriz abaixo. Faça a alocação prévia da matriz com valores NA.
  
0 1 2 3 4
1 0 1 2 3
2 1 0 1 2
3 2 1 0 1
4 3 2 1 0

#### Exercício 2
Crie o seguinte data frame:
```r
student.df <- data.frame( name = c("Sue", "Eva", "Henry", "Jan"),

sex = c("f", "f", "m", "m"),
years = c(21,31,29,19));
```

Usando um comando ifelse(), crie uma coluna chamada teen, booleana, que indica se a pessoa possui menos de 20 anos.

#### Exercício 3
Crie o seguinte data frame:

```r
a = c(3,7,NA, 9)
b = c(2,NA,9,3)
f = c(5,2,5,6)
d = c(NA,3,4,NA)
mydf = data.frame(a=a,b=b,f=f,d=d)
```

Adicione uma quinta coluna usando as seguintes regras:

1. A 5a coluna tem o valor da coluna 2 se a coluna 1 é NA
2. A 5a coluna tem o valor da coluna 4 se a coluna 2 é NA
3. A 5a coluna contém o valor da coluna 3 em qualquer outro caso

O resultado deve ser:

a b f d V5
1 3 2 5 NA 5
2 7 NA 2 3 3
3 NA 9 5 4 9
4 9 3 6 NA 6

#### Exercício 4
Crie uma matriz com 10 colunas contendo 100.000 números, sendo os números de 1:100000. Faça um laço for que calcula a soma de cada linha desta matriz.

*Crie o seguinte data frame:
```r
vector1 <- 1:10
vector2 <- c("Odd", "Loop", letters[1:8])
vector3 <- rnorm(10, sd = 10)
df1 <- data.frame(vector1, vector2, vector3, stringsAsFactors = FALSE)
```

* Faça um laço genérico sobre as colunas deste data frame efetuando o seguinte cálculo:
  * Se a coluna for numérica, calcula sua média
  * Se a coluna for de texto calcula a soma dos caracteres na coluna (nchar())

#### Exercício 5 ❌
Crie um script R (chamado funcoes.R) e escreva nele as seguinte funções:
* Para calcular o quadrado de um número;
* Para receber duas matrizes e retornar a multiplicação;
* Para receber um data frame contendo uma coluna nome e uma coluna idade, e retornar a média das idades;
* Para receber um data frame contendo uma coluna nome e uma coluna idade, e retornar;
uma lista com dois dados, o nome e a idade, da pessoa que contém a maior idade;
* Carregue o script no R e execute as funções.


### Funções Apply
#### Exercício 1 ❌
Execute os exercícios apresentados nos slides

[...]

#### Exercício 2 ❌
Crie uma matriz com 10 colunas contendo 100.000 números, sendo os números de 1:100000.
* Execute um comando apply que calcula a soma de cada linha desta matriz.
* Execute um comando apply que calcula a média de cada coluna desta matriz.

[...]

#### Exercício 3 ❌
Crie o seguinte data frame:

```r
> idade <- c(56, 34, 67, 33, 25, 28)
> peso <- c(78, 67, 56, 44, 56, 89)
> altura <- c(165, 171, 167, 167, 166, 181)
> dados <- data.frame(idade, peso, altura)
```

* Dê as seguintes respostas;
* A média de todas as colunas (usando apply);
* O valor máximo de todas as colunas (usando apply);
* A raiz quadrada de todos os valores do data frame, como uma matriz;
* A raiz quadrada de todos os valores do data frame, como uma lista;
* Todos os valores do data frame multiplicados por 20, como uma matriz (usando uma UDF).

[...]
  
## Aula 3 - Estatística Básica, Gráficos, Regressão, Classificação e Salvando & Finalizando o Modelo <a name="aula3"></a>
[Aula 3 - Exercícios em arquivo .R](/linguagem_r/aula_3/linguagem_r_aula3.R)
### Gráficos
#### Exercício 1
Execute os exercícios apresentados nos slides.
```r
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
```

#### Exercício 2 ❌
Gere os gráficos em arquivos PDF e PNG.
[...]

### Regressão
#### Exercício 1
Efetuar a análise de regressão para os seguintes dados. Mostre as estatísticas, equação de reta e plote o gráficos de dispersão com a reta, e os gráficos de resíduos.

| Variável Independente (x) | Variável Dependente (y)  |
|---------------------------|--------------------------|
| 6.5 | 1.4 |
| 5.8 | 1.5 |
| 7.8 | 1.7 |
| 8.1 | 1.9 |
| 10.4 | 2.1 |
| 12.3 | 2.2 |
| 13.1 | 2.4 |
| 17.4 | 3.2 |
| 20.1 | 3.7 |
| 24.5 | 4.2 |
| 25.5 | 4.8 |
| 27.1 | 5.2 | 

```r
x <- c(6.5,5.8,7.8,8.1,10.4,12.3,13.1,17.4,20.1,24.5,25.5,27.1)
y <- c(1.4,1.5,1.7,1.9,2.1,2.2,2.4,3.2,3.7,4.2,4.8,5.2)

# gráfico de disperção com reta
df <- data.frame(x, y)
plot(df$x, df$y)
abline(h=mean(df$y), col="red")

# gráfico de resíduos
modelo <- lm(y ~ x)
plot(resid(modelo))
```

#### Exercício 2 ❌
Efetuar a análise de regressão para os dados do arquivo GAGurine.csv que está no Moodle. Mostre as estatísticas, equação de reta e plote o gráficos de dispersão com a reta, e os gráficos de resíduos

Este arquivo contém a medição de níveis de GAG (glicosaminoglicanos) na urina de crianças de certa idade
http://www.razer.net.br/datasets/GAGurine.csv

[...]

### Regressão Polinomial
#### Exercício 1 ❌
* Para os dados CoolingWater, gere as estimativas com um polinômio de grau 3 e de grau 4. Compare as curvas de predição.

* Use a base cars do R
  * Gere modelos polinomiais de graus 2, 3, 4 e 5;
  * Faça as predições com cada modelo;
  * Plote os pontos dos dados;
  * Plote as linhas de cada uma das predições efetuadas, em cores     diferentes.

* Gerar os PDFs dos gráficos com as predições de grau 2, 3 e 4, para o problema CoolingWater, usando scripts R.

[...]

### Classificação
#### Exercício 1  ❌
Efetuar o exercício de classificação apresentado, usando a base IRIS.

a) Apresente os resultados dos modelos;

b) Apresente o modelo que deu o melhor resultado.

[...]

#### Exercício 2 ❌
Efetuar o exercício de classificação apresentado, usando a base Câncer de Mama.

a) Apresente os resultados dos modelos;

b) Apresente o modelo que deu o melhor resultado.

[...]

### Salvando e Finalizando o Modelo
#### Exercício ❌
Sobe os exercícios da base Iris e Câncer de Mama.

a) Salve os modelos de gerados;

b) Em um script, carregue os modelos e execute uma predição com cada.

[...]