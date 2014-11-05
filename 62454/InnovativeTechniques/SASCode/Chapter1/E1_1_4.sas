* E1_1_4.sas
*
* Clearing/replacing the values in a sheet;

libname toxls excel "&path\data\newwb.xls";

data toxls.ClinicNames;
   set advrpt.clinicnames;
   where clinname>'X';
   run;

* Running the DATA step a second time results in an error;
data toxls.ClinicNames;
   set advrpt.clinicnames;
   run;

* Clear the libref so the workbook can be reestablished.;
libname toxls excel "&path\data\newwb.xls" scan_text=no;
proc datasets library=toxls nolist;
   delete ClinicNames;
   quit;
data toxls.ClinicNames;
   set advrpt.clinicnames;
   run;
libname toxls clear;
