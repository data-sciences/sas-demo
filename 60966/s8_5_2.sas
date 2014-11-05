* S8_5_2.sas
*
* Establishing links through data values.;

ods listing close;

* Regional Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_2_Region.html';

title1 'Region Summary';
footnote1;

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE'))
      nowd;
   column region regtag product,actual;
   define region  / group noprint;
   define regtag  / computed format=$4. 'Region';
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute regtag / char length=60;
      * There are two ways that we can specify the region tag - the second is commented out;
      regtag = "<a href='ch8_5_2_Region"||trim(region)||".html'>"||trim(region)||"</a>";
      /*if region='WEST' then
         regtag = "<a href='ch8_5_2_RegionWEST.html'>West</a>";
      else if region='EAST' then
         regtag = "<a href='ch8_5_2_RegionEAST.html'>East</a>";*/
   endcomp;
   rbreak after / summarize;
   run;
ods html close;

* Western Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_2_RegionWEST.html';

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
         ctag = "<a href='ch8_5_2_Region.html'>Total</a>";
      else ctag=country;
   endcomp;
   rbreak after / summarize;
   run;
ods html close;

* Eastern Region Report  ***********************;
ods html style=default
         path="&path\results" (url=none)
         body='ch8_5_2_RegionEAST.html';

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
         ctag = "<a href='ch8_5_2_Region.html'>Total</a>";
      else ctag=country;
   endcomp;
   rbreak after / summarize;
   run;
ods html close;
