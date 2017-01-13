# ---------------------------------------------------------------------
#
#     Code to extract data series from WDI and create line charts
#                  for a Latex-based Beamer presentation
#
#     Original code by:       Dominique van der Mensbrugghe
#
# ---------------------------------------------------------------------
# >>>>> BEGINNING OF USER INPUT
# Set output directory (use './' for default directory
# Windows
outwd <- "v:/data/wdi/"
# MAC
# outwd <- "~/Documents/Dominique/data/wdi/"
# Set file name
fName <- "pptExample.tex"
fName <- paste(outwd, fName, sep="")
# Set title, author and address (Use \\ to separate lines)
pTitle <- "Example of creating slides from an R-based WDI extraction procedure"
shortTitle <- "WDI Charts"
author <- "Dominique van der Mensbrugghe"
nickName <- "DvdM"
address <- "Center for Global Trade Analysis (GTAP) \\\\ Purdue University \\\\ West Lafayette, IN"
institute <- "GTAP"
#  Set the beginning year
begYear  <- 1990
#  Set the final year
endYear  <- 2013
#  Select the regions to be extracted
#  The regions are an r x 3 matrix were r is the number of regions
#  Column 1 is the region ISO-2 code and is used for the extraction
#  Column 2 is the region ISO-3 code (and will be used for the legend, and otherwise can be changed)
#  Column 3 is the region name (and currently ignored)
regions <- rbind(cbind("4e","EAP","East Asia & Pacific"),
                 cbind("8S","SAS","South Asia"),
                 cbind("7E","ECA","Europe & Central Asia"),
                 cbind("XQ","MNA","Middle East & North Africa"),
                 cbind("ZF","SSA","Sub-Saharan Africa"),
                 cbind("XJ","LAC","Latin America & Caribbean"),
                 cbind("XD","HIC","High-income countries")
               )
#  Select the indicators
#  The indicators are an n x 4 matrix were n is the number of indicators
#  Column 1 is an indicator name (ignored for the moment)
#  Column 2 is the WB CETS code and is used for the extraction
#  Column 3 is a scale that will be used to scale the output data
#  Column 4 is a descriptor for the indicator -- it will be used as the chart title
indTable <- rbind(cbind("pop","sp.pop.totl",1e6,"Population (million)"),
                  cbind("gdpkd","ny.gnp.mktp.kd",1e9, "GDP (\\$2005 billion)"),
                  cbind("gdpkdpp","ny.gdp.mktp.pp.kd",1e12, "GDP (\\$2005PPP trillion)"),
                  cbind("gdppckd","ny.gnp.pcap.kd",1e0, "GDP per capita (\\$2005)"),
                  cbind("gdppckdpp","ny.gdp.pcap.pp.kd",1e0, "GDP per capita (\\$2005PPP)")
               )
#  Set the colors for the lines -- check Latex's 'xcolor' package for additional choices
Colors <- rbind(
      "blue",
      "LightSkyBlue",
      "DarkGrey",
      "ForestGreen",
      "red",
      "black",
      "Orchid",
      "Goldenrod",
      "ForestGreen",
      "red",
      "black",
      "Orchid",
      "Goldenrod"
)
# END OF USER INPUT <<<<<
# ---------------------------------------------------------------------
#
#  Main part of WDI extraction
#
# ---------------------------------------------------------------------
#  Load the WDI library
library(WDI)
#  Get the number of indicators and regions
nInd <- nrow(indTable)
nReg <- nrow(regions)
maxColor <- nrow(Colors)
#  Get the iso2 codes
iso2 <- toupper(regions[,1])
# Write the Latex file preamble -- note that it is possible to change 'beamer' themes and theme colors
sink(fName,append=FALSE, split=FALSE)
cat("\\documentclass[xcolor={dvipsnames,svgnames}]{beamer}\n")
cat("\\usetheme{CambridgeUS}\n")
cat("\\usecolortheme{orchid}\n\n")
cat("\\usepackage{pgfplots}\n\n")
cat("\\begin{document}\n\n")
cat("\\pgfplotsset{every axis/.append style={line width=0.75pt}, axis x line*=bottom, axis y line*=left}\n")
cat("\\pgfsetplotmarksize{0pt}\n\n")
cat("\\title[",shortTitle,"]{",pTitle,"}\n",sep="")
cat("\\author[",nickName,"]{",author,"}\n",sep="")
cat("\\institute[",institute,"]{",address,"}\n",sep="")
cat("\\date{\\today}\n")
cat("\\frame{\\titlepage}\n\n")
sink()
#  Loop over all indicators
for (i in 1:nInd) {
#  Get the data from the WDI database
   cube <- WDI(iso2, indicator=indTable[i,2], start=begYear, endYear)
#  Save the chart pre-amble
   sink(fName,append=TRUE,split=FALSE)
   cat("\\frame{\\frametitle{",indTable[i,4],"}\n", sep="")
   cat("\\begin{figure}[h]\n")
   cat("\\centering\n")
   cat("\\begin{tikzpicture}[scale=0.5]\n")
   cat("\\begin{axis}[width=19.0cm, height=13.5cm,\n")
   cat("   xlabel={Year},\n")
   cat("   xmin={",begYear-1,"},\n",sep="")
   cat("   xmax={",endYear,"},\n",sep="")
   cat("   ymajorgrids,\n")
   cat("   legend style={draw=none},\n")
   cat("   x tick label style={/pgf/number format/.cd, scaled x ticks = false,set thousands separator={},fixed},\n")
   cat("   y tick label style={/pgf/number format/.cd, scaled y ticks = false,set decimal separator={.},fixed},\n")
   cat("   legend style={at={(1.03,0.5)},anchor=west,font=\\footnotesize},\n")
   cat("   legend cell align=left\n")
   cat("   ]\n")
#  Set the scale for this  indicator and initialize the color table
   indScale <- as.numeric(indTable[i,3])
   nColor <- 0
#  Loop over all regions and write out the data
   for(r in 1:nReg) {
      nColor <- nColor + 1
      if(nColor > maxColor) nColor <- 1
#     Get the data for the selected region
      regData <- cube[cube$iso2c==iso2[r],c("iso2c", indTable[i,2], "year")]
#     Sort the data by year
      x <- regData[order(regData$year),]
#     Get the number of years
      nYear = nrow(x)
#     Save the data for this indicator
      cat("\\addplot+[",Colors[nColor],",smooth,line width=2.0pt] coordinates\n",sep="")
      cat("{\n")
      for(t in 1:nYear) {
         cat("(",x[t,3],",",x[t,2]/(indScale),")\n",sep="")
      }
      cat("};\n")
      cat("\\addlegendentry{",regions[r,2],"}\n",sep="")
   }
#  End the graph
   cat("\\end{axis}\n")
   cat("\\end{tikzpicture}\n")
   cat("\\end{figure}\n")
   cat("}\n\n")
   sink()
}
# Write the Latex closing
sink(fName,append=TRUE,split=FALSE)
cat("\\end{document}\n\n")
sink()
