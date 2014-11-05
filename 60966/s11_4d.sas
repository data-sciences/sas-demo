* S11_4d.sas
*
* Adding an ACROSS variable
* This approach does NOT work!!!!;
*
* There is NO compute block for the 
* computed variable PERCENT;
*
* Percent is NEVER calculated (directly or
* indirectly) on the report rows
* that will actually be written to the report.;

proc format ;
   value $gender
      'F' = '_Female_'
      'M' = '_Male_';
   run;

title1 'Summary Lines with a Percentage';
title2 'Report with an ACROSS Variable';
proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_4d nowd;
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

   * Wrong place for this calculation;
   compute after;
      _c3_ = _c2_/totn;
      _c5_ = _c4_/totn;
   endcomp;

   * wrong place for this calculation;
   compute after age;
      _c3_ = _c2_/totage;
      _c5_ = _c4_/totage;  
   endcomp;
   run;

proc print data=out11_4d;
run;
