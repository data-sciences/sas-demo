* S8_5_1b.sas
*
* HTML Links using the LINE statement;

ods listing close;

* Regional Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_1b_Region.html';

title1;
footnote1;

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
   
   compute before _page_;
      line @3 'Region Summary';
   endcomp;

   compute after;
      line @3 "<a href='ch8_5_1b_RegionWEST.html'
              >Detail for Western Region</a>";
      line @3 "<a href='ch8_5_1b_RegionEAST.html'
              >Detail for Eastern Region</a>";
   endcomp;
   run;
ods html close;

* Western Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_1b_RegionWEST.html';

title1 ;

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
   compute before _page_;
      line @3 'Western Region Summary';
   endcomp;

   compute after;
      line @3 "<a href='ch8_5_1b_Region.html'
              >Region Summary</a>";
      line @3 "<a href='ch8_5_1b_RegionEAST.html'
              >Detail for Eastern Region</a>";
   endcomp;
   run;
ods html close;

* Eastern Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_1b_RegionEAST.html';

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

   compute before _page_;
      line @3 'Eastern Region Summary';
   endcomp;
   compute after;
      line @3 "<a href='ch8_5_1b_Region.html'
               >Region Summary</a>";
      line @3 "<a href='ch8_5_1b_RegionWEST.html'
               >Detail for Western Region</a>";
   endcomp;
   run;
ods html close;
