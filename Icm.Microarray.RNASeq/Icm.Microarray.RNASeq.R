# https://f1000research.com/articles/5-1408/v2
# data packaging
## reading
source(paste0("Lib/", projectName, ".Util.R"));
fileList <- c("Data/GSM1545535_10_6_5_11.txt",
           "Data/GSM1545536_9_6_5_11.txt",
           "Data/GSM1545538_purep53.txt",
           "Data/GSM1545539_JMS8-2.txt",
           "Data/GSM1545540_JMS8-3.txt",
           "Data/GSM1545541_JMS8-4.txt",
           "Data/GSM1545542_JMS8-5.txt",
           "Data/GSM1545544_JMS9-P7c.txt",
           "Data/GSM1545545_JMS9-P8c.txt");
# gene names on col 1 and gene count on col 3
df <- TxtFileToDataFrame(fileList[1]);
head(df);
names(df);
geneColumns <- which(colnames(df) == "EntrezID" | colnames(df) == "Count");
geneColumns;
geneKeyType <- toupper(colnames(df)[1]);
geneKeyType;
rm(df);
#source("https://bioconductor.org/biocLite.R");
#biocLite("edgeR");
# library(edgeR); loads library
# limma
# x <- edgeR::readDGE(fileList, columns=c(1, 3)) ;
source(paste0("Lib/", "edgeR.Util.R"));
x <- GeneNameAndCountDGEList(fileList, geneColumns);
class(x); typeof(x); dim(x);
## Organising sample information
### shrink colnames remove from start to first underscore
colnames(x);
samplenames <- substring(colnames(x), 17, nchar(colnames(x))) ; #12->17
samplenames;
colnames(x) <- samplenames;
#rm(samplenames);
# col group & norm.factors preset to 1
x$samples;
### group factor foreach-9
group <- as.factor(c("LP", "ML", "Basal", "Basal", "ML", "LP", "Basal", "ML", "LP")) ;
x$samples$group <- group;
x$samples;
#rm(group);
### lane factor foreach-9
lane <- as.factor(rep(c("L004", "L006", "L008"), c(3, 4, 2))) ;
x$samples$lane <- lane;
x$samples;
#rm(lane);
## Organising gene annotations
#source("https://bioconductor.org/biocLite.R");
#biocLite("Mus.musculus");
#library(Mus.musculus);
source(paste0("Lib/", "Mus.musculus.Util.R"));
# loads library
# AnnotationDbi, stats4, BiocGenerics, parallel, Biobase, IRanges, S4Vectors
# OrganismDbi, GenomicFeatures, GenomeInfoDb, GenomicRanges, GO.db, org.Mm.eg.db,
# TxDb.Mmusculus.UCSC.mm10.knownGene
head(rownames(x), 10);
geneIdKeys <- rownames(x) ;
### foearch rowname select cols in ENTREZID
geneColumns <- c("SYMBOL", "TXCHROM");
#genes <- AnnotationDbi::select(Mus.musculus, keys = geneIdKeys, columns = geneColumns, keytype = geneKeyType);
genes <- EntrezIdSymbolChromosome(geneList = geneIdKeys, geneColumns = geneColumns, geneKeyType = geneKeyType);
dim(genes);
colnames(genes);
head(genes);
### rm duplicates
genes <- genes[!duplicated(genes$ENTREZID),];
dim(genes);
colnames(genes);
head(genes);
### match genes
x$genes <- genes;
x;
# Data pre-processing
## Transformations from the raw-scale
#simpleCountsPerMillion <- edgeR::cpm(x) ;
simpleCountsPerMillion <- CountsPerMillion(x);
#logCountsPerMillion <- edgeR::cpm(x, log = TRUE);
logCountsPerMillion <- CountsPerMillion(x, TRUE);
## Removing genes that are lowly expressed
table(rowSums(x$counts == 0) == 9);
keep.exprs <- rowSums(simpleCountsPerMillion > 1) >= 3;
x <- x[keep.exprs, , keep.lib.sizes = FALSE];
dim(x);
#library(RColorBrewer);
source(paste0("Lib/", "RColorBrewer.Util.R"));
sampleCount <- ncol(x);
#pairedColors <- RColorBrewer::brewer.pal(sampleCount, "Paired");
pairedColors <- ColorPalette(sampleCount, "Paired");
par(mfrow = c(1, 2));
plot(density(logCountsPerMillion[, 1]), col = pairedColors[1], lwd = 2, ylim = c(0, 0.21), las = 2, main = "", xlab = "");
title(main = "A. Raw data", xlab = "Log-cpm");
abline(v = 0, lty = 3);
for (i in 2:sampleCount){
  den <- density(logCountsPerMillion[, i]);
  lines(den$x, den$y, col = pairedColors[i], lwd = 2);
}
legend("topright", samplenames, text.col = pairedColors, bty = "n");

