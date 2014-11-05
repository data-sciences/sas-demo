* S8_5_6.sas
*
* Creating RTF links.;

ods listing close;

* Regional Report  ***********************;
ods rtf style=rtf
        file="&path\results\ch8_5_6_Region.rtf";

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
      rtag = "ch8_5_6_Region"||trim(region)||".rtf";
      call define(_col_,'url',rtag);
   endcomp;
   rbreak after / summarize;
   run;
ods rtf close;

* Western Region Report  ***********************;
ods rtf style=rtf
        file="&path\results\ch8_5_6_RegionWEST.rtf";

title1 'Western Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='WEST'))
            nowd;
   column region country product,actual;
   define region  / group style(header)={url='ch8_5_6_Region.rtf'};
   define country / group;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods rtf close;

* Eastern Region Report  ***********************;
ods rtf style=rtf
        file="&path\results\ch8_5_6_RegionEAST.rtf";

title1 'Eastern Region Summary';

proc report data=sashelp.prdsale
                    (where=(prodtype='OFFICE' and region='EAST'))
            nowd;
   column region country product,actual;
   define region  / group style(header)={url='ch8_5_6_Region.rtf'};
   define country / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   rbreak after / summarize;
   run;
ods rtf close;
