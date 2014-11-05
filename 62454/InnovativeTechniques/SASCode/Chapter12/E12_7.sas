* E12_7.sas
* 
* Building Formats from data;

title1 '12.7 Building Formats from Data';

***********************************************;
* Build the cl_reg format;
data cntrlfmt(keep=fmtname start label);
   set advrpt.clinicnames(rename=( clinnum=start region=label));
   retain fmtname '$cl_reg';
   run;
proc format cntlin=cntrlfmt;
   run;

proc freq data=advrpt.demog;
   table clinnum;
   format clinnum $cl_reg.;
   run;

*************************************************;
* Construct two formats at the same time;
* Build the cl_reg and cl_name formats;
data cntrlfmt(keep=fmtname start label);
   set advrpt.clinicnames(rename=( clinnum=start));
   length fmtname $8 label $40;
   fmtname = '$cl_reg';
   label = region;
   output cntrlfmt;
   fmtname = '$cl_name';
   label = clinname;
   output cntrlfmt;
   run;
proc sort data=cntrlfmt;
   by fmtname start;
   run;
proc format cntlin=cntrlfmt;
   run;

proc freq data=advrpt.demog;
   table clinnum;
   format clinnum $cl_name25.;
   run;

*************************************************;
* Show available variables in a control file;
proc format cntlout=control(where=(fmtname='CL_NAME'));
   run;
proc print data=control;
   run;

*************************************************;
* Create a format with a nested format;
data intervals(keep=fmtname start end label hlo);
retain fmtname 'studydt';
length label $20;
start = '12jan2006:01:01:01'dt;
end = '24nov2007:11:12:13'dt;
label = 'datetime18.';
hlo = 'F';
output intervals;
start=.;
end=.;
hlo='O';
label= 'Out of Compliance' ;
output intervals;
run;

proc format cntlin=intervals;
run;

data tryit;
value= '10jan2000:01:01:01'dt; put 'Below range ' value= datetime. value=studydt.;
value= '10jan2004:01:01:01'dt; put 'In range ' value= datetime. value=studydt.;
value= '10jan2006:01:01:01'dt; put 'After range ' value= datetime. value=studydt.;
run;

**************************************************;
* Show control data set variable values - especially HLO;
proc format ;
value testdt
 low-<'01jan2011'd = 'early'
 '01jan2011'd - '01jan2012'd = [date9.]
 other = 'unk';
 run;
 proc format cntlout=testdt(where=(fmtname='TESTDT'));
 run;
 proc print data=testdt;
 run;