#logCountsPerMillion <- edgeR::cpm(x, log = TRUE);
logCountsPerMillion <- CountsPerMillion(x, TRUE);
plot(density(logCountsPerMillion[, 1]), col = pairedColors[1], lwd = 2, ylim = c(0, 0.21), las = 2, main = "", xlab = "");
title(main = "B. Filtered data", xlab = "Log-cpm");
abline(v = 0, lty = 3);
for (i in 2:sampleCount){
  den <- density(logCountsPerMillion[, i]);
  lines(den$x, den$y, col = pairedColors[i], lwd = 2);
}
legend("topright", samplenames, text.col = pairedColors, bty = "n");
## Normalising gene expression distributions
#x <- edgeR::calcNormFactors(x, method = "TMM");
x <- CalculateNormalizationFactors(x, "TMM");
x$samples$norm.factors;
x2 <- x
x2$samples$norm.factors <- 1;
x2$counts[, 1] <- ceiling(x2$counts[, 1]*0.05);
x2$counts[, 2] <- x2$counts[, 2]*5;
par(mfrow = c(1, 2));
#logCountsPerMillion <- edgeR::cpm(x2, log=TRUE);
logCountsPerMillion <- CountsPerMillion(x2, TRUE);
boxplot(logCountsPerMillion, las = 2, col = pairedColors, main ="");
title(main = "A. Example: Unnormalised data", ylab = "Log-cpm");

#x2 <- edgeR::calcNormFactors(x2);
x2 <- CalculateNormalizationFactors(x2);
x2$samples$norm.factors;
#logCountsPerMillion <- edgeR::cpm(x2, log=TRUE);
logCountsPerMillion <- CountsPerMillion(x2, TRUE);
boxplot(logCountsPerMillion, las = 2, col = pairedColors, main = "");
title(main = "B. Example: Normalised data", ylab = "Log-cpm");
## Unsupervised clustering of samples
#logCountsPerMillion <- edgeR::cpm(x, log=TRUE);
logCountsPerMillion <- CountsPerMillion(x, TRUE);
par(mfrow = c(1,2));
col.group <- group;
#levels(col.group) <- RColorBrewer::brewer.pal(nlevels(col.group), "Set1");
levels(col.group) <- ColorPalette(nlevels(col.group), "Set1");

col.group <- as.character(col.group);
col.lane <- lane;
#levels(col.lane) <- RColorBrewer::brewer.pal(nlevels(col.lane), "Set2");
levels(col.lane) <- ColorPalette(nlevels(col.lane), "Set2");

col.lane <- as.character(col.lane);
#library(limma)
source(paste0("Lib/", "limma.Util.R"));
#limma::plotMDS(logCountsPerMillion, labels = group, col = col.group);
PlotMultiDimensionalScaling(logCountsPerMillion, group, col.group);
title(main="A. Sample groups");

#limma::plotMDS(logCountsPerMillion, labels = lane, col = col.lane, dim = c(3,4));
PlotMultiDimensionalScalingFixed(logCountsPerMillion, lane, col.lane, c(3,4));
title(main="B. Sequencing lanes");
## http://bioinf.wehi.edu.au/folders/limmaWorkflow/glimma-plots/MDS-Plot.html
#source("https://bioconductor.org/biocLite.R");
#biocLite("Glimma");
library(Glimma);
Glimma::glMDSPlot(logCountsPerMillion, labels = paste(group, lane, sep = "_"), groups = x$samples[,c(2,5)], launch = FALSE);
# Differential expression analysis
## Creating a design matrix and contrasts
design <- model.matrix(~0 + group + lane);
colnames(design) <- gsub("group", "", colnames(design));
colnames(design);
design;

