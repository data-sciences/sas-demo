/*-------------------------------------------------------------------------------------------
Section 24.3
-------------------------------------------------------------------------------------------*/



DATA CustomerMart;
 MERGE Customer (IN = InCustomer)
       UsageMart (IN = InUsageMart);
 BY CustID;
 IF InCustomer;
RUN;



PROC CONTENTS DATA = sashelp.citimon 
              OUT  = VarList(KEEP = name type length 
                                    varnum label format);
RUN;

/*-------------------------------------------------------------------------------------------
Section 24.4
-------------------------------------------------------------------------------------------*/


DATA class;
 SET sashelp.prdsale;
WHERE product = 'SOFA';
KEEP actual year quarter country;
RUN;


DATA test;
 SET sashelp.class;
 Age_Weight = Age * Weihgt;
RUN;



data class; set sashelp.class;
if age <= 13 then age_class = 1;
else if age <= 14 then age_class =2;
else age_class = 3;
label age="Age (years)" height="Height (inch)" weight="Weight (pound)";
rename sex=gender name = firstname;
run;



data class;
 set sashelp.class;

      if age <= 13 then age_class = 1;
 else if age <= 14 then age_class = 2;
 else                   age_class = 3;
 label age    = "Age (years)" 
       height = "Height (inch)" 
       weight = "Weight (pound)"
 ;
 rename sex    = gender 
        name   = firstname
 ;
run;




DATA class;
 SET sashelp.class;
 ATTRIB NrChildren	LABEL  = "Number of children in family"
                    FORMAT = 8.;
 ATTRIB district	LABEL = "Regional district" 
                    FORMAT = $10.;
RUN;


****************************************************************
*** Author: Gerhard Svolba  
*** Date:
*** Project: 
*** Subroutine:
***
*** Change History:
***
****************************************************************;




