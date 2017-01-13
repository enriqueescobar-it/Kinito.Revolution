$TITLE Matrix adjustment program

*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to: Andre Lemelin        *                            *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

* This program adjusts a matrix
* following the Junius and Oosterhaven (2003) principle,
* but with an objective function defined as the true Kullback-Leibler
* cross-entropy information-gain measure.
* The method is extended to deal with zero row-sums, or column-sums, or both.

* Thanks to Roberto Ferrer of the Banco Central de Venezuela, who contributed
* to generalizing the program.
*
* Reference:
* LEMELIN, André (2010), "A GRAS variant solving for minimum information loss",
* Economic Systems Research, 21(4), p. 399-408.

* André Lemelin, July 2013
*
* Professeur-chercheur
* Université du Québec
* INRS-UCS
* 385, rue Sherbrooke est
* Montréal H1X 1E3 QUÉBEC
* tél.: 514-499-4042
* fax : 514-499-4065
* Andre_Lemelin@UCS.INRS.ca

*===========================================================================*
*-------------------- Reading input from an Excel file ---------------------*

* This program comes with 4 examples of input Excel files:
*  Input.xls
*  Zero_line_tot.xls
*  Zero_col_tot.xls
*  Zero_margins.xls
* See the GPCEMA quick user guide.

* Row and column labels are read from the Excel file containing the matrix
* to be adjusted, except for the "ROWNCT" and "COLNRT" labels, which MUST BE
* absent from the DATA table, but must be included in the set definitions.

*------------------------------ Row labels ---------------------------------*
* The following statement reads row labels from the Excel data file,
* and produces an output text file called setI.inc containing the row labels.
* The text file setI.inc will be incorporated into the code later with $include.
* The last row in the Excel input file MUST be the row of column totals,
* it MUST be labeled "CTOTS",
* and it MUST be outside the range specified in the $call statement below.
* The range in the $call statement (parameter r) is the range that contains
* the row labels.
$call =xls2gms r=A4:A7 i=Input.xls o=setI.inc
*$call =xls2gms r=A5:A7 i=Zero_line_tot.xls o=setI.inc
*$call =xls2gms r=A5:A8 i=Zero_col_tot.xls o=setI.inc
*$call =xls2gms r=A5:A7 i=Zero_margins.xls o=setI.inc

*---------------------------- Column labels --------------------------------*
* The following statement reads column labels from the Excel data file,
* and produces an output text file called setJ.inc containing the column labels.
* The text file setJ.inc will be incorporated into the code later with $include.
* The last column in the Excel input file MUST be the column of row totals,
* it MUST be labeled "RTOTS",
* and it MUST be outside the range specified in the $call statement below.
* The s="," option in the $call statement is needed for all labels to be read.
* The range in the $call statement (parameter r) is the range that contains
* the column labels.
* range in the Excel file.
$call =xls2gms r=B3:E3 s="," i=Input.xls o=setJ.inc
*$call =xls2gms r=B4:E4 s="," i=Zero_line_tot.xls o=setJ.inc
*$call =xls2gms r=B4:D4 s="," i=Zero_col_tot.xls o=setJ.inc
*$call =xls2gms r=B4:E4 s="," i=Zero_margins.xls o=setJ.inc

*---------------------------- Problem data  --------------------------------*
* The original matrix is not balanced: values in the RTOTS column
* and in the CTOTS line are not equal to the corresponding sums.
* The CTOTS line and the RTOTS column contain the marginal totals
* (target values) to which the matrix is to be adjusted.
* It is expected that the sum of column totals in the CTOTS line
* equal the sum of line totals in the RTOTS column.
* If not, the problem as stated has no solution and adjustments are made below.
* The following statement produces an output text file called Input.inc
* containing the problem data, which will be incorporated into the code later
* with a $include.
* The range in the $call statement (parameter r) is the range that contains
* the problem data, including row and column labels.
$call =xls2gms r=A3:F8 i=Input.xls o=Input.inc
*$call =xls2gms r=A4:F8 i=Zero_line_tot.xls o=Input.inc
*$call =xls2gms r=A4:E9 i=Zero_col_tot.xls o=Input.inc
*$call =xls2gms r=A4:F8 i=Zero_margins.xls o=Input.inc

