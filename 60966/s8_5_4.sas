* S8_5_4.sas
*
* Using STYLE= to form a link;

ods listing close;

* Regional Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_4_Region.html';

title1 'Region Summary';
footnote1;

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE'))
            nowd;
   column region product,actual;
   define region  / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute region;
      rtag = "ch8_5_4_Region"||trim(region)||".html";
      call define(_col_,'url',rtag);
   endcomp;
   rbreak after / summarize;
   run;
ods html close;

* Western Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_4_RegionWEST.html';

title1 'Western Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='WEST'))
            nowd;
   column region country product,actual;
   define region  / group style(header)={url='ch8_5_4_Region.html'};
   define country / group;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods html close;

* Eastern Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_4_RegionEAST.html';

title1 'Eastern Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
            nowd;
   column region country product,actual;
   define region  / group style(header)={url='ch8_5_4_Region.html'};
   define country / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods html close;
