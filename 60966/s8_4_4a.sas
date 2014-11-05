* S8_4_4a.sas
*
* Applying STYLE= to columns that contain summary lines.;

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
         body='ch8_4_4a.html';

title1;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd;
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
                       'Total Sales'
                       style(column) = {background=cback.
                                        foreground=cfore.};  
   break after region / summarize suppress;
   rbreak after       / summarize;

   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;
   run;
ods html close;

