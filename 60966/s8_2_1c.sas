* s8_2_1c.sas
*
* Basic program with numerous silly style changes;

options center;
ods listing close;

ods html style=default
         path="&path\results"
         body='ch8_2_1c.html';

title1 'Sales Summary';
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd
            style(report)={just=left}    
            style(header)={background=yellow  
                           font_weight=bold  
                           foreground=green}   
            style(column)={foreground=red  
                           background=white};
   column region country product,actual totalsales;
   define region  / group
                    style(header)={background=cyan}  ;
	define country / group
	                 style(header column)={background=pink
                                         font_face=times};
   define product / across;
   define actual  / analysis sum format=dollar8. 
                    'Sales';
   define totalsales / computed format=dollar10.
                         'Total Sales';
   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;
   break after region/summarize suppress
                      style(summary)={font_weight=bold}  ;
   rbreak after / summarize
                  style(summary)={font_weight=bold  
                                  font_size=4};
   run;
ods html close;
