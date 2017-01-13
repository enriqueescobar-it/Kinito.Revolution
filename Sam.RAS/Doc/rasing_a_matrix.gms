$TITLE PROGRAM TO CARRY OUT RAS OF CONSUMPTION SHARES
$OFFSYMLIST OFFSYMXREF OFFUPPER
* Program requires specification of row and column indices
* If square matrix, only one set need be provided,
* and ALIAS statements changed
SETS
I SECTORS / FarmFood Farm Food Crops
            Nonfood Farm Nonfood Crops
            Livestck Livestock
            Forestry Forestry
            Fishery Fishery
            OilGas Coal Gas & Oil
            OthMines Other Mining
            Foodproc Food Bev & Tobacco
            Textiles Textiles & Leather
            WoodFurn Wood & Furniture
            PapPrint Paper & Printing
            ChemRef Chemicals & Fertilizers
            RefinLNG Refining LNG & Coal
            Nometmin Nonmetallic Mineral
            BasicMet Basic Metals
            Machines Metal Prod & Machines
            OthIndus Other Industry
            Utility Elect Gas & Water
            Construc Construction
            TradStor Trade & Storage
            RestHot Restaurants & Hotels
            LandTran Rail & Road Transpor
            OthTrans Sea Air Trans & Comm
            FinServ Financial Serv & Insur
            BusServ Real Estate
            PubAdmin Public Admin
            OthServ Social & Other Serv/,
HH HOUSEHOLD TYPE / rurwork Ag worker households
                    rurcap Ag owners households
                    urbwork Low wage households
                    urbcap High wage households/
;
* Program requires three different data inputs:
* CONFLOW: the matrix of original flows
* C0: column containing row sum controls
* CON: column containing column sum controls
TABLE CONFLOW(i,hh) INITIAL PRIVATE CONSUMPTION FLOWS
         rurwork  rurcap urbwork urbcap
FarmFood  165.56 5356.08 1331.07 2757.31
Nonfood   149.77  410.60  154.18  357.37
Livestck  141.53  905.99  501.23 1904.72
Forestry   56.70  141.65   55.69   56.52
Fishery   170.94  849.68  394.32  932.19
OilGas       .00     .00     .00     .00
OthMines     .22     .86     .29     .56
Foodproc 1169.48 5245.54 2777.09 6066.52
Textiles   82.61  529.25  279.48  806.17
Woodfurn   18.70  125.78   63.12  249.40
PapPrint    5.10   54.76   33.10  151.39
ChemRef    47.13  432.05  299.22  844.25
RefinLNG   56.26  515.80  357.23 1007.92
Nometmin    2.33   21.38   14.80   41.75
BasicMet     .00     .00     .00     .00
Machines   44.89  481.86  291.23 1332.10
OthIndus    3.67   39.38   23.80  108.85
Utility     5.63   51.97  119.31  413.36
Construc     .00     .00     .00     .00
TradStor    3.20   18.64   39.30  113.54
RestHot   108.44 1045.05 1061.97 2564.35
LandTran   42.85  313.51  600.14 1737.71
OthTrans   13.25  147.42  277.10  994.59
FinServ    23.17  300.03  136.31  589.15
BusServ    87.98  779.65  700.31 1979.36
PubAdmin     .00     .00     .00     .00
OthServ   116.65  853.46  987.11 4353.09
;
PARAMETER c0(i) Control vector ;
c0("FarmFood") = 6394.42 ;
c0("Nonfood") =   990.61 ;
c0("Livestck") = 2661.24 ;
c0("Forestry") =  259.31 ;
c0("Fishery") =  1569.93 ;
c0("OilGas") =       .00 ;
c0("OthMines") =     .21 ;
c0("Foodproc") =13911.94 ;
c0("Textiles") = 1367.44 ;
c0("Woodfurn") =  329.88 ;
c0("PapPrint") =  161.59 ;
c0("ChemRef") =  1160.43 ;
c0("RefinLNG") = 1385.44 ;
c0("Nometmin") =   57.41 ;
c0("BasicMet") =     .00 ;
c0("Machines") = 1419.86 ;
c0("OthIndus")=   116.05 ;
c0("Utility") =   523.35 ;
c0("Construc")=      .00 ;
c0("TradStor")=  5737.68 ;
c0("RestHot") =  4553.91 ;
c0("LandTran")=  3552.82 ;
c0("OthTrans")=  1607.77 ;
c0("FinServ") =   883.65 ;
c0("BusServ") =  3287.49 ;
c0("PubAdmin")=      .00 ;
c0("OthServ") =  9063.46 ;
PARAMETER CON(hh) AGGREGATE CONSUMPTION LEVELS ;
CON("rurwork") =  2516.05 ;
CON("rurcap")  = 18620.37 ;
CON("urbwork") = 10497.40 ;
CON("urbcap")  = 29362.18 ;
ALIAS(I,RR) ;
ALIAS(HH,CC) ;
PARAMETER a0(rr,cc) Initial coefficients matrix to RAS
          a1(rr,cc) Final coefficients matrix after RAS
          rasmat0(rr,cc) Initial flows matrix to RAS
          ct(cc) RAS column control totals
          rt(rr) RAS row control totals
          ratio Adjustment parameter on control totals
          checkcol Check sum of column control totals
          checkrow Check sum of row control totals
          sumccc Original column sums of RAS matrix
          sumrrr Original row sums of RAS matrix
