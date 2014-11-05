* S8_4_2a.sas
*
* Using Formats with STYLE=;

options center;


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
         body='ch8_4_2a.html';

title1 'Sales Summary';
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
      nowd;
   column country region product actual;
   define country / group;
   define region  / group;
   define product / group;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales'
                    style(column) = {background=cback.
                                     foreground=cfore.};

   run;
ods html close;
