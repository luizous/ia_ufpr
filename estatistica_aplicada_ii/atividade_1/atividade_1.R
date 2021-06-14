### ---------------------------------------------------------------------------- 
### 
### Estatística Aplicada II 
### Primeira Lista de Exercícios
###
### ----------------------------------------------------------------------------

# Com a base de dados "ceo" obter os seguintes resultados com o auxílio do "R" 
ceo <- read.table("C:/Projects/iaa-ufpr/estatistica_aplicada_ii/atividade_1/ceo.txt", header = TRUE, sep = "", 
                  na.strings = "NA", dec = ".", strip.white = TRUE)
summary(ceo)

install.packages("Rcmdr")
library (Rcmdr)
library(RcmdrMisc)

normalityTest(~salary, test="lillie.test", data=ceo)


### -------
# a) Elaborar a regressão linear preliminar com as seguintes variáveis: 
#    Variável dependente: salary; 
#    Variáveis explicativas: age, college, grad, comten, ceoten, sales, profits, mktval,  profmarg.
resultados <- lm (salary~age+college+comten+ceoten+profits+grad+mktval+
                    sales+profmarg, data=ceo)
summary(resultados)

#
install.packages("PanJen")
library("PanJen")

formBase <- formula(salary ~ age + college + grad + comten + ceoten + sales 
                    + profits + mktval + profmarg)

summary(gam(formBase, method="GCV.Cp", data = ceo))

PanJenArea<-fform(ceo,"age",formBase,distribution=gaussian)
PanJenArea<-fform(ceo,"comten",formBase,distribution=gaussian)
PanJenArea<-fform(ceo,"ceoten",formBase,distribution=gaussian)
PanJenArea<-fform(ceo,"sales",formBase,distribution=gaussian)
PanJenArea<-fform(ceo,"profits",formBase,distribution=gaussian)
PanJenArea<-fform(ceo,"mktval",formBase,distribution=gaussian)
PanJenArea<-fform(ceo,"profmarg",formBase,distribution=gaussian)
#


### -------
# b) Testar outliers e deletar se necessário (essa etapa é opcional); 
ceo$ceoten2 <- with(ceo, ceoten^2)
ceo$salessqrt <- with(ceo, sqrt(sales))
ceo$mktvalsqrt <- with(ceo, sqrt(mktval))
ceo$profmarg_prof2 <- with(ceo, profmarg+profmarg^2)

library(Rcmdr)

resultado2 <- lm(salary ~ age + college + grad + comten + ceoten + sales + profits
              + mktval + profmarg + ceoten2 + salessqrt + mktvalsqrt 
              + profmarg_prof2, data = ceo)

summary(resultado2)

## remover os outliers usando o teste de Bonferroni
install.packages("carData")
library (carData)
install.packages("car")
library(car)

outlierTest(resultado2)

ceo <- ceo[-c(74, 103),]

resultado2 <- lm(salary ~ age + college + grad + comten + ceoten + sales + profits
              + mktval + profmarg + ceoten2 + salessqrt + mktvalsqrt 
              + profmarg_prof2, data = ceo)

summary(resultado2)

### -------
# c) Testar a especificação do modelo e alterar se for o caso; 
library (zoo)
library (lmtest)

resettest(salary ~ age + college + grad + comten + ceoten + sales + profits
          + mktval + profmarg + ceoten2 + salessqrt + mktvalsqrt 
          + profmarg_prof2, power=2:3, type="regressor", data=ceo)

qf(.95, df1=54, df2=130)


### -------
# d) Testar autocorrelação e corrigir com HAC se for o caso; 
library(lmtest)

dwtest(salary ~ age + college + grad + comten + ceoten + sales + profits
       + mktval + profmarg + ceoten2 + salessqrt + mktvalsqrt 
       + profmarg_prof2,  alternative="greater", data=ceo)

library(sandwich)

summary(resultado2)

coeftest(resultado2, vcov. = vcovHAC)

### -------
# e) Testar heterocedasticidade e corrigir se for o caso, com HC1; 
bptest(salary ~ age + college + grad + comten + ceoten + sales + profits
       + mktval + profmarg + ceoten2 + salessqrt + mktvalsqrt 
       + profmarg_prof2, studentize=FALSE, data=ceo)

chisup <- qchisq(.95, df = 13)
chisup

library(Rcmdr)
library (lmtest)
library (sandwich)

resultado2 <- lm(salary ~ age + college + grad + comten + ceoten + sales + profits
              + mktval + profmarg + ceoten2 + salessqrt + mktvalsqrt 
              + profmarg_prof2, data = ceo)

summary(resultado2)

coeftest(resultado2, vcov=vcovHC(resultado2, type="HC1"))


### -------
# f) Fazer regressão stepwise e fazer a regressão do melhor modelo estimador HC1  ou HAC;

library(Rcmdr)

stepwise(resultado2, direction= 'backward', criterion ='BIC')

resultado_final <- lm(formula = salary ~ comten + ceoten + profmarg + ceoten2 + 
                     mktvalsqrt + profmarg_prof2, data = ceo)
summary(resultado_final)

bptest(salary ~ comten + ceoten + profmarg + ceoten2 + 
         mktvalsqrt + profmarg_prof2, studentize=FALSE, data=ceo)

chisup <- qchisq(.95, df = 24.551)
chisup


### -------
# g) Obter o AIC, BIC e AICc do melhor modelo selecionado;
AIC (resultado2)
BIC (resultado2)

install.packages("AICcmodavg")
library(AICcmodavg)

AICc (resultado2)

install.packages("performance")
library(performance)
model_performance(resultado2)
model_performance(resultado_final)


### -------
# h) Estimar os Intervalos de confiança dos parâmetros. 
confint(resultado2)
confint(resultado_final)
