library(plm)

myDataFrame <- read.csv("Data/panel_wage.csv")
attach(myDataFrame)

Y <- cbind(lwage)
X <- cbind(exp, exp2, wks, ed)

# Set data as panel data
myPanelData <- plm.data(myDataFrame, index=c("id","t"))

# Descriptive statistics
summary(Y)
summary(X)

# Pooled OLS estimator
myPoolingOLSEstimator <- plm(Y ~ X, data=myPanelData, model= "pooling")
summary(myPoolingOLSEstimator)

# Between estimator
myBetweenEstimator <- plm(Y ~ X, data=myPanelData, model= "between")
summary(myBetweenEstimator)

# First differences estimator
myFirstDifferencesEstimator <- plm(Y ~ X, data=myPanelData, model= "fd")
summary(myFirstDifferencesEstimator)

# Fixed effects or within estimator
myWithinEstimator <- plm(Y ~ X, data=myPanelData, model= "within")
summary(myWithinEstimator)

# Random effects estimator
myRandomEstimator <- plm(Y ~ X, data=myPanelData, model= "random")
summary(myRandomEstimator)

# LM test for random effects versus OLS
plmtest(myPoolingOLSEstimator)

# LM test for fixed effects versus OLS
pFtest(myWithinEstimator, myPoolingOLSEstimator)

# Hausman test for fixed versus random effects model
phtest(myRandomEstimator, myWithinEstimator)
