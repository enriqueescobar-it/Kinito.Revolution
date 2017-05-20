## calling the installed package
library(Rtsne);
## Choose the train.csv file downloaded from the link above "E:/Disk_X/Kinito.Revolution/Algorithm.t-SNE/Data/train.csv"
train <- read.csv(file.choose());
## Curating the database for analysis with both t-SNE and PCA
labelList <- train$label;
train$label <- as.factor(train$label);
## for plotting
colorList = rainbow(length(unique(train$label)));
names(colorList) = unique(train$label);
## Executing the algorithm on curated data
tsne <- Rtsne::Rtsne(train[, -1], dims = 2, perplexity = 30, verbose = TRUE,
                     max_iter = 500);
exeTimeTsne <- system.time(
        Rtsne::Rtsne(train[, -1], dims = 2, perplexity = 30, verbose = TRUE,
                     max_iter = 500));
## Plotting
tsneMainTitle <- "Algorithm t-SNE";
plot(tsne$Y, t = 'n', main = tsneMainTitle);
text(tsne$Y, labels = train$label, col = colorList[train$label]);

