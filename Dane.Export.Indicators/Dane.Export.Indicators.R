#
source(paste0("Lib/", projectName, ".Util.R"));
#
rawDir <- "Raw";
dirList <- GetFullnameDirectories(rawDir);
lastDir <- tail(dirList, n = 1);
rm(dirList);

fileList <- GetFullnameFiles(lastDir);
newFileList <- fileList;
rm(lastDir);

for (i in seq(along = fileList)) {
  oldFile <- fileList[i];
  cat(paste0("old\t", oldFile, "\n"));
  newFile <- RmAccent(oldFile);
  cat(paste0("new\t", newFile, "\n"));
  newFileList[i] <- newFile;
  if(!file.exists(oldFile)) {
    cat("ERROR|FilenameFormatError: Cannot read file\n");
  } else {
     #CopyFullnameFiles(oldFilePath = oldFile, newFilePath = newFile);
  }
  rm(oldFile);
  rm(newFile);
}
rm(fileList);
rm(i);

df <- DaneTabbedFileToDF(aFilePath = newFileList[1]);
View(df);


