if (!require(limma)) {
  stop('The package <limma> was not installed');
  source("https://bioconductor.org/biocLite.R");
  biocLite("limma");
}
#
#
#

#' Title  PlotMultiDimensionalScaling
#'
#' @param aMatrix 
#' @param labelList 
#' @param groupList 
#'
#' @return plotMDS
#' @export
#'
#' @examples
PlotMultiDimensionalScaling <- function(aMatrix = data.matrix(NULL),
                                        labelList = colnames(aMatrix),
                                        groupList = c()){
  
  return(limma::plotMDS(aMatrix, labels = labelList, col = groupList));
}


#' Title  PlotMultiDimensionalScalingFixed
#'
#' @param aMatrix 
#' @param labelList 
#' @param groupList 
#' @param indexList 
#'
#' @return plotMDS
#' @export
#'
#' @examples
PlotMultiDimensionalScalingFixed <- function(aMatrix = data.matrix(NULL),
                                        labelList = colnames(aMatrix),
                                        groupList = c(),
                                        indexList =  c(3,4)){
  
  return(limma::plotMDS(aMatrix, labels = labelList, col = groupList, dim = indexList));
}

GetContrastsFrom <- function(contrasts = "", levels = NULL){
  
  return(limma::makeContrasts(contrasts, levels));
}

PlotRNASeqDataReadyLinearModel <- function(aMatrix = data.matrix(NULL),
                                          designMatrix = data.matrix(NULL)){
  
  return(limma::voom(aMatrix, designMatrix, plot = TRUE));
}

LinearModelFitToDesign <- function(anELIst = NULL, designMatrix = NULL){
  
  return (limma::lmFit(anELIst, designMatrix));
}

LinearModelFitToContrast <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL), contrastMatrix = NULL){
  
  return (limma::contrasts.fit(mArrayLM, contrasts = contrastMatrix));
}

LinearModelFitToEmpBayes <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::eBayes(mArrayLM));
}

PlotMicroArrayLinearModelSigmaVsAverageLogExpression <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::plotSA(mArrayLM));
}

LinearModelTreatment <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::treat(mArrayLM, lfc = 1));
}


ClassifyTtestGenesAcross <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::decideTests(mArrayLM));
}

DifferentialExpressionSum <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(summary(ClassifyTtestGenesAcross(mArrayLM)));
}
