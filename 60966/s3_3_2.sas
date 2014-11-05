* S3_3_2.sas
*
* Using the RBREAK statement;

ods html file="&path\results\ch3_3_2.html"
         style=brick;

* Creating Breaks;
   title1 'Creating Breaks in the Report';
   title2 'Summarizing Groups in a Detail REPORT';
   proc report data=rptdata.clinics
                  (where=(region in('1' '2' '3' '4'))) 
               nofs;
     column region lname fname sex wt,(n mean);
     define region / group 'Region' format=$6.;  
     define lname  / order;  
     define fname  / order;  
     define sex    / group format=$6. 'Gender';  
     define wt     / analysis format=5.1;
     break after region / summarize suppress;  
     rbreak before / summarize;  
     run;
