# Time Series Plotting
library(ggplot2);
library(xts);
library(dygraphs);

# Get IBM and Linkedin stock data from Yahoo Finance
ibm_url <- "http://real-chart.finance.yahoo.com/table.csv?s=IBM&a=07&b=24&c=2010&d=07&e=24&f=2015&g=d&ignore=.csv";
lnkd_url <- "http://real-chart.finance.yahoo.com/table.csv?s=LNKD&a=07&b=24&c=2010&d=07&e=24&f=2015&g=d&ignore=.csv";

FetchYahooStockCsvURL <- function(url){
  dat <- read.table(url,header=TRUE,sep=",");
  df <- dat[,c(1,5)];
  df$Date <- as.Date(as.character(df$Date));
  return(df);
}

ibm  <- FetchYahooStockCsvURL(ibm_url);
lnkd <- FetchYahooStockCsvURL(lnkd_url);
ggplot(ibm,aes(Date,Close)) + 
  geom_line(aes(color="ibm")) +
  geom_line(data=lnkd,aes(color="lnkd")) +
  labs(color="Legend") +
  scale_colour_manual("", breaks = c("ibm", "lnkd"), values = c("blue", "brown")) +
  ggtitle("Closing Stock Prices: IBM & Linkedin") + 
  theme(plot.title = element_text(lineheight=.7, face="bold"));
