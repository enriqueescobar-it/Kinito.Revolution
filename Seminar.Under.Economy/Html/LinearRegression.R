myDataFrame <- read.csv("Data/regression_auto.csv")
head(myDataFrame)
attach(myDataFrame)

# Define variables
Y <- cbind(mpg)
X1 <- cbind(weight1)
X <- cbind(weight1, price, foreign)

# Descriptive statistics
summary(Y)
summary(X1)
summary(X)

# Correlation among variables
cor(Y, X)

# Plotting data on a scatter diagram
plot(Y ~ X1, data = myDataFrame)

# Simple linear regression 
simpleLinearRegression <- lm(Y ~ X1)
summary(simpleLinearRegression)
confint(simpleLinearRegression, level=0.95)
anova(simpleLinearRegression)

# Plotting regression line
abline(simpleLinearRegression)

# Predicted values for dependent variable
predValuesDepVarY <- fitted(simpleLinearRegression)
summary(predValuesDepVarY)
plot(predValuesDepVarY ~ X1)

# Regression residuals
regressionResiduals <- resid(simpleLinearRegression)
summary(regressionResiduals)
plot(regressionResiduals ~ X1)

# Multiple linear regression
multipleLinearRegression <- lm(Y ~ X)
summary(multipleLinearRegression)
confint(multipleLinearRegression, level=0.95)
anova(multipleLinearRegression)

# Predicted values for dependent variable
predValuesDepVarMultiY <- fitted(multipleLinearRegression)
summary(predValuesDepVarMultiY)

# Regression residuals
regressionResidualsMulti <- resid(multipleLinearRegression)
summary(regressionResidualsMulti)
