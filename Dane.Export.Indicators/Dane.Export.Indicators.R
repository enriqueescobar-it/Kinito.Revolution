#
source(paste0("Lib/", projectName, ".Util.R"));
#
rawDir <- "Raw";
dirList <- GetFullnameDirectories(rawDir);
lastDir <- tail(dirList, n = 1);
rm(dirList);

fileList <- GetFullnameFiles(lastDir);
rm(lastDir);

for (i in seq(along = fileList)) {
  cat(paste0(i, "\t", fileList[i], "\n"));
}
