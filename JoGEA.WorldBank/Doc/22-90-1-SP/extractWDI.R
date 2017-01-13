# -------------------------------------------------------------------------------------------------
#     Code to extract data series from WDI
#     Code is in two parts -- the first part describes a generic function that extracts
#                             a single indicator, replaces the iso2c codes, and saves to a CSV file
#                             the second part allows the user to set the output filename
#                             and select the relevant indicators
#                             The reason it is done one indicator at a time is that this
#                             appears to be the easiest way to 'vectorize' the incoming data
#     Original code by:       Dominique van der Mensbrugghe
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
#  Define a function for retrieving and saving WDI data (wdi.Retrieve)
# -------------------------------------------------------------------------------------------------
wdi.Retrieve <- function(cName, sName, indName, startYear, endYear, fName, ifAppend, ifName) {
#     Arguments:
#        cName:      List of countries/regions being extracted (could be "all")
#        sName:      Short series name (will be output to CSV file)
#        indName:    Name of WDI indicator
#        startYear:  Beginning year
#        endYear:    End year
#        fName:      Name of output file
#        ifAppend:   FALSE for first record (normally header), otherwise TRUE
#        ifName:     FALSE to delete country name from output, otherwise TRUE
#  Retrieve the indicator
   cube <- WDI(country=cName, indicator=indName, start=startYear, end=endYear)
#  Convert the ISO-2 labels to ISO-3 labels -- requires the countrycode package
   cube$iso3c <- countrycode(cube$iso2c,"iso2c","iso3c")
#  Fix ISO-3 codes for missing countries
   iso2Ndx <- grep('iso2c', colnames(cube))
   iso3Ndx <- grep('iso3c', colnames(cube))
#  !!!! May need to add other countries and/or change ISO-3 codes
   cube[iso3Ndx][cube[iso2Ndx]=='JG']<-"JGY"
   cube[iso3Ndx][cube[iso2Ndx]=='XK']<-"KOS"
#  Delete regions with no iso code
   cube <- cube[!(is.na(cube$iso3c)),]
#  Append the variable name to the dataframe
   cube[,"Var"] <- sName
#   Create the final data frame by re-ordering columns
   if(ifName) {
      cube <- cube[,c("Var", "iso3c", "country", "year", indName)]
   }
   else {
      cube <- cube[,c("Var", "iso3c", "year", indName)]
   }
#  Save the data in CSV format
   write.table(cube, fName, append=ifAppend, row.names=FALSE, col.names=FALSE, na="", sep=",")
}
# -------------------------------------------------------------------------------------------------
#  Main part of WDI extraction
# -------------------------------------------------------------------------------------------------
#  Load the needed libraries (assuming they have been installed on the local machine)
library(WDI);
library(countrycode);
#  Read the command line arguments
args <- commandArgs(TRUE);
if(length(args) < 1) {
  srcFile <- "extractWDI.opt";
} else {
   srcFile <- args[1];
}
#  Get the options from the options file
options <- read.csv(srcFile, stringsAsFactors = FALSE, strip.white=TRUE, quote = "\"'");
#  Get the name of the output file
outFileName <- options[grep("Output file", options$Name),2];
#  Get the beginning year
begYear  <- as.numeric(options[grep("Start year", options$Name),2]);
#  Get the final year
endYear  <- as.numeric(options[grep("End year", options$Name),2]);
#  Flag for header
ifHeader <- as.logical(options[grep("Header", options$Name),2]);
#  Flag for outputting country name
ifName <- as.logical(options[grep("Country name", options$Name),2]);
#  Get the regions -- 'all' is to get all regions, regions should be coded in iso2c
regions  <- options[grep("Regions", options$Name),2];
if(regions != "all") {
   regions <- toupper(regions);
}
# Parse the regions
regions <- strsplit(regions,",");
regions <- c(do.call("cbind",regions));
#  Get the indicators -- assumes input file has no blank lines
row1 <- 8;
row2 <- nrow(options);
indTable <- options[row1:row2,];
#  Get the number of indicators
nInd <- nrow(indTable);
if(ifHeader) {
#  Use header for CSV file
   if(ifName) {
      header <- cbind("Var", "iso3", "regName","Year", "Val");
   }
   else {
      header <- cbind("Var", "iso3", "Year", "Val");
   }
   write.table(header, outFileName, append=FALSE, row.names=FALSE, col.names=FALSE, sep=",");
}
ifAppend <- ifHeader;
#  Loop over all indicators
for (i in 1:nInd) {
#  Get the short and World Bank name for the indicators
   var <- indTable[i,1];
   wbName <- indTable[i,2];
#  Use the function above to retrieve the data, convert iso2 to iso3, drop the
#     regions, and append to the CSV file
   wdi.Retrieve(regions, var, wbName, begYear, endYear, outFileName, ifAppend, ifName);
#  After the first indicator, ifAppend must be TRUE
   ifAppend <- TRUE;
}
