$TITLE        SAMBAL PROGRAM
$STITLE       SAM Balancing Program, December 2013
*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to:                      *
*                                                        Andre Lemelin         *
*                                                        Ismael Fofana         *
*                                                        John Cockburn         *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

*=========== 1. Input names of matrix accounts =================================

SETS
I MATRIX ACCOUNTS    /LDO     Labor
                      KDO     Capital
                      LANDO   Land
                      RP      Rural poor households
                      UP      Urban poor households
                      RR      Rural rich households
                      UR      Urban rich households
                      FIRM    Firms
                      GOV     Government
                      ROW     Rest of the world
                      AGR     Agriculture
                      IND     Industry
                      SER     Tradable service sector
                      NTSER   Non tradable services sector
                      DAGR    Domestic demand for agricultural products
                      DIND    Domestic demand for industrial products
                      DSER    Domestic demand for tradable services
                      DNTSER  Domestic demand for non-tradable services
                      EAGR    Exports of agricultural products
                      EIND    Exports of industrial products
                      ESER    Exports of services
                      ACC     Accumulation account
                      TOT     Total /

INT(I) All accounts except total;

ALIAS(I,J);
ALIAS(INT,JNT);
INT(I) = YES;
INT('TOT') = NO;

*============ 2.Input initial matrix ===========================================
PARAMETER
SAM0(I,J) initial matrix ;

*----------------------------------------------------------------------------
* Data input method #1: Table
*----------------------------------------------------------------------------
$ontext
TABLE SAM0(I,J)

                 LDO       KDO     LANDO        RP        UP        RR
RP             10575       324      1099
UP             11351       998
RR              2000       503      3496
UR              2100      6003
FIRM                      4496       471
GOV                        180                  75       496       153
ROW                         39       880
DAGR                                          6003      4246      2347
DIND                                          3419      4421      1803
DSER                                          2500      3335      1501
ACC                                                                205
TOT            26026     12543      5946     11997     12498      6009


+                 UR      FIRM       GOV       ROW       AGR       IND
LDO                                                    10175      2300
KDO                                                     1868      6976
LANDO                                                   5959
UP                                   146
UR                        1898
GOV              502      1292                          1075      3476
ROW                        374
DAGR            1653                                    2548      1302
DIND            4851                                    2000      3604
DSER            2175                                    1992      2858
DNTSER                              8703
EAGR                                          6891
EIND                                          1161
ESER                                          2203
ACC              821      1411      1714      5422
TOT            10002      4975     10563     15677     25617     20516


+                SER     NTSER      DAGR      DIND      DSER    DNTSER
LDO             9597      3953
KDO             3702
GOV              706                 123      2576
ROW                                 2381     10305      1705
AGR                                18634
IND                                          19350
SER                                                    18508
NTSER                                                             8700
DAGR            1203        96
DIND            1950      2351
DSER            3551      2295
TOT            20709      8695     21138     32231     20213      8700


+               EAGR      EIND      ESER       ACC       TOT
LDO                                                    26025
KDO                                                    12546
LANDO                                                   5959
RP                                                     11998
UP                                                     12495
RR                                                      5999
UR                                                     10001
FIRM                                                    4967
GOV              -89                                   10565
ROW                                                    15684
AGR             6984                                   25618
IND                       1158                         20508
SER                                 2198               20706
NTSER                                                   8700
DAGR                                          1731     21129
DIND                                          7831     32230
DSER                                                   20207
DNTSER                                                  8703
EAGR                                                    6891
EIND                                                    1161
ESER                                                    2203
ACC                                                     9573
TOT             6895      1158      2198      9562
;
$offtext

*----------------------------------------------------------------------------
* Data input method #2: *.prn file
*----------------------------------------------------------------------------
* The unbalanced SAM in SAM_unbal1.xls contains NO cross-flows of opposite
* signs.
*$include SAM_unbal1.prn

