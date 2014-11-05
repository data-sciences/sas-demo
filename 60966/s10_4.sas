* S10_4.sas
*
* Increasing cell height to force a break space;

ods html path="&path\results"
         body="ch10_4.html";

title1 'Inserting blank spaces';
title2 'Adding Summary Row Height';
proc report data=sashelp.class nowd;
   column sex age height weight;
   define sex    / group;
   define age    / group;
   define height / mean;
   define weight / mean;

   break after sex / summarize suppress;

   compute after sex;
      call define(_row_,'style','style={htmlstyle="height:60px"}');
   endcomp;
   run;

ods html close;

