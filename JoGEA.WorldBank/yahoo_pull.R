# Revision: 2013-01-09 12:34:09 -0600
getYahooStockUrl <- function(symbol, start, end, type="m") {
  # Creates a Yahoo URL for fetching historical stock data
  # Args:
  #   symbol - the stock symbol for which to fetch data
  #   start - the date (CCYY-MM-DD) to start fetching data
  #   end - the date (CCYY-MM-DD) to finish fetching data
  #   type - daily/monthly data indicator ("d" or "m")
  # Returns:
  #   A Yahoo URL string for fetching historical stock data
  start <- as.Date(start);
  end <- as.Date(end);
  url <- "http://ichart.finance.yahoo.com/table.csv?s=%s&a=%d&b=%s&c=%s&d=%d&e=%s&f=%s&g=%s&ignore=.csv";
  yahooStockURL <- sprintf(url,
                  toupper(symbol),
                  as.integer(format(start, "%m")) - 1,
                  format(start, "%d"),
                  format(start, "%Y"),
                  as.integer(format(end, "%m")) - 1,
                  format(end, "%d"),
                  format(end, "%Y"),
                  type);
  return(yahooStockURL);
}

yahooStockData <- read.csv(getYahooStockUrl("sbux", "2008-1-1", "2008-12-31"), stringsAsFactors=FALSE);
sbux.monthly <- yahooStockData[order(yahooStockData$Date), c('Date', 'Adj.Close')];
