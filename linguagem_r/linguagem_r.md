# Linguagem R
**Prof. Dr. Razer Anthom Nizer Rojas Montaño**

Uso da linguagem R e Aplicações em Inteligência Artificial.

## Conteúdo
1. [Aula 1 - Operações, Vetores e Matrizes](#aula1)
2. [Aula 2 - ](#aula2)
3. [Aula 3 - ](#aula3)

## Aula 1 - Operações, Vetores e Matrizes <a name="aula1"></a>
[Aula 1 - Exercícios em arquivo .R](linguagem_r/linguagem_r_aula1.R)
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
#### Exercício 1
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
#### Exercício 1
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

## Aula 2 - Listas, DataFrames <a name="aula2"></a>
[Aula 2 - Exercícios em arquivo .R](linguagem_r/linguagem_r_aula2.R)
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