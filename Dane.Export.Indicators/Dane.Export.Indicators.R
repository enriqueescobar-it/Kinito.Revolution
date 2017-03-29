#
#source(paste0("Lib/", projectName, ".Util.R"));
#
library(stringi);
#
rawDir <- "Raw";
dirList <- list.dirs(path = rawDir, full.names = TRUE, recursive = FALSE);
for (i in seq(along = dirList)) {
    currentDir <- dirList[i];
    cat(currentDir);
    # setwd(currentDir);
    # getwd();
    currentFiles <- list.files(currentDir, all.files = TRUE, full.names = TRUE);
    cat(currentFiles);
    cat(iconv(currentFiles, to = 'TRANSLIT//ASCII'));
}