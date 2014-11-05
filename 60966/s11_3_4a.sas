* S11_3_4a.sas
*
* Adding a computed variable;

title1 'Summary Lines with a Percentage';
proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_3_4a nowd;
   column age sex n percent;

   define age    / group;
   define sex    / group 'Gender' format=$6.;
   define n      / 'N' format=2.;
   define percent/ computed format=percent8. 'Percent';

   break after age / summarize suppress skip;
   rbreak after    / summarize;

   compute before;
      totn = n;
   endcomp;
   compute before age;
      totage = n;
   endcomp;
   compute percent;
      if _BREAK_='_RBREAK_' then percent=n/totn;
      else percent = n/ totage;  
   endcomp;
   run;

proc print data=out11_3_4a;
run;
