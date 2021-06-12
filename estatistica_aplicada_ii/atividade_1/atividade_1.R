### ---------------------------------------------------------------------------- 
### 
### Estatística Aplicada II 
### Primeira Lista de Exercícios
###
### ----------------------------------------------------------------------------

# Com a base de dados "ceo" obter os seguintes resultados com o auxílio do "R" 
ceo <- read.table("C:/Projects/iaa-ufpr/estatistica_aplicada_ii/atividade_1/ceo.txt", header = TRUE, sep = "", 
                  na.strings = "NA", dec = ".", strip.white = TRUE)

# a) Elaborar a regressão linear preliminar com as seguintes variáveis: 
#    Variável dependente: salary; 
#    Variáveis explicativas: age, college, grad, comten, ceoten, sales, profits, mktval,  profmarg.
resultados <- lm (salary~age+college+comten+ceoten+profits+grad+mktval+
                    sales+profmarg, data=ceo)
summary(resultados)

# b) Testar outliers e deletar se necessário (essa etapa é opcional); 
ceo<- within(ceo, {residuos <- residuals(resultados) })

cooksd <- cooks.distance(resultados)

ceo$cooksd <- cooksd 

ceo$outlier <- with(ceo, ifelse(cooksd>4/177,"yes","no"))

outliers <- ceo[ceo$outlier != "no", ]
outliers


# c) Testar a especificação do modelo e alterar se for o caso; 
library (zoo)
library (lmtest)

resettest(lwage ~ faminc + husage + husearns + huseduc + husblck + inlf +
            hushisp + hushrs + exper + kidge6 + earns + age + black + educ +
            hispanic + kidlt6 + hours + hrwage + nwifeinc + exper2 + exper3 +
            husexper2 + husexper3 + age2 + age3 + husage2 + husage3,
          power=2:3, type="regressor", data=salarios)



# d) Testar autocorrelação e corrigir com HAC se for o caso; 


# e) Testar heterocedasticidade e corrigir se for o caso, com HC1; 


# f) Fazer regressão stepwise e fazer a regressão do melhor modelo estimador HC1  ou HAC;


# g) Obter o AIC, BIC e AICc do melhor modelo selecionado;


# h) Estimar os Intervalos de confiança dos parâmetros.  
