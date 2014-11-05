* E8_4_6.sas
* 
* Using STYLE on the compute statement;

ods pdf file="&path\results\E8_4_6.pdf" 
        style=journal;
title1 '8.4.6 Using STYLE on the COMPUTE statement';
title2 'Patient Weight';
proc report data=advrpt.demog nowd;
   column edu sex,(wt wt=wtse) wt=n wt=allwt;
   define edu / group 'Years/Ed.';
   define sex / across order=formatted;
   define wt  / mean 'Mean' F=5.1;
   define wtse / stderr 'StdErr' f=5.2;
   define n   / n noprint;
   define allwt / mean 'Overall/Mean' f=5.1;

   compute after/style(lines)={just=center
                               font_face=Arial 
                               font_style=italic 
                               font_size=10pt};
      line ' ';
      line @10  'Overall Statistics:';
      line @15 n 3. ' Subjects had a mean weight of ' allwt 5.1 ' pounds';
   endcomp;
run;
ods pdf close;      

**************************************
* Show the use of the inline formatting;
ods rtf file="&path\results\E8_4_6b.rtf";
ods escapechar='~';
title1 '8.4.6b Using Inline Formatting';
title2 '~S={just=r} Patient Weight';
data Demog;
set advrpt.demog;
pageflag=1;
run;

proc report data=demog(where=(sex='F')) nowd;
   column pageflag edu sex,(wt wt=wtse) wt=n wt=allwt;
   define pageflag / group noprint;
   define edu / group 'Years/Ed.';
   define sex / across order=formatted;
   define wt  / mean 'Mean' F=5.1;
   define wtse / stderr 'StdErr' f=5.2;
   define n   / n noprint;
   define allwt / mean 'Overall/Mean' f=5.1;

   compute after pageflag;
   line "~S={just=l background=pink } Females Only"; 
   endcomp; 
   compute after/style(lines)={just=center
                               font_face=Arial 
                               font_style=italic 
                               font_size=10pt};
      line ' ';
      line @10  'Overall Statistics:';
      line @15 n 3. ' Subjects had a mean weight of ' allwt 5.1 ' pounds';
   endcomp;
run;
ods rtf close;

