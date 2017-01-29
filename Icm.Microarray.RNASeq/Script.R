# modify this path to you local repository
# Windows machines have a environment variable SystemDrive=C:
# I use my own for working directory as DataDrive & REPO_DIR
localRepository <- Sys.getenv("DataDrive");
localRepository <- paste0(localRepository, "/", Sys.getenv("REPO_DIR"));
write(paste0(c("Repository ...\t", localRepository), sep = "", collapse = ""), stdout());
# solution is the folder containing the project
projectSolution <- "Kinito.Revolution";
write(paste0(c("Solution .....\t", projectSolution), sep = "", collapse = ""), stdout());
# project is the project's name
projectName <- "Icm.Microarray.RNASeq";
write(paste0(c("Project ......\t", projectName), sep = "", collapse = ""), stdout());
# namespace
projectNamespace <- "";
projectNamespace <- if(projectSolution == projectName) projectSolution else paste0(projectSolution, ".", projectName);
write(paste0(c("Namespace ....\t", projectNamespace), sep = "", collapse = ""), stdout());
# common
projectCommon <- "RCommon";
write(paste0(c("Common .......\t", projectCommon), sep = "", collapse = ""), stdout());
# path
projectPath <- "";
projectPath <- if(projectSolution == projectName) projectSolution else paste0(projectSolution, "/", projectName);
write(paste0(c("Path .........\t", projectPath), sep = "", collapse = ""), stdout());
projectPath <- paste0(localRepository, "/", projectPath);
write(paste0(c("Path old .....\t", getwd()), sep = "", collapse = ""), stderr());
write(paste0(c("Path new .....\t", projectPath), sep = "", collapse = ""), stdout());
setwd(projectPath);
# clean
rm(localRepository);
# options
options(scipen = 100);
# session info
sessionInfo();
# attached
search();
# Create a listing of all objects in the "global environment".
ls();
# load project
#source(paste0(projectName, ".R"));
# files <- c("Data/GSM1545535_10_6_5_11.txt",
#            "Data/GSM1545536_9_6_5_11.txt",
#            "Data/GSM1545538_purep53.txt",
#            "Data/GSM1545539_JMS8-2.txt",
#            "Data/GSM1545540_JMS8-3.txt",
#            "Data/GSM1545541_JMS8-4.txt",
#            "Data/GSM1545542_JMS8-5.txt",
#            "Data/GSM1545544_JMS9-P7c.txt",
#            "Data/GSM1545545_JMS9-P8c.txt");
# read.delim(files[1], nrow=5)
# library(limma)
# library(edgeR)
# x <- readDGE(files, columns=c(1,3))
# class(x); dim(x)
# samplenames <- substring(colnames(x), 17, nchar(colnames(x)))
# samplenames
# colnames(x) <- samplenames
# group <- as.factor(c("LP", "ML", "Basal", "Basal", "ML", "LP", "Basal", "ML", "LP"))
# x$samples$group <- group
# lane <- as.factor(rep(c("L004","L006","L008"), c(3,4,2)))
# x$samples$lane <- lane
# x$samples
# library(Mus.musculus)
# geneid <- rownames(x)
# genes <- select(Mus.musculus, keys=geneid, columns=c("SYMBOL", "TXCHROM"),
#                 keytype="ENTREZID")
# dim(genes);head(genes)
# genes <- genes[!duplicated(genes$ENTREZID),]
# x$genes <- genes
# x
# cpm <- cpm(x)
# lcpm <- cpm(x, log=TRUE)
# table(rowSums(x$counts==0)==9)
# keep.exprs <- rowSums(cpm>1)>=3
# x <- x[keep.exprs,, keep.lib.sizes=FALSE]
# dim(x)
# library(RColorBrewer)
# nsamples <- ncol(x)
# col <- brewer.pal(nsamples, "Paired")
# par(mfrow=c(1,2))
# plot(density(lcpm[,1]), col=col[1], lwd=2, ylim=c(0,0.21), las=2,
#      main="", xlab="")
# title(main="A. Raw data", xlab="Log-cpm")
# abline(v=0, lty=3)
# for (i in 2:nsamples){
#   den <- density(lcpm[,i])
#   lines(den$x, den$y, col=col[i], lwd=2)
# }
# legend("topright", samplenames, text.col=col, bty="n")
# lcpm <- cpm(x, log=TRUE)
# plot(density(lcpm[,1]), col=col[1], lwd=2, ylim=c(0,0.21), las=2,
#      main="", xlab="")
# title(main="B. Filtered data", xlab="Log-cpm")
# abline(v=0, lty=3)
# for (i in 2:nsamples){
#   den <- density(lcpm[,i])
#   lines(den$x, den$y, col=col[i], lwd=2)
# }
# legend("topright", samplenames, text.col=col, bty="n")
# x <- calcNormFactors(x, method = "TMM")
# x$samples$norm.factors
# x2 <- x
# x2$samples$norm.factors <- 1
# x2$counts[,1] <- ceiling(x2$counts[,1]*0.05)
# x2$counts[,2] <- x2$counts[,2]*5
# par(mfrow=c(1,2))
# lcpm <- cpm(x2, log=TRUE)
# boxplot(lcpm, las=2, col=col, main="")
# title(main="A. Example: Unnormalised data",ylab="Log-cpm")
# x2 <- calcNormFactors(x2)
# x2$samples$norm.factors
# lcpm <- cpm(x2, log=TRUE)
# boxplot(lcpm, las=2, col=col, main="")
# title(main="B. Example: Normalised data",ylab="Log-cpm")
# lcpm <- cpm(x, log=TRUE)
# par(mfrow=c(1,2))
# col.group <- group
# levels(col.group) <- brewer.pal(nlevels(col.group), "Set1")
# col.group <- as.character(col.group)
# col.lane <- lane
# levels(col.lane) <- brewer.pal(nlevels(col.lane), "Set2")
# col.lane <- as.character(col.lane)
# plotMDS(lcpm, labels=group, col=col.group)
# title(main="A. Sample groups")
# plotMDS(lcpm, labels=lane, col=col.lane, dim=c(3,4))
# title(main="B. Sequencing lanes")
# library(Glimma)
# glMDSPlot(lcpm, labels=paste(group, lane, sep="_"), groups=x$samples[,c(2,5)], launch=FALSE)
# design <- model.matrix(~0+group+lane)
# colnames(design) <- gsub("group", "", colnames(design))
# design
# contr.matrix <- makeContrasts(
#   BasalvsLP = Basal-LP,
#   BasalvsML = Basal - ML,
#   LPvsML = LP - ML,
#   levels = colnames(design))
# contr.matrix
# v <- voom(x, design, plot=TRUE)
# v
# vfit <- lmFit(v, design)
# vfit <- contrasts.fit(vfit, contrasts=contr.matrix)
# efit <- eBayes(vfit)
# plotSA(efit)
# summary(decideTests(efit))
# tfit <- treat(vfit, lfc=1)
# dt <- decideTests(tfit)
# summary(dt)
# de.common <- which(dt[,1]!=0 & dt[,2]!=0)
# length(de.common)
# head(tfit$genes$SYMBOL[de.common], n=20)
# vennDiagram(dt[,1:2], circle.col=c("turquoise", "salmon"))
# write.fit(tfit, dt, file="Doc/results.txt")
# basal.vs.lp <- topTreat(tfit, coef=1, n=Inf)
# basal.vs.ml <- topTreat(tfit, coef=2, n=Inf)
# head(basal.vs.lp)
# head(basal.vs.ml)
# plotMD(tfit, column=1, status=dt[,1], main=colnames(tfit)[1], xlim=c(-8,13))
# glMDPlot(tfit, coef=1, status=dt, main=colnames(tfit)[1], id.column="ENTREZID", counts=x$counts, groups=group, launch=FALSE)
# library(gplots)
# basal.vs.lp.topgenes <- basal.vs.lp$ENTREZID[1:100]
# i <- which(v$genes$ENTREZID %in% basal.vs.lp.topgenes)
# mycol <- colorpanel(1000,"blue","white","red")
# heatmap.2(v$E[i,], scale="row",
#           labRow=v$genes$SYMBOL[i], labCol=group,
#           col=mycol, trace="none", density.info="none",
#           margin=c(8,6), lhei=c(2,10), dendrogram="column")
# load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c2_v5p1.rdata"))
# idx <- ids2indices(Mm.c2,id=rownames(v))
# cam.BasalvsLP <- camera(v,idx,design,contrast=contr.matrix[,1])
# head(cam.BasalvsLP,5)
# cam.BasalvsML <- camera(v,idx,design,contrast=contr.matrix[,2])
# head(cam.BasalvsML,5)
# cam.LPvsML <- camera(v,idx,design,contrast=contr.matrix[,3])
# head(cam.LPvsML,5)
# barcodeplot(efit$t[,3], index=idx$LIM_MAMMARY_LUMINAL_MATURE_UP,
#             index2=idx$LIM_MAMMARY_LUMINAL_MATURE_DN, main="LPvsML")
