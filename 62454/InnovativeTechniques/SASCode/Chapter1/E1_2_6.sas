*E1_2_6.sas
*
* Working with a named range;

* The spreadsheet created here has been manually altered for the example
* rerunning this step will overwrite those changes.;
title1 "1.2.6 Working with a Named Range";
/*proc export data=sashelp.class*/
/*            outfile= "&path\data\E1_2_6classmates.xls"*/
/*            dbms=excel2000*/
/*            replace;*/
/*   SHEET='MyClass';*/
/*   run;*/
*********************************************;
* Using EXCEL and manual operations the spreadsheet has been altered.
*   additional columns were added - data now starts in column c
*   additional rows were added -  column headers now start in row 3.
* A named range was created for the data portion of the sheet.
*   The named range was named CLASSDATA.
*********************************************;
* Read using a SET statement;
libname seexls excel "&path\data\E1_2_6classmates.xls";

data class;
   set seexls.classmates;
   run;
libname seexls clear;
*********************************************;
* Read using PROC IMPORT;
proc import out=work.classdata 
            datafile= "&path\data\E1_2_6classmates.xls" 
            dbms=xls replace;
   getnames=yes;
   range='classdata';
   run;

*********************************************;
