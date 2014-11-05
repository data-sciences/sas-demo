* s8_10.sas
*
* Using the TEXT= option;

ods listing close;
ods pdf file="&path\results\ch8_10.pdf" 
        startpage=no
        text='Example 8.10';

   title1 'Sales Summary';
   footnote;
   proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
               nowd;
   column region country product,actual;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   break after region / summarize suppress;
   rbreak after / summarize;
   run;
ods pdf close;
