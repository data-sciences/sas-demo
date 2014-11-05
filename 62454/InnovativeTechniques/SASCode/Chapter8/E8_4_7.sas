* E8_4_7.sas
* 
* Introducing CALL DEFINE;

ods pdf file="&path\results\E8_4_7.pdf" 
        style=journal;
title1 '8.4.7 Creating a Vertical Space Using CALL DEFINE';
proc report data=advrpt.demog nowd;
   column edu sex,(wt wt=wtse) dummy wt=allwt wt=allwtse;
   define edu / group 'Years/Ed.';
   define sex / across order=formatted;
   define wt  / mean 'Mean' F=5.1;
   define wtse / stderr 'StdErr' f=5.2;
   define dummy / computed ' ' ;
   define allwt / mean 'Overall/Mean' f=5.1;
   define allwtse / stderr 'Overall/StdErr' f=5.2;

   compute dummy/char length=1;
      call define(_col_,'style','style={background=cxd3d3d3 cellwidth=1mm}');
      dummy = ' ';
   endcomp;
run;
ods pdf close;      
