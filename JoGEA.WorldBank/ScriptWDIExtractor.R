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
library(WDI);
library(countrycode);
# Read the command line arguments
args <- commandArgs(TRUE);
if(length(args) < 1) {
  srcFile <- "extractWDI.opt";
} else {
  srcFile <- args[1];
}
# Get the options from the options file
fileOptions <- read.csv(srcFile, stringsAsFactors = FALSE, strip.white=TRUE, quote = "\"'");
# Get the name of the output file
outFileName <- fileOptions[grep("Output file", fileOptions$Name),2];
# Get the beginning year
startYear  <- as.numeric(fileOptions[grep("Start year", fileOptions$Name),2]);
# Get the final year
stopYear  <- as.numeric(fileOptions[grep("End year", fileOptions$Name),2]);
# Flag for header
hasHeader <- as.logical(fileOptions[grep("Header", fileOptions$Name),2]);
# Flag for outputting country name
hasCountryName <- as.logical(fileOptions[grep("Country name", fileOptions$Name),2]);
# Get the regions -- 'all' is to get all regions, regions should be coded in iso2c
iso2cRegions  <- fileOptions[grep("Regions", fileOptions$Name),2];
if(iso2cRegions != "all") {
  iso2cRegions <- toupper(iso2cRegions);
}
# Parse the regions
iso2cRegions <- strsplit(iso2cRegions,",");
iso2cRegions <- c(do.call("cbind",iso2cRegions));
# Get the indicators -- assumes input file has no blank lines
row1 <- 8;
row2 <- nrow(fileOptions);
indicatorsTable <- fileOptions[row1:row2,];
# Get the number of indicators
nbIndicators <- nrow(indicatorsTable);
if(hasHeader) {
  # Use header for CSV file
  if(hasCountryName) {
    header <- cbind("Var", "iso3", "regName","Year", "Val");
  }
  else {
    header <- cbind("Var", "iso3", "Year", "Val");
  }
  write.table(header, outFileName, append=FALSE, row.names=FALSE, col.names=FALSE, sep=",");
}
ifAppend <- hasHeader;
# Loop over all indicators
for (i in 1:nbIndicators) {
  # Get the short and World Bank name for the indicators
  var <- indicatorsTable[i,1];
  wbName <- indicatorsTable[i,2];
  # Use the function above to retrieve the data, convert iso2 to iso3, drop the regions, and append to the CSV file
  wdi.Retrieve(iso2cRegions, var, wbName, startYear, stopYear, outFileName, ifAppend, hasCountryName);
  RetreiveWDI(iso2cRegions, wbName, startYear, stopYear,
              var, hasCountryName, outFileName, ifAppend);
  # After the first indicator, ifAppend must be TRUE
  ifAppend <- TRUE;
}

