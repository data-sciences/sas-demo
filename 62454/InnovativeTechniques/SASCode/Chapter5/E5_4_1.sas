*E5_4_1.sas
*
* Using PWENCODE to encode passwords;

***************************************
* A copy of the ADVRPT.DEMOG data set has been written 
* to a sheet in the workbook &path\data\E5_4_1.xls
* The workbook has been encrypted with a password of
* 'wish2pharm';

filename pwfile "&path\results\pwfile.txt";
proc pwencode in='pharmer' out=pwfile;
  run;

/* the encoded password becomes
{sas002}81F6943F251507393B969C0753B2D73B 
*/

data _null_;
length tmp $1024 opt $1200;
infile pwfile truncover;
input tmp;
opt='dsn=SQLServer user=myid password="'||left(trim(tmp))||'"';
rc=libname('sqlsrv',,'odbc', opt);
txt=sysmsg();
put rc= txt=;
run;
  


