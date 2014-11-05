* E2_10_3.sas
*
* Using the MISSING System option;

title '2.10.3 Using the NMISS, CMISS and MISSING Functions';
* Reading missing values;
title2 'Noticing Missing Values';
data cntmiss;
infile cards missover;
input (a b c) ($1.) x y z;
nmisscnt = nmiss(x,y,z);
cmisscnt = cmiss(a,b,c);
missval  = missing(x+y+z);
*tot_missing = nmiss( of _numeric_,1 ) + cmiss( of _character_, 'a' ) -1;
datalines;
abc 1 2 3

de  3 4 .
    . . .
    1 2 .a
ghi
run;
proc print data=cntmiss;
run;
***************************************;
* Delete rows with all missing;
title2 'Delete all Missing Rows';
data nomissrows;
infile cards missover;
input (a b c) ($1.) x y z;
*if missing(coalesceC(of _character_)) and missing(coalesce(of _numeric_)) then delete;

if nmiss( of _numeric_ ) and cats( of _character_ ) =' ' then delete ;
datalines;
abc 1 2 3

de  3 4 .
    . . .
    1 2 .a
ghi
run;
proc print data=nomissrows;
run;
