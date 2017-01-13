# import library fpp
source("Lib/ImportFpp.R");
# import library forecast
source("Lib/ImportForecast.R");
# import library fracdiff
source("Lib/ImportFracdiff.R");
#' Title CsvToDataFrame
#'
#' @param filePath 
#'
#' @return a data.frame
CsvToDataFrame <- function(filePath){
  if (missing(filePath)){
    stop("filePath is missing");
  }
  write(paste0(c("CsvToDataFrame\t\t", filePath), sep = "", collapse = ""), stdout());
  dataFrame <- read.csv(filepath);
  return(dataFrame);
}
#' Title DataFrameNoFactor
#'
#' @param dataFrame 
#'
#' @return a data.fram without column "factor"
DataFrameNoFactor <- function(dataFrame){
  if (missing(dataFrame)){
    stop("dataFrame is missing");
  }
  write(paste0(c("DataFrameNoFactor\t", ncol(dataFrame)), sep = "", collapse = ""), stdout());
  myIndex <- 0;
  for(i in 1:ncol(dataFrame))
  {
    boo <- class(dataFrame[,i]) == "factor";
    if (boo) myIndex <- i;
  }
  return(dataFrame[,-myIndex]);
}
#' Title DataFrameNoFactorToTimeSeries
#'
#' @param dataFrameNoFactor 
#' @param startYear 
#'
#' @return a time sieri ts no factor
DataFrameNoFactorToTimeSeries <- function(dataFrameNoFactor, startYear=1945){
  if (missing(dataFrameNoFactor)){
    stop("dataFrameNoFactor is missing");
  }
  if (missing(startYear)){
    stop("startYear is missing");
  }
  timeSerieNoFactor <- ts(dataFrameNoFactor, start=startYear, frequency=4);
  return(timeSerieNoFactor);
}
#' Title PlotTsNoFactor
#'
#' @param tsNoFactor 
#' @param tsNoFactorTitle 
#' @param tsNoFactorPath
PlotTsNoFactor <- function(tsNoFactor, tsNoFactorTitle, tsNoFactorPath){
  if (missing(tsNoFactor)){
    stop("tsNoFactor is missing");
  }
  if (missing(tsNoFactorTitle)){
    stop("tsNoFactorTitle is missing");
  }
  if (missing(tsNoFactorPath)){
    stop("tsNoFactorPath is missing");
  }
  png(filename = tsNoFactorPath,
      width    = 2*length(tsNoFactor),
      height   = 150*ncol(tsNoFactor),
      units    = "px",
      bg       = "transparent");
  plot(tsNoFactor, main=tsNoFactorTitle);
  dev.off();
}
#' Title BoxplotTsNoFactor
#'
#' @param tsNoFactor 
#' @param tsNoFactorTitle 
#' @param boxplotPath
BoxplotTsNoFactor <- function(tsNoFactor, tsNoFactorTitle, boxplotPath){
  if (missing(tsNoFactor)){
    stop("tsNoFactor is missing");
  }
  if (missing(tsNoFactorTitle)){
    stop("tsNoFactorTitle is missing");
  }
  if (missing(boxplotPath)){
    stop("boxplotPath is missing");
  }
  png(filename = boxplotPath,
      width    = 2*length(tsNoFactor),
      height   = 150*ncol(tsNoFactor),
      units    = "px",
      bg       = "transparent");
  boxplot(tsNoFactor, main=tsNoFactorTitle, col=colorRampPalette(c('green','yellow','brown'))(3), outline=FALSE);
  dev.off();
}
#' Title SeasonplotTsNoFactor
#'
#' @param tsNoFactor 
#' @param tsNoFactorTitle
#' @param titleY 
#' @param seasonplotPath
SeasonplotTsNoFactor <- function(tsNoFactor, tsNoFactorTitle, titleY, seasonplotPath){
  if (missing(tsNoFactor)){
    stop("tsNoFactor is missing");
  }
  if (missing(tsNoFactorTitle)){
    stop("tsNoFactorTitle is missing");
  }
  if (missing(titleY)){
    stop("titleY is missing");
  }
  if (missing(seasonplotPath)){
    stop("tsNoFactorPath is missing");
  }
  colNumber <- ncol(tsNoFactor);
  if (is.null(colNumber)) colNumber=2;
  png(filename = seasonplotPath,
      width    = 3*length(tsNoFactor),
      height   = 150*colNumber,
      units    = "px",
      bg       = "transparent");
  seasonplot(tsNoFactor, main=tsNoFactorTitle, ylab=titleY);
  dev.off();
}
#' Title MonthplotTsNoFactor
#'
#' @param tsNoFactor 
#' @param tsNoFactorTitle 
#' @param titleY 
#' @param monthPath
MonthplotTsNoFactor <- function(tsNoFactor, tsNoFactorTitle, titleY="", monthPath){
  if (missing(tsNoFactor)){
    stop("tsNoFactor is missing");
  }
  if (missing(tsNoFactorTitle)){
    stop("tsNoFactorTitle is missing");
  }
  if (missing(titleY)){
    stop("titleY is missing");
  }
  if (missing(monthPath)){
    stop("tsNoFactorPath is missing");
  }
  colNumber <- ncol(tsNoFactor);
  if (is.null(colNumber)) colNumber<-2;
  png(filename = monthPath,
      width    = 3*length(tsNoFactor),
      height   = 150*colNumber,
      units    = "px",
      bg       = "transparent");
  monthplot(tsNoFactor, main=tsNoFactorTitle, ylab=titleY);
  dev.off();
}
#' Title PairsplotTsNoFactor
#'
#' @param tsNoFactor 
#' @param pairsPath
PairsplotTsNoFactor <- function(tsNoFactor, pairsPath){
  if (missing(tsNoFactor)){
    stop("tsNoFactor is missing");
  }
  if (missing(pairsPath)){
    stop("pairsPath is missing");
  }
  png(filename = pairsPath,
      width    = 2*length(tsNoFactor),
      height   = 150*ncol(tsNoFactor),
      units    = "px",
      bg       = "transparent");
  pairs(as.data.frame(tsNoFactor));
  dev.off();
}
#' Title HistogramTsNoFactor
#'
#' @param tsNoFactor 
#' @param histTitle 
#' @param titleX 
#' @param histPath
HistogramTsNoFactor <- function(tsNoFactor, histTitle, titleX, histPath){
  if (missing(tsNoFactor)){
    stop("tsNoFactor is missing");
  }
  if (missing(histTitle)){
    stop("histTitle is missing");
  }
  if (missing(titleX)){
    stop("titleX is missing");
  }
  if (missing(histPath)){
    stop("histPath is missing");
  }
  colNumber <- ncol(tsNoFactor);
  if (is.null(colNumber)) colNumber<-2;
  png(filename = histPath,
      width    = 3*length(tsNoFactor),
      height   = 150*colNumber,
      units    = "px",
      bg       = "transparent");
  hist(tsNoFactor, col="lightgreen", freq=FALSE, main=histTitle, xlab=titleX);
  curve(dnorm(x, mean=mean(tsNoFactor), sd=sd(tsNoFactor)), add=TRUE, col="darkblue", lwd=2);
  dev.off();
}
#' Title TimeSerieNoFactorToETS
#'
#' @param timeSerie 
#'
#' @return ets object from time serie
TimeSerieNoFactorToETS <- function(timeSerier=ts()){
  if (missing(timeSerier)){
    stop("timeSerier is missing");
  }
  return(ets(timeSerier));
}
#' Title TimeSerieNoFactorToAutoArima
#'
#' @param timeSerier 
#'
#' @return auto arima from time serie
TimeSerieNoFactorToAutoArima <- function(timeSerier=ts()){
  if (missing(timeSerier)){
    stop("timeSerier is missing");
  }
  return(auto.arima(timeSerier));
}
#' Title TimeSerieNoFactorToArfima
#'
#' @param timeSerier 
#'
#' @return arfima from time serie
TimeSerieNoFactorToArfima <- function(timeSerier=ts()){
  if (missing(timeSerier)){
    stop("timeSerier is missing");
  }
  return(arfima(timeSerier));
}
#' Title TimeSerieNoFactorToSTLM
#'
#' @param timeSerier 
#'
#' @return STLM from time serie
TimeSerieNoFactorToSTLM <- function(timeSerier=ts()){
  if (missing(timeSerier)){
    stop("timeSerier is missing");
  }
  return(stlm(timeSerier, modelfunction=ar));
}
#' Title TimeSerieNoFactorToSTL
#'
#' @param timeSerier 
#'
#' @return STL window priodic from time serie
TimeSerieNoFactorToSTL <- function(timeSerier=ts()){
  if (missing(timeSerier)){
    stop("timeSerier is missing");
  }
  return(stl(timeSerier,s.window = "periodic"));
}
#' Title TimeSerieNoFactorToTbats
#'
#' @param timeSerier 
#'
#' @return Tbats from time serie
TimeSerieNoFactorToTbats <- function(timeSerier=ts()){
  if (missing(timeSerier)){
    stop("timeSerier is missing");
  }
  return(tbats(timeSerier, use.parallel=FALSE));
}
#' Title ETSToForecast
#'
#' @param etser 
#'
#' @return forecast object from ETS
ETSToForecast <- function(etser=ets()){
  if (missing(etser)){
    stop("etser is missing");
  }
  return(forecast(etser, h=16));
}
#' Title AutoArimaToForecast
#'
#' @param autoArimaer 
#'
#' @return forecast from auto arima
AutoArimaToForecast <- function(autoArimaer=auto.arima()){
  if (missing(autoArimaer)){
    stop("autoArimaer is missing");
  }
  return(forecast(autoArimaer, h=16));
}
#' Title ArfimaToForecast
#'
#' @param arfimaer 
#'
#' @return forecast from arfima
ArfimaToForecast <- function(arfimaer=arfima()){
  if (missing(arfimaer)){
    stop("arfimaer is missing");
  }
  return(forecast(arfimaer, h=16));
}
#' Title STLMToForecast
#'
#' @param stlmer 
#'
#' @return forecast from STLM
STLMToForecast <- function(stlmer=stlm()){
  if (missing(stlmer)){
    stop("stlmer is missing");
  }
  return(forecast(stlmer, h=16));
}
#' Title STLToForecast
#'
#' @param stler 
#'
#' @return forecast from STL
STLToForecast <- function(stler=stl()){
  return(forecast(stler, h=16));
}
#' Title TbatsToForecast
#'
#' @param tbatser 
#'
#' @return forecast from Tbats
TbatsToForecast <- function(tbatser=tbats()){
  if (missing(tbatser)){
    stop("tbatser is missing");
  }
  return(forecast(tbatser, h=16));
}
#' Title PlotForecast
#'
#' @param forecaster 
#' @param forecastPath
PlotForecast <- function(subject="", forecaster=forecast(), forecastPath){
  if (missing(forecaster)){
    stop("forecaster is missing");
  }
  if (missing(forecastPath)){
    stop("forecastPath is missing");
  }
  xLength <- length(forecaster$mean);
  yLength <- length(forecaster);
  forecastTitle <- paste0(c(subject, " Forecast from ", forecaster$method), sep = "", collapse = "");
  png(filename = forecastPath,
      #width    = 10*xLength,
      #height   = 150*yLength,
      units    = "px",
      bg       = "transparent");
  plot(forecaster, main=forecastTitle);
  dev.off();
}