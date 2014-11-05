* S8_9b.sas
*
* Using COLUMNS=;

ods listing close;
ods pdf style=printer
    columns=4
    file="&path\results\ch8_9b.pdf";
ods rtf style=rtf
    columns=4
    file="&path\results\ch8_9b.rtf"
    bodytitle;

title1 "Name Lists by Clinic";
proc report data=rptdata.clinics nowd;
   columns clinname clinnum ("Name" lname fname);

   define clinname/ display noprint;
   define clinnum / order 'Clinic Number';
   define lname   / order 'Last';
   define fname   / order  'First';

   compute clinnum;
      attrib = 'style={flyover="'||trim(clinname)||'"}';
      call define(_col_,'style',attrib);
   endcomp;
   run;
ods _all_ close;
