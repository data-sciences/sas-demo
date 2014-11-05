* S8_5_5a.sas
*
* Creating links in a PDF document;

ods listing close;

* Regional Report  ***********************;
ods pdf style=printer
        file="&path\results\ch8_5_5a_Region.pdf";

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
      rtag = "ch8_5_5a_Region"||trim(region)||".pdf";
      call define(_col_,'url',rtag);
   endcomp;
   rbreak after / summarize;
   run;
ods pdf close;

* Western Region Report  ***********************;
ods pdf style=printer
        file="&path\results\ch8_5_5a_RegionWEST.pdf";

title1 'Western Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='WEST'))
            nowd;
   column region country product,actual;
   define region  / group style(header)={url='ch8_5_5a_Region.pdf'};
   define country / group;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods pdf close;

* Eastern Region Report  ***********************;
ods pdf style=printer
        file="&path\results\ch8_5_5a_RegionEAST.pdf";

title1 'Eastern Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
            nowd;
   column region country product,actual;
   define region  / group style(header)={url='ch8_5_5a_Region.pdf'};
   define country / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods pdf close;