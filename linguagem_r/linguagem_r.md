# Linguagem R
**Prof. Dr. Razer Anthom Nizer Rojas Montaño**

Uso da linguagem R e Aplicações em Inteligência Artificial.

## Aula 1
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

* 7 / 2 + 8 * (5 – 3)
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