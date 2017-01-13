library(MASS)
library(pscl)
library(AER)

myDataFrame<- read.csv("Data/count_docvisit.csv")
head(myDataFrame)
attach(myDataFrame)
# Define variables
Y <- cbind(docvis)
X <- cbind(private, medicaid, age, educyr)
X1 <- cbind(private, medicaid, age, educyr)
# Descriptive statistics
summary(Y)
summary(X)
# Poisson model coefficients
poisson <- glm(Y ~ X, family = poisson)
summary(poisson)
# Test for overdispersion (dispersion and alpha parameters) from AER package
dispersiontest(poisson)
dispersiontest(poisson, trafo=2)
# Negative binomial model coefficients
negbin <- glm.nb(Y ~ X)
summary(negbin)
# Hurdle or truncated Poisson model coefficients
hpoisson <- hurdle(Y ~ X | X1, link = "logit", dist = "poisson")
summary(hpoisson)
# Hurdle or truncated negative binonomial model coefficients
hnegbin <- hurdle(Y ~ X | X1, link = "logit", dist = "negbin")
summary(hnegbin)
# Zero-inflated Poisson model coefficients
zip <- zeroinfl(Y ~ X | X1, link = "logit", dist = "poisson")
summary(zip)
# Zero-inflated negative binomial model coefficients
zinb <- zeroinfl(Y ~ X | X1, link = "logit", dist = "negbin")
summary(zinb)
