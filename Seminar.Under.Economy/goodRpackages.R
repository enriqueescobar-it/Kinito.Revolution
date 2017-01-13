

library(jsonlite)
library(ggplot2)
 
# Read in package data as JSON file and form into a data frame
json_file <- "https://mran.revolutionanalytics.com/packagedata/allpackages.json"
json_data <- as.data.frame(fromJSON(paste(readLines(json_file),collapse="")))
json_data <- tibble::as_data_frame(json_data)
dF <- json_data[,c(1,2,6,7)]
names(dF) <- c("Name","Date","Task_View","Vignettes")
dF$Vignettes <- ifelse(is.na(dF$Vignettes)==TRUE,0,dF$Vignettes)
dF$Task_View <- ifelse(is.na(dF$Task_View)==TRUE,"None",dF$Task_View)
head(dF)
 
# Look at some summary statistics
summary(dF$Vignettes)
table(dF$Vignettes)
 
# Find number of vignettes
have_vig <- sum(dF$Vignettes>0)
have_vig #1961
 
pct_vig <- have_vig / length(dF$Vignettes)
pct_vig #0.2353859
 
# Find package with >= 10 Task Views
dF[dF$Vignettes>=10,] 
 
# Modify data frame for printing
dF10 <- dF[dF$Vignettes>=10, -3]
row.names(dF10) <- NULL
dF10
 
# Plot histogram
p <- ggplot(dF, aes(x=Vignettes))
p + geom_histogram(binwidth=1) +
  ggtitle("The sad tale but long tail of vignettes")
 
# Find number of packages in task views
have_TV <- dF[dF$Task_View!="None",]
pct_TV <- dim(have_TV)[1] / length(dF$Vignettes)
pct_TV #0.2724763