*===========================================================================*
*-------------------------------Set definition------------------------------*

SET I Row labels /
$include setI.inc

* Two additional row labels are included:
* ROWNCT means "ROW of Negative Column Totals". It is used in Case 3; see below.
  ROWNCT
* CTOTS is the row of Colum TOTalS
  CTOTS
  /;

SET I2(I) Row labels without CTOTS /
$include setI.inc
  ROWNCT
  /;

SET J Column labels /
$include setJ.inc

* Two additional column labels are included:
* COLNRT means "COLumn of Negative Row Totals". It is used in Case 2; see below.
  COLNRT
* RTOTS is the column of Row TOTalS
  RTOTS
  /;

SET J2(J) Column labels without RTOTS /
$include setJ.inc
  COLNRT
  /;

ALIAS (I2,I2J);
ALIAS (J2,J2J);

*===========================================================================*
*-------------------------------- Problem data -----------------------------*

$Stitle Problem data

TABLE DATA(I,J)
$include Input.inc
  ;

* The following assignments ensure that the ROWNCT row and the COLNRT column
* are initialized as zero.
  DATA('ROWNCT',J) = 0;
  DATA(I,'COLNRT') = 0;

*=========================================================================*
* Other ways of reading the problem data are to read a text input file using
* a $include statement, such as
*     $INCLUDE INPUT.GMS
* or to write the data directly into this program, as follows
*     TABLE DATA(I,J)
*                  COL1          COL2       COL3          COL4        RTOTS
*     ROW1         0             38.9344    23.3607       23.3607       100
*     ROW2         31.1475        0         11.6803       11.6803        50
*     ROW3         18.6885       11.6803     0             7.0082        30
*     ROW4          6.2295        3.8934     2.3361        0             10
*     CTOTS        80            50         30            30
*=========================================================================*

Display DATA;
*===========================================================================*
*---------------------------List of parameters------------------------------*

PARAMETER
  OLDMAT(I,J)        A priori (non adjusted) distribution matrix
  NEWMAT(I,J)        Adjusted matrix
*  NEWMAT(I2,J2)      Adjusted matrix
  ZSOL(I2,J2)        Solution values of ZED
  SUMROWTOT          Sum of row totals
  SUMCOLTOT          Sum of column totals
  EPSILON            Lower bound on ZED to prevent log(0) and divisions by zero
  ZCOLTOT            Equals 1 if all column totals are zero
  ZROWTOT            Equals 1 if all row totals are zero
  CASE               Indicator of which combination of ZROWTOT and ZCOLTOT

*============================================================================*
*---------------------------- Variable names --------------------------------*

VARIABLE
  ZED(I2,J2)    Correction factors to be applied to the elements of OLDMAT
  OBJ           Objective function
;

* It is not sufficient to declare ZED as a positive variable. It must have a
* lower bound, defined below as EPSILON

*============================================================================*
*------------------------------ Value assignments ---------------------------*

  OLDMAT(I,J) = DATA(I,J) ;
  SUMROWTOT   = SUM(I2,OLDMAT(I2,"RTOTS"));
  SUMCOLTOT   = SUM(J2,OLDMAT("CTOTS",J2));

* ZROWTOT and ZCOLTOT are logical variables.
  ZROWTOT     = 0;
* ZROWTOT equals 1 if all row totals are zero
* i.e. if the sum of absolute values of the "RTOTS" column is zero
  IF(SUM(I2,ABS(OLDMAT(I2,"RTOTS")))=0, ZROWTOT=1);

  ZCOLTOT = 0;
* ZCOLTOT equals 1 if all column totals are zero
* i.e. if the sum of absolute values of the "CTOTS" row is zero
  IF(SUM(J2,ABS(OLDMAT("CTOTS",J2)))=0, ZCOLTOT=1);

