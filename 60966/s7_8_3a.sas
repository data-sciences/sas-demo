* S7_8_3a.sas
*
* Understanding the LINE statement;


title1 'Extending Compute Blocks';
title2 'Understanding the LINE Statement';
title3 'Just to show the LINE Execution';

proc report data=sashelp.class nowd;
   column age sex,height;
   define age    / group ;
   define sex    / across ;
   define height / mean;
 
   rbreak after / summarize;
 
   compute after;
      line ' ';
      value = 'DEF';
      count = 5678;

      line 'Show letters ' value $3.;
      line 'Show count ' count 5.1;
      line 'Show M HT  ' _c3_ 5.1;
      line ' ';

      do cnt = 1 to 5;
         line 'Loop counter is ' cnt 3.;
      end;

      if 1 = 2 then line 'This is true: 1 = 2'; 
      value = 'ABC';
      count = 1234;
      _c3_ = 11.11;
   endcomp;
   run;
