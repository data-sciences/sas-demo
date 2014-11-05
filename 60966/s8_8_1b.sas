* S8_8_1b.sas
*
* Tip text using FLYOVER;

ods listing close;
ods html style=default
    path="&path\results"
    body="ch8_8_1b.html";
ods pdf style=printer
    file="&path\results\ch8_8_1b.pdf";

title1 "Clinic Summaries";
proc report data=rptdata.clinics nowd;
   columns clinname clinnum ht ht=htmean wt;

   define clinname/ group noprint;
   define clinnum / group 'Clinic Number';
   define ht      / analysis n 'N';
   define htmean  / analysis mean 'Height';
   define wt      / analysis mean 'Weight';

   rbreak after   / summarize;

   compute clinnum;
      attrib = 'style={flyover="'||trim(clinname)||
               '" htmlstyle="cursor:hand"}';
      call define(_col_,'style',attrib);
   endcomp;
   run;
ods _all_ close;
