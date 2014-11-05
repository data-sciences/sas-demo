* S7_2_4a.sas
*
* Counting columns;

title1 'Extending Compute Blocks';
title2 'Using Indirect Column References';
title3 'Determining Column Counts';

* Nesting statistics within an ACROSS ;
proc report data=rptdata.clinics nowd;
   column region sex,('_Weight_' wt wt=wtmean wt=wtstd );  
   define region / group width=6;
   define sex    / across        format=$2. '_Gender_';
   define wt     / analysis n    format=2.0 'N';  
   define wtmean / analysis mean format=6.2 'Mean';
   define wtstd  / analysis mean format=6.1 'STD';
   run;
