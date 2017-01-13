#env var
gDriveHome <- gsub("\\\\", "/", Sys.getenv("GDrive"));
#shared folder
gDriveFolder <- "MiApp";
#namespace
gDriveProject <- "Kinito.Revolution";
write(paste0(c("Namespace........\t", gDriveProject), sep = "", collapse = ""), stdout());
#environment
gDriveSpace <- "RobjHyndman.Hyndsight.MelburnTalk";
#path
write(paste0(c("Environment......\t", gDriveSpace), sep = "", collapse = ""), stdout());
gDriveList <- c(gDriveHome, gDriveFolder, gDriveProject, gDriveSpace);
gDrivePath <- paste0(gDriveList, sep = "/", collapse = "");
write(paste0(c("Path old.........\t", getwd()), sep = "", collapse = ""), stderr());
setwd(gDrivePath);
write(paste0(c("Path.............\t", getwd()), sep = "", collapse = ""), stdout());
#doc
gDriveDoc <- paste0(c(gDriveSpace, "Doc"), sep = "/", collapse = "");
write(paste0(c("Doc folder.......\t", gDriveDoc), sep = "", collapse = ""), stdout());
#lib
gDriveLib <- paste0(c(gDriveSpace, "Lib"), sep = "/", collapse = "");
write(paste0(c("Lib folder.......\t", gDriveLib), sep = "", collapse = ""), stdout());
#
#
#
#
#util
gDriveUtil <- paste0(c("Lib/", gDriveSpace, ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", gDriveUtil), sep = "", collapse = ""), stdout());
source(gDriveUtil);
### file to forecast
filehandle <- "tute1";
# data.frame
filepath <- paste0(c(gDrivePath, "Doc/", filehandle, ".csv"), sep = "", collapse = "");
aDataFrame <- CsvToDataFrame(filepath);
head(aDataFrame,1);
aDataFrameNoFactor <- DataFrameNoFactor(aDataFrame);
aTimeSerieNoFactor <- DataFrameNoFactorToTimeSeries(aDataFrameNoFactor, 1980);
# to TsNoFactor.png
aTsNoFactorPath <- gsub("csv", "TsNoFactor.png", filepath);
PlotTsNoFactor(aTimeSerieNoFactor, "A Time Serie No Factor plot", aTsNoFactorPath);
#timeseries plot Sales ~ AdBudget
salesVsAdBudgetPath <- gsub("csv", "plot.SalesVsAdBudget.png", filepath);
png(filename = salesVsAdBudgetPath,
    width    = 2*length(aTimeSerieNoFactor),
    height   = 150*ncol(aTimeSerieNoFactor),
    units    = "px",
    bg       = "transparent");
plot(Sales ~ AdBudget, main="Sales Vs AdBudget", data=aTimeSerieNoFactor);
dev.off();
#timeseries plot Sales ~ GDP
salesVsGDPPath <- gsub("csv", "plot.SalesVsGDP.png", filepath);
png(filename = salesVsGDPPath,
    width    = 2*length(aTimeSerieNoFactor),
    height   = 150*ncol(aTimeSerieNoFactor),
    units    = "px",
    bg       = "transparent");
plot(Sales ~ GDP, main="Sales Vs GDP", data=aTimeSerieNoFactor);
dev.off();
#timeseries boxplot
boxplotPath <- gsub("csv", "boxplot.png", filepath);
BoxplotTsNoFactor(aTimeSerieNoFactor, "A Time Serie No Factor boxplot", boxplotPath);
#colnames
colNames <- colnames(aTimeSerieNoFactor);
#timeseries histograms
for (i in 1:length(colNames))
{
  histTitle <- paste0(c(colNames[i], " histogram"), sep = "", collapse = "");
  histPath <- paste0(c("histogram.", colNames[i], ".png"), sep = "", collapse = "");
  histPath <- gsub("csv", histPath, filepath);
  HistogramTsNoFactor(aTimeSerieNoFactor[,colNames[i]], histTitle, colNames[i], histPath);
  write(histPath, stdout());
}
#timeseries seasonplot
seasonplotPath <- gsub("csv", "seasonplot.png", filepath);
SeasonplotTsNoFactor(aTimeSerieNoFactor, "Seasonplot", "All", seasonplotPath);
for (i in 1:length(colNames))
{
  seasonTitle <- paste0(c(colNames[i], " seasonplot"), sep = "", collapse = "");
  seasonPath <- paste0(c("seasonplot.", colNames[i], ".png"), sep = "", collapse = "");
  seasonPath <- gsub("csv", seasonPath, filepath);
  SeasonplotTsNoFactor(aTimeSerieNoFactor[,colNames[i]], seasonTitle, colNames[i], seasonPath);
  write(seasonPath, stdout());
}
#timeseries monthplot
for (i in 1:length(colNames))
{
  monthTitle <- paste0(c(colNames[i], " monthplot"), sep = "", collapse = "");
  monthPath <- paste0(c("monthplot.", colNames[i], ".png"), sep = "", collapse = "");
  monthPath <- gsub("csv", monthPath, filepath);
  MonthplotTsNoFactor(aTimeSerieNoFactor[,colNames[i]], monthTitle, colNames[i], monthPath);
  write(monthPath, stdout());
}
#timeseries corrrelation test
cor.test(aTimeSerieNoFactor[,"Sales"],aTimeSerieNoFactor[,"AdBudget"]);
#timeseries pairs
pairsPath <- gsub("csv", "pairsplot.png", filepath);
PairsplotTsNoFactor(aTimeSerieNoFactor, pairsPath);
# ETS forecasts
for (i in 1:length(colNames))
{
  etsFromTimeSerieNoFactor <- TimeSerieNoFactorToETS(aTimeSerieNoFactor[,colNames[i]]);
  aForecast <- ETSToForecast(etsFromTimeSerieNoFactor);
  aForecastPath <- paste0(c("forecast.", colNames[i], ".png"), sep = "", collapse = "");
  aForecastPath <- gsub("csv", aForecastPath, filepath);
  PlotForecast(colNames[i], aForecast, aForecastPath);
  print(aForecastPath);
}
# Automatic ARIMA forecasts
for (i in 1:length(colNames)){
  autoArimaFromTimeSerieNoFactor <- TimeSerieNoFactorToAutoArima(aTimeSerieNoFactor[,colNames[i]]);
  aForecast <- AutoArimaToForecast(autoArimaFromTimeSerieNoFactor);
  aForecastPath <- paste0(c("autoarima.forecast.", colNames[i], ".png"), sep = "", collapse = "");
  aForecastPath <- gsub("csv", aForecastPath, filepath);
  PlotForecast(colNames[i], aForecast, aForecastPath);
  print(aForecastPath);
}
# ARFIMA forecasts
for (i in 1:length(colNames)){
  arfimaFromTimeSerieNoFactor <- TimeSerieNoFactorToArfima(aTimeSerieNoFactor[,colNames[i]]);
  aForecast <- ArfimaToForecast(arfimaFromTimeSerieNoFactor);
  aForecastPath <- paste0(c("arfima.forecast.", colNames[i], ".png"), sep = "", collapse = "");
  aForecastPath <- gsub("csv", aForecastPath, filepath);
  PlotForecast(colNames[i], aForecast, aForecastPath);
  print(aForecastPath);
}
# STL Forecast
for (i in 1:length(colNames)){
  stlmFromTimeSerieNoFactor <- TimeSerieNoFactorToSTLM(aTimeSerieNoFactor[,colNames[i]]);
  aForecast <- STLMToForecast(stlmFromTimeSerieNoFactor);
  aForecastPath <- paste0(c("stlm.forecast.", colNames[i], ".png"), sep = "", collapse = "");
  aForecastPath <- gsub("csv", aForecastPath, filepath);
  PlotForecast(colNames[i], aForecast, aForecastPath);
  print(aForecastPath);
  #plot(stlf(stlFromTimeSerieNoFactor));
  #plot(stlf(stlFromTimeSerieNoFactor, lambda=0));
  stlFromTimeSerieNoFactor <- TimeSerieNoFactorToSTL(aTimeSerieNoFactor[,colNames[i]]);
  aForecast <- STLToForecast(stlFromTimeSerieNoFactor);
  aForecastPath <- paste0(c("stl.periodic.forecast.", colNames[i], ".png"), sep = "", collapse = "");
  aForecastPath <- gsub("csv", aForecastPath, filepath);
  PlotForecast(colNames[i], aForecast, aForecastPath);
  print(aForecastPath);
}
# TBATS forecast
for (i in 1:length(colNames)){
  tbatsFromTimeSerieNoFactor <- TimeSerieNoFactorToTbats(aTimeSerieNoFactor[,colNames[i]]);
  aForecast <- TbatsToForecast(tbatsFromTimeSerieNoFactor);
  aForecastPath <- paste0(c("tbats.forecast.", colNames[i], ".png"), sep = "", collapse = "");
  aForecastPath <- gsub("csv", aForecastPath, filepath);
  PlotForecast(colNames[i], aForecast, aForecastPath);
  print(aForecastPath);
}

