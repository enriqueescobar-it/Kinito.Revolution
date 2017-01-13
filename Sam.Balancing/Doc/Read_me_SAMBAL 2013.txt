SAMBAL, December 2013

*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to:  Andre Lemelin       *
*                                                          Ismael Fofana       *
*                                                          John Cockburn       *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

This zip file has been downloaded from:
http://www.pep-net.org/programs/mpia/training-material/

It contains the PEP SAMBAL social accounting matrix balancing program 
sambal_2013.gms.

It also contains 5 unbalanced SAMs as examples to illustrate the behavior of the 
adjustment procedure in different cases:

- SAM_unbal1.xls contains a negative flow, but NO cross-flows of opposite signs.

- SAM_unbal2.xls contains a pair of cross-flows that are both negative. In the 
  solution, there is one negative flow, and it is positioned in the cell with 
  the initial negative flow largest in absolute value.

- In SAM_unbal3.xls, the pair of negative cross-flows in SAM_unbal2.xls have 
  been consolidated, and the result is a single positive flow in the unbalanced
  matrix. The solution is identical to that of SAM_unbal2.xls, except for the 
  fact that the negative flow in the latter is transposed to a positive flow.

- SAM_unbal4.xls contains a pair of cross-flows, the larger one of which is 
  negative. In the solution, there is only one flow, and it is negative and 
  positioned in the cell with the initial negative flow.

- SAM_unbal5.xls contains a pair of cross-flows, the larger one of which is 
  positive. In the solution, there is only one flow, and it is positive and 
  positioned in the cell with the initial positive flow. All other cells are 
  equal to the solution of SAM_unbal4.

This zip file also contains the corresponding solution Excel files 
NSAM_unbal1.xls to NSAM_unbal5.xls. 

For users who may wish to test data input with a *.prn file, SAM_unbal1.prn 
contains the same data as SAM_unbal1.xls.

For further details, please refer to the comments in the GAMS program and to 
the included program documentation SAM_balancing_2013.pdf. Comments and 
inquiries may be sent to andre_lemelin@ucs.inrs.ca.

André Lemelin, Ismaël Fofana and John Cockburn