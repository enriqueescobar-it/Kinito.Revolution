getwd() ;
scriptDir   <- "C:/Scripts/RUtils" ;
setwd(scriptDir) ;
getwd() ;
dataDir <- Sys.getenv("DataRoot") ;
dataDir  <- gsub("\\\\", "/", dataDir) ;
setwd(dataDir) ;
getwd() ;
ramList <- list.files(path = getwd(),
            pattern = paste (Sys.getenv("COMPUTERNAME"),"MemoryPhysicalInfo", sep = "_"),
            all.files = TRUE, full.names = TRUE,
            recursive = FALSE, ignore.case = FALSE,
            include.dirs = TRUE) ;
ramList ;
ramDAT  <- read.csv(ramList[2], sep="\t", header=TRUE) ;
ramDAT