require(edgeR);
# loads library
# limma
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
