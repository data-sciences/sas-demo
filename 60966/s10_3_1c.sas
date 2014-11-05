* Ch10_3_1c.sas
* Adding graphics;
* Reducing size with XPIXELS and YPIXELS;

* The listing destination must be open to create the graphs
* (even though they do not go to that destination);
ods listing;

* Create a format to group regions 
* This value also serves as the name of the file and the GRSEG entry;
proc format;
   value $regfile
     '1','2','3' = 'NoEast'  
     '4'         = 'SoEast'
     '5' - '8'   = 'MidWest' 
     '9', '10'   = 'Western';
   run;

* Specify four gray scale patterns ;
pattern1 v=psolid c=gray22 r=1;
pattern2 v=psolid c=gray66 r=1;
pattern3 v=psolid c=grayaa r=1;
pattern4 v=psolid c=grayee r=1;

title1;

* Clear the GSEG catalog from the work library;
proc datasets library=work mt=cat nolist;
   delete gseg;
   quit;

* Create a dummy record for each combination of 
* region type and procedure;
data dummy(keep=region proced wt ht edu);
   do region='5 ','1','4','9';
      do proced=' ','1','2','3';
         wt=.; ht=.; edu=.;
         output;
      end;
   end;
   run;
 
* Combine the clinics data with the dummy data;
* Add a counter for summing valid observations;
data clinics(keep=reggrp proced wt ht edu cnt);
   set rptdata.clinics(keep=region proced wt ht edu)
       dummy(in=indum);
   reggrp = put(region,$regfile.);
   * CNT is 1 for all valid (non-dummy) obs;
   cnt = 1-indum;
   run;        

proc sort data=clinics;
   by reggrp proced;
   run;

%macro bldimage;
* Count regions and save names in macro variables;
proc sql noprint;
   select distinct(reggrp)
      into :reg1-:reg99
         from clinics;
   %let regcnt = &sqlobs;
   quit; 


%do i = 1 %to &regcnt;
   * Name the file that holds result;
   * &&REG&I resolves to the region name;
   filename propie "&path\results\&&reg&i...gif";
   * Define the graphics device;
   * GIF160 is the smallest gif driver pre-defined in SAS/GRAPH
   *        It has XPIXELS=160 and YPIXELS=120;
   goptions dev=gif
            xpixels=40 ypixels=30
            gsfname=propie;
   proc gchart data=clinics(where=(reggrp="&&reg&i"));
      pie proced / noheading missing
                   type=sum
                   sumvar=cnt
                   slice=none
                   /* specify the name of the entry as the region */
                   name="&&reg&i";
      run;
      quit;
%end;
%mend bldimage;
%bldimage

ods listing close;
ods html path="&path\results"
         body="ch10_3_1c.html"
         style=default;
ods pdf  file="&path\results\ch10_3_1c.pdf"
         style=minimal;
ods rtf  file="&path\results\ch10_3_1c.rtf"
         style=rtf;

title1 'Interfacing with REPORT';
title2 'Adding Graphics';
title3 'Reducing size with XPIXELS and YPIXELS';

proc report data=clinics nowd split='*';
   column reggrp image image2 edu ht wt;
   define reggrp / group width=10 'Region' order=formatted;
   define image  / computed 'style';
   define image2 / computed 'grseg';
   define edu    / analysis mean 'Years of*Education' 
                   format=9.2 ;
   define ht     / analysis mean format=6.2 'Height';
   define wt     / analysis mean format=6.2 'Weight';

   compute image / char length=10;
      image=' ';
      imageloc = "style={postimage='&path\results\"
                         ||trim(reggrp)|| ".gif'}";
      call define('image',
                  'style',
                  imageloc);
   endcomp;
   
   compute image2 / char length=10;
      image2=' ';
      imageloc = "work.gseg."||trim(reggrp)||'.grseg';
      call define('image2',
                  'grseg',
                  imageloc);
   endcomp;
   run;
ods _all_ close;
