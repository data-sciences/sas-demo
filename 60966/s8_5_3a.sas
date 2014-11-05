* S8_5_3a.sas
*
* Using CALL Define to link tables;

ods listing close;

* Regional Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_3a_Region.html';

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
      rtag = "ch8_5_3a_Region"||trim(region)||".html";
      call define(_col_,'url',rtag);
   endcomp;
   rbreak after / summarize;
   run;
ods html close;

* Western Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_3a_RegionWEST.html';

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
   compute country;
      if _break_='_RBREAK_' then do;
         country = 'Region';
         call define(_col_,'url',"ch8_5_3a_Region.html");
      end;
   endcomp;
   rbreak after / summarize;
   run;
ods html close;

* Eastern Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_3a_RegionEAST.html';

title1 'Eastern Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
      nowd;
   column country product,actual;
   define country / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute country;
      if _break_='_RBREAK_' then do;
         country = 'Region';
         ctag = "ch8_5_3a_Region.html";
         call define(_col_,'url',ctag);
      end;
   endcomp;
   rbreak after / summarize;
   run;
ods html close;
