myDataFrame<- read.csv("Data/probit_insurance.csv")
attach(myDataFrame)

# Define variables
Y <- cbind(ins)
X <- cbind(retire, age, hstatusg, hhincome, educyear, married, hisp)

# Descriptive statistics
summary(Y)
summary(X)

table(Y)
table(Y)/sum(table(Y))

# Regression coefficients
olsRegressionModel <- lm(Y ~ X)
summary(olsRegressionModel)

# Logit model coefficients
logitModelCoefs <- glm(Y ~ X, family=binomial (link = "logit"))
summary(logitModelCoefs) 

# Logit model odds ratios
exp(logitModelCoefs$coefficients)

# Probit model coefficients
probitModelCoefs <- glm(Y ~ X, family=binomial (link="probit"))
summary(probitModelCoefs)

# Regression marginal effects
coef(olsRegressionModel)

# Logit model average marginal effects
LogitScalar <- mean(dlogis(predict(logitModelCoefs, type = "link")))
LogitScalar * coef(logitModelCoefs)

# Probit model average marginal effects
ProbitScalar <- mean(dnorm(predict(probitModelCoefs, type = "link")))
ProbitScalar * coef(probitModelCoefs)

# Regression predicted probabilities
olsRegressionProbs <- predict(olsRegressionModel)
summary(olsRegressionProbs)

# Logit model predicted probabilities
logitModelProbs <- predict(logitModelCoefs, type="response")
summary(logitModelProbs)

# Probit model predicted probabilities
probitModelProbs <- predict(probitModelCoefs, type="response")
summary(probitModelProbs)

# Percent correctly predicted values
table(true = Y, pred = round(fitted(probitModelCoefs)))
table(true = Y, pred = round(fitted(logitModelCoefs))) 

# McFadden's Pseudo R-squared
probitModelCoefsUpdate <-update(probitModelCoefs, formula= Y ~ 1)
McFadden<- 1-as.vector(logLik(probitModelCoefs)/logLik(probitModelCoefsUpdate))
McFadden
