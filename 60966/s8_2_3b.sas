* S8_2_3b.sas
*
* Font size of 9 points;

ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_2_3b.html';

title1 'Sales Summary';
   proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
               nowd
               style(report)={font_size=9pt}  
               style(column)={font=('times new roman')
                              font_size=9pt}  ;

   column region country product,actual totalsales;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   define totalsales / 
               computed format=dollar10.
               'Total Sales';
   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;
   break after region / summarize suppress;
   rbreak after / summarize;
   run;
ods html close;
