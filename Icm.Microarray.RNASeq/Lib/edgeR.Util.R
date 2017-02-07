if (!require(edgeR)) {
  stop('The package <edgeR> was not installed');
  source("https://bioconductor.org/biocLite.R");
  biocLite("edgeR");
}
# loads library
# limma
#
#
#

#' Title  GeneNameAndCountDGEList
#'
#' @param filePathList 
#' @param columnList 
#'
#' @return DGEList
#' @export TBD
#'
#' @examples TBD
GeneNameAndCountDGEList <- function(filePathList = c("", "", ""), columnList = c(1,3)){
  aDgeList <- edgeR::readDGE(filePathList, columns = columnList);
  
  return(aDgeList);
}

#' Title  CountsPerMillion
#'
#' @param aDGEList
#' @param IsLog
#'
#' @return matrix
#' @export TBD
#'
#' @examples TBD
CountsPerMillion <- function(aDGEList = NULL, IsLog = FALSE){
  
  if (IsLog == FALSE){
    
    return(edgeR::cpm(aDGEList));
  } else {
    
    return(edgeR::cpm(aDGEList, log = IsLog));
  }
}

#' Title  CalculateNormalizationFactors
#'
#' @param obj 
#' @param aMethod 
#'
#' @return DGEList
#' @export TBD
#'
#' @examples TBD
CalculateNormalizationFactors <- function(obj = NULL, aMethod = NULL){
  
  if (is.null(aMethod)) {
    
    return(edgeR::calcNormFactors(obj));
  } else {
    
    return(edgeR::calcNormFactors(obj, method = aMethod));
  }
}
