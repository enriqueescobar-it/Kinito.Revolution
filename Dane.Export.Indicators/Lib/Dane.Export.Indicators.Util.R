#
library(stringi);
#
library(stringr);
#
library(ArgumentCheck);
#

#' Title GetFullnameDirectories
#'
#' @param aDir 
#'
#' @return directory list()
#' @export TBD
#'
#' @examples TDB
GetFullnameDirectories <- function(aDir = ""){
  
  argumentCheck <- ArgumentCheck::newArgCheck();
  
  if (!dir.exists(aDir)){
    ArgumentCheck::addWarning(
      msg = paste0("The directory provided does not exist: ", aDir),
      argcheck = argumentCheck
    )
  }
  
  ArgumentCheck::finishArgCheck(argumentCheck);
  
  return(base::list.dirs(path = aDir, full.names = TRUE, recursive = FALSE));
}

#' Title GetFullnameFiles
#'
#' @param aDir 
#'
#' @return full path file list
#' @export TBD
#'
#' @examples TBD
GetFullnameFiles <- function(aDir = ""){
  
  argumentCheck <- ArgumentCheck::newArgCheck();
  
  if (!dir.exists(aDir)){
    ArgumentCheck::addWarning(
      msg = paste0("The directory provided does not exist: ", aDir),
      argcheck = argumentCheck
    )
  }
  
  ArgumentCheck::finishArgCheck(argumentCheck);
  
  fileList <-
    base::list.files(aDir, all.files = TRUE, pattern=".txt", full.names = TRUE)[-c(1, 2)];
  fileList <- fileList[!grepl(" ", fileList)];
  
  return(fileList);
}

CopyFullnameFiles <- function(oldFilePath = "", newFilePath = "") {
  
  base::file.copy(oldFilePath, newFilePath, overwrite = TRUE, recursive = FALSE,
                  copy.mode = TRUE, copy.date = TRUE);
}

RmAccent <- function(aString = "") {
  
  replaceCharList <- list('Š'='S', 'š'='s', 'Ž'='Z', 'ž'='z', 'Ç'='C', 'ç'='c',
                           'Ñ'='N', 'ñ'='n', 'Þ'='B', 'þ'='b',
                           'ß'='Ss', '╡'='A', '¦'='A', '('='', ')'='',
                           'À'='A', 'Á'='A', 'Â'='A', 'Ä'='A', 'Ã'='A', 'Å'='A', 'Æ'='A',
                           'à'='a', 'á'='a', 'â'='a', 'ä'='a', 'ã'='a', 'å'='a', 'æ'='a',
                           'È'='E', 'É'='E', 'Ê'='E', 'Ë'='E',
                           'è'='e', 'é'='e', 'ê'='e', 'ë'='e',
                           'Ì'='I', 'Í'='I', 'Î'='I', 'Ï'='I',
                           'ì'='i', 'í'='i', 'î'='i', 'ï'='i',
                           'Ù'='U', 'Ú'='U', 'Û'='U', 'Ü'='U',
                           'ù'='u', 'ú'='u', 'û'='u', 'ü'='u',
                           #'Ỳ'='Y',
                           'Ý'='Y', 'Ŷ'='Y', 'Ÿ'='Y',
                           #'ỳ'='y',
                           'ý'='y', 'ŷ'='y', 'ÿ'='y',
                           'Ò'='O', 'Ó'='O', 'Ô'='O', 'Ö'='O', 'Õ'='O', 'Ø'='O',
                           'ò'='o', 'ó'='o', 'ô'='o', 'õ'='o', 'ö'='o', 'ø'='o', 'ð'='o');
  aString <- gsub("['`^~\"]", " ", aString);
  aString <- iconv(aString, to = "ASCII//TRANSLIT//IGNORE");
  aString <- gsub("`|\\'", "", aString);
  aString <- iconv(aString, to = "ASCII//TRANSLIT//IGNORE");
  aString <- gsub(pattern = " \\(", replacement = "_", x = aString);
  aString <- gsub(pattern = "\\)", replacement = "_", x = aString);
  aString <- gsub(pattern = "\\|", replacement = "A", x = aString);
  aString <- gsub(pattern = " -", replacement = "-", x = aString);
  aString <- gsub(pattern = "- ", replacement = "-", x = aString);
  aString <- gsub(pattern = " ", replacement = "_", x = aString);
  
  return(aString);
}

library(readr);

DaneTabbedFileToDF <- function(aFilePath = "") {
  
  return(readr::read_delim(aFilePath, "\t", escape_double = FALSE, na = "NA", trim_ws = TRUE));
}