contr.matrix <- limma::makeContrasts(
  BasalvsLP = Basal - LP,
  BasalvsML = Basal - ML,
  LPvsML = LP - ML,
  levels = colnames(design));
contr.matrix;
## Removing heteroscedascity from count data
#v <- limma::voom(x, design, plot = TRUE);
v <- PlotRNASeqDataReadyLinearModel(x, design);
v;
## Fitting linear models for comparisons of interest
#vfit <- limma::lmFit(v, design);
uArrayLinearModelFit <- LinearModelFitToDesign(v, design);
#uArrayLinearModelContrast <- limma::contrasts.fit(uArrayLinearModelFit, contrasts = contr.matrix);
uArrayLinearModelContrast <- LinearModelFitToContrast(uArrayLinearModelFit, contrastMatrix = contr.matrix);
uArrayLinearModelebayes <- LinearModelFitToEmpBayes(uArrayLinearModelContrast);
PlotMicroArrayLinearModelSigmaVsAverageLogExpression(uArrayLinearModelebayes);
## Examining the number of DE genes
#summary(limma::decideTests(uArrayLinearModelebayes));
DifferentialExpressionSum(uArrayLinearModelebayes);
#tfit <- limma::treat(uArrayLinearModelContrast, lfc = 1);
tfit <- LinearModelTreatment(uArrayLinearModelContrast);
#dt <- limma::decideTests(tfit);
dt <- ClassifyTtestGenesAcross(tfit);
summary(dt);
de.common <- which(dt[,1] != 0 & dt[,2] != 0);
length(de.common);
head(tfit$genes$SYMBOL[de.common], n = 20);
#limma::vennDiagram(dt[,1:2], circle.col = c("turquoise", "salmon"));
TwoGroupVennDiagram(dt[,1:2]);
#limma::write.fit(tfit, dt, file = "Doc/results.txt");
MArrayLMToFile(tfit, aTestResults = dt, filePath = "Doc/results.txt");
## Examining individual DE genes from top to bottom
#basal.vs.lp <- limma::topTreat(tfit, coef = 1, n = Inf);
basal.vs.lp <- LinearModelFitToTopGenes(tfit, coefficient = 1);
head(basal.vs.lp);
#basal.vs.ml <- limma::topTreat(tfit, coef = 2, n = Inf);
basal.vs.ml <- LinearModelFitToTopGenes(tfit, coefficient = 2);
head(basal.vs.ml);
## Useful graphical representations of differential expression results BasalvsLP
limma::plotMD(tfit, column = 1, status = dt[, 1], main = colnames(tfit)[1], xlim = c(-8, 13));
#***
Glimma::glMDPlot(tfit, coef = 1, status = dt, main = colnames(tfit)[1],
         id.column = "ENTREZID", counts = x$counts, groups = group, launch = FALSE);

library(gplots);
basal.vs.lp.topgenes <- basal.vs.lp$ENTREZID[1:100];
i <- which(v$genes$ENTREZID %in% basal.vs.lp.topgenes);
mycol <- gplots::colorpanel(1000, "blue", "white", "red");
gplots::heatmap.2(v$E[i, ], scale = "row",
          labRow = v$genes$SYMBOL[i], labCol = group,
          col = mycol, trace = "none", density.info = "none", 
          margin = c(8, 6), lhei = c(2, 10), dendrogram = "column");
# Gene set testing with camera
# http://bioinf.wehi.edu.au/software/MSigDB/
# http://bioinf.wehi.edu.au/software/MSigDB/mouse_c2_v5p1.rdata : Mm.c2
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c2_v5p1.rdata")) ;
idx <- limma::ids2indices(Mm.c2, id = rownames(v)) ;
cam.BasalvsLP <- limma::camera(v, idx, design, contrast = contr.matrix[,1]) ;
head(cam.BasalvsLP,5);
cam.BasalvsML <- limma::camera(v, idx, design, contrast = contr.matrix[,2]) ;
head(cam.BasalvsML,5);
cam.LPvsML    <- limma::camera(v, idx, design, contrast = contr.matrix[,3]) ;
head(cam.LPvsML,5);

limma::barcodeplot(uArrayLinearModelebayes$t[,3], index = idx$LIM_MAMMARY_LUMINAL_MATURE_UP, 
            index2 = idx$LIM_MAMMARY_LUMINAL_MATURE_DN, main = "LPvsML");
# Software availability

