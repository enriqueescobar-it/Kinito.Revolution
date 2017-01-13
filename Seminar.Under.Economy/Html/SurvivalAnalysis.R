library(survival)

myDataFrame<- read.csv("Data/survival_unemployment.csv")
head(myDataFrame)
attach(myDataFrame)

# Define variables 
timeList <- spell
eventList <- event
X <- cbind(logwage, ui, age)
groupList <- ui

# Descriptive statistics
summary(timeList)
summary(eventList)
summary(X)
summary(groupList)

# Kaplan-Meier non-parametric analysis
nonParamKMSurvival <- survfit(Surv(timeList,eventList) ~ 1)
summary(nonParamKMSurvival)
plot(nonParamKMSurvival, xlab="Time", ylab="Survival Probability")

# Kaplan-Meier non-parametric analysis by Group
nonParamKMSurvivalByGroup <- survfit(Surv(timeList, eventList) ~ groupList)
summary(nonParamKMSurvivalByGroup)
plot(nonParamKMSurvivalByGroup, xlab="Time", ylab="Survival Probability")

# Nelson-Aalen non-parametric analysis
nonParamNASurvival <- survfit(coxph(Surv(timeList,eventList)~1), type="aalen")
summary(nonParamNASurvival)
plot(nonParamNASurvival, xlab="Time", ylab="Survival Probability")

# Cox proportional hazard model - coefficients and hazard rates
coxProportionalHazardBreslow <- coxph(Surv(timeList,eventList) ~ X, method="breslow")
summary(coxProportionalHazardBreslow)

# Exponential, Weibull, and log-logistic parametric model coefficients
# Opposite signs from Stata results, Weibull results differ; same as SAS
exponentialSurvival <- survreg(Surv(timeList,eventList) ~ X, dist="exponential")
summary(exponentialSurvival)

weibullSurvival <- survreg(Surv(timeList,eventList) ~ X, dist="weibull")
summary(weibullSurvival)

loglogisticSurvival <- survreg(Surv(timeList,eventList) ~ X, dist="loglogistic")
summary(loglogisticSurvival)
