#
source(paste0("Lib/", projectName, ".Util.R"));
#
rawDir <- "Data";
dirList <- GetFullnameDirectories(rawDir);
lastDir <- tail(dirList, n = 1);
rm(dirList);

aQuarter <- unlist(strsplit(lastDir, "/"))[2];
aQuarter <- unlist(strsplit(aQuarter, ".txt"))[1];
aYear <- as.integer(unlist(strsplit(aQuarter, "-"))[2]);
aMonth <- as.integer(unlist(strsplit(aQuarter, "-"))[1]);
library(zoo);
aQuarter <- unlist(strsplit(as.character(as.yearqtr(aQuarter, format = "%m-%Y")), " "))[2];

fileList <- GetFullnameFiles(lastDir);
newFileList <- fileList;
rm(lastDir);

for (i in seq(along = fileList)) {
  oldFile <- fileList[i];
  if(!file.exists(oldFile)) {
    cat("ERROR|FilenameFormatError: Cannot read file\n");
  } else {
    cat(paste0("old\t", oldFile, "\n"));
    newFile <- RmAccent(oldFile);
    cat(paste0("new\t", newFile, "\n"));
    newFileList[i] <- newFile;
  }
  rm(oldFile);
  rm(newFile);
}
rm(fileList);
rm(i);
newFileList <- newFileList[1:8];
#df <- DaneTabbedFileToDF(aFilePath = newFileList[1]);
#View(df);
library(readr);
aDF <- read_delim(newFileList[1], "\t", escape_double = FALSE, na = "null", trim_ws = TRUE);
aDF <- cbind(aDF[1:2], aYear, aQuarter, aMonth, aDF[3:length(aDF)]);
# library(RODBC)
# con <- odbcDriverConnect("driver=SQL Server; server=database")
# df <- data.frame(a=1:10, b=10:1, c=11:20)
# values <- paste("(",df$a,",", df$b,",",df$c,")", sep="", collapse=",")
# cmd <- paste("insert into MyTable values ", values)
# result <- sqlQuery(con, cmd, as.is=TRUE)
# url = "Server=localhost;Database=TEST_RSQLSERVER;Trusted_Connection=True;"
# conn <- dbConnect('SqlServer',url=url)
# ## I assume the table already exist
# dbBulkCopy(conn,name='T_BULKCOPY',value=df,overwrite=TRUE)
# dbDisconnect(conn)
# sqlSave(uploaddbconnection, outputframe, tablename =
#           "your_TableName",rownames=FALSE, append = TRUE)
# #creating data to be saved in SQL Table
# data_to_save<-cbind(scenario_1,scenario_2,scenario_3,scenario_4,store_num,future_date,Province,index)
# 
# #use sqlSave() rather than sqlQuery() for saving data into SQL Server
# sqlSave(conn,data.frame(data_to_save),"CC_Forecast",safer=FALSE,append=TRUE
#         specificDB= odbcConnect(dsn ='name you set up in ODBC',uid = '***', pwd = '****')
#         
#         sqlSave(specificDB, output_to_sql, tablename = 'a_table_in_specificDB', rownames = F,append = T)
#         
#         close(specificDB)
        


