# env var
gDriveHome <- gsub("\\\\", "/", Sys.getenv("GDrive"));
write(paste0(c("Environment.....\t", gDriveHome), sep = "", collapse = ""), stdout());
# shared folder
gDriveFolder <- "MiApp";
write(paste0(c("Folder..........\t", gDriveFolder), sep = "", collapse = ""), stdout());
# solution
gDriveSolution <- "Kinito.Revolution";
write(paste0(c("Solution........\t", gDriveSolution), sep = "", collapse = ""), stdout());
# project
gDriveProject <- "JoGEA.WorldBank";
write(paste0(c("Project.........\t", gDriveProject), sep = "", collapse = ""), stdout());
# namespace
gDriveNamespace <- paste0(c(gDriveSolution, gDriveProject), sep = "", collapse = ".");
write(paste0(c("Namespace.......\t", gDriveNamespace), sep = "", collapse = ""), stdout());
# common
gDriveCommon <- "RCommon";
write(paste0(c("Common..........\t", gDriveCommon), sep = "", collapse = ""), stdout());
# path
gDriveList <- c(gDriveHome, gDriveFolder, gDriveSolution, gDriveProject); #, "Data");
#, gDriveSpace);
gDrivePath <- paste0(gDriveList, sep = "/", collapse = "");
write(paste0(c("Path old........\t", getwd()), sep = "", collapse = ""), stderr());
write(paste0(c("Path new........\t", gDrivePath), sep = "", collapse = ""), stdout());
setwd(gDrivePath);
#doc
gDriveDoc <- paste0(c(gDrivePath, "Doc"), sep = "/", collapse = "");
write(paste0(c("Doc folder......\t", gDriveDoc), sep = "", collapse = ""), stdout());
#lib
gDriveLib <- paste0(c(gDrivePath, "Lib"), sep = "/", collapse = "");
write(paste0(c("Lib folder......\t", gDriveLib), sep = "", collapse = ""), stdout());
# util
gDriveUtil <- paste0(c("Lib/", gDriveProject, ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util.......\t", gDriveUtil), sep = "", collapse = ""), stdout());
source(gDriveUtil);
###
# Main Program
###
wDir <- "Data/";
# Name of input file with country and region codes
fName <- "wbreg.csv";
# Output file name
bpName <- "gdppcBoxPlot";
# Type of output for box plot (valid options are PDF, WMF, JPG)
fType <- "pdf";
#  Threshold for dropping growth rates (in percent)
dropThresholdPercent <- 10.1;
# END OF USER SECTION
#  Initialize files
fName <- paste(wDir, fName, sep="");
bpName <- paste(wDir, bpName, sep="");
fType <- toupper(fType);
#  Load the WDI library
library(WDI);
# Read the countries/regions to analyze
# myCountryCodes <- read.csv(fName, sep=",", header=TRUE, na.strings="")
myCountryCodes <- ReadContrastMatrix(fName);
head(myCountryCodes);
nrow(myCountryCodes);
typeof(myCountryCodes);class(myCountryCodes);
#  Get the codes for the myCountryCodes regions
# myCountryFrecuencies <- as.data.frame(lapply(myCountryCodes, function(x) (table(x)))[4])
myCountryFrecuencies <- GetFrecuencyListOnColumn(myCountryCodes);
head(myCountryFrecuencies);
nrow(myCountryFrecuencies);
typeof(myCountryFrecuencies);class(myCountryFrecuencies);
#  Get the number of WB regions
myCountryFrecuencyCount <- nrow(myCountryFrecuencies);
#  Get the greatest number of countries in any given region
myCountryMaxFrecuency <- max(myCountryFrecuencies$WBREG.Freq);
#  Get the maximum number of growth episodes for any region
# First year
fromYear <- 1960;
# Final year
upToYear <- 2014;
#  Growth interval (in years)
growthIntervalInYears <- 10;
# WDI Indicator total population     --------- http://data.worldbank.org/indicator/SP.POP.TOTL
indTotalPop <- "sp.pop.totl";
# WDI indicator GDP at market prices --------- http://data.worldbank.org/indicator/ny.gdp.mktp.kd
indGdpPriceMar <- "ny.gdp.mktp.kd";
# myCountryMaxSpan <- myCountryMaxFrecuency * (upToYear - fromYear - growthIntervalInYears + 2);
myCountryMaxSpan <- GetMaxSpanFromFrequency(fromIntYear = fromYear,
                                            upToIntYear = upToYear,
                                            intervalIntYears = growthIntervalInYears,
                                            maximalFrequency = myCountryMaxFrecuency);
#  Initialize the data vectors for the growth rate estimations
yVectorDouble <- GetDoubleVector(growthIntervalInYears);
xVectorDouble <- GetDoubleVector(growthIntervalInYears);
#  Loop over all WB regions
for(regionCounter in 1:myCountryFrecuencyCount){
  #myCountryCodesFactor <- GetISO2Codes(myCountryCodes, regionCounter, myCountryFrecuencies);
  #regionFactor <- myCountryFrecuencies[regionCounter,1];
  # Get the country ISO-2 codes for this region and get the number of countries
  # iso2List <- myCountryCodes[myCountryCodes$WBREG == regionFactor,3];
  # iso2List <- myCountryCodes[myCountryCodesFactor == regionFactor,3];
  iso2List <- GetISO2FromCountryCodes(myCountryCodes, regionCounter, myCountryFrecuencies);
  # Get the number of countries for this region
  iso2Count <- length(iso2List);
  print(paste0("RegionCounter:", regionCounter, "|",
               as.character(myCountryFrecuencies[regionCounter,1]), "_", iso2Count));
  # Extract the data from WDI
  regionTotalPop <- WDI(indicator = indTotalPop, country = iso2List, start = fromYear, end = upToYear);
  regionGdpPriceMar <- WDI(indicator = indGdpPriceMar, country = iso2List, start = fromYear, end = upToYear);
  # Initialize the growth episode vector
  # growthRateVector <- vector(mode = "double", length = myCountryMaxSpan);
  growthRateVector <- GetDoubleVector(myCountryMaxSpan);
  growthRateVector <- NA;
  smpl <- 0;
  # Loop over each iso2-country in this region
  for(iso2Country in 1:iso2Count) {
    # Extract the data for this country from the regional database without column 'country'
    #countryTotalPop <- regionTotalPop[regionTotalPop$iso2c == iso2List[iso2Country], c("iso2c", indTotalPop, "year")];
    countryTotalPop <- regionTotalPop[regionTotalPop$iso2c == iso2List[iso2Country], -which(colnames(regionTotalPop) %in% "country")];
    #countryGdpPriceMar <- regionGdpPriceMar[regionGdpPriceMar$iso2c == iso2List[iso2Country], c("iso2c", indGdpPriceMar, "year")];
    countryGdpPriceMar <- regionGdpPriceMar[regionGdpPriceMar$iso2c == iso2List[iso2Country], -which(colnames(regionTotalPop) %in% "country")];
    # Sort the data by year
    countryTotalPop <- countryTotalPop[order(countryTotalPop$year),];
    countryGdpPriceMar <- countryGdpPriceMar[order(countryGdpPriceMar$year),];
    # Calculate country per capita GDP
    countryGDPPerCapita <- countryGdpPriceMar[,2] / countryTotalPop[,2];
    # Calculate length of this vector
    countryMaxYears <- length(countryGDPPerCapita);
    # For every available growth episode of size growthIntervalInYears, calculate the growth rate using OLS
    print(paste0("for[", growthIntervalInYears, ",", countryMaxYears, "]"));
    for(intervalInYears in growthIntervalInYears:countryMaxYears) {
      minus9 <- intervalInYears - growthIntervalInYears + 1;
      minus0 <- intervalInYears;
      print(paste0("forfor[", minus0, ",", minus9, "]"));
      # Fill the xVectorDouble and yVectorDouble vectors for OLS
      i <- 0;
      for(yearCounter in minus9:minus0) {
        if(!is.na(countryGDPPerCapita[yearCounter])) {
          i <- i + 1;
          yVectorDouble[i] <- log(countryGDPPerCapita[yearCounter]);
          xVectorDouble[i] <- i;
        }
      }
      # Calculate the growth rate if we have a full vector
      if(i == growthIntervalInYears){
        # Do the regression and extract the growth rate
        growthRate <- 100 * coef(lm(yVectorDouble ~ xVectorDouble))[2];
        # Only use this growth episode if growth is below the dropThresholdPercent in absolute terms
        if(abs(growthRate) <= dropThresholdPercent) {
          smpl <- smpl + 1;
          growthRateVector[smpl] <- growthRate;
        }
      }
    }
  }
  #  Set the name for this region and append the number of growth episodes
  regionName <- paste(toString(myCountryFrecuencies[regionCounter,1]),"(",smpl,")",sep="");
  #  To concatenate the vectors, they have to be of identical length. Fill out the vector with NA
  s1 <- smpl + 1;
  for(z in s1:myCountryMaxSpan) {
    growthRateVector[z] <- NA;
  }
  if(regionCounter == 1) {
    result <- cbind(growthRateVector);
  }
  else {
    result <- cbind(result,growthRateVector);
  }
  colnames(result)[regionCounter] <- regionName;
}
# # #  Create the boxplot
# # # if (fType == "PDF") {
# # #   pdf(paste(bpName, ".pdf", sep=""), height=6.5, width=9)
# # # } else if(fType == "WMF") {
# # #   win.metafile(paste(bpName, ".wmf", sep=""), height=5.5, width=8.5)
# # # } else if (fType == "JPG") {
# # #   jpeg(paste(bpName, ".jpg", sep=""), height=480, width=580)
# # # } else {
# # #   stop(paste("Wrong file type <", ftype, ">", sep=""))
# # # }
#  Create the box plot
par(cex.axis=0.75, las=1)
boxplot(result, medcol="red", col="lightgreen",ylab="Per capita growth, percent")
grid(nx=NA, ny=NULL, col="lightgray", lty=1, lwd=1)
#dev.off()
