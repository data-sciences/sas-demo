* S8_4_3.sas
*
* Using CALL DEFINE for traffic lighting;

proc format;
   value cfore
      low    - 21000 = 'white'
      21000< - 25000 = 'black'
      >50000         = 'white';
   value cback
      low    - 21000 = 'red'
      21000< - 25000 = 'yellow'
      >50000         = 'green';
   run;

ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_4_3.html';

title1 'Sales Summary';
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
      nowd;
   column country region product actual;
   define country / group;
   define region  / group;
   define product / group;
   define actual  / analysis sum 
                    format=dollar8.  
                    'Sales';
   compute actual;
      call define(_col_,
                  'style',
                  'style = {background=cback.  
                                    foreground=cfore.}');
   endcomp;
   run;
ods html close;
