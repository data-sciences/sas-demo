* S11_4c.sas
*
* Adding an ACROSS variable;
*
* Demonstrate that the PERCENT compute block will
* be executed twice for each report row ;

proc format ;
   value $gender
      'F' = '_Female_'
      'M' = '_Male_';
   run;

title1 'Summary Lines with a Percentage';
title2 'Report with an ACROSS Variable';
proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_4c nowd;
   column age sex,(n percent) counter;

   define age    / group;
   define sex    / across 'Gender' format=$gender.;
   define n      / 'N' format=2.;
   define percent/ computed format=percent8. 'Percent';
   define counter/ computed 'Executions of the PERCENT compute block' 
                   format=10.;

   rbreak after / summarize dol;

   compute before;
      totn = _c2_ + _c4_;
   endcomp;
   compute before age;
      totage = _c2_ + _c4_;
      cnt=0;
   endcomp;
   compute percent;  
      if _BREAK_='_RBREAK_' then do;
         _c3_ = _c2_/totn;
         _c5_ = _c4_/totn;
      end;
      else do;
         _c3_ = _c2_/totage;
         _c5_ = _c4_/totage;
      end;
      cnt+1;
   endcomp;
   compute counter;
      * Assignment to this report item is made 
      * before CNT is reset to 0 on summary rows.
      * AND after the execution of the PERCENT block;
      counter=cnt;
   endcomp;
   run;

proc print data=out11_4c;
run;
