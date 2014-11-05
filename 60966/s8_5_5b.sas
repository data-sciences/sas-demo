* S8_5_5b.sas
*
* PDF links in a single document;

ods listing close;

* Regional Report  ***********************;
ods pdf style=default
        file="&path\results\ch8_5_5b.pdf";

title1 'Sales Summary';
footnote1;
ods proclabel='Sales Summary';
proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE'))
            nowd
            contents='Overall'
            ;
   column region product,actual;
   define region  / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute region;
      rtag = "#"||trim(region);
      call define(_col_,'url',rtag);
   endcomp;
   rbreak after / summarize;
   run;

* Western Region Report  ***********************;
ods pdf anchor="WEST" 
        startpage=now;
ods proclabel="Western";

title1 'Western Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='WEST'))
            nowd;
   column country product,actual;
   define country / group;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;

* Eastern Region Report  ***********************;
ods pdf anchor="EAST" 
        startpage=now;
ods proclabel="Eastern";


title1 'Eastern Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
            contents=''
            nowd;
   column country product,actual;
   define country / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods pdf close;
