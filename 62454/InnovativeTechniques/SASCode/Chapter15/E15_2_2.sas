* E15_2_2.sas
* 
* Creating Function Libraries;

title1 '15.2.2 Creating Function Libraries';
********************************************;
proc fcmp outlib=advrpt.functions.dates;
   function qnum(d) $;
      return(cats('Q',qtr(d)));
   endsub;
run;
options cmplib=(advrpt.functions.dates);
data qlabs;
   set advrpt.lab_chemistry(keep=visit labdt
                            where=(visit le 10));
   qtr=qnum(labdt); 
   run;

ods pdf file="&path\results\E15_2_2a.pdf";
title2 'Quarters without years';
proc freq data=qlabs;
   table qtr*visit;
   run;
ods pdf close;


*********************************************;
proc fcmp outlib=Advrpt.functions.Conversions;
   function c2f(c);
      return(((9*c)/5)+32); 
   endsub;

   function f2c(f);
      return((f-32)*5/9); 
   endsub;
run;

options cmplib=(advrpt.functions);
data _null_; 
     f=c2f(100); put f=; 
     c=f2c(212); put c=; 
     run;
******************************************************;
proc fcmp outlib=AdvRpt.functions.Dates;
   function qfmt(date) $;
      length yyq4 $4; 
      yyq4=put(date,yyq4.); 
      if substr(yyq4,3,1)='Q' 
         then return(substr(yyq4,3,2)); 
      else return(yyq4); 
   endsub;
run;
options cmplib=(advrpt.functions);
******************************************************;
proc fcmp outlib=AdvRpt.functions.Conversions;
   function E_BMI(h,w);
      return((w * 703)/(h*h) ); 
   endsub;
   function M_BMI(h,w);
      return(w /(h*h)); 
   endsub;
   run;
title2 'Calculate BMI';
data bmi;
   set advrpt.demog(keep=lname fname ht wt);
   ebmi = e_bmi(ht,wt);
   * Convert ht and WT to metric units;
   mh = ht*.0254;
   mw = wt/2.2;
   mbmi=m_bmi(mh,mw);
   run;
proc print data=bmi;
run;
************************************************;
* Show retrieval order for multiple functions with the same name;
proc fcmp outlib=work.functions.Apacket;
subroutine special(val$);
   put 'in A' val;
endsub;
run;
proc fcmp outlib=work.functions.Bpacket;
subroutine special(val$);
   put 'in b' val;
endsub;
run;
proc fcmp outlib=work.tstfunc.cpacket;
subroutine special(val$);
   put 'in b' val;
endsub;
run;
options cmplib=(work.functions tstfunc);
data tst;
call special('aaaa');
run;
