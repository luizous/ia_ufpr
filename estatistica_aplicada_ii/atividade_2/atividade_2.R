### ---------------------------------------------------------------------------- 
### 
### Estatística Aplicada II 
### Segunda Lista de Exercícios
###
### ----------------------------------------------------------------------------

# Com a base de dados "prostate" obter os seguintes resultados com o auxílio do "R" .
install.packages('readxl')
library(readxl)
prostate <- read_excel("C:/Projetos/iaa-ufpr/estatistica_aplicada_ii/atividade_2/prostate.xlsx")

### ------- 
# a) Elaborar a regressão linear preliminar com as seguintes variáveis: 
#    - Variável dependente: lcavol; 
#    - Variáveis explicativas: lweight, age, lbph, svi, lcp, gleason, pgg45, lpsa.
install.packages('Rcmdr')
install.packages('RcmdrMisc')
library(Rcmdr)
library(RcmdrMisc)

result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa, data = prostate)
summary(result)

prostate <- within(prostate, {
  residuos <- residuals(result)
})


### ------- 
# b) Testar outliers pela técnicas de Grubbs, qui-quadrado, Bonferroni e da Distância  de Cook e eliminar observações se necessário.
## Grubbs
library ("outliers")
grubbs.test(prostate$residuos, type = 10, opposite = FALSE, two.sided = TRUE)

## qui-quadrado
chisq.out.test(prostate$residuos,opposite=FALSE)

#
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
prostate <- prostate[-c(69),]
chisq.out.test(prostate$residuos,opposite=FALSE)

#
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
prostate <- prostate[-c(55),]
chisq.out.test(prostate$residuos,opposite=FALSE)

#
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
prostate <- prostate[-c(12),]
chisq.out.test(prostate$residuos,opposite=FALSE)

## Bonferroni 
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
library (car)
outlierTest(result)

## Distância  de Cook
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
prostate_size <- nrow(prostate)
prostate$cooksd <- cooks.distance(result)
prostate$outlier <- with(prostate, ifelse(cooksd > 4/prostate_size,"yes","no"))
prostate[prostate$outlier != "no", ]

prostate <- prostate[-c(1,2,3,4,5,6),]
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa , data = prostate)
summary(result)


### -------
# c) Testar normalidade por Kolmogorov-Smirnov e Shapiro-Wilk.
## Kolmogorov-Smirnov --
library("RcmdrMisc")
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
normalityTest(~residuos, test="lillie.test", data=prostate)

## Shapiro-Wilk --
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa
             , data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
normalityTest(~residuos, test="shapiro.test", data=prostate)


### -------
# d) Testar autocorrelação e corrigir com HAC se for o caso.
library(lmtest)
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason 
             + pgg45 + lpsa, data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
dwtest(lcavol ~  lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa, 
       alternative="greater", data=prostate)


### -------
# e) Testar heterocedasticidade e corrigir se for o caso, com regressão robusta ou  HC1.
library(lmtest)
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason 
             + pgg45 + lpsa, data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
bptest(lcavol ~  lweight + age + lbph + svi + lcp + gleason 
            + pgg45 + lpsa, studentize=FALSE, data=prostate)

chisup <- qchisq(0.95, df=8)
chisup


### -------
# f) Fazer regressão stepwise e obter a melhor regressão, apresentar o resultado do  modelo.
# Models by STEPWISE - use BIC for calculation
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason 
             + pgg45 + lpsa, data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
lm(formula = lcavol ~ lcp + lpsa, data = prostate)
stepwise(result, direction= 'backward', criterion ='BIC')

result_stepwise <- lm(formula = lcavol ~ lcp + lpsa, data = prostate)
summary(result_stepwise)


### -------
# g) Obter o AIC, BIC e AICc do melhor modelo selecionado. 
result <- lm(lcavol ~  lweight + age + lbph + svi + lcp + gleason 
             + pgg45 + lpsa, data = prostate)
prostate <- within(prostate, {
  residuos <- residuals(result) 
})
library(AICcmodavg)
AIC (result)
BIC (result)
AICc (result)


### -------
# h) Estimar os Intervalos de confiança dos parâmetros. 
library(performance)
model_performance(result)
model_performance(result_stepwise)

confint(result)
confint(result_stepwise)
