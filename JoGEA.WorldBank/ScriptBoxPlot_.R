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
wDir <- "Data/"
# Name of input file with country and region codes
fName <- "wbreg.csv"
# Output file name
bpName <- "gdppcBoxPlot"
# Type of output for box plot (valid options are PDF, WMF, JPG)
fType <- "pdf"
# First year
fromYear <- 1960
# Final year
upToYear <- 2014
#  Growth interval (in years)
growthIntervalInYears <- 10
#  Threshold for dropping growth rates (in percent)
dropThresholdPercent <- 10.1
# END OF USER SECTION
#  Initialize files
fName <- paste(wDir, fName, sep="")
bpName <- paste(wDir, bpName, sep="")
fType <- toupper(fType)
#  Load the WDI library
library(WDI)
# Read the countries/regions to analyze
myCountryCodes <- read.csv(fName, sep=",", header=TRUE, na.strings="")
# myCountryCodes <- ReadContrastMatrix(fName);
#  Get the codes for the myCountryCodes regions
myCountryFrecuencies <- as.data.frame(lapply(myCountryCodes, function(x) (table(x)))[4])
# myCountryFrecuencies <- GetFrecuencyListOnColumn(myCountryCodes);
#  Get the number of WB regions
myCountryFrecuencyCount <- nrow(myCountryFrecuencies)
#  Get the greatest number of countries in any given region
#  And calculate the maximum number of growth episodes for any region
myCountryMaxFrecuency <- max(myCountryFrecuencies$WBREG.Freq)
myCountryMaxSpan <- myCountryMaxFrecuency*(upToYear-fromYear-growthIntervalInYears+2)
#  Initialize the data vectors for the growth rate estimations
yVectorDouble <- vector(mode="double", length=growthIntervalInYears)
xVectorDouble <- vector(mode="double", length=growthIntervalInYears)
#  Loop over all WB regions
for(regionCounter in 1:myCountryFrecuencyCount){
  # Get the country ISO-2 codes for this region and get the number of countries
  iso2Codes <- myCountryCodes[myCountryCodes$WBREG==myCountryFrecuencies[regionCounter,1],3]
  # Get the number of countries for this region
  countriesCount <- length(iso2Codes)
  #  Extract the data from WDI
  pop <- WDI(iso2Codes, "sp.pop.totl", start=fromYear, upToYear)
  gdp <- WDI(iso2Codes, "ny.gdp.mktp.kd", start=fromYear, upToYear)
  #  Initialize the growth episode vector
  gr <- vector(mode = "double", length=myCountryMaxSpan)
  gr <- NA
  smpl <- 0
  #  Loop over all countries in this region
  for(c in 1:countriesCount) {
    #     Extract the data for this country from the regional database
    popc <- pop[pop$iso2c==iso2Codes[c],c("iso2c", "sp.pop.totl", "year")]
    gdpc <- gdp[gdp$iso2c==iso2Codes[c],c("iso2c", "ny.gdp.mktp.kd", "year")]
    #     Sort the data by year
    popc <- popc[order(popc$year),]
    gdpc <- gdpc[order(gdpc$year),]
    #     Calculate per capita GDP
    gdppc <- gdpc[,2]/popc[,2]
    #     Calculate length of this vector
    maxYears <- length(gdppc)
    #     For every available growth episode of size growthIntervalInYears, calculate the growth rate
    #        using OLS
    for(t in growthIntervalInYears:maxYears) {
      i <- 0
      t1 <- t-growthIntervalInYears+1
      t2 <- t
      #        Fill the xVectorDouble and yVectorDouble vectors for OLS
      for(tt in t1:t2) {
        if(!is.na(gdppc[tt])) {
          i <- i+1
          yVectorDouble[i] <- log(gdppc[tt])
          xVectorDouble[i] <- i
        }
      }
      #        Calculate the growth rate if we have a full vector
      if(i == growthIntervalInYears){
        #           Do the regression and extract the growth rate
        grRate <- 100*coef(lm(yVectorDouble ~ xVectorDouble))[2]
        #           Only use this growth episode if growth is below the dropThresholdPercent
        #              in absolute terms
        if(abs(grRate) <= dropThresholdPercent) {
          smpl <- smpl+1
          gr[smpl] <- grRate
        }
      }
    }
  }
  #  Set the name for this region and append the number of growth episodes
  regName <- paste(toString(myCountryFrecuencies[regionCounter,1]),"(",smpl,")",sep="")
  #  To concatenate the vectors, they have to be of identical length
  #     Fill out the vector with NA
  s1 <- smpl+1
  for(z in s1:myCountryMaxSpan) {
    gr[z] <- NA
  }
  if(regionCounter == 1) {
    result <- cbind(gr)
  }
  else {
    result <- cbind(result,gr)
  }
  colnames(result)[regionCounter] <- regName
}
#  Create the boxplot
if (fType == "PDF") {
  pdf(paste(bpName, ".pdf", sep=""), height=6.5, width=9)
} else if(fType == "WMF") {
  win.metafile(paste(bpName, ".wmf", sep=""), height=5.5, width=8.5)
} else if (fType == "JPG") {
  jpeg(paste(bpName, ".jpg", sep=""), height=480, width=580)
} else {
  stop(paste("Wrong file type <", ftype, ">", sep=""))
}
#  Create the box plot
par(cex.axis=0.75, las=1)
boxplot(result, medcol="red", col="lightgreen",ylab="Per capita growth, percent")
grid(nx=NA, ny=NULL, col="lightgray", lty=1, lwd=1)
dev.off()
