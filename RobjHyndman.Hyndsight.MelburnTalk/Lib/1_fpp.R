setwd("E:/Users/Admin/Google Drive/MiApp/httprobjhyndman.com/hyndsight/melburntalk");
library("fpp");
plot(a10);
#"tute1.csv"
tute1 <- read.csv("../Doc/tute1.csv");
head(tute1);
tail(tute1);
#tute1 col 2=Sales
tute1[,2];
tute1[,"Sales"];
#tute1 lin 1-5
tute1[5,];
#tute1 lin 1-10 col 3-4
tute1[1:10,3:4];
#tute1 col 1-20
tute1[1:20,];
#timeseries
#tute1 col 1 out
tute_1 <- tute1[,-1];
tute_1_ts <- ts(tute_1, start=1981, frequency=4);
summary(tute_1_ts);
plot(tute_1_ts);
#ts plot
plot(Sales ~ AdBudget, data=tute_1_ts);
plot(Sales ~ GDP, data=tute_1_ts);
#ts hist
hist(tute_1_ts[,"Sales"]);
hist(tute_1_ts[,"AdBudget"]);
#ts boxplot
boxplot(tute_1_ts[,"Sales"]);
boxplot(tute_1_ts[,"AdBudget"]);
boxplot(as.data.frame(tute_1_ts));
#ts season
seasonplot(tute_1_ts[,"Sales"]);
seasonplot(tute_1_ts[,"AdBudget"]);
seasonplot(tute_1_ts[,"GDP"]);
seasonplot(tute_1_ts);
#ts monthplot
monthplot(tute_1_ts[,"Sales"]);
monthplot(tute_1_ts[,"AdBudget"]);
monthplot(tute_1_ts[,"GDP"]);
#ts cor
cor.test(tute_1_ts[,"Sales"],tute_1_ts[,"AdBudget"]);
#ts pairs
pairs(as.data.frame(tute_1_ts));
