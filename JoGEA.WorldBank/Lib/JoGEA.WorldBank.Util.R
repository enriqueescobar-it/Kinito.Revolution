
library(WDI);

ReadContrastMatrix <- function(filePath=""){
  myDataFrame <- read.csv(filePath, sep=",", header=TRUE, na.strings="");
  head(myDataFrame, 1);
  # myDataFrame <- tibble::as_data_frame(myDataFrame);
  return(myDataFrame);
}

GetFrecuencyListOnColumn <- function(aDataFrame, colNumber = 4){
  if(is.null(aDataFrame)){
    return(NULL);
  }
  aList <- lapply(aDataFrame, function(x) (table(x)))[colNumber];
  # return(tibble::as_data_frame(as.data.frame(aList)));
  return(as.data.frame(aList));
}

GetMaxSpanFromFrequency <- function(fromIntYear = 1960,
                                    upToIntYear = 2014,
                                    intervalIntYears = 10,
                                    maximalFrequency = 54){
  return(maximalFrequency * (upToIntYear - fromIntYear - intervalIntYears + 2));
}

GetDoubleVector <- function(anIntegerSize = 1){
  return(vector(mode = "double", length = anIntegerSize));
}

GetISO2FromCountryCodes <- function(CountryCodes,
                         regionCounter,
                         CountryFrecuencies){
  countryCodesFactor <- CountryCodes$WBREG;
  regionFactor <- CountryFrecuencies[regionCounter,1];
  return(CountryCodes[countryCodesFactor == regionFactor,3]);
}

library(countrycode);
RetreiveWDI <- function(countryList, indicatorWDI, startYear, endYear,
                        shortSeriesName, isRemoved, fileName, isAppended){
  # Retrieve the indicator
  cube <- WDI(country = countryList, indicator = indicatorWDI, start = startYear, end = endYear);
  # Convert the ISO-2 labels to ISO-3 labels
  cube$iso3c <- countrycode(cube$iso2c,"iso2c","iso3c");
  # Fix ISO-3 codes for missing countries
  iso2Ndx <- grep('iso2c', colnames(cube));
  iso3Ndx <- grep('iso3c', colnames(cube));
  # !!!! May need to add other countries and/or change ISO-3 codes
  cube[iso3Ndx][cube[iso2Ndx]=='JG']<-"JGY";
  cube[iso3Ndx][cube[iso2Ndx]=='XK']<-"KOS";
  # Delete regions with no iso code
  cube <- cube[!(is.na(cube$iso3c)),];
  # Append the variable name to the dataframe
  cube[,"Var"] <- shortSeriesName;
  # Create the final data frame by re-ordering columns
  if(isRemoved) {
    cube <- cube[,c("Var", "iso3c", "country", "year", indicatorWDI)];
  }
  else {
    cube <- cube[,c("Var", "iso3c", "year", indicatorWDI)];
  }
  #  Save the data in CSV format
  write.table(cube, fileName, append = isAppended, row.names = FALSE, col.names = FALSE, na = "", sep = ",");
}
