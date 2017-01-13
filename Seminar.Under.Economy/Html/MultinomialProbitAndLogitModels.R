library(mlogit)

myDataFrame<- read.csv("Data/multinomial_fishing1.csv")
head(myDataFrame)
attach(myDataFrame)

# Descriptive statistics
table(mode)

# Reshaping the data from wide to long format
#myDataFrame$mode<-as.factor(myDataFrame$mode)
mlogitData <- mlogit.data(myDataFrame, varying=4:15, choice="mode", shape="wide")
mlogitData[1:20,]

# Multinomial logit model coefficients 
mlogitModelCharter <- mlogit(mode ~ 1 | income,
							data = mlogitData,
							reflevel="charter")
summary(mlogitModelCharter)

# Multinomial logit model coefficients (with different base outcome)
mlogitModelPier <- mlogit(mode ~ 1 | income,
							data = mlogitData,
							reflevel="pier")
summary(mlogitModelPier)
# Multinomial logit model odds ratios 
exp(coef(mlogitModelCharter))

# Conditional logit model
mlogitConditionalModelCharter <- mlogit(mode ~ price+catch | income,
							data = mlogitData,
							reflevel="charter")
summary(mlogitConditionalModelCharter)
mlogitConditionalModelPier <- mlogit(mode ~ price+catch | income,
									data = mlogitData,
									reflevel="pier")
summary(mlogitConditionalModelPier)
# Setting mean values for variables to use for marginal effects 
m <- mlogit(mode ~ price+catch | income,
			data = mlogitData,
			reflevel="charter")
z <- with(mlogitData,
			data.frame(price = tapply(price, index(m)$alt, mean), catch = tapply(catch, index(m)$alt, mean), income = mean(income))
		)
# Multinomial logit model marginal effects
effects(mlogitModelCharter, covariate = "income", data = z)

# Conditional logit model marginal effects
effects(mlogitConditionalModelCharter, covariate = "income", data = z)
effects(mlogitConditionalModelCharter, covariate = "price", data = z)
effects(mlogitConditionalModelCharter, covariate = "catch", data = z)
# Multinomial probit model coefficients 
#mprobit.model1 <- mlogit(mode ~ 1 | income, data = mlogitData, reflevel="charter", probit=TRUE)
#summary(mprobit.model1)
# Hauseman-McFadden test of independence of irrelevant alternatives
mSet <- mlogit(mode ~ 1 | income, data = mlogitData, reflevel="beach")
mSubset <- mlogit(mode ~ 1 | income, data = mlogitData, reflevel="beach", alt.subset=c("beach", "pier", "private"))
hmftest(mSet, mSubset)

