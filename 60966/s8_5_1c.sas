* S8_5_1c.sas
*
* Using the LINK= option in the TITLE statement;

* Regional Report  ***********************;
ods pdf style=printer
        file="&path\results\ch8_5_1c_Region.pdf";

title1 'Region Summary';
title2 link='ch8_5_1c_RegionWEST.pdf'
             "Detail for Western Region";
title3 link='ch8_5_1c_RegionEAST.pdf'
             "Detail for Eastern Region";

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
ods pdf close;

* Western Region Report  ***********************;
ods pdf style=printer
        file="&path\results\ch8_5_1c_RegionWEST.pdf";

title1 'Western Region Summary';
title2 link='ch8_5_1c_Region.pdf'
             "Region Summary";
title3 link='ch8_5_1c_RegionEAST.pdf'
             "Detail for Eastern Region";

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
ods pdf close;

* Eastern Region Report  ***********************;
ods pdf style=printer
        file="&path\results\ch8_5_1c_RegionEAST.pdf";

title1 'Eastern Region Summary';
title2 link="ch8_5_1c_Region.pdf"
             "Region Summary";
title3 link="ch8_5_1c_RegionWEST.pdf"
             "Detail for Western Region";

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
ods pdf close;
