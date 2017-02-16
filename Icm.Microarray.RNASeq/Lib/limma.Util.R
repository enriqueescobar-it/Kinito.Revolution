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
  
  limma::plotMDS(aMatrix, labels = labelList, col = groupList);
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
  
  limma::plotMDS(aMatrix, labels = labelList, col = groupList, dim = indexList);
}

#' Title  PlotRNASeqDataReadyLinearModel
#'
#' @param aMatrix 
#' @param designMatrix 
#'
#' @return EList
#' @export
#'
#' @examples
PlotRNASeqDataReadyLinearModel <- function(aMatrix = data.matrix(NULL),
                                          designMatrix = data.matrix(NULL)){
  
  return(limma::voom(aMatrix, designMatrix, plot = TRUE));
}

#' Title LinearModelFitToDesign
#'
#' @param anELIst 
#' @param designMatrix 
#'
#' @return MArrayLM
#' @export
#'
#' @examples
LinearModelFitToDesign <- function(anELIst = NULL, designMatrix = NULL){
  
  return(limma::lmFit(anELIst, designMatrix));
}

#' Title  LinearModelFitToContrast
#'
#' @param mArrayLM 
#' @param contrastMatrix 
#'
#' @return MArrayLM
#' @export
#'
#' @examples
LinearModelFitToContrast <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL), contrastMatrix = NULL){
  
  return(limma::contrasts.fit(mArrayLM, contrasts = contrastMatrix));
}

#' Title  LinearModelFitToEmpBayes
#'
#' @param mArrayLM 
#'
#' @return MArrayLM
#' @export
#'
#' @examples
LinearModelFitToEmpBayes <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::eBayes(mArrayLM));
}

#' Title PlotMicroArrayLinearModelSigmaVsAverageLogExpression
#'
#' @param mArrayLM 
#'
#' @return
#' @export
#'
#' @examples
PlotMicroArrayLinearModelSigmaVsAverageLogExpression <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::plotSA(mArrayLM));
}

#' Title  LinearModelTreatment
#'
#' @param mArrayLM 
#'
#' @return MArrayLM
#' @export
#'
#' @examples
LinearModelTreatment <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::treat(mArrayLM, lfc = 1));
}


#' Title  ClassifyTtestGenesAcross
#'
#' @param mArrayLM 
#'
#' @return TestResults
#' @export
#'
#' @examples
ClassifyTtestGenesAcross <- function(mArrayLM = limma::as.data.frame.MArrayLM(NULL)){
  
  return(limma::decideTests(mArrayLM));
}

#' Title  DifferentialExpressionSum
#'
#' @param mArrayLM 
#'
#' @return table
#' @export
#'
#' @examples
DifferentialExpressionSum <- function(mArrayLM = NULL){
  
  return(summary(ClassifyTtestGenesAcross(mArrayLM)));
}

TwoGroupVennDiagram <- function(matrixTestResults = NULL){
  
  colorList <- c("turquoise", "salmon");
  
  limma::vennDiagram(matrixTestResults, circle.col = colorList);
}

MArrayLMToFile <- function(aMArrayLM = NULL, aTestResults = NULL, filePath = ""){
  
  limma::write.fit(aMArrayLM, results = aTestResults, file = filePath);
}

LinearModelFitToTopGenes <- function(aMArrayLM = NULL, coefficient = 0){
  
  return(limma::topTreat(aMArrayLM, coef = coefficient, n = Inf));
}

PlotMeanDifferenceExpression <- function(aMArrayLM = NULL, aColumn = 0, aTestResults = NULL){
  
  limma::plotMD(aMArrayLM, column = aColumn, status = aTestResults[, aColumn],
                main = colnames(aMArrayLM)[aColumn], xlim = c(-8, 13));
}

GeneIdsToGeneSets <- function(geneSets = list(), ids = NULL){
  
  return(limma::ids2indices(geneSets, identifiers = ids));
}

