* S8_2_4a.SAS
*
* Creating blank lines and columns;

ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_2_4a.html';
ods pdf  style=printer
         file="&path\results\ch8_2_4a.pdf";

title1;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd;
   column region country product,actual dummy totalsales;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   define dummy  /  computed ' '
                    style(column) = {cellwidth=2pt
                                     background=gray99
                                     bordercolor=gray99};
   define totalsales / computed format=dollar10.
               'Total Sales'; 
   break after region / summarize suppress; 
   rbreak after / summarize;

   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;
   compute dummy /char length=2;
      dummy=' ';
   endcomp;
   compute after region/style(lines) = {font_size=2pt
                                        background=grayaa};
      line ' ' ;
   endcomp;
   run;
ods _all_ close;
