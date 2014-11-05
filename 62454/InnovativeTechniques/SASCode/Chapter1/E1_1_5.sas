* E1_1_5.sas
*
* Finding Sheet Names;

libname toxls excel "&path\data\newwb.xls";

title1 '1.1.5 Sheet Names';
title2 'Using SASHELP.VTABLE';
data sheetnames;
set sashelp.vtable;
where libname = 'TOXLS';
run;
proc print data=sheetnames;
run;
title2 'Using DICTIONARY.MEMBERS';
proc sql;  
create table sheetnames as 
   select * from dictionary.members 
      where engine= 'EXCEL' ;
   quit ;
proc print data=sheetnames;
run;

