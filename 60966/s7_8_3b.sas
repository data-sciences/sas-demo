* S7_8_3b.sas
*
* Understanding the LINE statement;


title1 'Extending Compute Blocks';
title2 'Understanding the LINE Statement';
title3 'LINE statements at the end';

proc report data=sashelp.class nowd;
   column age sex,height;
   define age    / group ;
   define sex    / across ;
   define height / mean;
 
   rbreak after / summarize;
 
   compute after;

      do cnt = 1 to 5;
      end;

      if 1 = 2 then ; 
      value = 'ABC';
      count = 5678;
      count = 1234;
      _c3_ = 11.11;
      value = 'DEF';

      line ' ';
      line 'Show letters ' value $3.;
      line 'Show count ' count 5.1;
      line 'Show M HT  ' _c3_ 5.1;
      line ' ';
      line 'Loop counter is ' cnt 3.;
      line 'This is true: 1 = 2';
   endcomp;
   run;