* The following equation determines to which case the problem belongs:
* CASE = 4 if both all row totals and all column totals are zero.
* CASE = 3 if all row totals, but not all column totals, are zero.
* CASE = 2 if all column totals, but not all row totals, are zero.
* CASE = 1 if neither all row totals, nor all column totals are zero.

  CASE = 4 * ZROWTOT*ZCOLTOT
         + 3 * ZROWTOT*(1-ZCOLTOT)
         + 2 * (1-ZROWTOT)*ZCOLTOT
         + (1-ZROWTOT)*(1-ZCOLTOT) ;

  DISPLAY SUMROWTOT, SUMCOLTOT, ZROWTOT, ZCOLTOT, CASE;

* The following conditional assignments convert Case 2 and 3 problems to
* Case 4 problems, except for the fact that the values in row "ROWNCT" or in
* column "COLNRT" are fixed at their initial value.
  IF(CASE = 3, OLDMAT("ROWNCT",J2) = - OLDMAT("CTOTS",J2);
               OLDMAT("CTOTS",J2) = 0
     );
  IF(CASE = 2, OLDMAT(I2,"COLNRT")  = - OLDMAT(I2,"RTOTS");
               OLDMAT(I2,"RTOTS") = 0
     );

* There may be small differences (such as due to rounding errors) between the
* sum of row totals and the sum of column totals. An adjustment is then needed
* for the problem to have a solution. Here, column totals are adjusted
* proportionately, so that their sum is equal to the sum of row totals (of
* course, it could be the other way around: row totals could be adjusted so
* that their sum is equal to the sum of column totals. That proportional
* adjustment is possible only if the sum of unadjusted column totals is nonzero.

  IF((SUMCOLTOT NE 0) AND (SUMROWTOT NE 0),
     DISPLAY "NONZERO SUMS OF COLUMN AND ROW TOTALS";
     OLDMAT("CTOTS",J2) = OLDMAT("CTOTS",J2)*SUMROWTOT/SUMCOLTOT ;
     SUMCOLTOT = SUM(J2,OLDMAT("CTOTS",J2));
    );

  Display "INITIAL VALUES:", OLDMAT ;

  EPSILON=0.000001;

*============================================================================*
*--------------------------------- Equations --------------------------------*

EQUATIONS
  EQROW(I2)    Constraint on the adjusted row totals
  EQCOL(J2)    Constraint on the adjusted column totals
  EQNRT(I2)    Constraint on adjusted row totals when column sums are all zero
  EQNCT(J2)    Constraint on adjusted column totals when row sums are all zero
  EQSUM        Constraint on the sum of absolute values of all elements
  EQOBJ        Objective function
  ;

  EQROW(I2)..    SUM(J2,OLDMAT(I2,J2)*ZED(I2,J2))
                    =E= OLDMAT(I2,"RTOTS") ;
  EQCOL(J2)..   SUM(I2,OLDMAT(I2,J2)*ZED(I2,J2))
                 =E= OLDMAT("CTOTS",J2) ;

* When CASE = 2, all column totals, but not all row totals, are zero.
* In that case, the problem is converted to a Case 4 problem with
* row totals included in the adjustment process as column "COLNRT"
* (COLumn of Negative Row Totals), but fixed.
  EQNRT(I2)$(CASE=2).. ZED(I2,"COLNRT") =E= 1 ;

* When CASE = 3, all row totals, but not all column totals, are zero.
* In that case, the problem is converted to a Case 4 problem with
* column totals included in the adjustment process as row "ROWNCT"
* (ROW of Negative Column Totals), but fixed.
  EQNCT(J2)$(CASE=3).. ZED("ROWNCT",J2) =E= 1 ;

* The preceding constraints are stated in terms of the algebraic values
* of OLDMAT(I2,J2). The following one is stated in terms of absolute values
* ABS(OLDMAT(I2,J2)).

* When CASE = 4, both all row totals and all column totals are zero.
* In that case, without a constraint on the sum of absolute values,
* the solution is defined only up to a multiplicative factor.
* The following constraint forces the grand total of absolute values in the
* adjusted matrix to be equal to the grand total of absolute values in the
* initial matrix OLDMAT.
  EQSUM$(CASE=4).. SUM((I2,J2),ABS(OLDMAT(I2,J2))*ZED(I2,J2)) =E=
                     SUM((I2,J2),ABS(OLDMAT(I2,J2))) ;
* In cases 2 and 3, however, this constraint is unnecessary, even if the
* problem is converted to a Case 4 problem, since the solution is anchored
* to the values in row "COLNRT" or in column "ROWNCT".

* The objective function is defined below:
* the specification minimizes cross-entropy (Kullback-Leibler measure),
* that is, information gain.

   EQOBJ..       OBJ =E=
                  SUM((I2,J2),ABS(OLDMAT(I2,J2))*ZED(I2,J2)*log(ZED(I2,J2)))
                  / SUM((I2,J2),ABS(OLDMAT(I2,J2))*ZED(I2,J2))
                  -log(SUM((I2,J2),ABS(OLDMAT(I2,J2))*ZED(I2,J2)))
                  +log(SUM((I2,J2),ABS(OLDMAT(I2,J2))));

*===========================================================================*
*-------------------------------- Model definition -------------------------*
MODEL ADJUS /ALL/;

*===========================================================================*
*-------------------------------- Result file ------------------------------*
file Resul /
* Name of the file to be created.
     'Adjust.xls'/;
* If necessary, specify the full path in the line above. For example:
* 'C:\My Documents\...\'Adjust.xls'/;

* Column separator: 6 = tab-separated file
*                   5 = comma-separated file
     Resul.pc=6;

* Number of decimal places (maximum 10)
     Resul.nd=10;

*============================================================================*
*------------------------ Initial value assignment --------------------------*

* The lower bound assigned to ZED guarantees that there will be no log(0)
  ZED.LO(I2,J2) = EPSILON ;

* The initial value of ZED depends on whether row totals are all zero,
* or column totals are all zero, or both, or none.

  ZED.L(I2,J2) =
* When CASE = 1, neither all row totals, nor all column totals are zero,
* and the initial value of ZED is set to the ratio of
* the sum of target marginal row totals to the sum of old matrix elements.
                     (1-ZCOLTOT)*(1-ZROWTOT)*SUM(I2J,OLDMAT(I2J,"RTOTS"))
                     /SUM((I2J,J2J),OLDMAT(I2J,J2J))
* When CASE = 4, both all row totals and all column totals are zero,
* and the initial value of ZED is set to 1.
                   + ZCOLTOT*ZROWTOT
* When CASE = 3, all row totals, but not all column totals, are zero,
* and the initial value of ZED is set to 1.
                   + ZROWTOT*(1-ZCOLTOT)
*                   + ZROWTOT*(1-ZCOLTOT)*SUM(J2J,ABS(OLDMAT("CTOTS",J2J)))
*                      /SUM(J2J,ABS(SUM(I2J,OLDMAT(I2J,J2J))))
* When CASE = 2, all column totals, but not all row totals, are zero.
* and the initial value of ZED is set to 1.
                   + (1-ZROWTOT)*ZCOLTOT
*                   + (1-ZROWTOT)*ZCOLTOT*SUM(I2J,ABS(OLDMAT(I2J,"RTOTS")))
*                     /SUM(I2J,ABS(SUM(J2J,OLDMAT(I2J,J2J))))
                    ;

* In the above statement, ZED.L is assigned a value over the full range
* of I2 and J2, whatever the case in point.
* However, the "ROWNCT" row is relevant only in case 3; in other cases,
* the ZED.L("ROWNCT",J2) are set them to zero
  ZED.L("ROWNCT",J2)$(CASE NE 3) = 0;
* Likewise, the "COLNRT" column is relevant only in case 2; in other cases,
* the ZED.L(I2,"COLNRT") are set them to zero
  ZED.L(I2,"COLNRT")$(CASE NE 2) = 0;
* This avoids attributing spurious values to ZSOL below.

  DISPLAY ZED.L ;

*============================================================================*
*------------------- Check for impossibility of solution --------------------*
  IF(SUMCOLTOT = SUMROWTOT,
* If SUMCOLTOT is not equal to SUMROWTOT, the problem has no solution
* and the program skips to the "ELSE" statement at the end.
* That situation may occur in spite of the adjustment above if
* SUMCOLTOT = 0 and SUMROWTOT ne 0,
* or SUMCOLTOT ne 0 and SUMROWTOT = 0.

*============================================================================*
*------------------------Solution of the problem ----------------------------*

OPTION ITERLIM=100000;
* The following option limits to 5 the number of decimals
* in DISPLAY statement output only.
OPTION DECIMALS=5;
* It is preferable to use the solver CONOPT, which has a greater precision
* than MINOS5
*OPTION NLP=MINOS5;
OPTION NLP=CONOPT3;
SOLVE ADJUS USING NLP MINIMIZING OBJ;

*============================================================================*
*                                RESULTS
*-------------------- Calculation of adjusted matrix ------------------------*

  NEWMAT(I2,J2) = OLDMAT(I2,J2)*ZED.L(I2,J2) ;
* The "ROWNCT" row and the "COLNRT" column in NEWMAT are irrelevant and they
* are set to zero
  NEWMAT("ROWNCT",J2) = 0;
  NEWMAT(I2,"COLNRT") = 0;
* It is convenient to include row and column totals in NEWMAT
  NEWMAT("CTOTS",J2) = SUM(I2,NEWMAT(I2,J2));
  NEWMAT(I2,"RTOTS") = SUM(J2,NEWMAT(I2,J2));

  ZSOL(I2,J2)   = ZED.L(I2,J2) ;
  DISPLAY NEWMAT, ZSOL;

* The user has two options to transfer results to an Excel file.
* The first is to construct a table using the GAMS put facility.
* The other is to proceed with the gdx facility.
* The advantage of using the gdx facility is that the values in the Excel
* file are more accurate.
*----------------------- Construction of Excel tables -----------------------*
*--------------------------- with the put facility --------------------------*
put Resul;

put 'ADJUSTED MATRIX' //;
put ' ' loop(J2, put J2.TE(J2)) put / ;
loop(I2, put I2.tl loop(J2, put NEWMAT(I2,J2)) put /);
put /;

*------------------------ GDX and XLS result files --------------------------*
* This creates an Excel file of results using the gdx facility.

execute_unload "adjust_resul",
NEWMAT
ZSOL
DATA
OLDMAT
;

* The GDX2XLS routine produces an Excel file with one page per variable.
* Variable values are displayed in database form, one row per value, 3 columns:
* row label, column label, value
* Tables can be created as Excel Pivot Table crosstabulations.
* See:
* Erwin Kalvelagen, GDX2XLS: A tool to convert gdx data to ms excel spreadsheets
* http://www.gams.com/dd/docs/tools/gdx2xls.pdf
*Execute '=GDX2XLS adjust_resul.gdx';

* The GDXXRW.EXE routine produces an Excel file with results in tabular form.
* See:
* GAMS Development Corporation (2013) GAMS GDX facilities and tools
* http://www.gams.com/dd/docs/tools/gdxutils.pdf
Execute 'GDXXRW.EXE adjust_resul.gdx O=Solution.xls par=NEWMAT rng=NEWMAT!A3 rdim=1 cdim=1';
Execute 'GDXXRW.EXE adjust_resul.gdx O=Solution.xls par=ZSOL rng=ZSOL!A3 rdim=1 cdim=1';
Execute 'GDXXRW.EXE adjust_resul.gdx O=Solution.xls par=DATA rng=DATA!A3 rdim=1 cdim=1';
Execute 'GDXXRW.EXE adjust_resul.gdx O=Solution.xls par=OLDMAT rng=OLDMAT!A3 rdim=1 cdim=1';

*============================================================================*
*--------------------------------- No solution ------------------------------*
  ELSE
    DISPLAY "==============================================================";
    DISPLAY "==============================================================";
    DISPLAY "++++ SUM OF COLUMN TOTALS ZERO, BUT NOT SUM OF ROW TOTALS ++++";
    DISPLAY "++++                   OR VICE-VERSA                      ++++";
    DISPLAY "==============================================================";
    DISPLAY "==============================================================";
     );
