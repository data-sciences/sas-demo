* S11_4b.sas
*
* Adding an ACROSS variable;

proc format ;
   value $gender
      'F' = 'Female'
      'M' = 'Male';
   run;

title1 'Summary Lines with a Percentage';
title2 'Report with an ACROSS Variable';
proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_4b nowd;
   column age sex,(n percent);

   define age    / group;
   define sex    / across 'Gender' format=$gender.;
   define n      / 'N' format=2.;
   define percent/ computed format=percent8. 'Percent';

   rbreak after / summarize dol;

   compute before;
      totn = _c2_ + _c4_;
   endcomp;
   compute before age;
      totage = _c2_ + _c4_;
   endcomp;
   compute percent;
      if _BREAK_='_RBREAK_' then do;
         _c3_ = _c2_/totn;
         _c5_ = _c4_/totn;
      end;
      else if _BREAK_=' ' then do;
         _c3_ = _c2_/totage;
         _c5_ = _c4_/totage;  
      end;
   endcomp;
   run;

proc print data=out11_4b;
run;
