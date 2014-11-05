* S4_4_8.sas
*
* PROC statement options;

* Using the WRAP option;
title1 'Only in LISTING';
title2 'Using WRAP';

data demog; 
input name $ sex $ idnum score1-score10 / comment $65.; 
format name $5. sex $3. idnum 5. score1-score10 6.
       comment $65.; 
datalines; 
Russ M 123 1 9 3 8 4 7 5 8 6 3 
Occasionally has difficulty with verbal communication 
Kevin M 456 4 7 5 6 8 5 4 3 2 3 
Is very particular about the placement of personal objects 
Paige F 789 6 7 4 3 5 8 9 2 3 4 
Gets very excited by the success of those people close to her  
run;

proc report data=demog 
               ls=70 nowd 
               wrap;
   column name comment;
   define name    / group;
   define comment / display;
   break after name / skip; 
   run;
