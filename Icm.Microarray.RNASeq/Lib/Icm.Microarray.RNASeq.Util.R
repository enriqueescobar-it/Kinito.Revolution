#' Title  TxtFileToDataFrame
#'
#' @param filePath 
#'
#' @return string[5]
#' @export TBD
#'
#' @examples TBD
TxtFileToDataFrame <- function(filePath = ""){
  peek <- data.frame(NULL);
  
  if (filePath != "") {
    
    peek <- read.delim(filePath);
  }
  
  return(peek);
}
