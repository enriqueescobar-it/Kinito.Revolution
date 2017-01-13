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
myCountryCodes <- ReadContrastMatrix("Data/wbreg.csv");
fromYear <- 1960;
upToYear <- 2014;
growthIntervalInYears <- 10;
dropThresholdPercent <- 10.10;
myCountryFrecuencies <- as.data.frame(lapply(myCountryCodes, function(x) (table(x)))[4]);
myCountryFrecuencies <- tibble::as_data_frame(myCountryFrecuencies);
myCountryFrecuencyCount <- nrow(myCountryFrecuencies);
myCountryMaxFrecuency <- max(myCountryFrecuencies$WBREG.Freq);
myCountryMaxSpan <- myCountryMaxFrecuency * (upToYear - fromYear - growthIntervalInYears + 2);
# Initialize the data vectors for the growth rate estimations
xVectorDouble <- vector(mode = "double", length = growthIntervalInYears);
yVectorDouble <- vector(mode = "double", length = growthIntervalInYears);
for(myRegions in 1:myCountryFrecuencyCount){
  print(myRegions);
  # Get the country ISO-2 codes for this region and get the number of countries
  # myCountryCodes[myCountryCodes$WBREG==myCountryFrecuencies[myRegions,1],3]
  iso <- myCountryCodes[myCountryCodes$WBREG == myCountryFrecuencies[myRegions,1],3];
  print(iso);
}


