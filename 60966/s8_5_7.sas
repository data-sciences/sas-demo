ods listing close;


%macro linked(prod=OFFICE);
%local i;

* Determine the count and list of regions;
proc sql noprint;
   select distinct region
      into :reg1- :reg99
         from sashelp.prdsale(where=(prodtype="&prod"));
   %let regcnt = &sqlobs;
   quit;


* Regional Report  ***********************;
ods rtf style=rtf
        file="&path\results\ch8_5_7_Region.rtf";

title1 'Region Summary';
footnote1;

proc report data=sashelp.prdsale
                    (where=(prodtype="&prod"))
            nowd;
   column region product,actual;
   define region  / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute region;
      rtag = "ch8_5_7_Region"||trim(region)||".rtf";
      call define(_col_,'url',rtag);
   endcomp;
   rbreak after / summarize;
   run;
ods rtf close;


%do i = 1 %to &regcnt;
   * Individual Region Report  ***********************;
   ods rtf style=rtf
           file="&path\results\ch8_5_7_Region&&reg&i...rtf";

   title1 "Region Summary for &&reg&i";

   proc report data=sashelp.prdsale
                       (where=(prodtype="&prod" and region="&&reg&i"))
               nowd;
      column region country product,actual;
      define region  / group style(header)={url='ch8_5_7_Region.rtf'};
      define country / group;
      define product / across;
      define actual  / analysis sum
                       format=dollar8.
                       'Sales';
      rbreak after / summarize;
      run;
   ods rtf close;
%end;
%mend linked;
%linked(prod=OFFICE)
