myDataFrame <- read.csv("Data/intro_auto.csv")
head(myDataFrame)
attach(myDataFrame)
# List the variables
names(myDataFrame)
# Show first lines of data
head(myDataFrame)
myDataFrame[1:10,]
# Descriptive statistics
summary(mpg)
sd(mpg)
length(mpg)
summary(price)
sd(price)
# Sort the data
sort(make)
# Frequency tables
table(make)
table(make, foreign)
# Correlation among variables
cor(price, mpg)
# T-test for mean of one group
t.test(mpg, mu=20)
# linear model of 2 groups
linearModel <- lm(mpg ~ factor(foreign))
# ANOVA for equality of means for two groups
anova(linearModel)
# OLS regression - mpg (dependent variable) and weight, length and foreign (independent variables)
olsreg <- lm(mpg ~ weight + length + foreign)
summary(olsreg)
# Plotting data
plot (mpg ~ weight)
olsreg1 <- lm(mpg ~ weight)
abline(olsreg1)
# Redefining variables 
Y <- cbind(mpg)
X <- cbind(weight, length, foreign)
summary(Y)
summary(X)
olsreg <- lm(Y ~ X)
summary(olsreg) 