;
VARIABLES
         DEV Deviations
         RASMAT(rr,cc) RASed matrix
         R1(rr) Rho of RAS matrix
         S1(cc) Sigma of RAS matrix
         LOSS Objective (loss) function value
;
* Parameter initialization
sumccc(cc)     = SUM(rr, conflow(rr,cc) ) ;
sumrrr(rr)     = SUM(cc, conflow(rr,cc) ) ;
a0(rr,cc)      = conflow(rr,cc) / sumccc(cc) ;
rasmat0(rr,cc) = a0(rr,cc) * CON(cc) ;
ct(cc)         = CON(cc) ;
rt(rr)         = c0(rr) ;
ratio          = SUM(rr, rt(rr)) / SUM(cc, ct(cc)) ;
ct(cc)         = ct(cc) * ratio ;
checkcol       = SUM(cc, ct(cc) );
checkrow       = SUM(rr, rt(rr) );
display ratio, checkcol, checkrow ;

display conflow, a0 ;

display con, ct ;
display c0, rt ;
* Variable initialization

         DEV.L = 0.0 ;
         R1.L(rr) = 1 ;
         S1.L(cc) = 1 ;
         RASMAT.L(rr,cc) = a0(rr,cc) * ct(cc) ;
         CON(cc) = ct(cc) ;
EQUATIONS
         BIPROP(rr,cc) Bi-proportionality for RAS matrix
         DEVSQ Definition of squared deviations
         OBJ Objective function
         RCONST(rr) Row constraint
         CCONST(cc) Column constraint
;
BIPROP(rr,cc).. RASMAT(rr,cc) =E= R1(rr)*S1(cc)*rasmat0(rr,cc) ;
CCONST(cc)..    ct(cc) =E= SUM(rr, RASMAT(rr,cc)) ;
RCONST(rr)..    rt(rr) =E= SUM(cc, RASMAT(rr,cc)) ;
DEVSQ..         DEV =E= SUM( (rr,cc)$rasmat0(rr,cc),
                SQR( (RASMAT(rr,cc) - rasmat0(rr,cc)) / rasmat0(rr,cc)) ) ;
OBJ..           LOSS =E= SUM(rr, R1(rr)**2 + (1/R1(rr))**2 )
                         + SUM(cc, S1(cc)**2 + (1/S1(cc))**2 ) ;

* Variable bounds
         RASMAT.LO(rr,cc) = 0.0 ;
         R1.LO(rr)        = 0.01 ;
         S1.LO(cc)        = 0.01 ;
MODEL CONSUMERAS / BIPROP
                   CCONST
                   RCONST
*                  DEVSQ
                   OBJ / ;
*DEVSQ is commented out

OPTIONS ITERLIM=10000,LIMROW=0,LIMCOL=0,SOLPRINT=OFF ;
SOLVE CONSUMERAS USING NLP MINIMIZING LOSS ;
display rasmat.l, r1.l, s1.l ;
a1(rr,cc) = rasmat.l(rr,cc) / ct(cc) ;
display a0, a1 ;