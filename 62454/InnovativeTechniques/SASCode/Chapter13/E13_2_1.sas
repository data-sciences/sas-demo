* E13_2_1.sas
* 
* SYMPUT vs SYMPUTX;

title1 '13.2.1 Using CALL SYMPUTX';

***********************************************;
* Show the differences between SYMPUT and SYMPUTX;
data _null_;
   set advrpt.demog(where=(subject=205));
   call symput('EDU205a',edu);
   call symput('EDU205b',left(put(edu,3.)));
   call symputx('EDU205c',edu);
   run;
%put |&edu205a| |&edu205b| |&edu205c|;
