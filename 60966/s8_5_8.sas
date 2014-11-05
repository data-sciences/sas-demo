* S8_5_8.sas
*
* Using a format to build a link;

ods listing close;

proc format;
   value $regtag
      'WEST' = "<a href='ch8_5_8_WEST.html'>West</a>"
      'EAST' = "<a href='ch8_5_8_EAST.html'>East</a>";
   run;

* Regional Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_8_Region.html';

title1 'Region Summary';
footnote1;

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE'))
            nowd;
   column region product,actual;
   define region  / group format=$regtag40. 'Region';
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
         body='ch8_5_8_WEST.html';

title1 'Western Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='WEST'))
            nowd;
   column country ctag product,actual;
   define country / group noprint;
   define ctag    / computed format=$7. 'Country';
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute ctag / char length=60;
      if _break_='_RBREAK_' then
         ctag = "<a href='ch8_5_8_Region.html'>Total</a>";
      else ctag=country;
   endcomp;
   rbreak after / summarize;
   run;
ods html close;

* Eastern Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_8_EAST.html';

title1 'Eastern Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
            nowd;
   column country ctag product,actual;
   define country / group noprint;
   define ctag    / computed format=$7. 'Country';
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute ctag / char length=60;
      if _break_='_RBREAK_' then
         ctag = "<a href='ch8_5_8_Region.html'>Total</a>";
      else ctag=country;
   endcomp;
   rbreak after / summarize;
   run;
ods html close;
