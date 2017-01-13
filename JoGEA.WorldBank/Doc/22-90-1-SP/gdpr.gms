* ------------------------------------------------------------------------------
*
*     Example of a GAMS file that calls R to extract data from
*        the World Bank's WDI database
*
*     Description:
*        This GAMS file provides an example of how to combine GAMS with R to
*        extract data from the World Bank's World Development Indicators
*        Database (WDI). The user prepares a list of countries and indicators to
*        extract from WDI, including the range of years. The GAMS program will
*        save all of this information in a text file and then invoke R as a
*        sub-process (using R's RScript program). If successful, the R script
*        will save the extracted data as a CSV file. The file is converted to
*        a GDX gile before being read back in to the GAMS file. This is
*        necessary because CSV files are read-in at compile time, but GDX files
*        are read in at execution time. A utility called CSV_GDX_Tools is used
*        to convert the R-outputted CSV file, to the GDX format.
*        N.B. When reading CSV files GAMS does not want a header line in the
*        data file that describes the different fields in the CSV file.
*        However the CSV to GDX converter, and many database-type translators
*        of CSV files, such as Excel's pivot table feature require
*        the header line. This is one of the user options provided below.
*
*     Requirements:
*
*        isocodes.gms:  A file containing a current set of ISO-2 and ISO-3 codes
*                       with their mapping. In addition, the file contains a
*                       mapping from ISO-3 to the GTAP regions.
*
*        R:             The RScript function is used to run R in background.
*                       When invoked, RScript should be in the system's path.
*                       If not, invoke R with full path name.
*
*        CSV_GDX_Tools  The CSV to GDX conversion program. It needs to be
*                       in the system's path, or else, the full path name
*                       needs to be provided. (N.B. The tool also requires
*                       a file called 'forbiddenwords.txt' that should be
*                       in the same folder as the conversion tool.)
*
*        extractWDI.R   The name of the R script file that performs the
*                       extraction from WDI and saves the data as a CSV file.
*                       Users are welcome to modify and/or rename the file.
*
*     User inputs:
*
*        BASENAME       This will be the base file name for all of the
*                       files created by the program.
*
*        FIRSTYR        First year to extract. The extraction routine requires a
*                       continuous range.
*
*        LASTYR         The last year to extract.
*
*        EXTALL         A true or false flag. If 'true' the extraction routine
*                       will download the data for all countries in the WDI
*                       database for the selected indicators. Any country
*                       information (for example as defined in the subset 'c2'
*                       will be ignored. If 'false', only data for countries
*                       identified in the subset 'c2' will be extracted.
*
*        IFHEADER       A true or false flag. If 'true' a header line will be
*                       included at the top of the CSV file with labels for the
*                       CSV file fields. If 'false', no header line will be
*                       output. For reading the CSV data into GAMS, the flag
*                       should be set to 'false'.
*
*        IFNAME         A true or false flag. The WDI extraction also retrieves
*                       the country names. If this flag is set to 'false', the
*                       country names will not be saved with the data. These can
*                       nonetheless be retrieved by the GAMS code since the
*                       country names are provided with the set definitions. The
*                       information is therefore redundant and takes up storage
*                       space (and can also not be readily read into a GAMS
*                       matrix). Set to 'true' to save the country names with
*                       the CSV data.
*
*        c2             C2 is a subset of the ISO-2 codes (that are used by the
*                       WDI extraction routine). The subset is user-defined and
*                       contains the ISO-2 codes for the countries which are to
*                       be extracted. The subset is ignored if 'EXTALL' is set
*                       to 'true'.
*
*        var            Var is a set of indicators to extract. The user provides
*                       short names for the extracted indicators--though is free
*                       to use the same mnemonic as the World Bank database. The
*                       set Var must be paired with the set wbind and the mapv
*                       mapping (see below).
*
*        wbind          WBInd is a set of indicators to extract using the WB's
*                       mnemonics. It is typically paired with the set Var and
*                       the mapping mapv.
*
*        mapv           The set mapv pairs the user-named indicators (Var) with
*                       the WB-named indicators (WBInd). It should be a
*                       one-to-one mapping.
*
* --------------------------------------------------------------------------------------------------

acronym true, false ;

*  Read the ISO-2, ISO-3 and GTAP codes and mappings

$offlisting
$include "isocodes.gms"
$onlisting

* ------------------------------------------------------------------------------
*
*  BEGINNNING OF USER INPUT
*
* ------------------------------------------------------------------------------

*  System options
$setglobal  R_EXE      "C:\Program Files\R\R-3.2.2\bin\RScript"
$setglobal  CSVGDX     "V:\bin\CSV_GDX_Tools"
$setglobal  RSCRIPT    "extractWDI.R"

*  User options
$setglobal  BASENAME   "GDPR"
$setglobal  FIRSTYR    2000
$setglobal  LASTYR     2014
$setglobal  EXTALL     false
$setglobal  IFHEADER   true
$setglobal  IFNAME     false

*  NOTE: If EXTALL is set to true, the following subset will be ignored
*        no matter how it is defined.

set c2(iso2) "Countries to extract" / fr, us, gb, be, bz / ;

set var "Indicators to extract" /
   "pop"
   "gdpcd"
   "gdpkd"
   "gnpppcd"
   "gnpppkd"
/ ;

set wbind "WB indicators to extract" /
   "SP.POP.TOTL"
   "NY.GDP.MKTP.CD"
   "NY.GDP.MKTP.KD"
   "NY.GDP.PCAP.PP.CD"
   "NY.GDP.PCAP.PP.KD"
/ ;

set mapv(var, wbind) "Mapping of variable names to WB indicators" /
   "pop"     . "SP.POP.TOTL"
   "gdpcd"   . "NY.GDP.MKTP.CD"
   "gdpkd"   . "NY.GDP.MKTP.KD"
   "gnpppcd" . "NY.GDP.PCAP.PP.CD"
   "gnpppkd" . "NY.GDP.PCAP.PP.KD"
/ ;

parameter scale(var) "Scaling factor for indicators" /
   "pop"       1e-6
   "gdpcd"     1e-6
   "gdpkd"     1e-6
   "gnpppcd"   1e-0
   "gnpppkd"   1e-0
/ ;

* ------------------------------------------------------------------------------
*
*  END OF USER INPUT
*
* ------------------------------------------------------------------------------

sets
   year     "Years to extract"      / %FIRSTYR%*%LASTYR% /
   y0(year) "First extraction year" / %FIRSTYR% /
   yf(year) "Last extraction year"  / %LASTYR% /
;

set c(iso3)  "Countries being extracted with ISO-3 codes" ;

if(%EXTALL% eq false,
   loop(mapISO(iso2,iso3)$c2(iso2),
      c(iso3) = yes ;
   ) ;
else
   c(iso3) = yes ;
) ;

*  Delete intermediate files if they exist

$if exist "%BASENAME%.opt" $call 'del "%BASENAME%.opt"'
$if exist "%BASENAME%.csv" $call 'del "%BASENAME%.csv"'

file fopt / "%BASENAME%.opt" / ;
put fopt ;
put '"Name","Value"' / ;

put '"Output file", "%BASENAME%.csv"' / ;

loop(y0, put '"Start year", ', y0.tl / ; ) ;
loop(yf, put '"End year", ', yf.tl / ; ) ;

if(%IFHEADER% eq false,
   put '"Header", "FALSE"' / ;
else
   put '"Header", "TRUE"' / ;
) ;

if(%IFNAME% eq false,
   put '"Country name", "FALSE"' / ;
else
   put '"Country name", "TRUE"' / ;
) ;

scalar ifFirst / 1 / ;

put '"Regions", "' ;
if(%EXTALL% eq false,
   loop(c2,
      if(ifFirst,
         put c2.tl:2 ;
         ifFirst = 0 ;
      else
         put ',', c2.tl:2 ;
      ) ;
   ) ;
else
   put "all" ;
) ;

put '"' / ;
put '"Indicators","wbName"' / ;
fopt.pc=5 ;
loop(mapv(var,wbind),
   put var.tl, wbind.tl / ;
) ;
putclose fopt ;

*  Extract the data using R
execute '"%R_EXE%" %RSCRIPT% %BASENAME%.opt'

*  Convert the data to GDX format
execute '%CSVGDX% "%BASENAME%.csv" comma "All" "Var,iso3,Year" /method=csvgdx /PARNAME=wdiData /GDX=%BASENAME%.gdx'

*  Load the GDX data

parameter
   wdiData(var,iso3,year)
;
execute_load "%BASENAME%.gdx", wdiData ;

*  Process the read-in data
wdiData(var,c,year) = scale(var)*wdiData(var,c,year) ;
option decimals=0 ;
display wdiData ;

*  Cleanup intermediate files
if(1,
$if exist "%BASENAME%.opt"  $call 'del "%BASENAME%.opt"'
$if exist "%BASENAME%.csv"  $call 'del "%BASENAME%.csv"'
$if exist "%BASENAME%.gref" $call 'del "%BASENAME%.gref"'
) ;
