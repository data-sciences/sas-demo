* S8_4_4c.sas
*
* Using the CALL DEFINE to control summary attributes;

proc format;
   value cfore
      low    - 21000 = 'white'
      21000< - 25000 = 'black'
      75000  - high  = 'white';
   value cback
      low    - 21000 = 'red'
      21000< - 25000 = 'yellow'
      75000  - high  = 'green';
   run;


ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_4_4c.html';

title1;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd
            style(summary)={background=cback. 
                            foreground=cfore.};
   column region country product,actual totalsales;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales'
                    style(column) = {background=cback.
                                     foreground=cfore.};
   define totalsales / computed format=dollar10.
                       'Total Sales';
 
   break after region / summarize suppress;
   rbreak after / summarize;

   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
      call define(_COL_,'style', 'style={background=cback. 
                                         foreground=cfore.}');
   endcomp;
   run;
ods html close;

