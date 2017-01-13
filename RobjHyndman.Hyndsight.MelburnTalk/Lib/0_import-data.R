##From TXT
#scan
#Suppose you have the following .txt document:
#24 1991
#21 1993
#53 1962
data <- scan("birth.txt");
data <- matrix(scan("birth.txt"), nrow=2, byrow=TRUE);
data <- scan("age.txt", what = list(Age = 0, Birthyear= 0), skip=1, quiet=TRUE);
#data.frame
data <- data.frame(scan("age.csv", what = list(Age=0, Name="", Birthyear=0), skip=1, sep=";", quiet=TRUE);
#read.table
df <- read.table("<FileName>.txt", header=FALSE);
df <- read.table("<FileName>.txt", header=FALSE, sep="/", strip.white = TRUE, na.strings = "EMPTY");
##Fixed-width text files: read.fwf() in the default installation.
# Single line per observation
fwf.data <- read.fwf("file.txt", width=c(3, 5, ...));
# Multiple lines per observation
fwf.data <- read.fwf("file.txt", width=list(c(3, 5, ...), c(5, 7, ...)));
#
read.fwf("scores.txt", widths=c(7,-14,1,-2,1,1,1,1,1,1), 
         col.names=c("subject","sex","s1","s2","s3","s4","s5","s6"),
         strip.white=TRUE);
##From CSV
# first row contains variable names, comma is separator 
# assign the variable id to row names
# note the / instead of \ on mswindows systems 
mydata <- read.table("c:/mydata.csv", header=TRUE, sep=",", row.names="id");
df <- read.table("<FileName>.csv", header=FALSE, sep=",");
df <- read.csv("<FileName>.csv", header=FALSE);
df <- read.csv2("<FileName>.csv", header=FALSE);
# with separator
df <- read.delim("<name and extension of your file>");
df <- read.delim2("<name and extension of your file>");
# Read CSV file (header assumed), then put that into "csv.data" data object (any name is ok).
csv.data <- read.csv("file.csv");
# This gives you a dialogue to choose a file, then the file is passed to read.csv() function
csv.data <- read.csv(file.choose());
#
df <- read.csv("<name and extension of your file>", header=TRUE, quote="\"", stringsAsFactors=TRUE, strip.white=TRUE);
#
df <- read.csv2("<name and extension of your file>", header=TRUE, quote="\"", dec=",", row.names=c("M", "N", "O", "P", "Q"), 
                col.names=c("X", "Y", "Z", "A","B"), fill=TRUE, strip.white=TRUE, stringsAsFactors=TRUE);
#
df <- read.delim("<name and extension of your file>", header=FALSE, sep="/", quote="\"", dec=".", row.names=c("O", "P", "Q"), 
                  fill=TRUE, strip.white=TRUE, stringsAsFactors=TRUE, na.strings="EMPTY", as.is=3, nrows=5, skip=2);
#
df <- read.delim2("<name and extension of your file>", header=FALSE, sep="t", quote="\"", dec=".", row.names=c("M", "N", "O"), 
                  col.names=c("X", "Y", "Z", "A","B"), colClasses=(rep("integer",2), "date", "numeric", "character"),
                  fill=TRUE, strip.white=TRUE, na.strings="EMPTY", skip=2);
# Space-separated (no header assumed)
ssf.data <- read.table("file.dat"); # No header
ssf.data <- read.table("file.dat", header=TRUE); # With header
# tab-separated (header assumed)
tsv.data <- read.delim("file.tsv");
##From Excel
# One of the best ways to read an Excel file is to export it to a comma delimited file and import it using the method above.
# Alternatively you can use the xlsx package to access Excel files. The first row should contain variable/column names.
# read in the first worksheet from the workbook myexcel.xlsx
# first row contains variable names
library(xlsx);
mydata <- read.xlsx("c:/myexcel.xlsx", 1);
# read in the worksheet named mysheet
mydata <- read.xlsx("c:/myexcel.xlsx", sheetName="mysheet");
# If you have not installed it before
install.packages("xlsx", dep=T);
library(xlsx);
# You need to specifiy the sheetIndex (sheet number)
excel.data <- read.xlsx("file.xlsx", sheetIndex = 1);
#
df <- read.xlsx("<name and extension of your file>", sheetIndex=1);
df <- read.xlsx2("<name and extension of your file>", sheetIndex = 1, startRow=2, colIndex=2);
#
write.xlsx(df, "df.xlsx", sheetName="Data Frame");      
write.xlsx(df, "<name and extension of your existing file>", sheetName="Data Frame", append=TRUE);
##From Excel XLConnect Package
library(XLConnect);
df <- readWorksheetFromFile("<file name and extension>", sheet=1);
wb <- loadWorkbook("<name and extension of your file>");
df <- readWorksheet(wb, sheet=1);
#
df <- readWorksheetFromFile("<file name and extension>", sheet=1, startRow=4, endCol=2);
##From Excel openxlsx Package
library(openxlsx);
read.xlsx("<path to your file>");
##From Excel Readxl Package
library(readxl);
df <- read_excel("<name and extension of your file>");
##From Excel readODS Package
library(readODS);
read.ods("<path to your file>", sheet = 1, formulaAsFormula=FALSE);
##From JavaScript Object Notation (JSON)
#path to file
library(rjson);
JsonData <- fromJSON(file="<filename.json>");
#URL to file
library(rjson);
JsonData <- fromJSON(file="<URL to your JSON file>");
#jsonlite package
library(jsonlite);
data <- fromJSON("<Path to your JSON file>");
#jsonlRJSONIOite package
library(RJSONIO);
data <- fromJSON("<Path to your JSON file");
##From XML
library(XML);
xmlfile <- xmlTreeParse("<Your URL to the XML data>");
class(xmlfile);
topxml <- xmlRoot(xmlfile);
topxml <- xmlSApply(topxml, function(x) xmlSApply(x, xmlValue));
xml_df <- data.frame(t(topxml), row.names=NULL);
url <- "<a URL with XML data>";
data_df <- xmlToDataFrame(url);
##From HTML Tables
url <- "<a URL>";
data_df <- readHTMLTable(url, which=3);
library(XML);
library(RCurl);
url <- "YourURL";
urldata <- getURL(url);
data <- readHTMLTable(urldata, stringsAsFactors=FALSE);
library(httr);
urldata <- GET(url);
data <- readHTMLTable(rawToChar(urldata$content), stringsAsFactors = FALSE);
# If you have not installed it before
install.packages("xlsx", dep=T);
library(xlsx);
# You need to specifiy the sheetIndex (sheet number)
excel.data <- read.xlsx("file.xlsx", sheetIndex=1);
##FRom DIFF files
data <- read.DIF("<your spreadsheet>", header=FALSE, as.is=!stringsAsFactors);
##From SPSS
# save SPSS dataset in trasport format
get file='c:\mydata.sav'.
export outfile='c:\mydata.por'.
##in R
library(Hmisc);
# last option converts value labels to R factors
mydata <- spss.get("c:/mydata.por", use.value.labels=TRUE);
#
library(foreign);
mySPSSData <- read.spss("example.sav");
mySPSSData <- read.spss("example.sav", to.data.frame=TRUE, use.value.labels=FALSE);
##From EPI
library(foreign);
data <- read.epiinfo("<Path to your file>");
##From Octave
library(foreign);
data <- read.octave("<Path to your file>");
##From MATLAB
library(R.matlab);
data <- readMat("<Path to your file>");
##From S-Plus
library(foreign);
data <- read.S("<Path to your file>");
##From SAS
# save SAS dataset in trasport format
libname out xport 'c:/mydata.xpt';
data out.mydata;
set sasuser.mydata;
run;
##in R
library(Hmisc);
mydata <- sasxport.get("c:/mydata.xpt");
#sas7bdat package
library(sas7bdat);
mySASData <- read.sas7bdat("example.sas7bdat");
#SASxport package
library(SASxport);
data <- read.xport("<path to your SAS file>");
#haven package
library(haven);
data <- read_sas("<path to your SAS file>");
# character variables are converted to R factors
# Native files
install.packages("sas7bdat", dep=T);      # If you have not installed it before
library(sas7bdat);
sas7bdat.data <- read.sas7bdat("file.sas7bdat");
## xport files
install.packages("foreign", dep = T);      # If you have not installed it before
library(foreign);
xport.data <- read.xport("file.xpt");
##From Stata
# input Stata file
library(foreign);
mydata <- read.dta("c:/mydata.dta");
#
install.packages("foreign", dep=T);    # If you have not installed it before
library(foreign);                      # If you have not loaded the package in the current session.
dta.data <- read.dta("file.xpt");
##From systat
# input Systat file
library(foreign);
mydata <- read.systat("c:/mydata.dta");
##From MiniTab
library(foreign);
myMTPData <- read.mtp("example2.mtp");
##From RDA RData
load("<FileName>.RDA");
##From Quantmod
library(quantmod);
data <- getSymbols("YHOO", src="google");
setSymbolLookup(YHOO='google',GOOG='yahoo');
saveSymbolLookup(file="mysymbols.rda");
loadSymbolLookup(file="mysymbols.rda");
getSymbols(c("YHOO","GOOG"));
##From ARFF
library(foreign);
data <- read.arff("<Path to your file>");
##From DBF
library(foreign);
data <- read.dbf("<Path to your file>");
##From Flat Contingency Tables
library(foreign);
data <- read.ftable("<Path to your file>");
##From Integrated Taxonomical Information (ITIS) Tables Into R
data <- read.table("<Path to your file>");
#Large dataset
library(data.table);
data <- fread("http://assets.datacamp.com/blog_assets/chol.txt");
data <- fread("http://assets.datacamp.com/blog_assets/chol.txt", sep=auto, nrows=-1, na.strings=c("NA","N/A",""), stringsAsFactors=FALSE);
df <- read.table("<Path to your file>", header=FALSE, sep="/", quote="", na.strings="EMPTY", colClasses=c("character", "numeric", "factor"),
                 strip.white=TRUE, comment.char="", stringsAsFactors=FALSE, nrows=n);
#Big data
bigdata <- read.table.ffdf(file="<Path to file>", nrows=n);
#
library(ff);
bigdata <- read.table.ffdf(file="<Path to file>", nrows=n, fileEncoding="", levels=NULL, FUN="read.table");
#bigmemory package
library(bigmemory);
bigdata <- read.big.matrix(filename="<File name>", sep="/", header=TRUE, skip=2);
#sqldf package
library(sqldf);
bigdata <- read.csv.sql(file="<Path to your file>", sql="select * from file where ...", colClasses=c("character", rep("numeric",10)));
#readr package
df <- read_table("<Path to your file>", col_names=TRUE);
#rio package
library(rio);
data <- import("<Path to your file>");