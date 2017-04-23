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
  
  return(list.dirs(path = aDir, full.names = TRUE, recursive = FALSE));
}

GetFullnameFiles <- function(aDir = ""){
  
  argumentCheck <- ArgumentCheck::newArgCheck();
  
  if (!dir.exists(aDir)){
    ArgumentCheck::addWarning(
      msg = paste0("The directory provided does not exist: ", aDir),
      argcheck = argumentCheck
    )
  }
  
  ArgumentCheck::finishArgCheck(argumentCheck);
  
  return(list.files(aDir, all.files = TRUE, full.names = TRUE)[-c(1, 2)]);
}