*----------------------------------------------------------------------------
* Data input method #3: GDX facility
*----------------------------------------------------------------------------
* Note that the specified range, A1:W23 does NOT contain the TOTAL row and
* column.
* The unbalanced SAM in SAM_unbal1.xls contains NO cross-flows of opposite
* signs.
*$CALL GDXXRW SAM_unbal1.xls Par=SAM0 rng=A1:W23
*$GDXIN SAM_unbal1.gdx
*$LOAD SAM0

*----------------------------------------------------------------------------
* Other example input files
*----------------------------------------------------------------------------

* The unbalanced SAM in SAM_unbal2.xls contains a pair of cross-flows that
* are both negative. In the solution, there is one negative flow, and it is
* positioned in the cell with the initial negative flow largest in absolute
* value.
*$CALL GDXXRW SAM_unbal2.xls Par=SAM0 rng=A1:W23
*$GDXIN SAM_unbal2.gdx
*$LOAD SAM0
*----------------------------------------------------------------------------

* In the unbalanced SAM of SAM_unbal3.xls, the pair of negative cross-flows in
* SAM_unbal2.xls have been consolidated, and the result is a single positive
* flow. The solution is identical to that of SAM_unbal2.xls, except for the
* fact that the negative flow in the latter is transposed to a positive flow.
*$CALL GDXXRW SAM_unbal3.xls Par=SAM0 rng=A1:W23
*$GDXIN SAM_unbal3.gdx
*$LOAD SAM0
*----------------------------------------------------------------------------

* The unbalanced SAM in SAM_unbal4.xls contains a pair of cross-flows, the
* larger one of which is negative. In the solution, there is only one flow,
* and it is negative and positioned in the cell with the initial negative flow.
*$CALL GDXXRW SAM_unbal4.xls Par=SAM0 rng=A1:W23
*$GDXIN SAM_unbal4.gdx
*$LOAD SAM0
*----------------------------------------------------------------------------

* The unbalanced SAM in SAM_unbal5.xls contains a pair of cross-flows, the
* larger one of which is positive. In the solution, there is only one flow,
* and it is positive and positioned in the cell with the initial positive flow.
* All other cells are equal to the solution of SAM_unbal4.
$CALL GDXXRW SAM_unbal5.xls Par=SAM0 rng=A1:W23
$GDXIN SAM_unbal5.gdx
$LOAD SAM0

*========== 3. Matrix of negative defined and negative values transposed =======
PARAMETER
NEG(I,J) Matrix of negative values;
NEG(INT,JNT)$[(SAM0(INT,JNT) LT 0)
               AND (SAM0(JNT,INT)-SAM0(INT,JNT) GT 0)
               AND (SAM0(JNT,INT)+SAM0(INT,JNT) LT 0)]=1;
*----------------------------------------------------------------------------
* NOTE:
* In an earlier version of SAMBAL, the NEG parameter was defined a follows
* NEG(INT,JNT)$[(SAM0(INT,JNT) LT 0)
*               AND (SAM0(JNT,INT)-SAM0(INT,JNT) GT 0)]=1;
* With that specification, a pair of cross-flows with one negative and
* one positive resulted in a single negative one, even if the positive flow
* was larger in absolute value. With the current specification, if there is
* a pair of cross-flows of opposite signs, the one that subsists in the
* solution is the larger one in absolute terms.
*----------------------------------------------------------------------------

SAM0(INT,JNT)$[(SAM0(JNT,INT) LT 0)
               AND (SAM0(INT,JNT)-SAM0(JNT,INT) GT 0)]=SAM0(INT,JNT)-SAM0(JNT,INT);
SAM0(JNT,INT)$[(SAM0(JNT,INT) LT 0)
               AND (SAM0(INT,JNT)-SAM0(JNT,INT) GT 0)]=0;
display SAM0, NEG;

*============ 4. Initial matrix values transformed in proportion ===============
PARAMETER
TOTO  initial matrix total ;
TOTO  = SUM((INT,JNT), SAM0(INT,JNT));
SAM0(INT,JNT) = SAM0(INT,JNT)/TOTO;

