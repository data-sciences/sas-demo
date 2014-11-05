*E15_1_3.sas
*
* Executing OS commands;

title '15.1.3 Executing OS commands';
* List all sas files;

x 'dir "c:\temp\*.sas7*" /b/o > c:\temp\SASFiles.txt';
filename flist 'c:\temp\SASFiles.txt';
data filelist;
infile flist truncover;
input name $20.;
run;
proc print data=filelist;
run;
*****
* Alternates to the X statement;
%sysexec(dir "c:\temp\*.sas7*" /b/o > c:\temp\SASFiles.txt);
systask command 'dir "c:\temp\*.sas7*" /b/o > c:\temp\SASFiles.txt';
filename flist pipe 'dir "c:\temp\*.sas7*" /b/o';

*******************************************;

data _null_;
   if fileexist('c:\temp') then do;
      call system('dir "c:\temp\*.sas7*" /b/o > c:\temp\SASFiles.txt');
      end;
   run;
****************************************************;
* mostly eliminate the command window;
options noxwait xmin noxsync;
x 'dir *.*';
