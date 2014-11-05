* S8_3_3.sas
*
* Conditional assignment of attributes;

ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_3_3.html';

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
   define totalsales / computed format=dollar10.
                       'Total Sales';  
   break after region / summarize suppress;
   rbreak after       / summarize;

   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
      if _c3_ < 25e3 then call define('_c3_',
                                     'style',
                                     'style={background=red
                                             foreground=white}');
      if _c4_ < 24e3 then call define('_c4_',
                                     'style',
                                     'style={background=red
                                             foreground=white}');
      if _c5_ < 21e3 then call define('_c5_',
                                     'style',
                                     'style={background=red
                                             foreground=white}');
   endcomp;

   run;
ods html close;

