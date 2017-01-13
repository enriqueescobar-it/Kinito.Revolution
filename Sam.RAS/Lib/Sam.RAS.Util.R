# import library gplots
source("Lib/ImportGplots.R");
# import library RColorBrewer
source("Lib/ImportRColorBrewer.R");
# import library lattice
source("Lib/ImportLattice.R");
#' Title GetSamData
#'
#' @param filePath 
#'
#' @return data.frame
#' @export
#'
#' @examples
GetSamData <- function(filePath){
  #samData <- read.table(filePath, header=TRUE, sep="\t");
  samData <- read.delim(filePath, row.names=1)
  return(samData);
}
#' Title SaveToTable
#'
#' @param dataFrame 
#' @param dataPath 
#'
#' @return NULL
#' @export
#'
#' @examples
SaveToTable <- function(dataFrame=NULL, dataPath=""){
  tdataPath=gsub("csv","txt",dataPath);
  write.table(dataFrame, tdataPath, sep="\t");
  rdataPath=gsub("csv","RData",dataPath);
  SaveToRData(dataFrame, rdataPath);
  rdsPath=gsub("csv","rds",dataPath);
  SaveToRDS(dataFrame, rdsPath);
}
#' Title SaveToRData
#'
#' @param object 
#' @param dataPath 
#'
#' @return NULL
#' @export
#'
#' @examples
SaveToRData <- function(object=NULL, dataPath=""){
  save(object, file=dataPath);
}
#' Title SaveToRDS
#'
#' @param object 
#' @param dataPath 
#'
#' @return NULL
#' @export
#'
#' @examples
SaveToRDS <- function(object=NULL, dataPath=""){
  saveRDS(object, file = dataPath);
}
#' Title PlotWireframe
#'
#' @param dataPath 
#' @param dataMatrix 
#'
#' @return NULL
#' @export
#'
#' @examples
PlotWireframe <- function(dataPath="", dataMatrix=data.matrix(NULL)){
  path <- strsplit(dataPath, "/");
  title <- path[[1]][length(path[[1]])];
  wireframe(dataMatrix, drape=TRUE, shade=FALSE, main=title,
            xlab="x", ylab="y", zlab="z", scale=list(arrows=FALSE),
            colorkey=TRUE,screen = list(z=-30, x=-30));
}
#' Title PlotLevelPlot
#'
#' @param dataPath 
#' @param dataMatrix 
#'
#' @return NULL
#' @export
#'
#' @examples
PlotLevelPlot <- function(dataPath="", dataMatrix=data.matrix(NULL)){
  path <- strsplit(dataPath, "/");
  title <- path[[1]][length(path[[1]])];
  levelplot(dataMatrix, contour=TRUE, colorkey=TRUE, main=title,
            xlab="x", ylab="y", cuts=10);
}
#' Title PlotContourPlot
#'
#' @param dataPath 
#' @param dataMatrix 
#'
#' @return NULL
#' @export
#'
#' @examples
PlotContourPlot <- function(dataPath="", dataMatrix=data.matrix(NULL)){
  path <- strsplit(dataPath, "/");
  title <- path[[1]][length(path[[1]])];
  contourplot(dataMatrix, contour=TRUE, colorkey=TRUE, main=title,
              xlab="x", ylab="y", cuts=10);
}
#' Title
#'
#' @param dataPath 
#' @param dataMatrix 
#'
#' @return NULL
#' @export
#'
#' @examples
PlotHeatmap <- function(dataPath="", dataMatrix=data.matrix(NULL)){
  path <- strsplit(dataPath, "/");
  title <- path[[1]][length(path[[1]])];
  heatmap(dataMatrix, col = heat.colors(256), scale = "none",
          #Rowv=NA, Colv=NA,
          main=title, xlab="x", ylab="y",
          symm = (ncol(dataMatrix) == nrow(dataMatrix)));
}