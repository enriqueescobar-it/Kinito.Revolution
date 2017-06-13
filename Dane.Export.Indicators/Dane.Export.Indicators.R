#
source(paste0("Lib/", projectName, ".Util.R"));
#
rawDir <- "Data";
dirList <- GetFullnameDirectories(rawDir);
lastDir <- tail(dirList, n = 1);
rm(dirList);
rm(rawDir);

aQuarter <- unlist(strsplit(lastDir, "/"))[2];
aQuarter <- unlist(strsplit(aQuarter, ".txt"))[1];
aYear <- as.integer(unlist(strsplit(aQuarter, "-"))[2]);
aMonth <- as.integer(unlist(strsplit(aQuarter, "-"))[1]);
library(zoo);
aQuarter <- unlist(strsplit(as.character(as.yearqtr(aQuarter, format = "%m-%Y")), " "))[2];

fileList <- GetFullnameFiles(lastDir);
newFileList <- fileList;
rm(lastDir);

source("Lib/RODBC.Util.R");

for (i in seq(along = fileList)) {
  oldFile <- fileList[i];
  # cat(paste0("old\t", oldFile, "\n"));
  newFile <- RmAccent(oldFile);
  cat(paste0("new\t", i, ":\t", newFile, "\n"));
  newFileList[i] <- newFile;
  #aTable <- "Area-Caracteristicas";
  aTable <- "Area-Fuerza";
  
  if (grepl(aTable, newFileList[i])) {
    cat(newFileList[i]);
    aDF <- DaneTabbedFileToTibble(newFileList[i]);
    aDF <- cbind(aDF[1:2], aMonth, aYear, aQuarter, aDF[3:length(aDF)]);
    aTable <- gsub("-", "", aTable);
    InsertTibbleToTable(aDF, aTable);
  }
  rm(oldFile);
  rm(newFile);
  rm(aTable);
}
rm(fileList);
rm(i);
rm(aYear); rm(aQuarter); rm(aMonth); rm(aDF);
newFileList <- newFileList[1:8];
rm(newFileList);