*============ 5. Non-zero logs parameter =======================================
SCALARS
delta      Non-zero logs parameter;
delta      =.0000000000001;

*============ 6. Variable definition ===========================================
VARIABLES
SAM(I,J)     New SAM with transposed negative values
OPT          Distance variable
;
*============ 7. Equation definition ===========================================
EQUATIONS
OPTIMIZE        Optimization criterion
CONSTRAINT(I)   Equality between matrix and row sums
CONSTRAINT1     Sum of proportions equals one
;

*----------------------------------------------------------------------------
* OPTIMIZATION CRITERION/OBJECTIVE FUNCTION -- Choose one

* Least squares (in percentage form) optimization criterion
* OPTIMIZE..  OPT =E= SUM((INT,JNT)$SAM0(INT,JNT),(NSAM(INT,JNT)/SAM0(INT,JNT)-1)**2);

* Entropy optimization criterion
OPTIMIZE..   OPT =E= SUM((INT,JNT)$(SAM0(INT,JNT) NE 0),(SAM(INT,JNT))
                     *(LOG(SAM(INT,JNT)+delta)-LOG(SAM0(INT,JNT)+delta)));
*----------------------------------------------------------------------------

* Equality between row and column sums
CONSTRAINT(INT).. SUM(JNT,SAM(INT,JNT))=E=SUM(JNT,SAM(JNT,INT));

* Proportions sum equal one
CONSTRAINT1..     SUM((INT,JNT),SAM(INT,JNT))=E=1 ;

*============ 8. Variable initialization =======================================

* Cell values between 0 and infinity and empty cells remain empty
SAM.L(I,J)                           = SAM0(I,J);
SAM.LO(INT,JNT)                      = 0 ;
SAM.UP(INT,JNT)                      = +INF ;
SAM.FX(INT,JNT)$(NOT SAM0(INT,JNT))  = 0 ;
OPT.L                                = 0;

* Fix any variables as desired. However, be careful not to fix too many
* variables, otherwise the program will not find an optimal solution.

* SAM.FX("RP",INT)=SAM0("RP",INT);
* SAM.FX("UP",INT)=SAM0("UP",INT);

*============= 9. Model solving ================================================

MODEL SAMBAL / ALL /;

* Model attributes (if desired)
* the "workspace" attribute tells the solver how much workspace in Megabytes
* to allocate for problem solution.
*SAMBAL.workspace = 10;
* The "optfile" attribute tells the solver to use a solver options file.
*SAMBAL.optfile = 1;

* OPTION statements
* Choose solver
* OPTION NLP             = MINOS5;
* OPTION NLP             = CONOPT;
* OPTION NLP             = CONOPT2;
 OPTION NLP             = CONOPT3;

* The "iterlim" option sets a limit on the number of solver iterations
OPTION iterlim = 99999;

SOLVE SAMBAL USING NLP MINIMIZING OPT;

*============= 10. Results copied into new matrix ==============================

PARAMETER
NSAM(I,J) New (balanced) matrix;
NSAM(INT,JNT)=SAM.L(INT,JNT);

* Negative values retransposed to original position
NSAM(INT,JNT)$(NEG(INT,JNT)=1)=-NSAM(JNT,INT);
NSAM(JNT,INT)$(NEG(INT,JNT)=1)=0;

* Transformation of proportions into SAM transaction flow
NSAM(INT,JNT) = NSAM(INT,JNT)*TOTO;

* Export results first to a GDX file, then to an Excel file
execute_unload "Results", NSAM;
*execute '=gdx2xls Results.gdx';
Execute 'GDXXRW.EXE Results.gdx O=NewSAM.xls par=NSAM rng=A1:W23 rdim=1 cdim=1';

*============= 11. PROBLEM DETECTION ===========================================
PARAMETER
PROBS(I,J);
PROBS(I,J)=0;
PROBS(I,J)$(NSAM(I,J) EQ 0 AND SAM0(I,J) NE 0)=SAM0(I,J);
DISPLAY NSAM, PROBS;

