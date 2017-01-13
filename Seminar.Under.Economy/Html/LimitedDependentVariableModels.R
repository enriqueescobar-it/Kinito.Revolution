library(VGAM)
library(AER)
library(truncreg)
library(censReg)

myDataFrame<- read.csv("Data/limdep_ambexp.csv")
head(myDataFrame)
attach(myDataFrame)
# Define variables
Y <- cbind(ambexp)
X <- cbind(age, female, totchr)
# Descriptive statistics
summary(Y)
summary(X)
# Tobit model coefficients (sensoring from below at 0)
myTobitModel <- tobit(Y ~ X, left=0, right=Inf, data=myDataFrame)
summary(myTobitModel)
myTobitCensored <- censReg(Y ~ X, left=0, right=Inf, data=myDataFrame)
summary(myTobitCensored)
# Tobit model marginal effects for the censored sample
summary(margEff(myTobitCensored))
# Probit model coefficients
myProbitModel <- glm(I(Y > 0) ~ X, data = myDataFrame, family = binomial(link = "probit"))
summary(myProbitModel)
# Truncated regression coefficients
myDataFrameSubset <- subset(myDataFrame, Y>0)
myLeftTruncatedRegression <- truncreg(Y ~ X, point = 0, direction = "left", data=myDataFrameSubset)
summary(myLeftTruncatedRegression)
# Test for Tobit versus Probit and Truncated regression
lrtest <- 2*(logLik(myProbitModel) + logLik(myLeftTruncatedRegression) - logLik(myTobitModel))
lrtest
