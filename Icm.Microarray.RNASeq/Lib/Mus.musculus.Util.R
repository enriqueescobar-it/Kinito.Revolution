if (!require(Mus.musculus)) {
  stop('The package <Mus.musculus> was not installed');
  source("https://bioconductor.org/biocLite.R");
  biocLite("Mus.musculus");
}
# loads library
# AnnotationDbi, stats4, BiocGenerics, parallel, Biobase, IRanges, S4Vectors
# OrganismDbi, GenomicFeatures, GenomeInfoDb, GenomicRanges, GO.db, org.Mm.eg.db,
# TxDb.Mmusculus.UCSC.mm10.knownGene
# 
# 
#

#' Title  EntrezIdSymbolChromosome
#'
#' @param geneList 
#' @param geneColumns 
#' @param geneKeyType 
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
EntrezIdSymbolChromosome <- function(geneList = NULL, geneColumns = NULL, geneKeyType = ""){
  aDataFrame <- AnnotationDbi::select(Mus.musculus, keys = geneList, columns = geneColumns, keytype = geneKeyType);
  
  return(aDataFrame);
}

