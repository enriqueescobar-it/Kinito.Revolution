library(rms)

myDataFrame<- read.csv("Data/ordered_health.csv")
head(myDataFrame)
attach(myDataFrame)
Y <- cbind(healthstatus1)
X <- cbind(age, logincome, numberdiseases)
Xvar <- c("age", "logincome", "numberdiseases")
# Descriptive statistics
summary(Y)
summary(X)
table(Y)
# Ordered logit model coefficients
ddist <- datadist(Xvar)
options(datadist='ddist')
ologit <- lrm(Y ~ X, data=myDataFrame)
print(ologit)
# Ordered logit model odds ratio
# summary(ologit)
# Ordered logit predicted probabilities
# xmeans <- colMeans(X)
# newdata1 <- data.frame(t(xmeans))
predictFitted <- predict(ologit, newdata=myDataFrame, type="fitted.ind")
colMeans(predictFitted)
