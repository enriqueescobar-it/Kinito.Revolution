library(RODBC);

InsertTibbleToTable <- function(aTibble = tibble::as_tibble(NULL), aTable = ""){
  
  aTibble <- head(aTibble);
  odbcConnector <- RODBC::odbcConnect("Odbc64", uid = "danegeihdbadmin", pwd = "Chest3r!");
  RODBC::sqlQuery(odbcConnector, "USE DaneGeih;");
  # sqlSave(odbcConnector, aTibble, tablename = aTable, append = TRUE);
  # sqlSave(odbcConnector, aTibble, tablename = aTable, append = TRUE, rownames = FALSE, safer = TRUE, test = FALSE, verbose = TRUE);
  aString <- paste0("SELECT COLUMN_NAME FROM DaneGeih.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '", aTable, "';");
  aString <- RODBC::sqlQuery(odbcConnector, aString);
  aString <- paste(as.character(aString[[1]])[-1], sep = '', collapse = ',');
  aString <- paste0("INSERT INTO ", aTable, " (", aString, ") VALUES\n(");
  #aQuery <- "MsSql/CreateDB-DaneGeih_Insert-AreaCaracteristicas.sql";
  #fileConnector <- file(aQuery);
  start_time <- Sys.time();
  for(i in 1:nrow(aTibble)) {
    row <- paste0(aTibble[i,], collapse = ',');
    row <- paste0(row, ");\n");
    row <- gsub("NA", "NULL", row);
    row <- paste0(aString, row);
    print(row);
    # aQuery <- paste0(aQuery, row);
    #aResult <- RODBC::sqlQuery(odbcConnector, row, errors = TRUE);
    #cat(aResult);
    #write(row, file = aQuery, append = TRUE);
    rm(row); #rm(aResult);
  }
  end_time <- Sys.time();
  laps_time <- end_time - start_time;
  print(laps_time);
  rm(start_time); rm(end_time); rm(laps_time); #rm(aQuery);
  #close(odbcConnector);
  #close(fileConnector);
}
# url = "Server=localhost;Database=TEST_RSQLSERVER;Trusted_Connection=True;"
# conn <- dbConnect('SqlServer',url=url)
# ## I assume the table already exist
# dbBulkCopy(conn,name='T_BULKCOPY',value=df,overwrite=TRUE)
# dbDisconnect(conn)
# sqlSave(uploaddbconnection, outputframe, tablename =
#           "your_TableName",rownames=FALSE, append = TRUE)
# #creating data to be saved in SQL Table
# #use sqlSave() rather than sqlQuery() for saving data into SQL Server
# sqlSave(conn,data.frame(data_to_save),"CC_Forecast",safer=FALSE,append=TRUE
# specificDB= odbcConnect(dsn ='name you set up in ODBC',uid = '***', pwd = '****')
# sqlSave(specificDB, output_to_sql, tablename = 'a_table_in_specificDB', rownames = F,append = T)
# close(specificDB)
# 
