* E13_8_2.sas
*
* Grabbing and resetting settings.;

title '13.8.2 Storing Settings'; 
%macro securecode;
data _null_;
   set sashelp.voption(where=(optname in('MPRINT', 'MLOGIC', 'SYMBOLGEN')));
   call symputx('hold'||left(optname),optname, 'l');
   run; 
options nomprint nomlogic nosymbolgen;

/* secure code goes here*/

options &holdmprint &holdmlogic &holdsymbolgen;
%mend securecode;
%securecode

filename super 'c:\temp\super.pdf';
options mprint symbolgen mlogic;
%macro newref(locref=, newlocref=, newname=);
%local origref origname nameloc newloc rc;
%let origref = %sysfunc(pathname(&locref));
%let origname= %scan(&origref,-1,\);
%let nameloc = %sysfunc(indexw(&origref,&origname,\));
%let newloc  = %substr(&origref,1,&nameloc-1)&newname;
%let rc      = %sysfunc(filename(newlocref,&newloc));
%put %sysfunc(fileexist(&newlocref));
%mend newref;
%newref(locref=super,newlocref=silly,newname=freqplot.pdf)

%macro findautos;                                                                                                                       
%local autoref i ref refpath;                                                                                                           
%let autoref = %sysfunc(getoption(sasautos));                                                                                           
%let i=0;                                                                                                                               
%do %until(&ref eq);                                                                                                                    
   %let ref = %qscan(&autoref,&i+1);                                                                                                    
   %if &ref eq %then %return;                                                                                                           
   %let refpath=%qsysfunc(pathname(&ref));                                                                                             
   %let i = %eval(&i + 1);                                                                                                             
   %put &i &ref &refpath;                                                                                                              
%end;                                                                                                                                   
%mend findautos; 
%put %sysfunc(getoption(sasautos)); 
%findautos    

* ***********************************************
** Alternate version of findautos
** this version may not work on UNIX  ;
%macro findautos2;
%local autoref i ref refpath;
%let autoref = %sysfunc(getoption(sasautos));
%let i=0;
%do %while(%scan(&autoref,&i+1) ne %bquote());
   %let ref = %qscan(&autoref,&i+1);
   %let refpath=%qsysfunc(pathname(&ref));
   %let i = %eval(&i + 1);
   %put &i &ref &refpath;
%end;
%mend findautos2;
%findautos2
