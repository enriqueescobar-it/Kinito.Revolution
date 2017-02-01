if (!require(RColorBrewer)) {
  stop('The package <RColorBrewer> was not installed');
  install.packages("RColorBrewer");
}
#
#
#

#' Title
#'
#' @param size 
#' @param type 
#'
#' @return list() of colors
#' @export TBD
#'
#' @examples TBD
ColorPalette <- function(size = 3, type = "Paired"){
  
  if (!(is.null(size) || is.null(type))) {
    
    return(RColorBrewer::brewer.pal(n = size, name = type));
  } else {
    
    return(NULL);
  }
}
