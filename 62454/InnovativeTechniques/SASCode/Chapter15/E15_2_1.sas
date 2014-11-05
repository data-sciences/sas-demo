* E15_2_1.sas
* 
* Creating User defined Functions;

title1 '15.2.1 Creating User Defined Functions';
*********************************************;
proc fcmp outlib=work.myfuncs.tmp;
   function qnum(date) $;
      length yyq4 $4; 
      yyq4=put(date,yyq4.); 
      if substr(yyq4,3,1)='Q' 
         then return(substr(yyq4,3,2)); 
      else return(yyq4); 
   endsub;
run;
options cmplib=(work.myfuncs);
data qlabs;
   set advrpt.lab_chemistry(keep=visit labdt
                            where=(visit le 10));
   qtr=qnum(labdt); 
   run;

ods pdf file="&path\results\E15_2_1.pdf";
title2 'Quarters without years';
proc freq data=qlabs;
   table qtr*visit;
   run;
ods pdf close;
******************************************************;
