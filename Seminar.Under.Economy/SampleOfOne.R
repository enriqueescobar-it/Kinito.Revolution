#util
gDriveUtil <- paste0(c("Lib/", "SampleOfOne", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", gDriveUtil), sep = "", collapse = ""), stdout());
source(gDriveUtil);

#util
gDriveUtil <- paste0(c("Lib/", "ggplot2", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", gDriveUtil), sep = "", collapse = ""), stdout());
source(gDriveUtil);

# constants
probs <- c(0.01, 0.02, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.98, 0.99);

# data
aData <- as.data.frame(seq(1, 20, by=1));
colnames(aData) <- "SequenceList";
head(aData);
aData <- tibble::as_data_frame(aData);
head(aData);
aDataVariance <- var(aData);
aDataVariance;
summary(aData);
# data plot
plot(aData);
# Z Test
aData[1:15,];
z <- sqrt(15) *
  (mean(aData[1:15,]$SequenceList)-0)/
  sd(aData[1:15,]$SequenceList);
z;
2 * pnorm(-abs(z),0,1) > 0.05;

# data
scoreList <- tibble::as_data_frame(read.csv("Doc/Variance-scores.txt"));
head(scoreList);
aData <- scoreList$Score;
aDataMean <- mean(aData);
aDataSD <- sd(aData);
aDataVariance <- var(aData);
aDataVariance;
summary(aData);
# data plot
QplotFromNumeric(aData);
Ggplot2SmoothedFromScore(scoreList);
# data distribution
Ggplot2DistributionFromScore(scoreList, probs);
# subset
aSubData <- NumericMaxSubset(aData);
aSubDataLength <- length(aSubData);
aSubDataMean <- mean(aSubData);
summary(aSubData);
# T test
aMuZero <- round(mean(aData), digits = 0);
aMuZero;
aTtest <- TTestFromNumeric(aData, aMuZero);
aTtest$method;
aTtest$data.name;
aTtest$statistic;
aTtest$p.value;
aTtest$conf.int;
aTtest$parameter;
aTtest$alternative;
# Z test
z <- sqrt(aSubDataLength) * (aDataMean - aSubDataMean)/ aDataSD;
z;
2 * pnorm(-abs(z),0,1) >= 0.05;

# data
eruptionList <- tibble::as_data_frame(read.csv("Doc/Variance-eruptions.txt", sep=""));
head(eruptionList);
aData <- eruptionList$eruptions;
aDataMean <- mean(aData);
aDataSD <- sd(aData);
aDataVariance <- var(aData);
aDataVariance;
summary(aData);
# data plot
QplotFromNumeric(aData);
Ggplot2SmoothedFromEruption(eruptionList);
# data distribution
Ggplot2DistributionFromEruption(eruptionList, probs);
# subset
aSubData <- NumericMaxSubset(aData);
aSubDataLength <- length(aSubData);
aSubDataMean <- mean(aSubData);
summary(aSubData);
# T test
aMuZero <- round(mean(aData), digits = 0);
aMuZero;
aTtest <- TTestFromNumeric(aData, aMuZero);
aTtest$method;
aTtest$data.name;
aTtest$statistic;
aTtest$p.value;
aTtest$conf.int;
aTtest$parameter;
aTtest$alternative;
# Z test
z <- sqrt(aSubDataLength) * (aDataMean - aSubDataMean)/ aDataSD;
z;
2 * pnorm(-abs(z),0,1) >= 0.05;

# data
lungCapList <- tibble::as_data_frame(read.delim("Doc/LungCapData.txt"));
head(lungCapList);
aData <- lungCapList$LungCap;
aDataMean <- mean(aData);
aDataSD <- sd(aData);
aDataVariance <- var(aData);
aDataVariance;
summary(aData);
# data plot
QplotFromNumeric(aData);
Ggplot2SmoothedFromLungCapacity(lungCapList);
# data distribution
Ggplot2DistributionFromLungCapacity(lungCapList, probs);
# subset
aSubData <- NumericMaxSubset(aData);
aSubDataLength <- length(aSubData);
aSubDataMean <- mean(aSubData);
summary(aSubData);
# T test
aMuZero <- round(mean(aData), digits = 0);
aMuZero;
aTtest <- TTestFromNumeric(aData, aMuZero);
aTtest$method;
aTtest$data.name;
aTtest$statistic;
aTtest$p.value;
aTtest$conf.int;
aTtest$parameter;
aTtest$alternative;
# Z test
z <- sqrt(aSubDataLength) * (aDataMean - aSubDataMean)/ aDataSD;
z;
2 * pnorm(-abs(z),0,1) >= 0.05;

# data
gapMinderList <- tibble::as_data_frame(read.csv("Doc/gapminder.csv"));
head(gapMinderList);
aData <- gapMinderList$lifeExp;
aDataMean <- mean(aData);
aDataSD <- sd(aData);
aDataVariance <- var(aData);
aDataVariance;
summary(aData);
# data plot
QplotFromNumeric(aData);
Ggplot2SmoothedFromGapMinder(gapMinderList);
# data distribution
Ggplot2DistributionFromGapMinder(gapMinderList, probs);
# subset
aSubData <- NumericMaxSubset(aData);
aSubDataLength <- length(aSubData);
aSubDataMean <- mean(aSubData);
summary(aSubData);
# T test
aMuZero <- round(mean(aData), digits = 0);
aMuZero;
aTtest <- TTestFromNumeric(aData, aMuZero);
aTtest$method;
aTtest$data.name;
aTtest$statistic;
aTtest$p.value;
aTtest$conf.int;
aTtest$parameter;
aTtest$alternative;
# Z test
z <- sqrt(aSubDataLength) * (aDataMean - aSubDataMean)/ aDataSD;
z;
2 * pnorm(-abs(z),0,1) >= 0.05;
