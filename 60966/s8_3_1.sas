* S8_3_1.sas
*
* Using CALL DEFINE in a simple report;

ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_3_1.html';

title1;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd;
   column region country product,actual totalsales;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   define totalsales / computed 
                       format=dollar10.
                       'Total Sales';
   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;
   compute after region;
      call define(_row_,
                  'style',
                  'style={font_weight=bold
                          background=white
                          font_face=arial}');
   endcomp;   
   break after region / summarize suppress;
   rbreak after       / summarize;
   run;
ods html close;

