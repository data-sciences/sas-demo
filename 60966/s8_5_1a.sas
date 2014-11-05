* S8_5_1a.sas
*
* HTML links using the FOOTNOTE statement;

* Regional Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_1a_Region.html';

title1 'Region Summary';
footnote1 "<a href='ch8_5_1a_RegionWEST.html'
             >Detail for Western Region</a>";
footnote2 "<a href='ch8_5_1a_RegionEAST.html'
             >Detail for Eastern Region</a>";

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE'))
            nowd;
   column region product,actual;
   define region  / group;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods html close;

* Western Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_1a_RegionWEST.html';

title1 'Western Region Summary';
footnote1 "<a href='ch8_5_1a_Region.html'
             >Region Summary</a>";
footnote2 "<a href='ch8_5_1a_RegionEAST.html'
             >Detail for Eastern Region</a>";

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='WEST'))
            nowd;
   column region country product,actual;
   define region  / group;
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
         body='ch8_5_1a_RegionEAST.html';

title1 'Eastern Region Summary';
footnote1 "<a href='ch8_5_1a_Region.html'
             >Region Summary</a>";
footnote2 "<a href='ch8_5_1a_RegionWEST.html'
             >Detail for Western Region</a>";

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
            nowd;
   column region country product,actual;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods html close;
