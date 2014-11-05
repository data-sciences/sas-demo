/* Most examples use these options */
options center nodate nonumber;

/******************************************************************************/
/* Chapter 1 - Why Use ODS?                                                   */
/******************************************************************************/
/* Figure 1.1, 1.2, 1.3 */
options formdlim=' ';
title "Frequencies";
proc freq data=sales;
    table ProductName Department;
run;
title "Univariate";
proc univariate data=sales;
    var ItemsSold;
run;
title "Outliers for Price";
proc print data=sales;
    where ItemPrice>13;
    var ItemPrice;
run;
title;
options formdlim='';

/* Figure 1.4 */
ods html file='ch01_4_body.html'
         frame='ch01_4_frame.html'
         contents='ch01_4_contents.html'
         style=sasweb;
title "Frequencies";
proc freq data=sales;
    table ProductName Department;
run;
title "Univariate";
proc univariate data=sales;
    var ItemsSold;
run;
title "Outliers for Price";
proc print data=sales;
    where ItemPrice>13;
    var ItemPrice;
run;
ods html close;
title;

/* Figure 1.5 */
ods rtf file='ch01_1.rtf';
title "Frequencies";
proc freq data=sales;
    table ProductName Department;
run;
title "Univariate";
proc univariate data=sales;
    var ItemsSold;
run;
title "Outliers for Price";
proc print data=sales;
    where ItemPrice>13;
    var ItemPrice;
run;
ods rtf close;
title;

/* Figure 1.6 */
/* CAUTION: This code sends output directly to the printer */
ods printer;
title "Frequencies";
proc freq data=sales;
    table ProductName Department;
run;
title "Univariate";
proc univariate data=sales;
    var ItemsSold;
run;
title "Outliers for Price";
proc print data=sales;
    where ItemPrice>13;
    var ItemPrice;
run;
ods printer close;
title;

/* Send same output to PDF destination */
ods pdf file='ch01_1.pdf';
title "Frequencies";
proc freq data=sales;
    table ProductName Department;
run;
title "Univariate";
proc univariate data=sales;
    var ItemsSold;
run;
title "Outliers for Price";
proc print data=sales;
    where ItemPrice>13;
    var ItemPrice;
run;
ods pdf close;
title;


/******************************************************************************/
/* End Chapter 1                                                              */
/******************************************************************************/


/******************************************************************************/
/* Chapter 2 - ODS Basics                                                     */
/******************************************************************************/


title;

ods proctitle;

/* Figure 2.1 */
title;
footnote;
ods html file='ch02_output1a.html';
proc corr data=sales nosimple;
  var ItemsSold;
  with ItemPrice;
run;
ods html close;

ods html file='ch02_output1b.html' style=sasweb;
proc corr data=sales nosimple;
  var ItemsSold;
  with ItemPrice;
run;
ods html close;

/* Figure 2.4 */
title;
footnote;
ods exclude varinformation;
ods html file='ch02_output4.html';
proc corr data=sales nosimple;
  var ItemsSold;
  with ItemPrice;
run;
ods html close;

/* Figure 2.5 */
title;
footnote;
ods exclude varinformation;
ods html file='ch02_output5.html';
ods noproctitle;
proc corr data=sales nosimple;
  var ItemsSold;
  with ItemPrice;
run;
ods html close;
ods proctitle;

/* Figure 2.6 */
title;
footnote;
proc template;
  define style silly;
  parent=styles.default;
  replace fonts /
         'TitleFont2' = ("Comic Sans MS, sans-serif",4,bold italic)
         'TitleFont' = ("Comic Sans MS, sans-serif",5,bold italic)
         'StrongFont' = ("Comic Sans MS, sans-serif",4,bold)
         'EmphasisFont' = ("Comic Sans MS, sans-serif",3,italic)
         'FixedEmphasisFont' = ("Comic Sans MS, monospace",2,italic)
         'FixedStrongFont' = ("Comic Sans MS, monospace",2,bold)
         'FixedHeadingFont' = ("Comic Sans MS, monospace",2)
         'BatchFixedFont' = ("Comic Sans MS, monospace",
         2)
         'FixedFont' = ("Comic Sans MS",2)
         'headingEmphasisFont' = ("Comic Sans MS, sans-serif",4,bold
         italic)
         'headingFont' = ("Comic Sans MS, sans-serif",4,bold)
         'docFont' = ("Comic Sans MS, sans-serif",3);
end;
run;

ods exclude varinformation;
ods noproctitle;
ods html file='ch02_output6.html' style=silly;
proc corr data=sales nosimple;
  var ItemsSold;
  with ItemPrice;
run;
ods html close;


/* Figure 2.7, 2.8, 2.9, 2.10, 2.11, 2.12 */
ods exclude varinformation;
ods noproctitle;

title;
footnote;

ods listing;
ods html file='ch02_output8.html';
ods rtf file='ch02_output9.rtf';
ods ps file='ch02_output10.pdf';
ods output pearsoncorr=ch02_dataset_output11;
proc corr data=sales nosimple;
  var ItemsSold;
  with ItemPrice;
run;
ods html close;
ods rtf close;
ods pdf close;


/******************************************************************************/
/* End Chapter 2                                                              */
/******************************************************************************/


/******************************************************************************/
/* Chapter 3 - HTML Output                                                    */
/******************************************************************************/

/* Figure 3.1 */
title;
footnote;

filename myfile 'myhtmlfile.html';
ODS HTML BODY=myfile;
proc means data=billings maxdec=2;
  class quarter;
  var Hours BillableAmt;
run;
ODS HTML CLOSE;

/* Figure 3.2, 3.3 */
title;
footnote;

ODS HTML BODY='procmeans.html';
proc means data=billings nonobs maxdec=2 mean min max;
  var BillableAmt;
run;
ODS HTML CLOSE;


/* Figure 3.4, 3.5 */
title;
footnote;

GOPTIONS DEVICE=GIF;
ODS HTML PATH='c:\temp' BODY='c:\temp\mygraph.html'
         GPATH='c:\temp' (URL=NONE);
proc gchart data=Billings;
   vbar3d Quarter / name="billqtr"
                    sumvar=BillableAmt
                    type=mean;
run;
quit;
ODS HTML CLOSE;



/* Figure 3.6 */
title;
footnote;

title 'Quarterly Report';
ODS HTML BODY='QReport.html';
title2 'Revenue by Customer';
proc means data=Billings nonobs mean sum;
  class CustomerName;
  var BillableAmt;
run;
title2 'Revenue by Division';
proc means data=Billings nonobs mean sum;
  class Division;
  var BillableAmt;
run;
title2 'Top Performers';
proc print data=Totals noobs;
  where BillableAmt>10000;
  var EmployeeName BillableAmt;
run;
ODS HTML CLOSE;


/* Figure 3.7,3.8,3.9 */
title;
footnote;

title 'Quarterly Report';
ODS HTML BODY='c:\temp\body.html'
         CONTENTS='c:\temp\contents.html'
         FRAME='c:\temp\frame.html';
title2 'Revenue by Customer';
proc means data=Billings nonobs mean sum;
  class CustomerName;
  var BillableAmt;
run;
title2 'Revenue by Division';
proc means data=Billings nonobs mean sum;
    class Division;
    var BillableAmt;
run;
title2 'Top Performers';
proc print data=Totals noobs;
  where BillableAmt>10000;
  var EmployeeName BillableAmt;
run;
ODS HTML CLOSE;

/********************************/
/* Code for Figure 3.10 OMITTED */
/********************************/


/* Figure 3.11 */
title;
footnote;

title "Quarterly Report";

ODS HTML BODY='body1_3_11.html' NEWFILE=PROC
         CONTENTS='contents_3_11.html'
         FRAME='main_3_11.html';
title2 'Revenue by Customer';
proc means data=Billings nonobs mean sum;
  class CustomerName;
  var BillableAmt;
run;
title2 'Revenue by Division';
proc means data=Billings nonobs mean sum;
    class Division;
    var BillableAmt;
run;
title2 'Top Performers';
proc print data=Totals noobs;
    where BillableAmt>10000;
    var EmployeeName BillableAmt;
run;
ODS HTML CLOSE;

/* Figure 3.12 */
title;
footnote;

title "Quarterly Report";

ODS HTML BODY='body1_3_12.html' NEWFILE=PROC
         FRAME='main_3_12.html'
         PAGE='page_3_12.html';
title2 'Revenue by Customer';
proc means data=Billings nonobs mean sum;
  class CustomerName;
  var BillableAmt;
run;
title2 'Revenue by Division';
proc means data=Billings nonobs mean sum;
    class Division;
    var BillableAmt;
run;
title2 'Top Performers';
proc print data=Totals noobs;
    where BillableAmt>10000;
    var EmployeeName BillableAmt;
run;
ODS HTML CLOSE;


/*******************************************/
/* Code for Figures 3.13,3.14,3.15 OMITTED */
/*******************************************/


/* Figure 3.16 */
title;
footnote;

title "Quarterly Report";
ODS HTML BODY='body_3_16.html'
         CONTENTS='contents_3_16.html'
         FRAME='main_3_16.html';
ODS PROCLABEL 'Hours Billed by Customer';
title2 'Hours Billed by Customer';
proc means data=Billings nonobs mean sum maxdec=1;
  class CustomerName;
  var Hours;
run;
ODS HTML CLOSE;


/* Figure 3.17 */
title;
footnote;

title "Quarterly Report";
ODS HTML BODY='body_3_17.html'
         CONTENTS='contents_3_17.html'
         FRAME='main_3_17.html';
ODS PROCLABEL ' ';
title2 'Hours Billed by Customer';
proc means data=Billings nonobs mean sum maxdec=1;
  class CustomerName;
  var Hours;
run;
ODS HTML CLOSE;


/* Figure 3.18 */
title;
footnote;

title "Quarterly Report";
ODS HTML BODY='body_3_18.html'
         CONTENTS='contents_3_18.html'
         FRAME='main_3_18.html';
title2 'Hours Billed by Customer';
ODS PROCLABEL 'Hours Billed';
proc means data=Billings nonobs mean sum maxdec=1;
   class CustomerName;
   var Hours;
run;
title2 'Hours Billed by Division';
proc means data=Billings nonobs mean sum maxdec=1;
  class Division;
  var Hours;
run;
title3 'Overtime Hours';
ODS PROCLABEL 'Overtime';
proc print data=Billings noobs;
  where Hours>8;
  var Hours Division WorkDate;
run;
ODS HTML CLOSE;


/* Figure 3.19 */
title;
footnote;

title "Quarterly Report";
ODS HTML BODY='body_3_19.html';
title2 'Hours Billed by Customer';
proc means data=Billings nonobs mean sum maxdec=1;
  class CustomerName;
  var Hours;
run;
ODS HTML CLOSE;

/* Figure 3.20 */
title;
footnote;

title "Quarterly Report";
ODS HTML BODY='body_3_20.html' (TITLE='Quarterly Report');
title2 'Hours Billed by Customer';
proc means data=Billings nonobs mean sum maxdec=1;
  class CustomerName;
  var Hours;
run;
ODS HTML CLOSE;


/* Figure 3.21, 3.22, 3.23, 3.24 */
title;
footnote;

ODS HTML(1) BODY='body_3_21.html';
ODS CHTML BODY='chtml_3_22.html';
ODS HTML(2) BODY='ht_css_3_23.html'
                       stylesheet='default.css';
ODS PHTML BODY='phtml_3_24.html';
proc means data=Billings nonobs mean sum maxdec=1;
  class CustomerName;
  var Hours;
run;
ODS _ALL_ CLOSE;



/* Figure 3.25, 3.26 */
title;
footnote;

title "Billable Amount by Division and Job Type";
ODS HTML(1) BODY='ForIntranet_3_25.html' Style=minimal;
ODS HTML(2) BODY='ForWeb_3_26.html' Style=sasweb;
proc tabulate data=billings missing;
  class division jobtype;
  var billableamt;
  tables jobtype all='Total',
         division*billableamt*(n*f=3. sum*f=dollar11.2);
run;
ODS HTML(2) CLOSE;
proc print data=billings n;
  where division='Reporting' and billableamt ge 1000;
  title2 "For Internal Distribution Only";
  title3 "Reporting Division Billable Amount $1000+";
  var jobtype employeename workdate customername hours billableamt quarter;
run;
ODS HTML(1) CLOSE;


/* Figure 3.27, 3.28, 3.29 */
title;
footnote;

ODS HTML BODY='body_3_27.html'
         CONTENTS='contents_3_27.html'
         FRAME='main_3_27.html';
proc univariate data=Billings plots;
  var Hours;
run;
ODS HTML CLOSE;


/*******************************************/
/* Code for Figures 3.30,3.31 OMITTED */
/*******************************************/

/* Figure 3.32 */
title;
footnote;

ODS HTML BODY='overtime_3_32.html';
title 'Overtime Billing for Contract Job Type';
footnote 'Overtime defined as >10 hours';
proc print data=Billings noobs label;
   where Hours>10 and jobtype=:'Contract';
   label Hours='Overtime Hours';
   var employeename WorkDate JobType Hours;
run;
ODS HTML CLOSE;
footnote;

/* Figure 3.33 */
ODS HTML BODY='overtime_3_33.html';
title '<H1>Overtime Billing for Contract Job Type</H1>';
footnote '<FONT SIZE=2>Overtime defined as >10 hours</FONT>';
proc print data=Billings noobs label;
   where Hours>10 and jobtype=:'Contract';
   label Hours='<I>Overtime Hours</I>';
   var employeename WorkDate JobType Hours;
run;
ODS HTML CLOSE;
footnote;

/* Figure 3.34, 3.35 */
title;
footnote;

ODS ESCAPECHAR='^';
ODS RTF FILE='overtime_3_34.rtf';
title '^{DEST [HTML] <H1>}Overtime Billing for Contract Job Type^{DEST [HTML]</H1>}';
footnote '^{DEST [HTML] <FONT SIZE=2>}Overtime defined as >10 hours^{DEST [HTML]</FONT>}';
proc print data=Billings noobs label;
   where Hours>10 and jobtype=:'Contract';
   label Hours='^{DEST [HTML]<I>}Overtime Hours^{DEST [HTML]</I>}';
   var employeename WorkDate JobType Hours;
run;
ODS RTF CLOSE;
footnote;


/* Figure 3.36 */
footnote;
ODS ESCAPECHAR='^';
proc format;
   value txfmt 1='Control'
               2='Low Dose^{super 1}'
               3='High Dose^{super 2}';
run;
ODS HTML BODY='PostBPMeans_3_36.html';
title;
proc means data=clinical mean std maxdec=1;
  class tx;
  var postsbp postdbp;
  format tx txfmt.;
run;
ODS HTML CLOSE;


/* Figure 3.37 */
title;
footnote;
ODS ESCAPECHAR='^';
proc format;
   value txfmt 1='Control'
               2='Low Dose^{super 1}'
               3='High Dose^{super 2}';
run;
ODS HTML BODY='PostBPMeans_3_37.html';
options nocenter;
footnote  "^{super 1}2 mL/kg.";
footnote2 "^{super 2}5 mL/kg";
proc means data=clinical mean std maxdec=1;
  class tx;
  var postsbp postdbp;
  format tx txfmt.;
run;
ODS HTML CLOSE;
options center;


/* Figure 3.38 */
title;
footnote;

ODS ESCAPECHAR='^';
proc format;
   value superfmt 1='Control'
                2='Low Dose^{super 1}'
                3='High Dose^{super 2}';
run;
ODS HTML BODY='PostBPMeans_3_38.html';
options nocenter;
footnote  "^{style [font_size=2] ^{super 1}2 mL/kg.}";
footnote2 "^{style [font_size=2] ^{super 2}5 mL/kg}";
proc means data=clinical mean std maxdec=1;
  class tx;
  var postsbp postdbp;
  format tx superfmt.;
run;
ODS HTML CLOSE;
options center;


/* Figure 3.39, 3.40 */
title;
footnote;

proc format;
   value txfmt 1='Control'
               2='Low Dose';
               3='High Dose';
run;
/* Save this code as counter.js in your working folder
******** beginning counter.js


******** end counter.js
*/

/* Save this code as counter2.js in your working folder
******** beginning counter2.js


******** end counter2.js

*/

%let headtext=%quote(<SCRIPT language=""Javascript""
     src=""counter.js"" type=""text/javascript""></SCRIPT>);
%let footer=%quote(<SCRIPT language=""Javascript""
     src=""counter2.js"" type=""text/javascript""></SCRIPT>);

ODS HTML PATH='.' (URL=NONE) BODY='TreatmentFreqs_3_39.html'
         HEADTEXT="&headtext";
footnote justify=right "&footer";
proc freq data=clinical;
  tables tx;
  format tx txfmt.;
run;
ODS HTML CLOSE;


/* Figure 3.41,3.42,3.43,3.44 */
title;
footnote;

ODS HTML(ID=1) BODY='make_externalcss_3_41.html'
               STYLESHEET='default_3_41.css';
ODS HTML(ID=2) BODY='external_sasweb_3_42.html'
               STYLESHEET='sasweb_3_42.css' STYLE=SASWEB;
ODS HTML(ID=3) BODY='use_externalcss_3_43.html'
               STYLESHEET=(URL='corpstyle_3_43.css');
proc means data=clinical mean std maxdec=2;
  class gender;
  var chgsbp chgdbp;
run;

ODS _ALL_ CLOSE;


/* Figure 3.45, 3.46 */
%macro univ(varname);
  ODS HTML FILE="univ_&varname..html";
  proc univariate data=clinical;
    var &varname;
  run;
  ODS HTML CLOSE;
%mend univ;
%univ(basedbp)
%univ(basesbp)
%univ(chgdbp)
%univ(chgsbp)

ODS HTML FILE='main_3_45.html';
proc tabulate data=clinical f=8.1;
   var basesbp basedbp chgsbp chgdbp;
   class tx;
   table basedbp='<a href="univ_basedbp.html">Baseline DBP</a>'
         basesbp='<a href="univ_basesbp.html">Baseline SBP</a>'
         chgdbp='<a href="univ_chgdbp.html">Change in DBP</a>'
         chgsbp='<a href="univ_chgsbp.html">Change in SBP</a>',
         mean*tx=' ';
  format tx txfmt.;
run;
ODS HTML CLOSE;


/* Figure 3.47, 3.48, 3.49 */

title;
footnote;

proc format;
   value txfmt 1='Control'
               2='Low Dose';
               3='High Dose';
run;
ODS HTML BODY='TreatGroup_3_48.html' (NOTOP NOBOT);
proc freq data=clinical;
  tables tx / nocum;
  format tx txfmt.;
run;
ODS HTML CLOSE;
title;
footnote;
ODS HTML BODY='TreatGroup_3_49.html';
proc freq data=clinical;
  tables tx / nocum;
  format tx txfmt.;
run;
ODS HTML CLOSE;


/* Figure 3.50, 3.51 */
title;
footnote;

/* the following statement is for UNIX */
*ODS HTML BODY='/tmp/trial1/results/Gender_3_54.html' (NOBOT);
/* This is the Windows version of the UNIX statement */
ODS HTML(1) BODY='Gender_3_50.html' (NOBOT);
ODS HTML(2) BODY='Gender_3_51.html' (NOBOT);
proc means data=clinical mean std maxdec=2;
  class gender;
  var chgsbp chgdbp;
run;
ODS _ALL_ CLOSE;

filename gender 'Gender_3_51.html' mod;
ODS HTML BODY=gender (NOTOP);
proc freq data=clinical;
  tables tx*gender / nocol norow nopct;
  format tx txfmt.;
run;

ODS HTML CLOSE;


/* Figure 3.52, 3.53 */
title;
footnote;

proc format;
   value txfmt 1='Control'
               2='Low Dose';
               3='High Dose';
run;

/* the following statement is for UNIX */
*ODS HTML BODY='/tmp/trial1/results/GenderBody_3_52.html' (NOBOT)
         CONTENTS='/tmp/trial1/results/GenderTOC_3_52.html' (NOBOT)
         FRAME='/tmp/trial1/results/GenderFrame_3_52.html' ANCHOR='firstrun';
/* This is the Windows version of the UNIX statement */
ODS HTML(1) BODY='c:\temp\GenderBody_3_52.html' (NOBOT)
            CONTENTS='c:\temp\GenderTOC_3_52.html' (NOBOT)
            FRAME='c:\temp\GenderFrame_3_52.html' ANCHOR='firstrun';
ODS HTML(2) BODY='c:\temp\GenderBody_3_53.html' (NOBOT)
            CONTENTS='c:\temp\GenderTOC_3_53.html' (NOBOT)
            FRAME='c:\temp\GenderFrame_3_53.html' ANCHOR='firstrun';
proc means data=clinical mean std maxdec=2;
  class gender;
  var chgsbp chgdbp;
run;
ODS _ALL_ CLOSE;

filename genderb 'c:\temp\GenderBody_3_53.html' mod;
filename gendert 'c:\temp\GenderTOC_3_53.html' mod;
ODS HTML BODY=genderb (NOTOP)
         CONTENTS=gendert (NOTOP)
         FRAME='c:\temp\GenderFrame_3_53.html' ANCHOR='secondrun';
proc freq data=clinical;
  tables tx*gender / nocol norow nopct;
  format tx txfmt.;
run;
ODS HTML CLOSE;

/* Figure 3.54 */
title;
footnote;
ODS HTML BODY='c:\webfiles\outliers_3_54.html'
         CONTENTS='c:\webfiles\toc_3_54.html'
         FRAME='c:\webfiles\frame_3_54.html' (URL=NONE);
ODS HTML SELECT EXTREMEOBS;
proc univariate data=clinical;
  var basesbp postsbp chgsbp;
run;
ODS HTML CLOSE;


/* Figure 3.55, 3.56, 3.57 */
title;
footnote;

proc format;
   value txfmt 1='Control'
               2='Low Dose';
               3='High Dose';
run;

ODS HTML FILE='c:\temp\ClinResults_3_57.html' STYLE=sasweb;
ODS HTML SELECT EXTREMEOBS;
ODS NOPROCTITLE;
proc univariate data=Clinical;
  title 'Outliers in Treatment Groups';
  class tx;
  var basesbp postsbp chgsbp;
  format tx txfmt.;
run;
ODS HTML CLOSE;

FILENAME myemail EMAIL
                 to='emailaddress@company.com'
                 from='emailaddress@company.com'
                 cc='emailaddress@company.com'
                 subject='Attached Case Report'
                 attach='c:\temp\ClinResults.html';
data _null_;
  file myemail;
  put 'Remember to review your cases by Friday.';
  put 'Outliers are shown in the attached report.';
  put 'This is a test with an attachment';
  put 'that was created by ODS HTML.';
run;


/* Figure 3.58, 3.59 */
title;
footnote;
ODS HTML BODY='avgbp_html4_3_58a.xls' STYLE=sasweb;
ODS MSOFFICE2K BODY='avgbp_msoffice_3_58b.xls' STYLE=sasweb;
ODS TAGSETS.EXCELXP BODY='avgbp_tagsetsxp_3_59.xls' STYLE=sasweb;
title 'Average BP Statistics';
proc report data=clinical nowd split=' ' style(header)={vjust=b};
  column tx ('Average' ChgDBP ChgSBP);
  define tx / group "Group" format=txfmt.;
  define ChgDBP / analysis mean format=10.1;
  define ChgSBP / analysis mean format=10.1;
 run;
ODS _ALL_ CLOSE;


/******************************************************************************/
/* End Chapter 3                                                              */
/******************************************************************************/
/******************************************************************************/


/******************************************************************************/
/******************************************************************************/
/* Chapter 4 - RTF Output                                                     */
/******************************************************************************/


/* Figure 4.1 */
footnote;
ODS RTF FILE='Payroll_4_01a.rtf';
title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;
ODS RTF FILE='Payroll_4_01b.rtf' STYLE=JOURNAL;
title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;

/* Figure 4.7 */
footnote;
ODS RTF FILE='Payroll_4_07.rtf' BODYTITLE;
title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Figure 4.8 */
footnote;
ODS RTF FILE='SalaryWide_4_08.rtf';
title 'Salary Report';
proc freq data=hr;
  tables Department*AnnualSalary / norow nocol nopct;
  format AnnualSalary salft.;
run;
ODS RTF CLOSE;

/* Figure 4.9 */
footnote;
ODS RTF FILE='SalaryTall_4_09.rtf';
title 'Salary Report';
proc freq data=hr;
  tables AnnualSalary / nopct nocum;
run;
ODS RTF CLOSE;


/* Figure 4.10 */
title;
footnote;
ODS RTF FILE='CLIPSStats_4_10.rtf';
proc means data=clips n mean std min p25 median p75 max nway maxdec=1;
  class tone;
  var mentions compete;
run;
ODS RTF CLOSE;


/* Figure 4.11 */
title;
footnote;
options orientation=landscape;
ODS RTF FILE='CLIPSStats_4_11.rtf';
proc means data=clips n mean std min p25 median p75 max nway maxdec=1;
  class tone;
  var mentions compete;
run;
ODS RTF CLOSE;
options orientation=portrait;


/* Figure 4.12 */
title;
footnote;
OPTIONS ORIENTATION=LANDSCAPE;
ODS RTF FILE='BothOrientations_4_12.rtf';
proc print data=clips(obs=5);
run;
OPTIONS ORIENTATION=PORTRAIT;
ODS RTF;
proc means data=clips n mean std min max maxdec=1;
run;
ODS RTF CLOSE;



/* Figure 4.13 */
title;
footnote;
OPTIONS ORIENTATION=LANDSCAPE PAPERSIZE=LETTER;
ODS RTF FILE='VeryWide_4_13.rtf';
proc means data=clips maxdec=1
                      mean std min p1 p5 p10 p25 p50
                      p75 p90 p95 p99 max stderr probt
                      clm lclm cv css uss;
  class tone;
  var mentions compete;
run;
ODS RTF CLOSE;
options orientation=portrait;

/* Figure 4.14 */
title;
footnote;
OPTIONS ORIENTATION=LANDSCAPE PAPERSIZE=LEGAL;
ODS RTF FILE='VeryWide_4_14.rtf';
proc means data=clips maxdec=1
                      mean std min p1 p5 p10 p25 p50
                      p75 p90 p95 p99 max stderr probt
                      clm lclm cv css uss;
   class tone;
   var mentions compete;
run;
ODS RTF CLOSE;
options orientation=portrait papersize=letter;


/* Figure 4.15 */
title;
footnote;
ODS RTF FILE='Multipage_4_15.rtf';
proc means data=clips maxdec=0 nonobs mean std;
   class media;
   var words;
run;
proc sort data=clips;
  by tone;
run;
proc tabulate data=clips f=8.;
   class media tone;
   var words;
   by tone;
   table min p1 p5 p10 p25 p50 p75 p90 p95 p99 max,
      words*media;
run;
ODS RTF CLOSE;


/* Figure 4.16 */
title;
footnote;
ODS RTF FILE='Multipage_4_16.rtf' STARTPAGE=NO;
proc means data=clips maxdec=0 nonobs mean std;
   class media;
   var words;
run;
proc sort data=clips;
  by tone;
run;
proc tabulate data=clips f=8.;
   class media tone;
   var words;
   by tone;
   table min p1 p5 p10 p25 p50 p75 p90 p95 p99 max,
      words*media;
run;
ODS RTF CLOSE;





/* Figure 4.20 */
title;
footnote;
ODS RTF FILE='TwoColumn_4_20.rtf';
proc report data=clips nowd;
   column media mentions compete;
   define media / group;
   define mentions / display;
   define compete / display;
run;
ODS RTF CLOSE;

/* Figure 4.21 */
title;
footnote;
ODS RTF FILE='TwoColumn_4_21.rtf' COLUMNS=2;
proc report data=clips nowd;
   column media mentions compete;
   define media / group;
   define mentions / display;
   define compete / display;
run;
ODS RTF CLOSE;


/* Figure 4.22 */
title;
footnote;
ODS RTF FILE='TwoColumnClinical_4_22.rtf' COLUMNS=2;
proc print data=clinical;
run;
ODS RTF CLOSE;


/* Figure 4.23 and 4.24 */
title;
footnote;
options number;
ODS RTF FILE='ListClips_4_23.rtf';
title "Data Set CLIPS";
proc print data=clips;
run;
ODS RTF CLOSE;
options nonumber;

/* Figure 4.25 and 4.26 */
title;
footnote;
OPTIONS NONUMBER;
ODS ESCAPECHAR='^';
title justify=center 'Data Set CLIPS' justify=right 'Page ^{pageof}';
ODS RTF FILE='ListClips_4_25.rtf';
proc print data=clips;
run;
ODS RTF CLOSE;


/* Associated with 4.25 and 4.26, not in an output */
title;
footnote;
OPTIONS NONUMBER;
ODS ESCAPECHAR='^';
title justify=center 'Data Set CLIPS'
      justify=right 'Page ^{thispage}/^{lastpage}';
ODS RTF FILE='ListClips_4_XX.rtf';
proc print data=clips;
run;
ODS RTF CLOSE;


/* Figure 4.27 and 4.28 */
title;
footnote;
options date nonumber;
ODS RTF FILE='ListClips_4_27.rtf';
title "Data Set CLIPS";
proc print data=clips;
run;
ODS RTF CLOSE;
options nodate;

/* Figure 4.29 and 4.30 */
title;
footnote;
options nonumber;
OPTIONS NODATE;
%let sdate=%sysfunc(putn("&sysdate"d,worddate.));
title justify=right '{Current date: \field {\*\fldinst { DATE \\@ "MMMM d, yyyy" \*\MERGEFORMAT}}}';
title2 justify=right "Report generated on: &sdate";
ODS RTF FILE='BothDates_4_29.rtf';
proc print data=clips;
run;
ODS RTF CLOSE;

/* Figure 4.31 */
title;
footnote;

ODS RTF FILE='DefaultPlacement_4_31.rtf';
title "Default Title Placement without BODYTITLE";
footnote "Default Footnote Placement without BODYTITLE";
proc tabulate data=clips format=8.;
  class media;
  var words;
  table min p50 max,words*media;
run;
ODS RTF CLOSE;

/* Figure 4.32 */
title;
footnote;

ODS RTF FILE='Bodytitle_4_32.rtf' BODYTITLE;
title "Title Placement with BODYTITLE Option";
footnote "Footnote Placement with BODYTITLE Option";
proc tabulate data=clips format=8.;
  class media;
  var words;
  table min p50 max,words*media;
run;
ods rtf close;


/* Figure 4.33 */
title;
footnote;

ODS RTF FILE='Bodytitle_Aux.rtf' BODYTITLE_AUX;
title "Title Placement with BODYTITLE_AUX Option";
footnote "Footnote Placement with BODYTITLE_AUX Option";
proc tabulate data=clips format=8.;
  class media;
  var words;
  table min p50 max,words*media;
run;
ods rtf close;


/* Figure 4.34 */
title;
footnote;

ODS NOPROCTITLE;
ODS RTF FILE='ToneFreqs_4_34.rtf';
ODS ESCAPECHAR='^';
title '^S={preimage="logo.jpg"}';
proc freq data=clips;
  tables tone;
run;
ODS RTF CLOSE;
ods proctitle;


/* Figure 4.35  */
title;
footnote;

ods noproctitle;
options center;
ODS RTF FILE='ToneFreqs_4_35.rtf' bodytitle  ;
ODS ESCAPECHAR='^';
title '^S={preimage="logo.jpg"}';
proc freq data=clips;
  tables tone;
run;
ODS RTF CLOSE;
ods proctitle;

/* Figure 4.36 */
title;
footnote;

options center;
ODS RTF FILE='ToneFreqs_4_36.rtf' bodytitle;
ODS ESCAPECHAR='^';
title '^S={just=l preimage="logo.jpg"}';
proc freq data=clips;
  tables tone media mentions compete;
run;
ODS RTF CLOSE;


/* Figure 4.37 */
title;
footnote;
ODS ESCAPECHAR='^';
ODS SELECT PearsonCorr;
ODS RTF FILE='AddText_4_37.rtf' BODYTITLE STARTPAGE=OFF;
proc corr data=clips nosimple;
   var mentions;
   with compete;
run;
ODS RTF TEXT='^S={LEFTMARGIN=1in RIGHTMARGIN=1in}
This text was inserted with the TEXT= option. It can be used to add a detailed explanatory caption below a table or figure. This example uses an inline formatting escape sequence to apply different styles here. This text can also be formatted by using PROC TEMPLATE and the USERTEXT style element';
ODS RTF CLOSE;


/* Figure 4.38 */
ods listing close;
title;
footnote;
ODS ESCAPECHAR='^';
ODS SELECT PearsonCorr;
ODS RTF FILE='c:\temp\ReportWithText_4_38.rtf' STARTPAGE=OFF;
ODS RTF TEXT='^{style[font_style=italic fontweight=bold fontsize=14pt] This bold, italicized text in 14pt introduces the table. Use ^n^n to insert blank lines to start a new paragraph}';
proc corr data=clips nosimple;
   var mentions;
   with compete;
run;
ODS RTF TEXT='^{newline 4}';
ODS RTF TEXT='^{style[font=(Arial)] Four lines appear before this sentence (in Arial) and a bar chart follows:}';
proc gchart data=clips;
  vbar mentions / midpoints=1 to 12 by 1 inside=freq;
run;
quit;
ODS RTF TEXT='^{style[fontweight=bold textdecoration=underline]This bold, underlined sentence concludes the report.}';
ODS RTF CLOSE;
ods listing;


/* Figure 4.39, 4.40 */
title;
footnote;
ODS ESCAPECHAR='^';
ODS RTF FILE='Hyperlink_4_39.rtf';
proc freq data=clips;
  table compete;
run;
ODS RTF TEXT='^S={URL="http://www.myweb.com"}Source: www.myweb.com';
ODS RTF CLOSE;

/* Figure 4.41 */
title;
footnote;
ODS ESCAPECHAR='^';
ODS RTF FILE='Hyperlink_4_41.rtf';
proc freq data=clips;
  table compete;
run;
ODS RTF TEXT='^S={URL="http://www.myweb.com"}Source: ^S={FOREGROUND=blue}www.myweb.com';
ODS RTF CLOSE;


/* Figure 4.42, 4.43, 4,44 */
title;
footnote;
ODS RTF FILE='PayrollTOC_4_42.rtf' CONTENTS=yes TOC_DATA;
ODS PROCLABEL 'Human Resources Report on Salary and Hours';
title;
proc tabulate data=hr;
  class department category;
  var annualsalary hoursweek;
  tables department='Annual Salary Statistics for ' all='Annual Salary Statistics in All Departments and Categories',
         (category all='All Categories in Department'),
         annualsalary*( (n mean min median max)*f=dollar8.);
  tables department='Hours per Week Statistics for ' all='Hours per Week Statistics for All Departments and Categories',
         (category all='All Categories in Department'),
         hoursweek*( (n mean min median max)*f=3.);
run;
ODS RTF CLOSE;


/* Figure 4.45 */
title;
footnote;
ODS RTF FILE='Payroll_Meta_4_45.rtf'
              AUTHOR="HR Report Designer"
              TITLE="HR Standard Payroll Report"
              OPERATOR="HR Assistant";
title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;

/* Figure 4.46 */
title;
footnote;
ODS RTF FILE='NoDecimalAlign_4_46.rtf';

proc report data=chemtest nowd;
  title 'Decimals Not Aligned';
  column sample chemppb;
  define sample / display;
  define chemppb / display;
run;

ODS RTF CLOSE;

/* Figure 4.47, 4.48 */
title;
footnote;
ODS RTF FILE='DecimalAlign_4_47.rtf';
ODS HTML FILE='DecimalAlign_4_47.html' STYLE=SASWEB;

proc report data=chemtest nowd;
  title 'Decimals Aligned';
  column sample chemppb;
  define sample / display style(COLUMN)={just=d};
  define chemppb / display style(COLUMN)={just=d};
run;
ODS _ALL_ CLOSE;

/* Figure 4.49, 4.50 */
title;
footnote;
%let d = %str({\doccomm This report produced without errors});
%let k = %str({\keywords HR, Payroll, Department, Annual Salary});
%let s = %str({\subject Salary Statistics});
%let m = %str({\*\manager HR Manager});
%let c = %str({\*\category Internal});
%let n = %str({\*\company Global Company, Inc.});

ODS RTF FILE='Payroll_Meta2_4_49.rtf'
          AUTHOR="HR Report Designer &d &k &s"
          TITLE="HR Standard Payroll Report &m &c &n"
          OPERATOR="HR Assistant";

title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;



/* Figure 4.51 */
title;
footnote;
ODS RTF file='Footnotes3_4_51.rtf';
ODS ESCAPECHAR='^';
footnote "\ql The file is: {\field{\*\fldinst { FileName }}}";
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;

/* Figure 4.52 */
title;
footnote;
proc template
  define style styles.usefc;
  parent=styles.rtf;
    class systemfooter/
       protectspecialchars=off;
  end;
run;

ODS RTF file='Footnotes3_4_52.rtf' style=styles.usefc;
ODS ESCAPECHAR='^';
footnote "\ql The file is: {\field{\*\fldinst { FileName }}}";
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
footnote "\q1 The file is: {\field{\*\fldinst { FileName \\p}}}";
proc means data=hr nonobs maxdec=0 mean sum;
   class category;
   var AnnualSalary;
run;
ODS RTF CLOSE;

/* Figure 4.53 */
title;
footnote;
ODS RTF file='Footnotes3_4_53.rtf';
ODS ESCAPECHAR='^';
footnote "^S={protectspecialchars=off}\ql The file is: {\field{\*\fldinst { FileName \\p}}}";
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Figure 4.54, 4.55   */
title;
footnote;
ODS ESCAPECHAR='^';
ODS RTF file='MoreControlWords_4_54.rtf';
/* SAS 9.2 */
title "^{raw \b\i0 Bold \b0 \i Italicize}";
title2 "^{raw \bullet Bullet}";
title3 "^{raw \striked1 Double Strike \striked0 Regular Words}";
title4 "^{raw \uldb Double Underline \uldb0}";
title5 "^{raw \impr Engrave}";
title6 "^{raw Subscript \sub 1}";
title7 "^{raw Superscript \super 2}";
title8 "^{raw \outl Outline}";
title9 "^{raw \shad Shadow}";
title10 "^{raw \cf1 Foreground1 \cf2 Foreground2 \cf3 Foreground3}";

footnote "^{raw \ulwave Wave underline"};
footnote2 "^{raw \ulth Thick Underline"};
footnote3 "^{raw \fs48 Font Size in half points size 48 will be 24pt in the document"};

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;

title;
footnote;
ODS ESCAPECHAR='^';
ODS RTF file='MoreControlWords_4_54_913.rtf';
/* SAS 9.2 or 9.1.3 */
title "^R'\b\i0 Bold \b0 \i Italicize'";
title2 "^R'\Bullet Bullet'";
title3 "^R'\striked1 Double Strike \striked0 Regular Words'";
title4 "^R'\uldb Double Underline \uldb0'";
title5 "^R'\impr Engrave'";
title6 "^R'Subscript \sub 1'";
title7 "^R'Superscript \super 2'";
title8 "^R'\outl Outline'";
title9 "^R'\shad Shadow'";
title10 "^R'\cf1 Foreground1 \cf2 Foreground2 \cf3 Foreground3'";

footnote "^R'\ulwave Wave underline'";
footnote2 "^R'\ulth Thick Underline'";
footnote3 "^R'\fs48 Font Size in half points size 48 will be 24pt in the document'";

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Figure 4.56 */
title;
footnote;
ODS ESCAPECHAR='^';
ODS RTF FILE='Animated_4_56_92.rtf';
proc report data=sashelp.class nowd;
  title '^{raw \animtext1 Las Vegas Lights}';
  title2 '^{raw \animtext2 Blinking Text}';
  title3 '^{raw \animtext3 Confetti or Sparkle}';
  title4 '^{raw \animtext4 Marching Black Dashes}';
  title5 '^{raw \animtext5 Marching Red Dashes}';
  title6 '^{raw \animtext6 Shimmering Text}';
run;
ODS RTF CLOSE;





/* Figure 4.57, 4.58 */
title;
footnote;
ODS ESCAPECHAR='^';
title j=r 'Page ^{pageof}';
ODS RTF FILE='PageNumRTF_4_57.rtf';
ODS HTML FILE='PageNumHTML_4_58.html';
ODS LISTING;
proc print data=clips;
run;
ODS _ALL_ CLOSE;

/* Figure 4.59, 4.60 */
title;
footnote;
ODS ESCAPECHAR='^';
title j=r ' ^{dest[rtf] Page ^{pageof}}';
ODS RTF FILE='PageNumRTF_4_59.rtf';
ODS HTML FILE='PageNumHTML_4_60.html';
ODS LISTING;
proc print data=clips;
run;
ODS _ALL_ CLOSE;


/* Figure 4.61, 4.62 */
title;
footnote;
ODS RTF file='PPTable_4_61.rtf';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Figure 4.63 */
title;
footnote;
ODS RTF FILE='Payroll_Title_4_63.rtf';
ODS ESCAPECHAR='^';
title "Payroll Report";
title2 "^{raw \highlight1 1= black \highlight2 2= blue "
       "\highlight3 3= cyan \highlight4 4= green "
       "\highlight5 5= magenta \highlight6 6= red "
       "\highlight7 7= yellow \highlight8 8= unused "
       "\highlight9 9= dark blue \highlight10 10= dark cyan }";
title4 "^{raw \highlight11 11= dark green \highlight12 12= dark magenta "
       "\highlight13 13= dark red \highlight14 14= dark yellow "
       "\highlight15 15= dark gray \highlight16 16= light gray }";
title6 "^{raw \embo Embossed }";
title7 "^{raw \strike Words Stricken Out \strike0} Regular Words}";
title8 "^{raw \ul Underline \ul0}";
title9 "^{raw \uld Dotted underline \uld0}";
title10 "^{raw Title10 \line New Line 11 \line New Line 12}";

footnote j=l "Footnote 1";
footnote2 "^{raw This is \ul footnote2 \ul0 with underlining.}";
footnote3 "^{raw \b0\i0 centered, NOT bold, NOT italic }";
footnote4 j=r "right justify";

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Figure 4.64, 4.65, 4.66 */
title;
footnote;

ODS RTF FILE='HRlist_4_64.rtf';
ODS TAGSETS.RTF FILE='HRlist_tagsets.rtf';

title 'Human Resources List';
proc print data=hr(obs=75);
run;

ODS _ALL_ CLOSE;



/* Figure 4.67, 4.68 */
title;
footnote;

ODS RTF FILE='prepage_4_67.rtf'
        PREPAGE ='Caption Above Table';
ODS TAGSETS.RTF FILE='prepage_tagsets_4_68.rtf'
                PREPAGE='Caption Above Table';
title 'Human Resources Reports';

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;

proc print data=hr(obs=25);
run;
ODS _ALL_ CLOSE;


/* Figure 4.69 */
title;
footnote;

ODS TAGSETS.RTF FILE='prepage_tagsets2_4_69.rtf'
                PREPAGE='Caption Above Means';
title 'Human Resources Reports';

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;

ODS TAGSETS.RTF PREPAGE='PREPAGE Above Print';
proc print data=hr(obs=25);
run;
ODS _ALL_ CLOSE;


/* Figure 4.70 */
title;
footnote;

ODS TAGSETS.RTF FILE='prepage_suboption_4_70.rtf'
        OPTIONS(doc='Help');

ODS _ALL_ CLOSE;


/* Figure 4.71 */
title;
footnote;

ODS TAGSETS.RTF FILE='TOC_SUBOPTIONS_4_71.rtf'
                OPTIONS(CONTENTS='yes' TOC_DATA='yes');
title 'Human Resources Reports';

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;

proc print data=hr(obs=25);
run;
ODS _ALL_ CLOSE;




/* Figure 4.72 */
title;
footnote;

ODS TAGSETS.RTF FILE='TOC_CONTROL_4_72.rtf' ;

proc freq data=hr;
   title 'Show Default Order of Columns';
   tables Department / nocum;
run;

ODS _ALL_ CLOSE;

/* Figure 4.73 */
title;
footnote;

ODS TAGSETS.RTF FILE='TOC_CONTROL2_4_73.rtf' OPTIONS(TROWD="\rtlrow");
proc freq data=hr;
   title 'Show Impact of RTLROW Control String';
   tables Department / nocum;
run;

ODS _ALL_ CLOSE;

/* Figure 4.74 */
title;
footnote;

ODS TAGSETS.RTF FILE='TOC_CONTROL3_4_74.rtf'
    OPTIONS(TROWHDRCELL="\clbghoriz\clcfpat3");
proc freq data=hr;
   title 'Show Impact of CLBGHORIZ and CLCFPAT3 Control Strings';
   tables Department / nocum;
run;

ODS _ALL_ CLOSE;


/* Figure 4.75 */
title;
footnote;

ODS TAGSETS.RTF FILE='HEADERS_UP_4_75.rtf' STYLE=journal
    OPTIONS (TRHDR="\trrh1225" TROWHDRCELL="\cltxbtlr");
proc print data=hr(obs=25);
  title 'Using TRRH1225 and CLTXBTLR Control Strings';
run;
ODS _ALL_ CLOSE;

/* Figure 4.76 */
title;
footnote;

ODS TAGSETS.RTF FILE='HEADERS_DOWN_4_76.rtf' STYLE=journal
    OPTIONS (TRHDR="\trrh1225" TROWHDRCELL="\cltxtbrl");
proc print data=hr(obs=25);
  title 'Using TRRH1225 and CLTXTBRL Control Strings';
run;
ODS _ALL_ CLOSE;


/* Figure 4.77 */
title;
footnote;

ODS TAGSETS.RTF FILE='HEADERS_CTR_4_77.rtf' STYLE=journal
    OPTIONS (TRHDR="\trrh1225" TROWHDRCELL="\clvertalc");
proc print data=hr(obs=25);
  title 'Using TRRH1225 and CLVERTALC Control Strings';
run;
ODS _ALL_ CLOSE;


/* Figure 4.78 */
title;
footnote;

ODS ESCAPECHAR='^';
ODS TAGSETS.RTF FILE='Hyperlink_4_78.rtf';
proc freq data=clips;
  table compete;
run;
ODS TAGSETS.RTF TEXT='^{style[URL="http://www.myweb.com"]Source: www.myweb.com'};
ODS _ALL_ CLOSE;


/* Figure 4.79 */
title;
footnote;

ODS ESCAPECHAR='^';
ODS TAGSETS.RTF FILE='Hyperlink_4_79.rtf';
proc freq data=clips;
  table compete;
run;
ODS TAGSETS.RTF TEXT='Source: ^{style[URL="http://www.myweb.com" FOREGROUND=blue]www.myweb.com}';
ODS _ALL_ CLOSE;


/******************************************************************************/
/* End Chapter 4                                                              */
/******************************************************************************/

/******************************************************************************/
/* Start Chapter 5 - PDF Output                                               */
/******************************************************************************/


/* Figure 5.1 */
title;
footnote;
ODS PDF FILE='ComplaintReport_5_1.pdf';
title "Summary Report: Retail Outlet Complaints";
proc report data=Complaints nowd;
   column Product Complaint Location NumComplaints;
   define Product / group order=formatted;
   define Complaint / group order=formatted;
   define Location / group order=formatted;
   define NumComplaints / analysis sum;
   break after Product / page summarize ;
run;
ODS PDF CLOSE;

/* Figure 5.2 */
title;
footnote;
ODS PDF FILE='ComplaintAnalysis_5_2.pdf';
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

/* Figure 5.3 */
title;
footnote;
ODS PROCLABEL 'Analysis of Consumer Complaints';
ODS PDF FILE='ComplaintAnalysis_5_3.pdf';
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;


/* Figure 5.4 */
title;
footnote;
ODS PDF FILE='ComplaintAnalysis_5_4.pdf' CONTENTS=YES;
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

/* Figure 5.5 */
title;
footnote;
ODS PDF FILE='ComplaintAnalysis_5_5.pdf' BOOKMARKGEN=NO;
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

/* Figure 5.6 */
title;
footnote;
ODS PDF FILE='ComplaintAnalysis_5_6.pdf' BOOKMARKLIST=HIDE;
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

/* Figure 5.7 */
title;
footnote;
ODS PDF FILE='ComplaintAnalysis_5_7.pdf' PFTDOC=1;
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

/* This shows results of combinations of BOOKMARKGEN= and BOOKMARKLIST= */
/* Output from this code is not in the book                             */
title;
footnote;
ODS PDF(1) FILE='ComplaintAnalysis_GY_LS.pdf' BOOKMARKGEN=YES BOOKMARKLIST=SHOW;
ODS PDF(2) FILE='ComplaintAnalysis_GY_LH.pdf' BOOKMARKGEN=YES BOOKMARKLIST=HIDE;
title 'Analysis of Consumer Complaints';
proc glm data=Complaints;
   class product location;
   model NumComplaints=Product Location;
run;
ODS _ALL_ CLOSE;


/* Figure 5.8 and 5.9 */
title;
footnote;
ODS PDF FILE='AnnotatedReport_5_8.pdf';
proc report data=gallery nowd;
   column artist medium price;
   define artist / group STYLE(Header)=
                   {URL="http://www.artistlookupwebsite.com/"};
   define medium / group STYLE(Header)=
                   {URL="http://www.artistmediumwebsite.com"};
   define price / analysis mean STYLE(Header)=
                  {FLYOVER="Prices listed in US$"};
run;
ODS PDF CLOSE;


/* Figure 5.10 */
title;
footnote;
ODS ESCAPECHAR='^';
ODS PDF FILE='HyperlinkedReport_5_10.pdf';
footnote '^{style[URL="http://threeartgalleries.info"]Click for more gallery info}';
proc tabulate data=gallery;
  class gallery;
  var price;
  tables gallery,price*(n*f=5. (mean min max)*f=dollar8.);
run;
ODS PDF CLOSE;

/* Figure 5.11 */
title;
footnote;
ODS ESCAPECHAR='^';
ODS PDF FILE='HyperlinkedReport_5_11.pdf';
proc tabulate data=gallery;
  class gallery;
  var price;
  tables gallery,price*(n*f=5. (mean min max)*f=dollar8.);
run;
ODS PDF TEXT= '^{style[just=c URL="http://threeartgalleries.info"]Click for more gallery info}';
ODS PDF CLOSE;


/* Figure 5.12 */
title;
footnote;
proc format;
  value $galft 'East Side'='^{style[FLYOVER="130 East 23rd"]East side}'
                'Downtown'='^{style[FLYOVER="10 Elm Street"]Downtown}'
                'Mall'='^{style[FLYOVER="Southside Mall Blvd"]Mall}';
run;
ODS ESCAPECHAR='^';
ODS PDF FILE='HyperlinkedReport_5_12.pdf';
proc tabulate data=gallery;
  class gallery;
  var price;
  tables gallery,price*(n*f=5. (mean min max)*f=dollar8.);
  format gallery $galft.;
run;
ODS PDF CLOSE;

/* Figure 5.13 */
%macro testcp(cnum=0);
  ODS PDF FILE="cmprs&cnum..pdf" COMPRESS=&cnum;
  proc print data=sashelp.shoes;
  run;
  ODS PDF CLOSE;
%mend testcp;

%testcp()
%testcp(cnum=1)
%testcp(cnum=2)
%testcp(cnum=3)
%testcp(cnum=4)
%testcp(cnum=5)
%testcp(cnum=6)
%testcp(cnum=7)
%testcp(cnum=8)
%testcp(cnum=9)

filename dirinfo pipe 'dir cmprs*.pdf ';

data _null_;
  length infoline $200;
  infile dirinfo truncover length=lg;
  input infoline $varying. lg;
  putlog _infile_;
run;


/* Figure 5.14 */
title;
footnote;

ODS PDF FILE="metadata_5_14.pdf" AUTHOR="Author Name"
      SUBJECT="Subject" TITLE="Document Title"
      KEYWORDS="ODS, PDF, Metadata Information";
proc print data=gallery(obs=5);
run;
ODS PDF CLOSE;


/* Figure 5.15 */
title;
footnote;

ODS PDF FILE="Reports_5_15.pdf";
title "Sales Report";
proc means data=gallery sum;
   class gallery;
   var sales;
run;
title "Revenue Report";
proc means data=gallery sum;
   class gallery;
   var revenue;
run;
ODS PDF CLOSE;


/* Figure 5.16 and 5.17 */
title;
footnote;

ODS ESCAPECHAR="^";
ODS PDF FILE="Reports_5_16.pdf" NOTOC;
title "Reports";
ODS PDF TEXT="^S={JUST=C URL='#sales'}Sales";
ODS PDF TEXT="^S={JUST=C URL='#revenue'}Revenue";
ODS PDF STARTPAGE=NOW;
title "Sales Report";
ODS PDF ANCHOR="sales";
proc means data=gallery sum;
   class gallery;
   var sales;
run;
title "Revenue Report";
ODS PDF ANCHOR="revenue";
proc means data=gallery sum;
   class gallery;
   var revenue;
run;
ODS PDF CLOSE;


/* Figure 5.18 */
title;
footnote;

ODS ESCAPECHAR='^';
ODS PDF FILE="Footnotes_5_18.pdf";
footnote justify=left 'Page ^{thispage} of ^{lastpage}';
footnote2 'Page -^{thispage}-' ;
footnote3 'Total Pages: ^{lastpage}';
footnote5 justify=left 'Seite ^{thispage} von ^{lastpage}';
footnote7 justify=left 'Página ^{thispage} de ^{lastpage}';
footnote8 '^{pageof}';
proc print data=gallery(obs=20);
run;
ODS PDF CLOSE;


/* Figure 5.19 */
title;
footnote;

ODS PDF FILE='startpage_5_19.pdf' STARTPAGE=NO;
proc means data=gallery maxdec=0;
   var sales revenue;
run;
proc univariate data=gallery normal;
   var sales revenue;
run;
ODS PDF CLOSE;


/* Figure 5.20 */
title;
footnote;

ODS PDF FILE='startpage2_5_20.pdf' STARTPAGE=NO;
proc means data=gallery maxdec=0;
   var sales revenue;
run;
proc univariate data=gallery normal;
   var sales;
run;
ODS PDF STARTPAGE=NOW;
proc univariate data=gallery normal;
   var revenue;
run;
ODS PDF CLOSE;


/* Figure 5.21 */
title;
footnote;

ODS LISTING FILE='ComplaintFreqs_5_21.txt';
title 'Monthly Complaint Summary';
proc freq data=complaints;
   tables location*complaint / norow nocol nopct;
run;
ODS LISTING CLOSE;
ODS LISTING;


/* Figure 5.22 */
title;
footnote;
ODS PRINTER;

/*ODS PDF FILE='ComplaintFreqs_5_22.pdf';*/
title 'Monthly Complaint Summary';
proc freq data=complaints;
   tables location*complaint / norow nocol nopct;
run;
/*ODS PDF CLOSE;*/
ODS PRINTER CLOSE;


/* Figure 5.23 */
title 'Complaint Resolution Summary';
ODS PRINTER PRINTER="FancyColorPrinter;"
proc freq data=Complaints;
   tables Outcome / nocum;
run;
ODS PRINTER CLOSE;

title 'Complaint Resolution Detail';
ODS PRINTER PRINTER="LinePrinter";
proc print data=Complaints noobs label;
   var complaint outcome;
run;
ODS PRINTER CLOSE;


/* Figure 5.24 */
title;
footnote;
ODS PRINTER PS FILE='DamagedCD_5_24.ps';
ODS PDF FILE='DamagedCD_5_24.pdf';
title 'Damaged CDs Report';
proc print data=complaints label noobs;
  where product='CDs';
   id location;
   var outcome;
run;
ODS PDF CLOSE;
ODS PRINTER CLOSE;

/* Figure 5.25, 5.26, 5.27 */
title;
footnote;
**ODS PRINTER HOST;
**ODS PRINTER SAS;
**ODS PRINTER PS;
ODS NOPROCTITLE;
ODS PDF FILE='DeliveryFailures_5_25.pdf';
title 'Delivery Failures';
proc freq data=complaints;
  where complaint='Not Delivered';
  tables location;
run;
ODS PDF CLOSE;
ODS PRINTER CLOSE;
ODS PROCTITLE;


/* Figure 5.28, 5.29 */
title;
footnote;
ODS NOPROCTITLE;
**ODS PRINTER COLOR=YES STYLE=DEFAULT;
ODS PDF FILE='DeliveryFailures_5_28.pdf'
        COLOR=YES STYLE=DEFAULT;
title 'Delivery Failures';
proc freq data=complaints;
  where complaint='Not Delivered';
  tables location;
run;
ODS PDF CLOSE;
ODS PRINTER CLOSE;

/* Figure 5.30 */
title;
footnote;
ODS NOPROCTITLE;
**ODS PRINTER NOCOLOR STYLE=DEFAULT;
ODS PDF FILE='DeliveryFailures_5_30.pdf'
        COLOR=NO STYLE=DEFAULT;
title 'Delivery Failures';
proc freq data=complaints;
  where complaint='Not Delivered';
  tables location;
run;
ODS PDF CLOSE;
ODS PRINTER CLOSE;


/* Figure 5.31 */
title;
footnote;

ODS PDF FILE='No_Uniform_5_31.pdf';
*ODS PRINTER;
proc print data=Uniforms noobs label;
   var UniformType Color Sales;
run;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;

/* Figure 5.32 */
title;
footnote;

ODS PDF FILE='Uniform_5_32.pdf' UNIFORM;
*ODS PRINTER UNIFORM;
proc print data=Uniforms noobs label;
   var UniformType Color Sales;
run;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;


/* Figure 5.33 */
title;
footnote;
ODS PDF FILE='Use_Columns_5_33.pdf' COLUMNS=3;
*ODS PRINTER COLUMNS=3;
proc print data=gallery label;
  var gallery artist price;
run;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;


/* Figure 5.34 */
title;
footnote;

OPTIONS ORIENTATION=LANDSCAPE;
ODS PDF FILE='Chg_Orientation_5_34.pdf';
*ODS PRINTER;
proc print data=gallery label;
  var gallery artist price;
run;
proc means data=gallery;
run;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;


/* Figure 5.35 */
title;
footnote;

OPTIONS LEFTMARGIN=.25in RIGHTMARGIN=.25in
        TOPMARGIN=.25in BOTTOMMARGIN=.25in;
OPTIONS NOCENTER;
ODS PDF FILE='GalleryList_5_35.pdf';
*ODS PRINTER;
proc print data=gallery label;
run;
OPTIONS CENTER;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;


/* Figure 5.36 */
title;
footnote;

OPTIONS ORIENTATION=LANDSCAPE PAPERSIZE=LEGAL;
ODS PDF FILE='Use_Papersize_5_36.pdf';
*ODS PRINTER;
proc means data=clips maxdec=1
   mean std min p1 p5 p10 p25 p50 p75 p90 p95 p99 max;
   class tone;
   var mentions compete;
run;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;
OPTIONS ORIENTATION=PORTRAIT PAPERSIZE=LETTER;


/* Figure 5.37, 5.38 */
title;
footnote;

ODS PDF FILE="GalleryCopy_5_37.pdf";
*ODS PRINTER;
proc means data=gallery maxdec=1 mean min max;
   class medium;
   var price;
run;
*ODS PRINTER CLOSE;
ODS PDF CLOSE;

ODS PRINTER PS FILE='psfiles\FileCopy.ps';
proc means data=gallery maxdec=1 mean min max;
   class medium;
   var price;
run;
ODS PRINTER CLOSE;

title;
footnote;
ODS PRINTER(1);
ODS PRINTER(2) PS FILE='psfiles\FileCopy.ps';
proc means data=gallery maxdec=1 mean min max;
   class medium;
   var price;
run;
ODS _ALL_ CLOSE;


/* Figure 5.39 */
proc options group=(odsprint pdf);
run;




/******************************************************************************/
/* End Chapter 5                                                              */
/******************************************************************************/

/******************************************************************************/
/* Start Chapter 6 - Exploring ODS Output                                     */
/******************************************************************************/

/* Figure 6.1, 6.2 */
title;
footnote;
ODS TRACE ON;
proc freq data=sales;
  tables Department / chisq;
run;
ODS TRACE OFF;


/* Figure 6.3 */
title;
footnote;
ODS LISTING;
ODS TRACE ON / LISTING;
proc reg data=sales;
   model itemprice=itemssold department;
quit;
ODS TRACE OFF;

/* Figure 6.4 and 6.5 */
title;
footnote;
ODS TRACE ON / LISTING;
proc glm data=sales;
   model itemprice=itemssold department;
quit;
ODS TRACE OFF;

/* Figure 6.6 */
title;
footnote;
ODS TRACE ON / LABEL;
proc glm data=sales;
   model itemprice=itemssold department;
run;
quit;
ODS TRACE OFF;


/* Figure 6.7, 6.8 */
title;
footnote;
ODS TRACE ON / LABEL;
proc univariate data=sales;
   var ItemPrice ;
run;
ODS TRACE OFF;

/* Figure 6.9 */
ODS TRACE ON;
proc chart data=sales;
vbar ProductName;
run;
proc gchart data=sales;
vbar ProductName;
quit;
ODS TRACE OFF;


/* Figure 6.10 */
title;
footnote;
ODS TRACE ON / LABEL;
proc contents data=sales;
run;
ODS TRACE OFF;


/* Figure 6.11 */
title;
footnote;
ODS TRACE ON / LABEL;
proc format library=library fmtlib;
run;
ODS TRACE OFF;

/* Figure 6.12 */
title;
footnote;
ODS TRACE ON / LABEL;
proc printto print=printf new;
run;
proc means data=sales;
   var ItemsSold;
run;
proc printto;
run;
ODS TRACE OFF;




/******************************************************************************/
/* End Chapter 6                                                              */
/******************************************************************************/


/******************************************************************************/
/* Start Chapter 7 - Output Data Sets                                         */
/******************************************************************************/

/* Figure 7.1, 7.2, 7.3 */
title;
footnote;

ODS RTF FILE='MPHStats_7_1.rtf';
ODS OUTPUT "Summary Statistics"=Stats;
proc means data=Traffic;
   var MPH;
run;
ODS OUTPUT CLOSE;
proc print data=stats;
run;
ODS RTF CLOSE;

/* Figure 7.4, 7.5, 7.6 */
title;
footnote;

ODS RTF FILE='TrafficCorr_7_4.rtf';
ODS OUTPUT "Pearson Correlations"=PearsonCorr;
proc corr data=Traffic nosimple;
   var TimeOfDay;
   with MPH;
run;
ODS OUTPUT CLOSE;
ODS RTF CLOSE;

/* Figure 7.7 */
title;
footnote;

ODS RTF FILE='TrafficCorr_7_5.rtf';
ODS OUTPUT "Variables Information"=VarInfo;
proc corr data=Traffic nosimple;
   var TimeOfDay;
   with MPH;
run;
ODS OUTPUT CLOSE;
ODS RTF CLOSE;

/* Figure 7.8, 7.9, 7.10 */
title;
footnote;

ODS OUTPUT "Cross-Tabular Freq Table"=FreqTable;
ODS OUTPUT "Chi-Square Tests"=FreqChiSq;
proc freq data=Traffic;
   tables highway*event / chisq norow nocol nopct;
run;
ODS OUTPUT CLOSE;

ODS OUTPUT "Cross-Tabular Freq Table"=FreqTable
           "Chi-Square Tests"=FreqChiSq;
proc freq data=Traffic;
   tables highway*event / chisq norow nocol nopct;
run;
ODS OUTPUT CLOSE;


/* Figure 7.11, 7.12 */
title;
footnote;

ODS OUTPUT "Moments"=UnivMPH;
proc univariate data=Traffic;
   class Highway;
   var MPH;
run;
ODS OUTPUT CLOSE;

/* Figure 7.13, 7.14 */
title;
footnote;

ODS OUTPUT "Odds Ratios"=FatalOdds;
proc logistic data=Traffic;
   model Fatal=MPH;
run;
proc logistic data=traffic;
  class Location;
  model Fatal=Location;
run;
proc logistic data=traffic;
  class Location Highway;
  model Fatal=Location Highway;
run;
ODS OUTPUT CLOSE;

/* Figure 7.15 */
title;
footnote;

/* SAS 9.0 */
*ODS OUTPUT "Odds Ratios"(MATCH_ALL=OddsDS PERSIST=PROC)=FatalOdds;

/* SAS 9.2, 9.1.3 Only */
ODS OUTPUT "Odds Ratios"(PERSIST=PROC)=AllOdds;
proc logistic data=Traffic;
   model Fatal=MPH;
run;
proc logistic data=traffic;
  class Location;
  model Fatal=Location;
run;
proc logistic data=traffic;
  class Location Highway;
  model Fatal=Location Highway;
run;
ODS OUTPUT CLOSE;



/* Figure 7.16, 7.17 */
title;
footnote;

ODS OUTPUT "Parameter Estimates"=Params;
proc logistic data=traffic NOPRINT;
   model fatal=mph timeofday;
quit;
ODS OUTPUT CLOSE;


/* Figure 7.18 */
title;
footnote;

ODS LISTING CLOSE;
ODS OUTPUT "Parameter Estimates"=Params;
proc logistic data=traffic;
   model fatal=mph timeofday;
quit;
ODS OUTPUT CLOSE;
ODS LISTING;


/* Figure 7.16 */
title;
footnote;

%macro testit;
  %do B=1 %to 5;
    ODS OUTPUT TTests=TTest&B;
    proc ttest data=product (where=(plant=&B));
      class product;
      var units;
    run;
    ODS OUTPUT CLOSE;
  %end;
%mend testit;
ODS LISTING CLOSE;
%testit;

ODS LISTING;

/* Figure 7.19, 7.20 */
title;
footnote;

%macro testit;
  %do B=1 %to 5;
    ODS OUTPUT TTests=TTest&B;
    proc ttest data=product (where=(plant=&B));
     class product;
     var units;
    run;
    ODS OUTPUT CLOSE;
  %end;
%mend testit;

options mlogic mprint;
ODS LISTING CLOSE;
ODS RESULTS=OFF;
%testit;
ODS RESULTS=ON;

ODS LISTING;
options nomlogic nomprint;


/* Figure 7.21, 7.22 */
title;
footnote;

ODS OUTPUT "T-Tests"=TTests;
proc ttest data=traffic;
   class fatal;
   var MPH;
ODS OUTPUT CLOSE;
proc print data=TTests;
run;

/* Corrected 7.21, 7.22 */
ODS OUTPUT "T-Tests"=TTests;
proc ttest data=traffic;
   class fatal;
   var MPH;
run;
ODS OUTPUT CLOSE;
proc print data=TTests;
run;


/* Figure 7.23, 7.24 */
title;
footnote;

ODS OUTPUT "Parameter Estimates"=Params;
proc rsreg data=traffic;
   model fatal=mph;
run;
ODS OUTPUT CLOSE;
data Params2;
   set Params (keep=Parameter Estimate Probt
                rename=(Probt=Pvalue));
run;


/* Figure 7.25 */
title;
footnote;

ODS OUTPUT "Parameter Estimates"=Params
   (KEEP=Parameter Estimate Probt RENAME=(Probt=Pvalue));
proc rsreg data=traffic;
   model fatal=mph;
run;
ODS OUTPUT CLOSE;


/* Figure 7.26 */
title;
footnote;

ODS TRACE ON;
proc print data=traffic(obs=10);
run;
proc report data=traffic(obs=10) nowd;
  column highway location event impact mph timeofday;
run;
ODS TRACE OFF;

/* Figure 7.27 */
title;
footnote;

ODS OUTPUT Print=PrintOut;
proc print data=traffic(obs=10);
run;
ODS OUTPUT CLOSE;

ODS OUTPUT Report=RepOut;
proc report data=traffic(obs=10) nowd;
  column highway location event impact mph timeofday;
run;
ODS OUTPUT CLOSE;

/******************************************************************************/
/* End Chapter 7                                                              */
/******************************************************************************/

/******************************************************************************/
/* Start Chapter 8 - Limiting ODS Output                                      */
/******************************************************************************/

/* Figure 8.1 */
title;
footnote;
ODS RTF FILE='Univariate_8_1.rtf';
proc univariate data=voters;
   var income;
run;
ODS RTF CLOSE;


/* Figure 8.2 */
title;
footnote;
ODS SELECT BasicMeasures;
ODS RTF FILE='UnivariateSelect_8_2.rtf';
proc univariate data=voters;
   var income;
run;
ODS RTF CLOSE;


/* Figure 8.3 */
title;
footnote;

ODS SELECT FitStatistics ParameterEstimates;
ODS HTML BODY='SelectLogistic_8_3.html' style=sasweb;
proc logistic data=voters;
  class gender party;
  model voted=gender party;
run;
ODS HTML CLOSE;

/* Figure 8.4 */
title;
footnote;

ODS TRACE ON;
proc contents data=voters;
run;
ODS TRACE OFF;

ODS SELECT Attributes;
ODS HTML BODY='SelectContents_8_4.html' style=sasweb;
proc contents data=voters;
run;
ODS HTML CLOSE;


/* Figure 8.5 */
title;
footnote;

ODS SELECT Moments BasicMeasures TestsForLocation Quantiles;
ODS PDF FILE='SelectUniv_8_5.pdf';
proc univariate data=voters;
   var income;
run;
ODS PDF CLOSE;

ODS EXCLUDE ExtremeObs;
ODS PDF FILE='SelectUniv2_8_5.pdf';
proc univariate data=voters;
   var income;
run;
ODS PDF CLOSE;


/* Before Figure 8.6 */
title;
footnote;

ODS SELECT ChiSq;
ODS RTF FILE='SelectFreq_8_6.rtf' STARTPAGE=NO;
proc freq data=voters;
   table voted*party / chisq;
run;
proc freq data=voters;
   table voted*gender / chisq;
run;
ODS RTF CLOSE;

/* Figure 8.6, 8.7 */
title;
footnote;

ODS SELECT ChiSq (PERSIST);
ODS RTF FILE='SelectFreq_8_7.rtf' STARTPAGE=NO;
proc freq data=voters;
   table voted*party / chisq;
run;
proc freq data=voters;
   table voted*gender / chisq;
run;
ODS RTF CLOSE;
ODS SELECT ALL;


/* Figure 8.8, 8.9 */
title;
footnote;

ODS HTML BODY='SelectCorr_8_8.html' STYLE=SASWEB;
ODS HTML SELECT PearsonCorr;
proc corr data=voters;
   var income;
   with age;
run;
ODS HTML CLOSE;


/* Figure 8.10 */
title;
footnote;

ODS TRACE ON / LABEL;
proc freq data=voters;
   tables gender voted party / chisq;
run;
proc univariate data=voters;
   var income age;
run;
ODS TRACE OFF;


/* Figure 8.11 */
title;
footnote;

ODS LISTING CLOSE;
ODS HTML BODY='SelectMany_8_11.html' STYLE=SASWEB;
ODS HTML SELECT Freq.Table1.OneWayFreqs
                Table2.OneWayFreqs
                "Table party"."One-Way Frequencies"
                "One-Way Chi-Square Test";
proc freq data=voters;
   tables gender voted party / chisq;
run;
ODS HTML SELECT ExtremeObs#1 Quantiles#2;
proc univariate data=voters;
   var income age;
run;
ODS HTML CLOSE;
ODS LISTING;


/* Figure 8.12, 8.13, 8.14 */
title;
footnote;

ODS EXCLUDE CHISQ(PERSIST);

ODS RTF FILE='selectshow_8_12.rtf';
ODS RTF EXCLUDE CrossTabFreqs(Persist);
proc freq data=voters;
   tables party*gender / chisq;
run;
proc freq data=voters;
   tables party*voted / chisq;
run;
ODS RTF CLOSE;

ODS SHOW;
ODS RTF SHOW;

ODS EXCLUDE NONE;


/* Figure 8.15, 8.16, 8.17 */
title;
footnote;

ODS TRACE ON / LABEL;

ODS RTF FILE='SelectIncome_8_16.rtf';
ODS HTML BODY='SelectAge_8_17.html' STYLE=SASWEB;
ODS RTF SELECT WHERE=(upcase(_path_) contains 'INCOME' or
                      upcase(_labelpath_) contains 'INCOME');
ODS HTML SELECT WHERE=(upcase(_path_) ? 'AGE' or
                       upcase(_labelpath_) ? 'AGE');
proc univariate data=voters;
   var income age;
run;
proc freq data=voters;
   tables age / chisq;
run;
ODS HTML CLOSE;
ODS RTF CLOSE;

ODS TRACE OFF;

/******************************************************************************/
/* End Chapter 8                                                              */
/******************************************************************************/


/******************************************************************************/
/* Start Chapter 9 - Using ODS in the DATA Step                               */
/******************************************************************************/

/* Figure 9.1, 9.2, 9.3, 9.4 */
title;
footnote;

ODS RTF FILE='BasicReport_9_1.rtf';
ODS PDF FILE='BasicReport_9_2.pdf';
ODS HTML FILE='BasicReport_9_3.html' STYLE=sasweb;
title 'Default PUT _ODS_ of All Variables';
data _null_;
  set traffic;
  file print ods;
  put _ods_;
RUN;
ODS _ALL_ CLOSE;


/* Figure 9.5, 9.6 */
title;
footnote;

ODS RTF FILE='LabelODS_9_5.rtf';
ODS PDF FILE='LabelODS_9_5.pdf';
ODS HTML FILE='LabelODS_9_5.html' STYLE=sasweb;
title 'Default PUT _ODS_ of All Variables';
data _null_;
  set traffic;
  FILE PRINT ODS=(OBJECT=objlink OBJECTLABEL='My Label');
  put _ods_;
RUN;
ODS _ALL_ CLOSE;


/* Figure 9.7 */
title;
footnote;

ODS RTF FILE='LabelODS_9_7.rtf';
ODS PDF FILE='LabelODS_9_7.pdf';
ODS HTML FILE='LabelODS_9_7.html' STYLE=sasweb;
title 'Default PUT _ODS_ of All Variables';
data _null_;
  set traffic;
  FILE PRINT ODS=(OBJECT=objlink OBJECTLABEL='Other Label');
  put _ods_;
RUN;
ODS _ALL_ CLOSE;


/* Figure 9.8 */
title;
footnote;

ODS HTML file='keepvar_9_8.html' STYLE=sasweb;
ODS PDF file='keepvar_9_8.pdf';
title 'Using the KEEP= Data Set Option';
data _null_;
  set traffic(keep=location event highway
                   timeofday impact);
  file print ods;
  put _ods_;
run;
ODS _ALL_ CLOSE;


/* Figure 9.9 */
title;
footnote;

ODS HTML file='varopt_9_9.html' STYLE=sasweb;
ODS PDF file='varopt_9_9.pdf';
title 'Using the VARIABLES= Suboption on the ODS= Option';
data _null_;
  set traffic;
  file print ods=(variables=(location event highway
                             timeofday impact));
  put _ods_;
run;
ODS _ALL_ CLOSE;


/* Figure 9.10 */
title;
footnote;

proc sort data=traffic;
  by impact;
run;

ODS HTML file='collayout_9_10.html' STYLE=sasweb;
title 'Controlling Layout';
data _null_;
  set traffic;
  by impact;
  file print ods=(variables=(impact event location highway ));
  if first.impact then do;
     put _ods_;
  end;
  else do;
    put @2 event @3 location @4 highway;
  end;
  if last.impact then put @1 ' ';
run;
ODS HTML CLOSE;



/* Figure 9.11 */
title;
footnote;

proc format;
  value $hwyrt '80'='I-80'
               '101'='US 101'
               '280'='I-280';
run;

title 'DATA Step that Modifies Formats and Labels';
ODS HTML FILE='FormatsLabels_9_11.html' STYLE=sasweb;
data _null_;
   set traffic;
   file print ods=(variables=(impact event location highway));
   put _ods_;
   attrib impact label = 'Accident Impact'
          highway label = 'Hwy' format=$hwyrt.;
run;
ODS HTML CLOSE;

ODS HTML FILE="FormatsLabels_9_11_2.html" STYLE=sasweb;
title 'DATA Step that Modifies Formats and Labels';
data _null_;
   set traffic;
   file print ods=(variables=(
              impact(label="Accident Impact")
              event
              location
              highway(format=$hwyrt. label="Hwy")
              ));
   put _ods_;
run;
ODS HTML CLOSE;


/* Figure 9.12 */
title;
footnote;

ODS HTML FILE='TotBreak_9_12.html' STYLE=sasweb;
title 'Total At Break';
data _null_;
  set traffic;
  by impact;
  file print ods=(variables=(impact event location highway ));
  length itotchar $ 8;
  if first.impact then do;
     itot = 1;
     put _ods_;
  end;
  else do;
    itot + 1;
    put @2 event @3 location @4 highway;
  end;
  if last.impact then do;
     itotchar=put(itot,8.);
     put @1 'Tot Event' @2 itotchar;
  end;
run;
ODS HTML CLOSE;




/* Figure 9.13, 9.14 */
title;
footnote;

ODS HTML file='UseEsc_9_13.html' STYLE=sasweb;
ODS PDF file='UseEsc_9_14.pdf';
ODS RTF file='UseEsc_9_14.rtf';
ODS ESCAPECHAR='^';
title 'DATA Step with Inline Formatting';
data _null_;
  length impact event highway itotchar $ 50;
  set traffic;
  by impact;
  file print ods=(variables=(impact event location highway));
  highway = cats('^{style[just=c]',highway,'}');
  if first.impact then do;
    itot = 1;
    impact = cats('^{style[font_weight=bold]',impact,'}');
    put _ods_;
  end;
  else do;
    itot + 1;
    put @2 event @3 location @4 highway;
  end;
  if last.impact then do;
    itotchar=cats('^{style [just=r font_weight=bold]',left(put(itot,8.)),'}');
    put @1 '^{style [font_weight=bold]Tot Event}' @2 itotchar;
  end;
run;
ODS _ALL_ CLOSE;




/******************************************************************************/
/* End Chapter 9                                                              */
/******************************************************************************/


/******************************************************************************/
/* Start Chapter 10 - Creating Custom Reports from the DATA Step              */
/******************************************************************************/

/* Figure 10.1, 10.2 */
title;
footnote;

ods path work.newtemp(update)
         sashelp.tmplmst(read);

proc template;
  define table tables.hr_table;
  column Department AnnualSalary BonusAmt NewSal;
    define Department;
      header='Dept';
    end;
    define AnnualSalary;
      header='Annual';
      format=dollar14.2;
    end;
    define BonusAmt;
      header = '#Bonus#@5%';
      format=7.2;
    end;
    define NewSal;
      header = 'Adjusted';
      format=dollar14.2;
    end;
  end;
run;

ODS HTML FILE='CustomHRLayout_10_2.html' STYLE=sasweb;
title 'Custom Layout with the DATA Step';
data _null_;
  set hr;
  BonusAmt = AnnualSalary * .05;
  NewSal = AnnualSalary + BonusAmt;
  file print ods=(template='tables.hr_table');
  put _ods_;
run;
ODS HTML CLOSE;


/* Figure 10.3, 10.4 */
title;
footnote;

ods path work.newtemp(update)
         sashelp.tmplmst(read);

proc template;
  define table tables.hr_calc;
  column Department AnnualSalary BonusAmt NewSal;
    define Department;
      header='Dept';
    end;
    define AnnualSalary;
      header='Annual';
      format=dollar14.2;
    end;
    define BonusAmt;
      compute as AnnualSalary * .05;
      header = '#Bonus#@5%';
      format=7.2;
    end;
    define NewSal;
      compute as AnnualSalary + BonusAmt;
      header = 'Adjusted';
      format=dollar14.2;
    end;
  end;
run;

ODS HTML FILE='CalcHRLayout_10_4.html' STYLE=sasweb;
title 'Columns Calculated in Custom Template';
data _null_;
  set hr;
  file print ods=(template='tables.hr_calc');
  put _ods_;
run;
ODS HTML CLOSE;


/* Figure 10.5 */
title;
footnote;

ods path work.newtemp(update)
         sashelp.tmplmst(read);

proc template;
  define table tables.hr_span;
  column Department AnnualSalary BonusAmt NewSal;
  header spanhead calchead;
    define header spanhead;
      text 'Based on Salary';
      just=center;
      start=AnnualSalary;
      end = NewSal;
    end;
    define header calchead;
      text 'Calculated';
      just = center;
      start = BonusAmt;
      end = NewSal;
    end;
    define Department;
      header='Dept';
    end;
    define AnnualSalary;
      header='Annual';
      format=dollar14.2;
    end;
    define BonusAmt;
      compute as AnnualSalary * .05;
      header = '#Bonus#@5%';
      format=7.2;
    end;
    define NewSal;
      compute as AnnualSalary + BonusAmt;
      header = 'Adjusted';
      format=dollar14.2;
    end;
  end;
run;

ODS HTML FILE='SpanHRReport_10_5.html' STYLE=sasweb;
title 'Spanning Columns in Custom Template';
data _null_;
  set hr;
  file print ods=(template='tables.hr_span');
  put _ods_;
run;
ODS HTML CLOSE;



/* Figure 10.6 */
title;
footnote;

ods path work.newtemp(update)
         sashelp.tmplmst(read);

proc template;
  define table tables.hr_html;
  column Department AnnualSalary BonusAmt NewSal;
  style={rules=none frame=box cellspacing=0
         protectspecialchars=off};
  header spanhead calchead;
    define header spanhead;
      text 'Based on Salary';
      just=center;
      start=AnnualSalary;
      end = NewSal;
      style={tagattr='style="border-bottom:thick double black"'};
    end;
    define header calchead;
      text 'Calculated';
      just=center;
      start=BonusAmt;
      end = NewSal;
      style={tagattr='style="border-bottom:thick double black"'};
    end;
    define Department;
      define header dhead;
        text 'Dept';
        style={prehtml='<img src="LH_TRANS.GIF">'};
      end;
      header=dhead;
    end;
    define AnnualSalary;
      header='Annual';
      format=dollar14.2;
    end;
    define BonusAmt;
      compute as AnnualSalary * .05;
      header = '#Bonus#@5%';
      format=7.2;
    end;
    define NewSal;
      compute as AnnualSalary + BonusAmt;
      header = 'Adjusted';
      format=dollar14.2;
    end;
  end;
run;

ODS HTML FILE='HTMLCustomReport_10_6.html' STYLE=sasweb;
title 'HTML Custom Report';
data _null_;
  set hr;
  file print ods=(template='tables.hr_html');
  put _ods_;
run;
ODS HTML CLOSE;


/* Figure 10.7, 10.8 */
title;
footnote;

ods path work.newtemp(update) sashelp.tmplmst(read);

proc template;
  define table tables.hr_traffic;
  column Department AnnualSalary BonusAmt NewSal;
    define Department;
      style={font_face=$DFont.};
      header='Dept';
    end;
    define AnnualSalary;
      header='Annual';
      format=dollar14.2;
    end;
    define BonusAmt;
      compute as AnnualSalary * .05;
      header = '#Bonus#@5%';
      format=7.2;
      cellstyle _val_ between 1600 and 2500 as
                  {font_weight=bold},
                _val_ between 2500 and 4000 as
                  {background=black foreground=white},
                _val_ gt 4000 as {font_style=italic},
                  1 as Data;
    end;
    define NewSal;
      compute as AnnualSalary + BonusAmt;
      header = 'Adjusted';
      format=dollar14.2;
    end;
  end;
run;

proc format;
  value $dfont 'Administration','R&D'='Courier New'
              'Marketing','Manufacturing'='SAS Monospace';
run;

ODS HTML FILE='HRTrafficLayout_10_7.html' STYLE=sasweb;
title 'Traffic Lighting in Custom Template';
data _null_;
  set hr;
  file print ods=(template='tables.hr_traffic');
  put _ods_;
run;
ODS HTML CLOSE;



/* Figure 10.9 */
title;
footnote;

ods path work.newtemp(update) sashelp.tmplmst(read);

proc template;
  define table tables.hr_generic;
  column Department SalGen;
  dynamic colhdr;
    define Department;
      header='Dept';
      style=RowHeader;
    end;
    define SalGen;
      header=colhdr;
      generic=on;
    end;
  end;
run;

ODS HTML FILE='HRGenericLayout_10_9.html' STYLE=sasweb;
title "Generic Variables in Custom Template";
data _null_;
  set hr;
  BonusAmt = AnnualSalary * .05;
  NewAmt = AnnualSalary + BonusAmt;
  file print ods=
       (template='tables.hr_generic'
        columns=(Department
                 SalGen=AnnualSalary
           (dynamic=(colhdr='Annual Salary') generic=on)
                 SalGen=BonusAmt
           (dynamic=(colhdr='Bonus') generic=on)
                 SalGen=NewAmt
           (dynamic=(colhdr='Adj Salary') generic=on)));
  put _ods_;
  format BonusAmt comma8.2 NewAmt Dollar14.2;
run;
ODS HTML CLOSE;






/* Figure 10.10 */
title;
footnote;

ods path work.newtemp(update) sashelp.tmplmst(read);
proc template;
  define table tables.hr_macro;
  column Department AnnualSalary BonusAmt NewSal;
  mvar thisyear btxt sysdate9 sysscpl;
  nmvar bpct;
  header spanhead;
  footer rundate;
    define header spanhead;
      text 'Based on ' thisyear
           ' Salary Numbers at ' btxt '%';
      just=center;
    end;
    define footer rundate;
      text 'Run on: ' sysdate9 ' Platform: ' sysscpl;
    end;
    define BonusAmt;
      compute as AnnualSalary * bpct;
      header = "Bonus";
      format=6.2;
    end;
    define NewSal;
      compute as AnnualSalary + BonusAmt;
      header = 'Adjusted';
      format=dollar14.2;
    end;
  end;
run;

%let thisyear = 2008;
%let bpct = 0.075;
%let btxt = 7.5;

ODS HTML FILE='HRMacroVars_10_10.html' style=sasweb;
title 'Using Macro Variables in Custom Template';
data _null_;
  set hr;
  file print ods=(template='tables.hr_macro');
  put _ods_;
run;
ODS HTML CLOSE;


/* Figure 10.11, 10.12, 10.13 */
title;
footnote;

ODS PATH WORK.NEWTEMP(UPDATE) SASHELP.TMPLMST(READ);
proc template;
  define table tables.table_just;
  column Type Sales AmtCom Profit PctCom;
    define Type;
      header='Type';
    end;
    define Sales;
      header='#Sales#Amount#c/off';
      just=c;
      justify=off
      format=dollar14.2;
    end;
    define AmtCom;
      header = '#Amount#Commission#c/on';
      just=c;
      justify=on;
      format=dollar14.2;
    end;
    define Profit;
      header = '#Profit#l/off';
      just=l;
      justify=off;
      format=dollar14.2;
    end;
    define PctCom;
      header = '#Pct#Commission#l/on';
      just=l;
      justify=on;
      format=6.2;
    end;
  underline=on;
  end;
run;

ODS LISTING;
ODS PDF file='Table_Just_10_12.pdf';
ODS RTF file='Table_Just_10_13.rtf';
ODS HTML file='Table_Just_10_13.html' style=sasweb;
title 'JUST= and JUSTIFY= Attributes in Custom Table Template';
data _null_;
  set salesdata;
  if Sales lt 1 then AmtCom = (Sales * -1) * PctCom;
  else if Sales ge 0 then AmtCom = Sales * PctCom;
  Profit = Sales - AmtCom;
  file print ods=(template='tables.table_just');
  put _ods_;
run;
ODS _ALL_ CLOSE;

title;
footnote;

ODS PATH WORK.NEWTEMP(UPDATE) SASHELP.TMPLMST(READ);
proc template;
  define table tables.table_jval;
  dynamic jval y_or_n;
  column Type Sales AmtCom Profit PctCom;
    define Type;
      header='Type';
    end;
    define Sales;
      header='#Sales#Amount#c/off';
      just=c;
      justify=off
      format=dollar14.2;
    end;
    define AmtCom;
      header = '#Amount#Commission#c/on';
      just=c;
      justify=on;
      format=dollar14.2;
    end;
    define Profit;
      header = '#Profit#l/off';
      just=l;
      justify=off;
      format=dollar14.2;
    end;
    define PctCom;
      header = '#Pct#Commission#l/on';
      just=l;
      justify=on;
      format=6.2;
    end;
  underline=on;
  end;
run;
ODS LISTING;
ODS PDF file='Table_Just2_10_12.pdf';
ODS RTF file='Table_Just2_10_13.rtf';
ODS HTML file='Table_Just2_10_13.html' style=sasweb;
data _null_;
  set salesdata;
  AmtCom = Sales * PctCom;
  Profit = Sales - AmtCom;
  file print
       ods=(template='tables.table_jval'
            columns=(
            Type(dynamic=(jval='r' y_or_n=0))
            Sales(dynamic=(jval='c' y_or_n=1))
            AmtCom(dynamic=(jval='c' y_or_n=0))
            Profit(dynamic=(jval='l' y_or_n=1))
            PctCom(dynamic=(jval='l' y_or_n=0))
           ));
  put _ods_;
run;
ODS _ALL_ CLOSE;





/******************************************************************************/
/* End Chapter 10                                                             */
/******************************************************************************/



/******************************************************************************/
/* Start Chapter 11 - Modifying and Replaying ODS Output                      */
/******************************************************************************/


/* Figure 11.1-11.4 */
proc sort data=hr;
  by country;
run;
ODS DOCUMENT NAME=work.origdoc(write);
proc means data=hr min mean max;
  title 'Salary Analysis by Country';
  by Country;
  class Category;
  var AnnualSalary;
run;

proc freq data=hr;
  title 'Department Information by Country';
  by Country;
  table Department;
run;
ODS DOCUMENT CLOSE;

proc datasets library=work;
quit;


/* Figure 11.5 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

ODS LISTING;
PROC DOCUMENT NAME=work.origdoc;
   LIST / LEVELS=ALL;
RUN;
QUIT;

/* Figure 11.6, 11.7 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

ODS PDF FILE='ReplayDoc_11_6.pdf';
ODS RTF FILE='ReplayDoc_11_6.rtf';
ODS HTML FILE='ReplayDoc_11_6.html';
ODS LISTING;
PROC DOCUMENT NAME=work.origdoc;
  REPLAY;
RUN;
QUIT;
ODS _ALL_ CLOSE;

/* Figure 11.14 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

ODS LISTING;
PROC DOCUMENT NAME=work.newhr;
   LIST / LEVELS=ALL;
RUN;
QUIT;


/* Figure 11.15 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

proc document name=work.newhr;
  obstitle \Central_America#1\Mexico#1\Summary#1 ;
  obstitle \US_Canada#1\Canada#1\Summary#1 ;
  obstitle \US_Canada#1\United_States#1\Summary#1 ;
  obpage \Central_America#1\Mexico#1\OneWayFreqs#1 /  delete ;
  obpage \Central_America#1\Mexico#1\OneWayFreqs#1 /  after delete ;
  obpage \US_Canada#1\Canada#1\OneWayFreqs#1  /  delete ;
  obpage \US_Canada#1\United_States#1\Summary#1 ;
  obpage \US_Canada#1\United_States#1\OneWayFreqs#1 /  delete ;
  obtitle1 \Central_America#1\Mexico#1\Summary#1
           'Salary and Work Force Report';
  obtitle1 \US_Canada#1\Canada#1\Summary#1
          'Salary and Work Force Report';
  obtitle1 \US_Canada#1\United_States#1\Summary#1
           'Salary and Work Force Report';
run;
quit;

ODS LISTING CLOSE;
ODS PDF FILE='NewHRDoc_11_15.pdf';
proc document name=work.newHR;
  replay;
run;
quit;
ODS PDF CLOSE;


/* Figure 11.16, 11.17 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

proc document name=work.newsaldoc(write);
  make Central_America, US_Canada;
run;
  dir;
  setlabel \Central_America#1 'Reports for Central America';
  setlabel \US_Canada#1 'Reports for United States and Canada';
run;
  dir Central_America;
  make Mexico;
  dir;
run;
  dir \US_Canada;
  make Canada;
  dir;
  dir \US_Canada;
  make United_States;
  setlabel \US_Canada #1\United_States#1 'United States';
  dir;
run;
quit;


/* Figure 11.18, 11.19 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

ODS DOCUMENT NAME=work.basicsaldoc(write);
ODS NOPROCTITLE;
proc means data=hr min mean max;
  by Country;
  class Category;
  var AnnualSalary;
run;

proc freq data=hr;
  by Country;
  table Department;
run;
ODS DOCUMENT CLOSE;

proc document name=work.newsaldoc(update);
  dir \work.newsaldoc\Central_America#1\Mexico#1;
  copy \work.basicsaldoc\Means#1\ByGroup2#1\Summary#1
    to \work.newsaldoc\Central_America#1\Mexico#1;
  copy \work.basicsaldoc\Freq#1\ByGroup2#1\Table1#1\OneWayFreqs#1
    to ^;
run;
  dir;
  dir \US_Canada#1;
  dir Canada;
  copy \work.basicsaldoc\Means#1\ByGroup1#1\Summary#1 to ^;
  copy \work.basicsaldoc\Freq#1\ByGroup1#1\Table1#1\OneWayFreqs#1 to ^;
run;
  dir;
  dir \US_Canada#1\United_States#1;
  copy \work.basicsaldoc\Means#1\ByGroup3#1\Summary#1 to ^;
  copy \work.basicsaldoc\Freq#1\ByGroup3#1\Table1#1\OneWayFreqs#1 to ^;
run;
quit;


/* Figure 11.20 */
/* Run program for 11.1 to produce item store WORK.ORIGDOC */
title;
footnote;

proc document name=work.newsaldoc;
  obpage \Central_America#1\Mexico#1\Summary#1 /  after delete ;
  obpage \Central_America#1\Mexico#1\OneWayFreqs#1 /  delete ;

  obpage \US_Canada#1\Canada#1\Summary#1  /  after delete ;
  obpage \US_Canada#1\Canada#1\OneWayFreqs#1  /  delete ;

  obpage \US_Canada#1\Canada#1\Summary#1;
  obpage \US_Canada#1\United_States#1\Summary#1 ;

  obpage \US_Canada#1\United_States#1\Summary#1  /  after delete ;

  obpage \US_Canada#1\United_States#1\OneWayFreqs#1 /  delete ;
  obtitle1 \Central_America#1\Mexico#1\Summary#1
         'Salary and Work Force Report';
  obtitle1 \US_Canada#1\Canada#1\Summary#1
         'Salary and Work Force Report';
  obtitle1 \US_Canada#1\United_States#1\Summary#1
         'Salary and Work Force Report';
run;
quit;

ODS LISTING CLOSE;
ODS PDF FILE='NewHRByCountry_11_20.pdf';
  proc document name=work.newsaldoc;
    replay;
  run;
  quit;
ODS PDF CLOSE;



/* Figure 11.21, 11.22 */
title;
footnote;

ODS LISTING;
PROC DOCUMENT NAME=work.origdoc;
   LIST / LEVELS=ALL;
RUN;
QUIT;
LIBNAME cansum SASEDOC "\work.origdoc\Means\ByGroup1#1";
LIBNAME mexsum SASEDOC "\work.origdoc\Means\ByGroup2#1";
LIBNAME usasum SASEDOC "\work.origdoc\Means\ByGroup3#1";


proc contents data=cansum.summary;
run;
proc print data=cansum.summary;
 title 'Summary document object for Canada';
run;
proc datasets library=mexsum nolist;
     change summary=sumby2;
run;
quit;
PROC DOCUMENT NAME=work.origdoc;
   LIST / LEVELS=ALL;
RUN;
QUIT;


/******************************************************************************/
/* End Chapter 11                                                             */
/******************************************************************************/



/******************************************************************************/
/* Start Chapter 12 - Using Tagsets to Generate Markup Output                 */
/******************************************************************************/

/* Figure 12.1 */
title;
footnote;

ODS DOCBOOK FILE='docbook1_12_1.xml';
ODS MARKUP TAGSET=DOCBOOK FILE='docbook2_12_1.xml';
ODS TAGSETS.DOCBOOK FILE='docbook3_12_1.xml';
proc print data=billings;
  title 'Using Markup Tagsets';
  var Division JobType CustomerName BillableAmt;
run;
ODS _ALL_ CLOSE;



/* Figure 12.3, 12.4, 12.5 */
title;
footnote;

proc sort data=billings;
  by division jobtype;
run;

ODS CSV FILE='result1_12_3.csv';
ODS CSVALL FILE='result2_12_4.csv';
ODS TAGSETS.CSVBYLINE FILE='result3_12_5.csv';
proc print data=billings;
  by Division JobType;
  title 'Using CSV Tagsets';
  var JobType CustomerName BillableAmt;
run;
ODS _ALL_ CLOSE;



/* Figure 12.6, 12.7 */
title;
footnote;

ODS HTML FILE='html4_12_6.html' STYLE=sasweb;
ODS PHTML FILE='plain_12_6.html' STYLE=sasweb;
ODS CHTML FILE='compact_12_7.html' STYLE=sasweb;
proc print data=billings;
  title 'Using Markup Tagsets';
  var Division JobType CustomerName BillableAmt;
run;
ODS _ALL_ CLOSE;



/* Figure 12.8, 12.9 */
title;
footnote;

ODS MARKUP TAGSET=DEFAULT FILE='DefaultTagset_12_8.xml' STYLE=sasweb;
ODS TAGSETS.EXCELXP FILE='ExcelXPTagset_12_9.xml' STYLE=sasweb;
proc print data=billings;
  title 'Using Markup Tagsets';
  var Division JobType CustomerName BillableAmt;
run;
ODS _ALL_ CLOSE;



/* Figure 12.10 */
title;
footnote;

ODS TAGSETS.STYLE_POPUP FILE='StyleDiag_12_10.HTML';
proc print data=billings(obs=5);
run;
ODS _ALL_ CLOSE;


/* Figure 12.11 */
title;
footnote;

ODS TAGSETS.NAMEDHTML FILE='TableDiag_12_11.HTML';
proc print data=billings(obs=5);
run;
ODS _ALL_ CLOSE;

/* Figure 12.12 */
title;
footnote;

ODS TAGSETS.SHORT_MAP FILE='TableDiag_12_12.XML';
proc print data=billings(obs=5);
run;
ODS _ALL_ CLOSE;


/* Figure 12.13 */
title;
footnote;


ODS PATH work.tagtemp(update) sashelp.tmplmst(read);

proc template;
  define tagset tagsets.reparchive / store=work.tagtemp;
    notes "Document Archive XML";
    parent = tagsets.docbook;
    mvar arcdate;
    define event doc_head;
      start: put "<archive>" ;
             put arcdate;
             break;
      finish: put "</archive>" NL;
              break ;
    end;
  end;
run;
%let arcdate = 2008-12-31;

ODS PATH WORK.TAGTEMP(UPDATE) SASHELP.TMPLMST(READ);
ODS TAGSETS.REPARCHIVE FILE='BillingsReport_12_13.xml';
proc print data=billings(obs=5);
run;
ODS _ALL_ CLOSE;



/* Figure 12.14 */
title;
footnote;

proc template;
  define tagset tagsets.partsauction / store=work.tagtemp;
    notes "Parts Auction XML";
    define event doc;
      start: put "<?xml version=""1.0""";
             putq " encoding=" encoding / if exists( $show_charset);
             put "?>" NL NL;
             put "<parts>" NL;
             ndent;
             break;
      finish: xdent;
              put "</parts>" NL;
              break;
    end;
    define event header;
      start: put "<header>" ;
             put VALUE;
             break;
      finish: xdent;
              put "</header>" NL;
              break;
    end;
    define event row;
      start: ndent;
             put "<row>" ;
             break;
      finish: xdent;
              put "</row>" NL;
              break;
     end;
    define event data;
       start: ndent;
              put "<data>" ;
              put VALUE;
              break;
       finish: xdent;
               put "</data>" NL;
               break;
    end;
    output_type = "xml";
    nobreakspace = " ";
    mapsub = %nrstr("/&lt;/&gt;/&amp;/");
    map = %nrstr("<>&");
  end;
run;

ODS PATH WORK.TAGTEMP(UPDATE) SASHELP.TMPLMST(READ);
ODS TAGSETS.PARTSAUCTION FILE='PartsList_12_14.xml';

proc print data=partsauction noobs;
  title 'Online Parts Auction';
  var partnum partdesc sellerid askprice;
run;

ODS _ALL_ CLOSE;


/* Figure 12.15 */
title;
footnote;

ODS PATH WORK.TAGTEMP(UPDATE) SASHELP.TMPLMST(READ);
ODS TAGSETS.PARTSAUCTION FILE='Parts_Billing_12_15.xml';

proc print data=billings(obs=2)noobs;
  var division employeename customername hours jobtype;
run;

ODS _ALL_ CLOSE;



/* Bonus Chapter 12 Example                      */
/* Adds tag <!-- This is a Required Comment -->' */
/* after the <body> tag                          */

ODS PATH work.tagtemp(update) sashelp.tmplmst(read);

proc template;
  define tagset tagsets.spechtml / store=work.tagtemp;
  parent=tagsets.html4;
     define event doc_body;
         put "<body onload=""startup()""";
         put " onunload=""shutdown()""";
         put " bgproperties=""fixed""" / WATERMARK;
         putq " class=" HTMLCLASS;
         putq " background=" BACKGROUNDIMAGE;

         trigger style_nline;
         put ">" NL;
         trigger pre_post;
         put NL;
         trigger ie_check;
         put '<!-- This is a Required Comment -->' NL;

         finish:
           trigger pre_post;
           put "</body>" NL;
     end;
  end;
run;

ODS TAGSETS.SPECHTML FILE='add_comment.html' STYLE=SASWEB;
proc print data=billings(obs=2)noobs;
  title 'This is the Title';
  var division employeename customername hours jobtype;
run;
ODS TAGSETS.SPECHTML CLOSE;

/******************************************************************************/
/* End Chapter 12                                                             */
/******************************************************************************/



/******************************************************************************/
/* Start Chapter 13 - Using Tagsets to Generate Markup Output                 */
/******************************************************************************/

/* Figure 13.2 */
title;
footnote;

PROC TEMPLATE;
   LIST STYLES;
RUN:


/* Figure 13.3*/
title;
footnote;

ODS PDF FILE='StatdocStyle_13_3.pdf' STYLE=Statdoc;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS PDF CLOSE;

/* Figure 13.4 */
title;
footnote;

ODS HTML FILE='StatdocStyle_13_4.html' STYLE=Statdoc;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS HTML CLOSE;


/* Figure 13.5 */
title;
footnote;

ODS PDF FILE='AnalysisStyle_13_5.pdf' STYLE=Analysis;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS PDF CLOSE;



/* Figure 13.6 */
title;
footnote;

ODS PDF FILE='JournalStyle_13_6.pdf' STYLE=Journal;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS PDF CLOSE;



/* Figure 13.7 */
title;
footnote;

PROC TEMPLATE;
   SOURCE Styles.Default;
RUN;


/* Figure 13.8 */
title;
footnote;

ODS HTML FILE='StyleMod_13_8.html' style=default;
proc means data=fashions maxdec=0 sum;
  title "Sales Results";
  class Skirts;
  var Sales;
run;
ODS HTML CLOSE;

/* Figure 13.9 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE DefaultNewTitle;
  PARENT=styles.default;
  class fonts /
    'TitleFont2' = ("<sans-serif>, Helvetica, sans-serif",4,bold italic)
    'TitleFont' = ("Times New Roman, Times, sans-serif",5,bold italic)
    'StrongFont' = ("<sans-serif>, Helvetica, sans-serif",4,bold)
    'EmphasisFont' = ("<sans-serif>, Helvetica, sans-serif",3,italic)
    'FixedEmphasisFont' = ("<monospace>, Courier, monospace",2,italic)
    'FixedStrongFont' = ("<monospace>, Courier, monospace",2,bold)
    'FixedHeadingFont' = ("<monospace>, Courier, monospace",2)
    'BatchFixedFont' = ("SAS Monospace, <monospace>, Courier, monospace",2)
    'FixedFont' = ("<monospace>, Courier",2)
    'headingEmphasisFont' = ("<sans-serif>, Helvetica, sans-serif",4,bold italic)
    'headingFont' = ("<sans-serif>, Helvetica, sans-serif",4,bold)
    'docFont' = ("<sans-serif>, Helvetica, sans-serif",3);
  end;
run;

ODS HTML FILE='StyleMod_13_9.html' style=defaultnewtitle;
proc means data=fashions maxdec=0 sum;
  title "Sales Results";
   class Skirts;
   var Sales;
run;
ODS HTML CLOSE;



/* Figure 13.10*/
title;
footnote;

PROC TEMPLATE;
   LIST STYLES;
RUN:


/* Figure 13.11*/
title;
footnote;

PROC TEMPLATE;
   LIST / WHERE=(TYPE="Style");
RUN;


/******************************************************************************/
/* End Chapter 13                                                             */
/******************************************************************************/

/******************************************************************************/
/* Start Chapter 14 - Understanding the Built-In Style Template Definitions   */
/******************************************************************************/

/* Figure 14.1, 14.2 */
title;
footnote;

ODS TAGSETS.STYLE_POPUP FILE='BillingsStyle_14_1.HTML';
proc print data=billings(obs=5);
  title "Demonstrating Diagnostic Tagsets";
run;
ODS _ALL_ CLOSE;

/* Figure 14.3, 14.5, 14.6, 14.7, 14.8, 14.9 */
PROC TEMPLATE;
  SOURCE styles.default;
RUN;


/* Figure 14.5 */
PROC TEMPLATE;
  SOURCE BASE.TEMPLATE.STYLE;
RUN;


/* Figure 14.7 */
title;
footnote;

ODS TAGSETS.ODSSTYLE
   STYLESHEET='ResolvedDefn_14_7.sas';
proc print data=billings(obs=5);
run;
ODS _ALL_ CLOSE;



/* Figure 14.10 */
title;
footnote;

ODS PATH work.tempstyles(update) sashelp.tmplmst(read);

proc template;
  define style styles.redline / store=work.tempstyles;
    parent=styles.default;
    class html
  "Common HTML text used in the default style" /
  'expandAll' =
   "<span onclick=""if(msie4==1)expandAll()"">"
  'posthtml flyover line' = "</span><hr size=""3"">"
  'prehtml flyover line' = "<span><hr size=""3"">"
  'prehtml flyover bullet' = %nrstr("<span><b>&#183;</b>")
  'posthtml flyover' = "</span>"
  'prehtml flyover' = "<span>"
  'break' = "<br>"
  'Line' = "<hr size=""3"">"
  'PageBreakLine' =
    '<p style="page-break-after: always;"><br></p><hr size="5" color="red">'
  'fake bullet' = %nrstr("<b>&#183;</b>");

  end;
run;

ODS HTML FILE='BillingsRedLine_14_10.HTML' STYLE=STYLES.REDLINE;
proc means data=hr n mean min max maxdec=2;
  class country;
  var annualsalary;
run;
proc means data=hr n mean min max maxdec=2;
  class category;
  var annualsalary;
run;
ODS HTML CLOSE;



/* Figure 14.12 */
title;
footnote;

/* SAS 9.1.3 or SAS 9.2 */
proc template;
  define style styles.chgabs;
  parent=styles.default;
  style HeadersandFooters from HeadersandFooters/
     font = ("Courier New, SAS Monospace",4,Bold)
     background=yellow
     foreground=purple;
  end;
run;

/* SAS 9.2 */
proc template;
  define style styles.chgabs;
  parent=styles.default;
  class HeadersandFooters /
     font = ("Courier New, SAS Monospace",4,Bold)
     background=yellow
     foreground=purple;
  end;
run;
ODS PDF FILE="CHGABSStyle_14_12.PDF" STYLE=CHGABS;
proc freq data=hr;
  tables country;
run;
ODS PDF CLOSE;




/* Figure 14.13 */
title;
footnote;

proc template;
  define style styles.diffhdrs;
    parent=styles.default;
    class Header /
      font = ("Arial, Helvetica, sans-serif",5,Bold)
      background=black
      foreground=white
      just=center;
    class RowHeader /
      font = ("Courier New, SAS Monospace",4,Bold)
      background=white
      foreground=black
      just=right;
  end;
run;

ODS PDF FILE="DiffHdrs_14_13.pdf" STYLE=STYLES.DIFFHDRS;
proc freq data=hr;
  tables department;
run;
ODS PDF CLOSE;

/* Not used in a figure, same page as code for 14.13 */
proc template;
  define style styles.samehdrs;
    parent=styles.default;
    class Header, RowHeader from _self_ /
      font = ("Arial, Helvetica, sans-serif",5,Bold)
      background=black
      foreground=white
      just=center;
  end;
run;


/* Figure 14.14 */
title;
footnote;

proc template;
 define style styles.alert;
   parent=styles.default;
   class StartupFunction /
      tagattr='alert("To Get Paid For Overtime, Fill Out Your TimeSheets!!")';
 end;
run;

ODS HTML BODY='OvertimeAlert_14_14.html' STYLE=STYLES.ALERT;
title 'In-House Billing Overtime';
proc print data=billings noobs label;
   where Hours>8 and JobType = 'In-house';
   label Hours='Overtime Hours';
   var EmployeeName WorkDate JobType Hours;
run;
ODS HTML CLOSE;



/* Figure 14.15 */
title;
footnote;

proc template;
  define style styles.putdate;
    parent=styles.default;
    class body / posthtml='<SCRIPT LANGUAGE=JAVASCRIPT
                 TYPE="text/javascript" SRC="GETDATE.JS"></script>';
  end;
run;

ODS HTML BODY='POSTJS_14_15.html' STYLE=STYLES.PUTDATE;
title 'In-House Billing Overtime';
proc print data=billings noobs label;
   where Hours>8 and JobType = 'In-house';
   label Hours='Overtime Hours';
   var EmployeeName WorkDate JobType Hours;
run;
ODS HTML CLOSE;



/* Figure 14.16 */
title;
footnote;

proc template;
  define style styles.bottomtoc;
    parent=styles.default;
    class frame / contentposition=bottom  contentsize=25%;
    class contents / background=white;
    class contenttitle / font = ("Arial, Helvetica",16 pt,Bold)
                         foreground=black  background=white
                         pretext = 'Select Your Report From the List Below';
    class contentfolder / background=white;
    class ContentProcname / background=white  bullet=none;
    class contentitem / bullet=none  background=white;
  end;
run;

ODS HTML BODY='HRBody.html' CONTENTS='HRContents_14_17.html'
         FRAME='HRFrame_14_17.html' STYLE=styles.bottomtoc NEWFILE=proc;
proc freq data=hr;
  title "Country Report";
  tables country;
run;
proc means data=hr n mean maxdec=2;
  title "Salaries by Country";
  class country;
  var annualsalary;
run;
proc means data=hr n mean min max maxdec=1;
  title "Hours per Week by Department";
  class department;
  var hoursweek;
run;
ODS HTML CLOSE;

/* Figure 14.17, 14.18, 14.19 */
title;
footnote;

proc template;
  define style styles.chgbody;
  parent=styles.default;
    class Body / marginright = 2
                 marginleft = 0;
  end;
run;

OPTIONS NOCENTER;
ODS HTML(id=1) BODY='ChgBody_14_19.html' STYLE=styles.chgbody;
ODS HTML(id=2) BODY='DefBody_14_20.html' STYLE=styles.default;
ODS NOPTITLE;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;

ODS _ALL_ CLOSE;
options center;

/* Figure 14.20, 14.21 */
title;
footnote;

proc template;
  define style styles.chgtable;
    parent=styles.default;
    class Output / bordercollapse = separate
                   backgroundcolor = white
                   rules = ALL
                   frame = BOX
                   cellpadding = 7
                   borderspacing = 5
                   bordercolor = black
                   borderwidth = 5;
  end;
run;

ODS HTML BODY='DeptSalaries_14_22.html' STYLE=styles.chgtable;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;

ODS HTML CLOSE;


/* Figure 14.22 */
title;
footnote;

proc template;
  define style styles.chgtable;
    parent=styles.default;
    class Output / bordercollapse = separate
                   backgroundcolor = white
                   rules = ALL
                   frame = BOX
                   padding = 7
                   borderspacing = 0
                   bordercolor = black
                   borderwidth = 5;
  end;
run;

ODS HTML BODY='DeptSalaries_14_23.html' STYLE=styles.chgtable;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;

ODS HTML CLOSE;

/* Figure 14.23_1-8 */
title;
footnote;

ODS NOPROCTITLE;

proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = rows
                   frame = void;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_1.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=ROWS and FRAME=VOID";
  tables department / nocum;
run;
ODS HTML CLOSE;


proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = cols
                   frame = void;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_2.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=COLS and FRAME=VOID";
  tables department / nocum;
run;
ODS HTML CLOSE;

proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = none
                   frame = void;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_3.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=NONE and FRAME=VOID";
  tables department / nocum;
run;
ODS HTML CLOSE;


proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = groups
                   frame = void;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_4.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=GROUPS and FRAME=VOID";
  tables department / nocum;
run;
ODS HTML CLOSE;


title;
footnote;

proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = none
                   frame = hsides;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_5.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=NONE and FRAME=HSIDES";
  tables department / nocum;
run;
ODS HTML CLOSE;


proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = none
                   frame = vsides;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_6.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=NONE and FRAME=VSIDES";
  tables department / nocum;
run;
ODS HTML CLOSE;


proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = none
                   frame = box;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_7.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=NONE and FRAME=BOX";
  tables department / nocum;
run;
ODS HTML CLOSE;


proc template;
  define style styles.rulesframe;
    parent=styles.default;
    class Output / borderspacing=0
                   rules = none
                   frame = above;
  end;
run;
ODS HTML BODY='HRDeptFreq_14_24_8.html' STYLE=styles.rulesframe;
proc freq data=hr;
  title "RULES=NONE and FRAME=ABOVE";
  tables department / nocum;
run;
ODS HTML CLOSE;

ODS PROCTITLE;


/* Macro to generate templates and reports similar to Figure 14.23 */
%macro chgrf(rulelist=, framelist=, templatename=testtemplate);
  %let rulenumber=1;

  %let rule=%scan(&rulelist,&rulenumber);
  %do %until (&rule=);
    %let framenumber=1;
    %let frame=%scan(&framelist,&framenumber);
    %do %until (&frame=);
      proc template;
        define style styles.&templatename;
          parent=styles.default;
          class Output / borderspacing = 0
                         rules = &RULE
                         frame = &FRAME;
        end;
      run;

      ods html body="r_&rule._f_&frame..html"
               style=styles.&templatename;
      ods noproctitle;
      proc freq data=hr;
        title "RULE=&RULE and FRAME=&FRAME";
        tables Department / nocum;
      run;
      ods _all_ close;

      %let framenumber=%eval(&framenumber+1);
      %let frame=%scan(&framelist,&framenumber);
    %end;
    %let rulenumber=%eval(&rulenumber+1);
    %let rule=%scan(&rulelist,&rulenumber);
  %end;
%mend chgrf;

/* List the RULE= values you want to test separated by a space     */
/* List the FRAME= values you want to test separated by a space    */
/* This macro call does 6 different reports using the combinations */
/* of the values in RULELIST and FRAMELIST                         */
%chgrf(RULELIST=NONE ALL, FRAMELIST=VOID ABOVE BOX)


/* Figure 14.24 */
title;
footnote;

ODS HTML BODY='ReportParts_14_25.html';
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
proc freq data=hr;
  tables department / nocum;
run;
ODS HTML CLOSE;



/* Figure 14.25 */
title;
footnote;

proc template;
  define style styles.decorative;
    parent=styles.default;
    class Table / rules=all frame=box
      borderspacing=5 borderwidth=5 bordercolor=black
      bordertopstyle=dotted  borderbottomstyle=dotted
      borderrightstyle=dotted  borderleftstyle=dotted;
    class Header / background=gray foreground=white
                   font_face='Courier New'
      bordertopstyle=dashed borderbottomstyle=dashed
      borderrightstyle=dashed borderleftstyle=dashed;
    class Data / background=white foreground=black
      bordertopstyle=dotted borderbottomstyle=dotted
      borderrightstyle=dotted borderleftstyle=dotted;
  end;
run;

ODS HTML(id=1) BODY='DeptSalaries_14_26.html' STYLE=styles.decorative;
ODS RTF(id=2) BODY='DeptSalaries_14_26.rtf' STYLE=styles.decorative;
ODS PDF(id=3) BODY='DeptSalaries_14_26.pdf' STYLE=styles.decorative;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;

ODS _ALL_ CLOSE;


/* Figure 14.26, 14.27, 14.28 */
title;
footnote;

proc template;
  define style styles.manyparts;
    parent=styles.default;
    class Table / rules=all
                  frame=box
                  borderspacing=0
                  borderwidth=2
                  cellpadding=1
                  bordercolor=yellow;
    class Header / background=gray
                   foreground=white
                   font_face='Courier New';
    class RowHeader / background=black
                      foreground=white;
    class Data / background=white
                 foreground=black;
  end;
run;

ODS NOPROCTITLE;

ODS HTML(id=1) BODY='DataCells_14_28a.html';
ODS HTML(id=2) BODY='DataCells_14_28b.html' style=styles.manyparts;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML(id=1) CLOSE;
proc freq data=hr;
  tables department / nocum;
run;
ODS HTML(id=2) CLOSE;

ODS PROCTITLE;


/* Figure 14.29 */
title;
footnote;

proc template;
  define style styles.addimage;
  parent=styles.default;
  class Body / preimage= 'LH.gif';
  class Table / postimage='draft.gif';
  end;
run;
ODS NOPROCTITLE;
ODS HTML BODY='TwoImages_14_30.html' style=styles.addimage;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 14.30 */
title;
footnote;

proc template;
  define style styles.watermark;
  parent=styles.default;
  class Body /
      backgroundimage = 'LH.gif'
      watermark=on;
  end;
run;
ODS NOPROCTITLE;
ODS HTML BODY='Watermark_14_31.html' style=styles.watermark;
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 14.31, 14.32 */
title;
footnote;

proc template;
  define style styles.fmttitle;
    parent=styles.default;
    class SystemTitle / font_size=24pt;
    class SystemTitle2 / font_size=22pt;
    class SystemTitle3 / font_size=20pt;
    class SystemTitle4 / font_size=18pt;
    class SystemTitle5 / font_size=16pt;
    class SystemTitle6 / font_size=14pt;
    class SystemTitle7 / font_size=12pt;
    class SystemTitle8 / font_size=10pt;
    class SystemTitle9 / font_size=8pt;
    class SystemTitle10 / font_size=6pt;
    class SystemFooter from SystemTitle /;
    class SystemFooter2 from SystemTitle2 /;
    class SystemFooter3 from SystemTitle3/;
    class SystemFooter4 from SystemTitle4 /;
    class SystemFooter5 from SystemTitle5 /;
    class SystemFooter6 from SystemTitle6 /;
    class SystemFooter7 from SystemTitle7 /;
    class SystemFooter8 from SystemTitle8 /;
    class SystemFooter9 from SystemTitle9 /;
    class SystemFooter10 from SystemTitle10 /;
  end;
run;

ODS NOPROCTITLE;
ODS HTML BODY='TitlesFootnotes_14_33.html' style=styles.fmttitle;
title1 "This is Title 1";
title2 "This is Title 2";
title3 "This is Title 3";
title4 "This is Title 4";
title5 "This is Title 5";
title6 "This is Title 6";
title7 "This is Title 7";
title8 "This is Title 8";
title9 "This is Title 9";
title10 "This is Title 10";
footnote1 "This is Footnote 1";
footnote2 "This is Footnote 2";
footnote3 "This is Footnote 3";
footnote4 "This is Footnote 4";
footnote5 "This is Footnote 5";
footnote6 "This is Footnote 6";
footnote7 "This is Footnote 7";
footnote8 "This is Footnote 8";
footnote9 "This is Footnote 9";
footnote10 "This is Footnote 10";
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 14.33 */
title;
footnote;

proc template;
  define style styles.nofoot;
    parent=styles.default;
    class SystemTitle / font_size=24pt;
    class SystemTitle2 / font_size=22pt;
    class SystemTitle3 / font_size=20pt;
    class SystemTitle4 / font_size=18pt;
    class SystemTitle5 / font_size=16pt;
    class SystemTitle6 / font_size=14pt;
    class SystemTitle7 / font_size=12pt;
    class SystemTitle8 / font_size=10pt;
    class SystemTitle9 / font_size=8pt;
    class SystemTitle10 / font_size=6pt;
  end;
run;

ODS NOPROCTITLE;
ODS HTML BODY='TitlesFootnotes_14_34.html' style=styles.nofoot;
title1 "This is Title 1";
title2 "This is Title 2";
title3 "This is Title 3";
title4 "This is Title 4";
title5 "This is Title 5";
title6 "This is Title 6";
title7 "This is Title 7";
title8 "This is Title 8";
title9 "This is Title 9";
title10 "This is Title 10";
footnote1 "This is Footnote 1";
footnote2 "This is Footnote 2";
footnote3 "This is Footnote 3";
footnote4 "This is Footnote 4";
footnote5 "This is Footnote 5";
footnote6 "This is Footnote 6";
footnote7 "This is Footnote 7";
footnote8 "This is Footnote 8";
footnote9 "This is Footnote 9";
footnote10 "This is Footnote 10";
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 14.34 */
title;
footnote;

proc template;
  define style styles.nofoot;
    parent=styles.default;
    class SystemTitle / preimage='LH.gif'
                        just=left font_size=24pt;
    style SystemTitle2 / preimage=_undef_
                         just=center
                         font_size=22pt;

    class SystemTitle3 / font_size=20pt;
    class SystemTitle4 / font_size=18pt;
    class SystemTitle5 / font_size=16pt;
    class SystemTitle6 / font_size=14pt;
    class SystemTitle7 / font_size=12pt;
    class SystemTitle8 / font_size=10pt;
    class SystemTitle9 / font_size=8pt;
    class SystemTitle10 / font_size=6pt;
  end;
run;

ODS NOPROCTITLE;
ODS HTML BODY='TitlesFootnotes_14_34.html' style=styles.nofoot;
title1;
title2 "This is Title 2";
title3 "This is Title 3";
title4 "This is Title 4";
title5 "This is Title 5";
title6 "This is Title 6";
title7 "This is Title 7";
title8 "This is Title 8";
title9 "This is Title 9";
title10 "This is Title 10";
footnote1 "This is Footnote 1";
footnote2 "This is Footnote 2";
footnote3 "This is Footnote 3";
footnote4 "This is Footnote 4";
footnote5 "This is Footnote 5";
footnote6 "This is Footnote 6";
footnote7 "This is Footnote 7";
footnote8 "This is Footnote 8";
footnote9 "This is Footnote 9";
footnote10 "This is Footnote 10";
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 14.35 */
title;
footnote;

ODS NOPROCTITLE;
ODS HTML BODY='DefaultHTML_14_36a.html';
ODS PDF BODY='DefaultPDF_14_36a.pdf';
proc means data=hr n mean min median max maxdec=2;
  class department;
  var annualsalary;
run;
ODS HTML CLOSE;
ODS PDF CLOSE;
ODS PROCTITLE;

/******************************************************************************/
/* End Chapter 14                                                             */
/******************************************************************************/

/******************************************************************************/
/* Start Chapter 15 - Modifying Output Fonts                                  */
/******************************************************************************/

/* Figure 15.1, 15.2 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE DefaultSmaller;
     PARENT=Styles.Default;
     class fonts /
         'TitleFont2'=("Arial, Helvetica, Helv",3,Bold Italic)
         'TitleFont'=("Arial, Helvetica, Helv",4,Bold Italic)
         'StrongFont'=("Arial, Helvetica, Helv",3,Bold)
         'EmphasisFont'=("Arial, Helvetica, Helv",2,Italic)
         'FixedEmphasisFont'=("Courier",1,Italic)
         'FixedStrongFont'=("Courier",1,Bold)
         'FixedHeadingFont'=("Courier",1)
         'BatchFixedFont'=("SAS Monospace, Courier",1)
         'FixedFont'=("Courier",1)
         'headingEmphasisFont'=("Arial,Helvetica,Helv",3,Bold Italic)
         'headingFont'=("Arial, Helvetica, Helv",3,Bold)
         'docFont'=("Arial, Helvetica, Helv",2);
   END;
RUN;



ODS NOPROCTITLE;
ODS HTML(id=1) BODY='DefaultHTML_15_1.html' style=styles.default;
ODS HTML(id=2) BODY='SmallerHTML_15_2.html' style=defaultsmaller;
proc freq data=positions;
  title "This wordy title does not fit on one line with STYLES.DEFAULT";
  tables department;
run;
ODS HTML CLOSE;
ODS PROCTITLE;



/* Figure 15.4, 15.5 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE PrinterSmaller;
      PARENT=Styles.Printer;
   class fonts /
      'TitleFont2' = ("Times",10pt,Bold Italic)
      'TitleFont' = ("Times",11pt,Bold Italic)
      'StrongFont' = ("Times",8pt,Bold)
      'EmphasisFont' = ("Times",8pt,Italic)
      'FixedEmphasisFont' = ("Courier New, Courier",7pt,Italic)
      'FixedStrongFont' = ("Courier New, Courier",7pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",7pt,Bold)
      'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",6pt)
      'FixedFont' = ("Courier New, Courier",7pt)
      'headingEmphasisFont' = ("Times",9pt,Bold Italic)
      'headingFont' = ("Times",9pt,Bold)
      'docFont' = ("Times",8pt);
   END;
RUN;
ODS NOPROCTITLE;
ODS PDF(id=1) file='DefaultPDF_15_4.pdf' style=styles.printer;
ODS PDF(id=2) file='SmallerPDF_15_5.pdf' style=printersmaller;
proc freq data=positions;
  tables department;
run;
ODS _ALL_ CLOSE;
ODS PROCTITLE;



/* Figure 15.7, 15.8 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE RTFSmaller;
     PARENT=Styles.RTF;
     class fonts /
      'TitleFont2' = ("Times",10pt,Bold Italic)
      'TitleFont' = ("Times",11pt,Bold Italic)
      'StrongFont' = ("Times",8pt,Bold)
      'EmphasisFont' = ("Times",8pt,Italic)
      'FixedEmphasisFont' = ("Courier New, Courier",7pt,Italic)
      'FixedStrongFont' = ("Courier New, Courier",7pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",7pt,Bold)
      'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",6pt)
      'FixedFont' = ("Courier New, Courier",7pt)
      'headingEmphasisFont' = ("Times",9pt,Bold Italic)
      'headingFont' = ("Times",9pt,Bold)
      'docFont' = ("Times",8pt);
   END;
RUN;
ODS NOPROCTITLE;
ODS RTF(id=1) file='DefaultRTF_15_7.rtf' style=styles.rtf;
ODS RTF(id=2) file='SmallerRTF_15_8.rtf' style=rtfsmaller;
proc freq data=positions;
  tables department;
run;
ODS _ALL_ CLOSE;
ODS PROCTITLE;


/* Figure 15.9 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE DefaultNewFonts;
    PARENT=Styles.Default;
    CLASS fonts /
    'TitleFont2' = ("Algerian",4,Bold Italic)
    'TitleFont' = ("Brittanic Bold",5,Bold Italic)
    'StrongFont' = ("Comic Sans MS",4,Bold)
    'EmphasisFont' = ("Desdemona",3,Italic)
    'FixedEmphasisFont' = ("Lucida Typewriter",2,Italic)
    'FixedStrongFont' = ("Letter Gothic MT",2,Bold)
    'FixedHeadingFont' = ("QuickType Mono",2)
    'BatchFixedFont' = ("SAS Monospace",2)
    'FixedFont' = ("Courier New",2)
    'headingEmphasisFont' = ("Eras Demi ITC",4,Bold Italic)
    'headingFont' = ("Franklin Gothic Medium",4,Bold)
    'docFont' = ("Goudy Old Style",3);
  END;
RUN;

ODS HTML frame='ManyFonts_15_9_frame.html'
         contents='ManyFonts_15_9_contents.html'
         body='ManyFonts_15_9_body.html' style=defaultnewfonts;
proc glm data=positions;
  class grade position;
  model salary=grade position;
  means grade;
run;
ODS HTML CLOSE;



/* Figure 15.12, 15.13*/
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE RTFNoItalics;
      PARENT=Styles.RTF;
   class fonts /
      'TitleFont2' = ("Times",12pt,Bold)
      'TitleFont' = ("Times",13pt,Bold)
      'StrongFont' = ("Times",10pt,Bold)
      'EmphasisFont' = ("Times",10pt)
      'FixedEmphasisFont' = ("Courier New, Courier",9pt)
      'FixedStrongFont' = ("Courier New, Courier",9pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",9pt,Bold)
      'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",6.7pt)
      'FixedFont' = ("Courier New, Courier",9pt)
      'headingEmphasisFont' = ("Times",11pt,Bold)
      'headingFont' = ("Times",11pt,Bold)
      'docFont' = ("Times",10pt);
   END;
RUN;


ODS RTF(id=1) file='DefaultRTF_15_12.rtf' style=styles.rtf;
ODS RTF(id=2) file='NoItalicsRTF_15_13.rtf' style=rtfnoitalics;
proc freq data=positions;
  title "Frequencies in Data Set POSITIONS";
  tables grade;
run;
ODS _ALL_ CLOSE;



/* Figure 15.15 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE DefaultNewFonts2;
      PARENT=Styles.Default;
      CLASS fonts /
        'TitleFont2' = ("Arial, Helvetica, Helv",4,Bold Italic)
        'TitleFont' = ("Arial, Helvetica, Helv",5,Bold Italic)
        'StrongFont' = ("Arial, Helvetica, Helv",4,Bold)
        'EmphasisFont' = ("Arial, Helvetica, Helv",3,Italic)
        'FixedEmphasisFont' = ("Courier",2,Italic)
        'FixedStrongFont' = ("Courier",2,Bold)
        'FixedHeadingFont' = ("Courier",2)
        'BatchFixedFont' = ("SAS Monospace, Courier",2)
        'FixedFont' = ("Courier",2)
        'headingEmphasisFont' = ("Arial,Helvetica,Helv",4,Bold Italic)
        'headingFont' = ("Arial, Helvetica, Helv",4,Bold)
        'docFont' = ("Arial, Helvetica, Helv",3)
        'FootnoteFont'= ("Arial, Helvetica, Helv", 1, Italic);
     CLASS SystemFooter  /
       font = Fonts('FootnoteFont');
  end;
run;


ODS HTML file='FootnoteFonts_15_15.html' style=defaultnewfonts2;
proc means data=positions n mean min median max maxdec=2;
  title "Salary Statistics for Each Department";
  footnote "Data Set: POSITIONS";
  footnote2 "Data Set Last Updated: 30JUN2010";
  class department;
  var salary;
run;
ODS HTML CLOSE;



/* Figure 15.16, 15.17 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE RTFFixed;
    PARENT=Styles.RTF;
  REPLACE fonts /
    'TitleFont2' = ("Times",12pt,Bold Italic)
    'TitleFont' = ("Times",13pt,Bold Italic)
    'StrongFont' = ("Times",10pt,Bold)
    'EmphasisFont' = ("Times",10pt,Italic)
    'FixedEmphasisFont' = ("Courier New, Courier",9pt,Italic)
    'FixedStrongFont' = ("Courier New, Courier",9pt,Bold)
    'FixedHeadingFont' = ("Courier New, Courier",9pt,Bold)
    'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",12pt, Bold)
    'FixedFont' = ("Courier New, Courier",9pt)
    'headingEmphasisFont' = ("Times",11pt,Bold Italic)
    'headingFont' = ("Times",11pt,Bold)
    'docFont' = ("Times",10pt);
  END;
RUN;

ODS RTF(1) FILE='ExpChart_15_16.rtf';
ODS RTF(2) FILE='ExpChart_15_17.rtf' style=rtffixed;
proc chart data=positions;
  vbar grade / axis=0 to 300 by 100;
run;
ODS _ALL_ CLOSE;




/******************************************************************************/
/* End Chapter 15                                                             */
/******************************************************************************/


/******************************************************************************/
/* Start Chapter 16 - Modifying Output Structure                              */
/******************************************************************************/

/* Figure 16.1 */
title;
footnote;

ODS HTML FILE='DefaultStats_16_1.html' STYLE=styles.default;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS HTML CLOSE;

/* Figure 16.2 */
title;
footnote;

ODS HTML FILE='ThreeDStats_16_2.html' STYLE=styles.d3d;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS HTML CLOSE;



/* Figure 16.4 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE WiderBorder;
      PARENT=Styles.Default;
      CLASS Output /
         bordercollapse=separate
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 10;
   END;
RUN;

ODS HTML FILE='WiderBorder_16_4.html' STYLE=widerborder;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS HTML CLOSE;

/* Figure 16.5 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule;
      PARENT=Styles.Default;
      CLASS Output /
         background = colors('tablebg')
         rules = NONE
         frame = BOX
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;
ODS HTML FILE='NoBorder_16_5.html' STYLE=defaultnoborderrule;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS HTML CLOSE;


/* Figure 16.6 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule2;
      PARENT=Styles.Default;
      CLASS Output  /
         background = colors('tablebg')
         rules = NONE
         frame = VOID
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;
ODS HTML FILE='NoBorder_16_6.html' STYLE=defaultnoborderrule2;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS HTML CLOSE;

/* Figure 16.7 */
title;
footnote;

PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule3;
      PARENT=Styles.Default;
      CLASS Output /
         background = colors('tablebg')
         rules = NONE
         frame = VOID
         cellpadding = 7
         cellspacing = 0
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;
ODS HTML FILE='NoBorder_16_7.html' STYLE=defaultnoborderrule3;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS HTML CLOSE;



/* Figure 16.9 */
title;
footnote;

ODS PDF FILE='DefaultPtr_16_9.pdf';
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS PDF CLOSE;


/* Figure 16.10 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE PrinterNoBorder;
    PARENT=Styles.Printer;
    CLASS Table  /
         rules = NONE
         frame = VOID
         cellpadding = 4pt
         cellspacing = 0
         borderwidth = 1;
   END;
RUN;
ODS PDF FILE='NoBorderPtr_16_10.pdf' style=printernoborder;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class type;
  var costsqft;
run;
ODS PDF CLOSE;



/* Figure 16.11 */
title;
footnote;

ODS HTML FILE='DefaultSpacing_16_11.html' STYLE=styles.default;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class height;
  var costsqft;
run;
ODS HTML CLOSE;

/* Figure 16.12 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE DefaultSqueeze;
    PARENT=Styles.Default;
    CLASS Output /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 3
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
  END;
RUN;
ODS HTML FILE='Squeezed_16_12.html' STYLE=defaultsqueeze;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class height;
  var costsqft;
run;
ODS HTML CLOSE;


/* Figure 16.13 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE DefaultStretch;
    PARENT=Styles.Default;
    CLASS Output /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 10
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
  END;
RUN;
ODS HTML FILE='Stretched_16_13.html' STYLE=defaultstretch;
proc means data=buildings maxdec=2 n nonobs mean std min max;
  class height;
  var costsqft;
run;
ODS HTML CLOSE;


/* Figure 16.14 */
title;
footnote;

ODS HTML PATH='.' (url=none)
         FILE='TOCFreqs_16_14.html'
         FRAME='TOCFreqsframe_16_14.html'
         CONTENTS='TOCFreqsTOC_16_14.html'
         STYLE=DEFAULT;
ODS PROCLABEL=' ';
proc freq data=buildings;
  tables material;
run;
ODS HTML CLOSE;


/* Figure 16.15 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE NoBullet;
    PARENT=STYLES.DEFAULT;
    CLASS ContentProcName  /
       BULLET=NONE;
  END;
RUN;
ODS HTML PATH='.' (url=none)
         FILE='TOCFreqs_16_15.html'
         FRAME='TOCFreqsframe_16_15.html'
         CONTENTS='TOCFreqsTOC_16_15.html'
         STYLE=nobullet;
ODS PROCLABEL=' ';
proc freq data=buildings;
  tables material;
run;
ODS HTML CLOSE;



/* Figure 16.16 */
title;
footnote;

ODS HTML BODY='CostStats_16_16.html'
         FRAME='CostStatsframe_16_16.html'
         CONTENTS='CostStatsTOC_16_16.html';
proc univariate data=buildings;
  var costsqft;
run;
ODS HTML CLOSE;


/* Figure 16.17 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE FixedWidth;
    PARENT=STYLES.DEFAULT;
    CLASS Table / outputwidth=400;
    CLASS Frame /
         contentposition = L
         bodyscrollbar = auto
         bodysize = *
         contentscrollbar = auto
         contentsize = 200
         framespacing = 1
         frameborderwidth = 4
         frameborder = on;
  END;
RUN;

ODS HTML BODY='CostStats_16_17.html'
         FRAME='CostStatsframe_16_17.html'
         CONTENTS='CostStatsTOC_16_17.html'
         STYLE=FixedWidth;
proc univariate data=buildings;
  var costsqft;
run;
ODS HTML CLOSE;





/* Figure 16.18 */
title;
footnote;
ODS RTF FILE='Margins_16_18.rtf';
proc means data=clips maxdec=2;
run;
ODS RTF CLOSE;


/* Figure 16.19 */
title;
footnote;
PROC TEMPLATE;
   DEFINE STYLE RtfMargins;
      PARENT = Styles.RTF;
      STYLE BODY FROM BODY /
         BOTTOMMARGIN = .5in
         TOPMARGIN = .5in
         RIGHTMARGIN = .5in
         LEFTMARGIN = .5in;
   END;
RUN;
ODS RTF FILE='Margins_16_19.rtf';
proc means data=clips maxdec=2;
run;
ODS RTF CLOSE;

/* Figure 16.20 */
title;
footnote;
PROC TEMPLATE;
   DEFINE STYLE RtfMargins;
      PARENT = Styles.RTF;
      STYLE BODY FROM BODY /
         BOTTOMMARGIN = _undef_
         TOPMARGIN = _undef_
         RIGHTMARGIN = _undef_
         LEFTMARGIN = _undef_;
   END;
RUN;
OPTIONS LEFTMARGIN=1in RIGHTMARGIN=1in TOPMARGIN=1.5in BOTTOMMARGIN=1in;
ODS RTF FILE='Margins_16_20.rtf';
proc means data=clips maxdec=2;
run;
ODS RTF CLOSE;

/* Figure 16.21, 16.22, 16.23, 16.24 */
title;
footnote;

ODS PATH WORK.TEMPLAT(UPDATE) SASHELP.TMPLMST(READ);
PROC TEMPLATE;
  define style styles.looklist;
   parent=styles.printer;
    style fonts from fonts /
     'BatchFixedFont' = ("Courier",8pt)
     'TitleFont2' = ("Courier",8pt)
     'TitleFont' = ("Courier",8pt)
     'StrongFont' = ("Courier",8pt)
     'EmphasisFont' = ("Courier",8pt)
     'FixedEmphasisFont' = ("Courier",8pt)
     'FixedStrongFont' = ("Courier",8pt)
     'FixedHeadingFont' = ("Courier",8pt)
     'FixedFont' = ("Courier",8pt)
     'headingEmphasisFont' = ("Courier",8pt)
     'headingFont' = ("Courier",8pt)
     'docFont' = ("Courier",8pt);
    style table from output /
      cellpadding = 2pt
      cellspacing = 0pt
      background=white
      rules=groups
      frame=void;
    style color_list from color_list /
     'link' = black
     'bgH' = white
     'fg' = black
     'bg' = white;
 end;
RUN;

ODS LISTING;
ODS PDF FILE="LookList_16_21.pdf" STYLE=STYLES.LOOKLIST;
ODS RTF FILE="LookList_16_22.rtf" STYLE=STYLES.LOOKLIST;
ODS HTML FILE="LookList_16_23.html" STYLE=STYLES.LOOKLIST;

title 'Simulate Listing Look';
data _null_;
  set traffic(firstobs=1 obs=5);
  file print ods=(variables=(impact event location highway ));
  put _ods_;
run;
ODS _ALL_ CLOSE;

/* Figure 16.25 */
title;
footnote;

ODS PDF FILE='PTitle_16_25.pdf';
title 'Construction Materials';
proc freq data=Buildings;
    tables material*type / norow nocol nopercent;
run;
ODS PDF CLOSE;


/* Figure 16.26 */
title;
footnote;

ODS PDF FILE='NoProcedure_16_26.pdf';
ODS NOPTITLE;
title 'Construction Materials';
proc freq data=Buildings;
    tables material*type / norow nocol nopercent;
run;
ODS PDF CLOSE;
ODS PTITLE;

/******************************************************************************/
/* End Chapter 16                                                             */
/******************************************************************************/

/******************************************************************************/
/* Start Chapter 17 - Modifying Output Color and Graphics                     */
/******************************************************************************/

/* Figure 17.1, 17.2 */
title;
footnote;
proc template;
  source styles.default;
run;


/* Figure 17.3 */
title;
footnote;

ODS NOPROCTITLE;
ODS HTML FILE='DefColors_17_3.html';
proc freq data=paints;
  title "Paint Industry Statistics";
  tables base*type / norow nocol nopercent;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.4 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE ReverseColors;
  PARENT=Styles.Default;
  CLASS color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cxE0E0E0
      'bgA' = cx002288;
   END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='DefColors_17_4.html' STYLE=ReverseColors;
proc freq data=paints;
  title "Paint Industry Statistics";
  tables base*type / norow nocol nopercent;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 17.5 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE RevColorTitle;
  PARENT=Styles.Default;
  CLASS TitlesAndFooters /
      font = Fonts('TitleFont2')
      background = colors('systitlefg')
      foreground = colors('systitlebg');
   END;

RUN;
ODS NOPROCTITLE;
ODS HTML FILE='DefColors_17_5.html' STYLE=RevColorTitle;
proc freq data=paints;
  title "Paint Industry Statistics";
  tables base*type / norow nocol nopercent;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.6 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE GreenTitle;
  PARENT=Styles.Default;
  class color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cx00FF00
      'bgA' = cxE0E0E0;
   END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='DefColors_17_6.html' STYLE=GreenTitle;
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.7 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE GreenNameTitle;
  PARENT=Styles.Default;
  class color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = green
      'bgA' = cxE0E0E0;
   END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='DefColors_17_7.html' STYLE=GreenNameTitle;
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 17.9 */
title;
footnote;

ODS NOPROCTITLE;
ODS HTML FILE='DefBack_17_9.html';
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  class type;
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 17.10 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE WhiteBack;
  PARENT=Styles.Default;
  CLASS color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cx002288
      'bgA' = cxFFFFFF;
   END;
RUN;

ODS NOPROCTITLE;
ODS HTML FILE='WhiteBack_17_10.html' STYLE=whiteback;
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  class type;
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.11 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE AllWhiteBack;
  PARENT=Styles.Default;
  CLASS color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cxFFFFFF
      'bgA3' = cxFFFFFF
      'fgA2' = cx0033AA
      'bgA2' = cxFFFFFF
      'fgA1' = cx000000
      'bgA1' = cxFFFFFF
      'fgA' = cx002288
      'bgA' = cxFFFFFF;
   END;
RUN;

ODS NOPROCTITLE;
ODS HTML FILE='AllWhiteBack_17_11.html' STYLE=allwhiteback;
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  class type;
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 17.12 */
title;
footnote;

ODS NOPROCTITLE;
ODS HTML FILE='DefColors_17_12.html';
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  class type;
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 17.13 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE DefaultLogoColors;
  PARENT=Styles.Default;
  CLASS color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxFFFF33
      'fgA2' = cx336600
      'bgA2' = cxFFCC00
      'fgA1' = cx003300
      'bgA1' = cxFFFF66
      'fgA' = cx002288
      'bgA' = cxE0E0E0;
   END;
RUN;

ODS NOPROCTITLE;
ODS HTML FILE='LogoColors_17_13.html' STYLE=defaultlogocolors;
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  class type;
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.14 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE DefaultLogoColors2;
  PARENT=Styles.Default;
  CLASS color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxFFFF33
      'fgA2' = cx336600
      'bgA2' = cxFFCC00
      'fgA1' = cx003300
      'bgA1' = cxFFFF66
      'fgA' = cx336600
      'bgA' = cxFFFF66;
   END;
RUN;

ODS NOPROCTITLE;
ODS HTML FILE='LogoColors_17_14.html' STYLE=defaultlogocolors2;
proc means data=paints n mean std min max maxdec=1;
  title "Paint Industry Statistics";
  class type;
  var warranty;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.15 */
title;
footnote;

ODS NOPROCTITLE;
ODS SELECT BASICMEASURES;
ODS HTML FILE='DefFootnote_17_15.html';
proc univariate data=paints;
  title "Paint Industry Statistics";
  footnote "Current Month Sales";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.16 */
title;
footnote;


PROC TEMPLATE;
  DEFINE STYLE DefaultPurpleFN;
  PARENT=Styles.Default;

   class color_list
      "Colors used in the default style" /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cx002288
      'bgA' = cxE0E0E0
      'fgNew'= cx660066;
   class colors
      "Abstract colors used in the default style" /
      'headerfgemph' = color_list('fgA2')
      'headerbgemph' = color_list('bgA2')
      'headerfgstrong' = color_list('fgA2')
      'headerbgstrong' = color_list('bgA2')
      'headerfg' = color_list('fgA2')
      'headerbg' = color_list('bgA2')
      'datafgemph' = color_list('fgA1')
      'databgemph' = color_list('bgA3')
      'datafgstrong' = color_list('fgA1')
      'databgstrong' = color_list('bgA3')
      'datafg' = color_list('fgA1')
      'databg' = color_list('bgA3')
      'batchfg' = color_list('fgA1')
      'batchbg' = color_list('bgA3')
      'tableborder' = color_list('fgA1')
      'tablebg' = color_list('bgA1')
      'notefg' = color_list('fgA')
      'notebg' = color_list('bgA')
      'bylinefg' = color_list('fgA2')
      'bylinebg' = color_list('bgA2')
      'captionfg' = color_list('fgA1')
      'captionbg' = color_list('bgA')
      'proctitlefg' = color_list('fgA')
      'proctitlebg' = color_list('bgA')
      'titlefg' = color_list('fgA')
      'titlebg' = color_list('bgA')
      'systitlefg' = color_list('fgA')
      'systitlebg' = color_list('bgA')
      'Conentryfg' = color_list('fgA2')
      'Confolderfg' = color_list('fgA')
      'Contitlefg' = color_list('fgA')
      'link2' = color_list('fgB2')
      'link1' = color_list('fgB1')
      'contentfg' = color_list('fgA2')
      'contentbg' = color_list('bgA2')
      'docfg' = color_list('fgA')
      'docbg' = color_list('bgA')
      'footnotefg' = color_list('fgNew');
  CLASS SystemFooter /
      font = Fonts('TitleFont')
      foreground = colors('footnotefg');
   END;
RUN;


ODS NOPROCTITLE;
ODS SELECT BASICMEASURES;
ODS HTML FILE='PurpleFootnote_17_16.html' style=defaultpurplefn;
proc univariate data=paints;
  title "Paint Industry Statistics";
  footnote "Current Month Sales";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Alternate DEFAULTPURPLEFN */
PROC TEMPLATE;
  DEFINE STYLE DefaultPurpleFN;
  PARENT=Styles.Default;
  CLASS SystemFooter /
      font = Fonts('TitleFont')
      foreground = cx660066;
   END;
RUN;


/* Figure 17.17, 17.18, 17.19 */
title;
footnote;

ODS HTML FILE='hi_con_17_17.html' STYLE=HIGHCONTRAST;
ODS RTF FILE='jour_17_18.rtf' STYLE=JOURNAL;
ODS PDF FILE='monochr_17_19.pdf' STYLE=MONOCHROMEPRINTER;
proc corr data=paints;
  var price;
  with warranty;
run;
ODS _ALL_ CLOSE;


/* Figure 17.20 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE HCSerif;
  PARENT=Styles.HighContrast;
  CLASS fonts /
     'TitleFont2' = ("<MTserif>, Times Roman",4,bold italic)
     'TitleFont' = ("<MTserif>, Times Roman",5,bold italic)
     'StrongFont' = ("<MTserif>, Times Roman",4,bold)
     'EmphasisFont' = ("<MTserif>, Times Roman",3,italic)
     'FixedEmphasisFont' = ("<MTmonospace>, Courier",2,italic)
     'FixedStrongFont' = ("<MTmonospace>, Courier",2,bold)
     'FixedHeadingFont' = ("<MTmonospace>, Courier",2)
     'BatchFixedFont' = ("SAS Monospace, <MTmonospace>, Courier",2)
     'FixedFont' = ("<MTmonospace>, Courier",2)
     'headingEmphasisFont' = ("<MTserif>, Times Roman",4,bold italic)
     'headingFont' = ("<MTserif>, Times Roman",4,bold)
     'docFont' = ("<MTserif>, Times Roman",3);
   END;
RUN;

ODS HTML FILE='HCSerif_17_20.html' STYLE=HCSERIF;
ODS RTF FILE='HCSerif_17_20.rtf' STYLE=HCSERIF;
ODS PDF FILE='HCSerif_17_20.pdf' STYLE=HCSERIF;
proc corr data=paints;
  var price;
  with warranty;
run;
ODS _ALL_ CLOSE;

** Bonus: Other Black and White Styles;
ODS HTML FILE='minimal.html' STYLE=MINIMAL;
ODS RTF FILE='journal2.rtf' STYLE=JOURNAL2;
ODS PDF FILE='grayscaleprinter.pdf' STYLE=GRAYSCALEPRINTER;
proc corr data=paints;
  var price;
  with warranty;
run;
ODS _ALL_ CLOSE;



/* Figure 17.21 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE CorpLogo;
  PARENT=Styles.Default;
  CLASS Body /
      preimage="corporatelogo.gif";
   END;
RUN;

ODS NOPROCTITLE;
ODS HTML FILE='CorpLogo_17_21.html' style=corplogo;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;



/* Figure 17.22 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE CorpLogoJournal;
    PARENT=Styles.Journal;
    CLASS Body /
      preimage="corporatelogo.gif";
    CLASS SystemTitle /
      foreground = cx990000;
  END;
RUN;

ODS NOPROCTITLE;
ODS HTML FILE='CorpLogoJ_17_22.html' style=corplogojournal;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.23 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE CorpLogo2;
  PARENT=Styles.Default;
  CLASS Body /
     prehtml='<table width=100%><tr><td nowrap align=left>
        <img border="0" src="corporatelogo.gif">
        <font face="Arial" size=3><b>SprayTech Corp.</b></font>
        </tr></td></table>';
  END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='CorpLogo_17_23.html' style=corplogo2;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.24 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE CorpLogoBG;
  PARENT=Styles.Default;
  CLASS Body /
      backgroundimage="corporatelogobg.gif";
  END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='CorpLogo_17_24.html' style=corplogobg;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;



/* Figure 17.25 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE CorpLogoBG2;
  PARENT=Styles.Default;
  CLASS Body /
      prehtml='<table width=100%><tr><td nowrap align=left>
         <font face="Arial" size=5><b>SprayTech Corp.</b></font>
         </tr></td></table>'
      backgroundimage='corporatelogobg.gif';
   CLASS Container /
      font = Fonts('DocFont')
      foreground = colors('docfg');
   CLASS TitlesAndFooters /
      font = Fonts('TitleFont2')
      foreground = colors('systitlefg');
   END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='CorpLogo_17_25.html' style=corplogobg2;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;

/* Figure 17.26 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE CorpLogoMin;
  PARENT=Styles.Minimal;
  CLASS Body /
      prehtml='<table width=100%><tr><td nowrap align=left>
         <font face="Arial" size=5><b>SprayTech Corp.</b></font>
         </tr></td></table>'
      backgroundimage='corporatelogobg.gif';
   END;
RUN;
ODS NOPROCTITLE;
ODS HTML FILE='CorpLogo_17_26.html' style=corplogomin;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS HTML CLOSE;
ODS PROCTITLE;


/* Figure 17.27 */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE RTFImage;
     PARENT=Styles.RTF;
     CLASS Body /
        preimage="corporatelogo.jpg";
  END;
RUN;

ODS NOPROCTITLE;
ODS RTF FILE='CorpLogoTemp_17_27.rtf' style=rtfimage;
proc print data=paints(obs=100);
run;
ODS RTF CLOSE;
ods proctitle;


/* Figure 17.28  */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE RTFImageLeft;
     PARENT=Styles.RTF;
     CLASS Body  /
        preimage="corporatelogo.jpg"
        just=left;
  END;
RUN;

ODS NOPROCTITLE;
ODS RTF FILE='CorpLogoTemp_17_28.rtf' style=rtfimageleft;
proc print data=paints(obs=100);
run;
ODS RTF CLOSE;
ods proctitle;

/* Figure 17.29  */
title;
footnote;

PROC TEMPLATE;
  DEFINE STYLE RTFImageRepeat;
     PARENT=Styles.RTF;
     CLASS SystemTitle /
        preimage="corporatelogo.jpg"
        just=left;
  END;
RUN;

title " ";
ODS NOPROCTITLE;
ODS RTF FILE='CorpLogoTemp_17_29.rtf' style=rtfimagerepeat;
proc print data=paints(obs=100);
run;
ODS RTF CLOSE;
ods proctitle;


/* Figure 17.30  */
title;
footnote;

proc template;
   define style PrinterLogo;
   parent=styles.printer;
   CLASS body /
      preimage='corporatelogo.jpg';
   end;
run;


ODS NOPROCTITLE;
ODS PDF FILE="CorpLogoPtr_17_30.pdf"
      style=PrinterLogo;
*ODS PRINTER style=PrinterLogo;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS PDF CLOSE;
*ODS PRINTER CLOSE;
ODS PROCTITLE;


/* Figure 17.31  */
title;
footnote;

proc template;
   define style PrinterLogo;
   parent=styles.printer;
   CLASS body /
      preimage='corporatelogo.jpg';
   end;
run;

ODS NOPROCTITLE;
ODS PDF FILE="CorpLogoPtr_17_31.pdf"
      style=PrinterLogo STARTPAGE=NO;
*ODS PRINTER STYLE=PrinterLogo STARTPAGE=NO;
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report";
  var price;
run;
ODS PDF CLOSE;
ODS PDF STARTPAGE=YES;
*ODS PRINTER CLOSE;
*ODS PRINTER STARTPAGE=YES;
ODS PROCTITLE;



/* Figure 17.32  */
title;
footnote;

ODS NOPROCTITLE;
ODS ESCAPECHAR='^';
*ODS PRINTER;
ODS PDF FILE="CorpLogoPtr_17_32.pdf";
proc means data=paints n mean std min max maxdec=2;
  title "October Price Report" justify=right
        "^{style[preimage='corporatelogo.jpg']}";
  var price;
run;
ODS PDF CLOSE;
*ODS PRINTER CLOSE;
ODS PROCTITLE;



/******************************************************************************/
/* End Chapter 17                                                             */
/******************************************************************************/


/******************************************************************************/
/* Start Chapter 18 - Doing More with Styles and ODS                          */
/******************************************************************************/

/* Figure 18.1, 18.2, 18.3 */
title;
footnote;

ODS HTML FILE='Out_18_1.HTML' CSSSTYLE='corp.css';
ODS PDF  FILE='Out_18_2.PDF'  CSSSTYLE='corp.css';
ODS RTF  FILE='Out_18_3.RTF'  CSSSTYLE='corp.css';
title 'Using Corporate CSS file';
proc print data=billings(obs=10);
  var CustomerName JobType Hours;
run;
ODS _ALL_ CLOSE;



/* Figure 18.4, 18.5, 18.6 */
title;
footnote;

ODS PATH work.tmp(update) sashelp.tmplmst(read);

PROC TEMPLATE;
  define style styles.newcorp;
    parent=styles.printer;
    import 'corp.css';
  end;
RUN;

ODS HTML FILE='usecorp_18_4.HTML' STYLE=styles.newcorp;
ODS PDF  FILE='usecorp_18_5.PDF'  STYLE=styles.newcorp;
ODS RTF  FILE='usecorp_18_6.RTF'  STYLE=styles.newcorp;
title 'Using Corporate Style Template NEWCORP';
proc print data=billings(obs=5);
  var CustomerName JobType Hours;
run;
ODS _ALL_ CLOSE;


/* Figure 18.7, 18.8, 18.9, */
/*        18.10, 18.11, 18.12 */
title;
footnote;

ODS HTML(id=1) FILE='mediacss_18_7.HTML' cssstyle='use_media.css';
ODS HTML(id=2) FILE='mediacss_18_8.HTML' cssstyle='use_media.css' (print);
ODS RTF(id=3)  FILE='mediacss_18_9.RTF' cssstyle='use_media.css';
ODS RTF(id=4)  FILE='mediacss_18_10.RTF' cssstyle='use_media.css' (print);
ODS PDF(id=5)  FILE='mediacss_18_11.PDF'  cssstyle='use_media.css';
ODS PDF(id=6)  FILE='mediacss_18_12.PDF' cssstyle='use_media.css' (print);
title "CSSSTYLE USE_MEDIA with @MEDIA Section";
proc print data=billings(obs=5);
  var CustomerName JobType Hours;
run;
ODS _ALL_ CLOSE;




/* Figure 18.13 */
title;
footnote;

options nocenter;
ODS NOPROCTITLE;
ODS HTML BODY='use_two_css_18_13.html'
    STYLESHEET=(URL='sasweb.css fractals.css');
proc means data=clinical mean std maxdec=2;
  title "Using Two CSS Files -- SASWEB.CSS and FRACTALS.CSS";
  class gender;
  var chgsbp chgdbp;
run;
ODS HTML CLOSE;
ODS PROCTITLE;
options center;


/* Figure 18.15 */
title;
footnote;

options nocenter;
ODS NOPROCTITLE;
ODS HTML BODY='use_css_selector_18_15.html'
    STYLESHEET=(URL='sasweb.css fractals.css');
proc print data=clinical(obs=5) noobs label
  style(table)={just=left};
  title 'Using Two CSS Files -- SASWEB.CSS and FRACTALS CSS';
  var tx / style(header)={HTMLCLASS="MyHeader"};
  var basedbp basesbp chgdbp chgsbp;
  var age / style(header)={HTMLCLASS="MyHeader"};
run;
ODS HTML CLOSE;
ODS PROCTITLE;
options center;


/* Before Figure 18.16 */
title;
footnote;
proc print data=projected_billing;
run;


/* Figure 18.16 */
title;
footnote;

proc template;
  define style styles.projbill_colors;
    parent=styles.sasweb;
    class Hilite /
             background=yellow
             font_weight=bold
             foreground=black;
    class Hooray from Data/
             background=cyan
             font_weight=bold
             foreground=black;
  end;
run;
proc template;
  define table projbill_table;
    column Division BillAmt;
    dynamic treatcol;
    header RepHdr;
    define RepHdr;
      text '/Projected Billing Report';
    end;
    define Division;
      style=Header;
    end;
    define BillAmt;
      define header BillHdr;
        text _LABEL_;
        style=Header;
      end;
      generic=on;
      format=dollar14.2;
      header=BillHdr;
      style=treatcol;
    end;
  end;
run;

ODS LISTING CLOSE;
ODS RTF FILE='Special_Style_18_16.rtf' STYLE=styles.projbill_colors;
ODS PDF FILE='Special_Style_18_16.pdf' STYLE=styles.projbill_colors;
ODS HTML FILE='Special_Style_18_16.html' STYLE=styles.projbill_colors;
title 'Using Custom Table and Style Template';
data _null_;
  set work.projected_billing;
  file print ods=(template='projbill_table'
           columns=(Division
                    BillAmt=BillableAmt_Base(generic=on
                    dynamic=(treatcol='Hilite'))
                    BillAmt=Grow_At_05(generic=on
                    dynamic=(treatcol='Data'))
                    BillAmt=Grow_At_25(generic=on
                    dynamic=(treatcol='Hooray'))));
  put _ods_;
  label Grow_At_05 = 'Growth at 5%'
        Grow_At_10 = 'Growth at 10%'
        Grow_At_25 = 'Growth at 25%'
        Grow_At_50 = 'Growth at 50%'
        BillableAmt_Base = 'Baseline (Actual)';
run;
ODS _ALL_  CLOSE;
ODS LISTING;



/* Figure 18.17 */
title;
footnote;

proc template;
  define style Styles.smaller;
    parent = styles.Printer;
    class fonts /
      'TitleFont2' = ("Times",10pt,Bold Italic)
      'TitleFont' = ("Times",11pt,Bold Italic)
      'StrongFont' = ("Times",8pt,Bold)
      'EmphasisFont' = ("Times",8pt,Italic)
      'FixedEmphasisFont' = ("Courier New, Courier",7pt,Italic)
      'FixedStrongFont' = ("Courier New, Courier",7pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",7pt,Bold)
      'BatchFixedFont' = ("SAS Monospace, Courier New, Courier",5pt)
      'FixedFont' = ("Courier New, Courier",7pt)
      'headingEmphasisFont' = ("Times",9pt,Bold Italic)
      'headingFont' = ("Times",9pt,Bold)
      'docFont' = ("Times",8pt);
    class Table /
      rules = ALL
      cellpadding = 2pt
      cellspacing = 0;
  end;
run;

ods pdf(1) file='standard_18_17.pdf';
ods pdf(2) file='smaller_18_17.pdf' style=styles.smaller;
proc print data=clinical label;
  title "Making Smaller Files";
  var tx basedbp basesbp chgdbp chgsbp age ;
run;
ods _all_ close;


/* Figure 18.18 */
title;
footnote;
proc template;
   define style PrinterLogo;
   parent=styles.printer;
   style body from body /
      preimage='c:\books\ods\logo.jpg';
   end;
run;

ODS PDF FILE="EditionSales_18_18.pdf"
      style=PrinterLogo startpage=no;
proc tabulate data=gallery;
  class limited;
  var sales price;
  table limited, sales*sum*f=comma6. price*sum*f=dollar12.;
run;
ODS _ALL_ CLOSE;

/* Figure 18.19 */
title;
footnote;

proc template;
   define style PrinterLogo2;
   parent=styles.printer;
   class SystemTitle /
      just=r
      preimage='c:\books\ods\logo.jpg';
   end;
run;

ODS PDF FILE="EditionSales_18_19.pdf"
      style=PrinterLogo2 startpage=no;
proc tabulate data=gallery;
  title ' ';
  class limited;
  var sales price;
  table limited, sales*sum*f=comma6. price*sum*f=dollar12.;
run;
ODS _ALL_ CLOSE;


/* Output 18.20 */
title;
footnote;

/*  This template should NOT be used for HTML or PDF output. */
proc template;
  define style styles.usefc;
  parent=styles.rtf;
    class systemfooter  /
       protectspecialchars=off
       pretext='\brdrt\brdrs\brdrw1 ';
    class systemfooter2, systemfooter3, systemfooter4/
       pretext=_undef_;
  end;
run;


ODS RTF FILE='Payroll_Title_18_20.rtf' style=styles.usefc;
ODS ESCAPECHAR='^';
title "Payroll Report";

footnote j=l "Footnote 1";
footnote2 "This is \ul footnote2 \ul0 with underlining.";
footnote3 "This is footnote3.";
footnote4 "This is footnote4.";

proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Figure 18.21, 18.22 */
**a) Restablish the entire path;
ODS PATH work.mytemp(update) sashelp.tmplmst(read);
ODS PATH SHOW;

** b) Reset the path;
ODS PATH RESET;
ODS PATH SHOW;

** c) Prepending an item store;
ODS PATH(PREPEND) work.pretemp(update);
ODS PATH SHOW;

** d) Appending an item store;
ODS PATH(APPEND) work.apptemp(update);
ODS PATH SHOW;

** e) Removing an item store;
ODS PATH(REMOVE) work.apptemp(update);
ODS PATH SHOW;

** f) Reset the path;
ODS PATH RESET;
ODS PATH SHOW;


/* Figure 18.23 */
title;
footnote;


** Chapter 18 Testing for a style that exists;
%let choice=analysis;
%let itm = notfound;
%let usestyle=sasweb;
%let ilib=;
%let imem=;

proc sql;
  select libname, memname, style into :ilib, :imem, :usestyle
  from dictionary.styles
  where upcase(style) contains "%upcase(&choice)";
quit;

%let itm = %sysfunc(compress(&ilib..&imem));
%let usestyle=&usestyle;
%put itm is &itm and usestyle is &usestyle;

options symbolgen;
ODS HTML FILE='teststyle.html' STYLE=&usestyle;
proc print data=billings;
run;
ODS HTML CLOSE;

options nosymbolgen;


/* Figure 18.24 */
title;
footnote;


** Chapter 18 Testing for a style that does not exist;
%let choice=notastyle;
%let itm = notfound;
%let usestyle=sasweb;
%let ilib=;
%let imem=;

proc sql;
  select libname, memname, style into :ilib, :imem, :usestyle
  from dictionary.styles
  where upcase(style) contains "%upcase(&choice)";
quit;

%let itm = %sysfunc(compress(&ilib..&imem));
%let usestyle=&usestyle;
%put itm is &itm and usestyle is &usestyle;

options symbolgen;
ODS HTML FILE='teststyle.html' STYLE=&usestyle;
proc print data=billings;
run;
ODS HTML CLOSE;

options nosymbolgen;



/******************************************************************************/
/* End Chapter 18                                                             */
/******************************************************************************/


/********************************************************************************/
/* Start Chapter 19 - Special Cases: The REPORT, TABULATE, and PRINT Procedures */
/********************************************************************************/

/* Figure 19.1 */
title;
footnote;

ODS HTML BODY='furniture_19_1.html' STYLE=sasweb;
proc report data=furniture nowd;
  title "Retail Stock Report";
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.2 */
title;
footnote;

ODS HTML BODY='furniture2_19_2.html' STYLE=sasweb;
proc report data=furniture nowd
      STYLE(Header)=[FONT_FACE='Times New Roman' background=gray];
  title "Retail Stock Report";
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML CLOSE;


/* Figure 19.3 */
title;
footnote;

ODS HTML BODY='stock3_19_3.html' STYLE=sasweb;
proc report dafta=furniture nowd;
  title "Retail Stock Report";
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.
     STYLE(Column)=[BACKGROUND=cxDDDDDD];
run;
ODS HTML CLOSE;

/* Figure 19.4 */
title;
footnote;

ODS HTML BODY='stock4.html' STYLE=sasweb;
proc report data=furniture nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.
      STYLE(Column)=[BACKGROUND=cxDDDDDD];
      STYLE(Column)=[BACKGROUND=cx336699];
run;
ODS HTML CLOSE;



/* Figure 19.5 */
title;
footnote;

ODS HTML BODY='stock4_19_5.htm' STYLE=sasweb;
proc report data=furniture nowd;
  title "Retail Stock Report";
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute Material;
    count+1;
    if (mod(count,2)) then do;
      CALL DEFINE(_ROW_, "STYLE", "STYLE=[BACKGROUND=cxDDDDDD]");
    end;
  endcomp;
run;
ODS HTML CLOSE;



/* Figure 19.6 */
title;
footnote;

ODS HTML BODY='stock4_19_6.htm' STYLE=sasweb;
proc report data=furniture nowd;
  title "Retail Stock Report";
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute Material;
    count+1;
    if (mod(count,2)=0) then do;
      CALL DEFINE(_ROW_, "STYLE", "STYLE=[BACKGROUND=cxDDDDDD]");
    end;
  endcomp;
run;
ODS HTML CLOSE;


/* Figure 19.7 */
title;
footnote;

ODS HTML BODY='detailstock_19_7.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  break after Type / summarize;
  rbreak after / summarize;
run;
ODS HTML CLOSE;

/* Figure 19.8 */
title;
footnote;

ODS HTML BODY='detailstock2_19_8.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  break after Type / summarize STYLE=[VJUST=T CELLHEIGHT=50
                                      FONT_WEIGHT=Bold];
  rbreak after / summarize STYLE=[FONT_WEIGHT=Bold];
run;
ODS HTML CLOSE;


/* Figure 19.9 */
title;
footnote;

ODS HTML BODY='trafficstock_19_9.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute Price;
    if Price.mean <= 100 then
       CALL DEFINE(_COL_,"STYLE",
            "STYLE=[FOREGROUND=cx006633 FONT_WEIGHT=Bold]");
    else if Price.mean >= 300 then
       CALL DEFINE(_COL_,"STYLE",
            "STYLE=[FOREGROUND=cxCC0000 FONT_WEIGHT=Bold]");
    else
       CALL DEFINE(_COL_,"STYLE",
            "STYLE=[FOREGROUND=cxFF9900 FONT_WEIGHT=Bold]");
  endcomp;
run;
ODS HTML CLOSE;

/* Figure 19.10 */
title;
footnote;

ODS HTML BODY='trafficstock2_19_10.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute Price;
    if Price.mean <= 100 then
       CALL DEFINE(_COL_,"STYLE",
            "STYLE=[BACKGROUND=cx00cc33 FONT_WEIGHT=Bold]");
    else if Price.mean >= 300 then
       CALL DEFINE(_COL_,"STYLE",
            "STYLE=[BACKGROUND=cxFF3300 FONT_WEIGHT=Bold]");
    else
       CALL DEFINE(_COL_,"STYLE",
            "STYLE=[BACKGROUND=cxFFFF66 FONT_WEIGHT=Bold]");
  endcomp;
run;
ODS HTML CLOSE;


/* Figure 19.11 */
title;
footnote;

ODS HTML BODY='graphic_19_11.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute before _page_ / LEFT;
    LINE "Totally Tables, Inc.";
  endcomp;
run;
ODS HTML CLOSE;

/* Figure 19.12 */
title;
footnote;

ODS HTML BODY='graphic2_19_12.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute before _page_ / LEFT
      STYLE=[PREIMAGE='dining.gif'
             FONT_WEIGHT=Bold FONT_SIZE=5 FOREGROUND=cx993300];
    LINE "Totally Tables, Inc.";
  endcomp;
run;
ODS HTML CLOSE;


/* Figure 19.13 */
title;
footnote;

ODS LISTING;
proc report data=furniture nowd out=totaltables;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML BODY='totalreport_19_13.html' STYLE=sasweb;
proc print data=totaltables;
run;
ODS HTML CLOSE;


/* Figure 19.14 */
title;
footnote;

ODS LISTING;
proc report data=furniture nowd out=totaltables2;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  break after Type / summarize;
  rbreak after / summarize;
run;
ODS HTML BODY='totalreport2_19_14.html' STYLE=sasweb;
proc print data=totaltables2;
run;
ODS HTML CLOSE;

/* Figure 19.15 */
title;
footnote;

ODS HTML BODY='stdcolumns_19_15.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  break after Type / summarize;
  rbreak after / summarize;
  compute before _page_ / LEFT style=Header;
    LINE "Totally Tables, Inc.";
  endcomp;
run;
ODS HTML CLOSE;

/* Figure 19.16 */
title;
footnote;

ODS HTML BODY='stdcolumns2_19_16.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  break after Type / summarize;
  rbreak after / summarize;
   compute before _page_ / left style(Header)=[cellwidth=7in];
    LINE "Totally Tables, Inc.";
  endcomp;
run;
ODS HTML CLOSE;


/* Figure 19.17 */
title;
footnote;

ODS HTML BODY='stdcolumns3_19_17.html' STYLE=sasweb;
proc report data=furniture nowd;
  column Type Material Price;
  define Type / group 'Table Type' style(column)=[cellwidth=.5in];
  define Material / group 'Construction' style(column)=[cellwidth=1in vjust=b];
  define Price / analysis mean 'Average Price' format=dollar8.
          style(column)=[cellwidth=.75in];
    break after Type / summarize;
  rbreak after / summarize;
  compute before _page_ / left style=Header;
    LINE "Totally Tables, Inc.";
  endcomp;
run;
ODS HTML CLOSE;


/* Figure 19.18 */
title;
footnote;

ODS HTML BODY='blanks_19_18.html' STYLE=sasweb;
proc report data=furniture nowd
          style(summary)=Header style(lines)=Header;
  column Type Material Price;
  define Type / group 'Table Type';
  define Material / group 'Construction';
  define Price / analysis mean 'Average Price' format=dollar8.;
  compute before _page_ / LEFT;
    LINE ' ';
    LINE "Totally Tables, Inc.";
  endcomp;
  break after Type / summarize;
  compute after Type ;
    LINE ' ';
  endcomp;
  rbreak after / summarize;
  compute after;
    LINE 'This is the End of the Report';
    LINE ' ';
  endcomp;
run;
ODS HTML CLOSE;

/* Figure 19.19, 19.20 */
title;
footnote;

ODS LISTING;
ODS HTML BODY='no_span_19_19.html' style=sasweb;
proc report data=furniture nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML CLOSE;



/* Figure 19.21 */
title;
footnote;

ODS HTML BODY='span_19_21.html' style=sasweb;
proc report data=furniture spanrows nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML CLOSE;


/* Figure 19.22 */
title;
footnote;

ODS HTML BODY='tabstock_19_22.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;


/* Figure 19.23 */
title;
footnote;

ODS HTML BODY='tabstock2_19_23.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material / STYLE=[FONT_FACE="Times New Roman"];
  var Price / STYLE=[FONT_FACE="Times New Roman"];
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;


/* Figure 19.24 */
title;
footnote;

ODS HTML BODY='tabbox_19_24.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.
        / Box='Retail Stock Report';
run;
ODS HTML CLOSE;

/* Figure 19.25 */
title;
footnote;

ODS HTML BODY='tabbox2_19_25.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.
        / Box=[LABEL='Retail Stock Report' STYLE=[JUST=L]];
run;
ODS HTML CLOSE;


/* Figure 19.26 */
title;
footnote;

ODS HTML BODY='tabback_19_26.html' STYLE=sasweb;
proc tabulate data=furniture STYLE=[BACKGROUND=cxDDDDDD];
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.27 */
title;
footnote;

ODS HTML BODY='tabback2_19_27.html' STYLE=sasweb;
proc tabulate data=furniture
              STYLE=[BACKGROUND=cxDDDDDD FONT_WEIGHT=bold];
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.28 */
title;
footnote;

proc format;
   value $typecol 'Dining'='cxBBBBBB'
                   other='cxDDDDDD';
run;
ODS HTML BODY='tabrows_19_28.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  classlev Type / STYLE=[BACKGROUND=$typecol.];
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.29 */
title;
footnote;

proc format;
   value $typecol 'Dining'='cxBBBBBB'
                   other='cxDDDDDD';
run;
ODS HTML BODY='tabrows_19_29.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  classlev Type / STYLE=[BACKGROUND=$typecol.];
  classlev Material / STYLE=<parent>;
  var Price;
  table Type='Table Type'*
        Material='Construction'*[STYLE=<parent>],
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;


/* Figure 19.30 */
title;
footnote;

ODS HTML BODY='totals_19_30.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        (Material='Construction' ALL)
        ALL,
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.31 */
title;
footnote;

ODS HTML BODY='totals2_19_31.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        (Material='Construction' ALL*[STYLE=[FONT_WEIGHT=bold]])
        ALL*[STYLE=[FONT_WEIGHT=bold]],
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;


/* Figure 19.32 */
title;
footnote;

proc format;
   value traffic low-100='cx006600'
                 100<-300='cxFF9900'
                 300<-high='cxCC0000';
run;
ODS HTML BODY='tabtraffic_19_32.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.*
        [STYLE=[FOREGROUND=traffic. FONT_WEIGHT=bold]];
run;
ODS HTML CLOSE;

/* Figure 19.33 */
title;
footnote;

proc format;
   value traffic low-100=' cx00CC33'
                 100<-300='cxFFFF66'
                 300<-high='cxFF3300';
run;
ODS HTML BODY='tabtraffic_19_33.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.*
        [STYLE=[BACKGROUND=traffic. FONT_WEIGHT=bold]];
run;
ODS HTML CLOSE;


/* Figure 19.34 */
title;
footnote;

ODS HTML BODY='tabpic_19_34.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.
        / BOX=[LABEL='Totally Tables, Inc.'
               STYLE=[PREIMAGE='dining.gif']];
run;
ODS HTML CLOSE;


/* Figure 19.35 */
title;
footnote;

ODS HTML BODY='tabpic2_19_35.html' STYLE=sasweb;
proc tabulate data=furniture;
   class Type Material;
   var Price / STYLE=[VJUST=B];
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.
         / BOX=[LABEL='Totally Tables, Inc.'
                STYLE=[PREIMAGE='dining.gif']];
run;
ODS HTML CLOSE;


/* Figure 19.36 */
title;
footnote;

proc tabulate data=furniture OUT=totaltables;
  class Type Material;
  var Price;
  table Type='Table Type'*
        Material='Construction',
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML BODY='tabtotals_19_36.html' STYLE=sasweb;
proc print data=totaltables; run;
ODS HTML CLOSE;

/* Figure 19.37 */
title;
footnote;

proc tabulate data=furniture OUT=totaltables2;
  class Type Material;
  var Price;
  table Type='Table Type'*
        (Material='Construction' ALL) ALL,
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML BODY='tabtotals2_19_37.html' STYLE=sasweb;
proc print data=totaltables2; run;
ODS HTML CLOSE;


/* Figure 19.38 */
title;
footnote;

ODS HTML FILE='tabwidth_19_38.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
  table Type='Table Type'*
        (Material='Construction' ALL) ALL,
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.39 */
title;
footnote;

ODS HTML FILE='tabwidth2_19_39.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type / style=[cellwidth=.5in];
  class Material/ style=[width=1in];
  var Price;
  table Type='Table Type'*
        (Material='Construction' ALL) ALL,
        Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

/* Figure 19.40 */
title;
footnote;

ODS HTML FILE='tabwidth3_19_40.html' STYLE=sasweb;
proc tabulate data=furniture;
  class Type Material;
  var Price;
   table Type='Table Type'*
         (Material='Construction' ALL) ALL,
         Price='Average Price'*Mean=" "*f=dollar8. /
         style=[outputwidth=100%];
run;
ODS HTML CLOSE;


/* Figure 19.41 */
title;
footnote;

ODS HTML FILE='listfurniture_19_41.html' STYLE=sasweb;
proc print data=furniture(obs=5) noobs label;
  title "Retail Stock Report";
  var Type Material Price;
run;
ODS HTML CLOSE;

/* Figure 19.42 */
title;
footnote;

ODS HTML BODY='listfurniture2_19_42.html' STYLE=sasweb;
proc print data=furniture(obs=5) noobs label
                       STYLE(Header)=[FONT_FACE='Times New Roman'];
  title "Retail Stock Report";
  var Type Material Price;
run;
ODS HTML CLOSE;



/* Figure 19.43 */
title;
footnote;

ODS HTML BODY='listfurniture3_19_43.html' STYLE=sasweb;
proc print data=furniture(obs=5) noobs label;
  title "Retail Stock Report";
  var Type Material;
  var Price / STYLE=[BACKGROUND=cxDDDDDD];
run;
ODS HTML CLOSE;

/* Figure 19.44 */
title;
footnote;

ODS HTML BODY='listfurniture4_19_44.html' STYLE=sasweb;
proc print data=furniture(obs=5) noobs label;
  title "Retail Stock Report";
  var Type Material;
  var Price / STYLE(Data)=[BACKGROUND=cxDDDDDD];
run;
ODS HTML CLOSE;


/* Figure 19.45 */
title;
footnote;

ODS HTML BODY='prttotals_19_45.html' STYLE=sasweb;
proc print data=furniture noobs label;
  var Type Material Price;
  sum Price;
run;
ODS HTML CLOSE;

/* Figure 19.46 */
title;
footnote;

ODS HTML BODY='prttotals2_19_46.html' STYLE=sasweb;
proc print data=furniture noobs label;
  var Type Material Price;
  sum Price / Style(grandtotal)=[VJUST=C CELLHEIGHT=50 COLOR=BLACK];
run;
ODS HTML CLOSE;

/* Figure 19.47, 19.48 */
title;
footnote;

ODS PDF FILE='margin_indent_19_47a.pdf';
ODS RTF FILE='margin_indent_19_47b.rtf';
ODS HTML BODY='margin_indent_19_48.html' STYLE=sasweb;

proc report data=furniture nowd;
  column type type=fmttyp material price price=avpr price=mxpr;
  define type / group 'Furniture Table Type' style(column)={leftmargin=.25in};
  define fmttyp / group 'Type With Format';
  define material / group 'Material';
  define price / min 'Min Price' f=10.2;
  define avpr / mean 'Avg Price' f=10.2;
  define mxpr / max 'Max Price' f=10.2;
  rbreak after / summarize;
run;
ODS _ALL_ CLOSE;




/* Figure 19.49, 19.50, 19.51 */
title;
footnote;


proc format ;
  value $typ 'Coffee' = '^{style[leftmargin=.25in]}Coffee'
             'Dining' = '^{style[leftmargin=.25in]}Dining'
             'End' = '^{style[leftmargin=.25in]}End';
  value $mat 'Glass/Metal' = '^{style[leftmargin=.25in]}Glass/Metal'
             'Wood' = '^{style[leftmargin=.25in]}Wood';
run;

ODS PDF FILE='margin_indent_19_49.pdf';
ODS RTF FILE='margin_indent_19_50.rtf';
ODS HTML BODY='margin_indent_19_51.html' STYLE=sasweb;

ODS ESCAPECHAR='^';

proc report data=furniture nowd;
  column type type=fmttyp material price price=avpr price=mxpr;
  define type / group 'Furniture Table Type' style(column)={leftmargin=.25in};
  define fmttyp / group 'Type With Format' f=$typ.;
  define material / group 'Material' f=$mat.;
  define price / min 'Min Price' f=10.2;
  define avpr / mean 'Avg Price' f=10.2;
  define mxpr / max 'Max Price' f=10.2;
  rbreak after / summarize;
run;

proc tabulate data=furniture f=10.2;
  class type material;
  classlev type material;
  var price;
  table type*material,
        price*(min mean max);
  format type $typ. material $mat.;
run;

ODS _ALL_ CLOSE;

/********************************************************************************/
/* End Chapter 19 - Special Cases: The REPORT, TABULATE, and PRINT Procedures   */
/********************************************************************************/

/******************************************************************************/
/* Start Chapter 20 - Understanding ODS Graphics Output                       */
/******************************************************************************/
/* Figure 20.1 */
title;
footnote;
options nodate nonumber center;

goptions reset=all;

options gstyle;
ods listing style=ocean;

proc gchart data=CandyBars;
  vbar Filling / sumvar=Sales name='out20_1';
run;
quit;

/* Figure 20.2 */
title;
footnote;
options nodate nonumber center;

goptions reset=all;

options nogstyle;
ODS LISTING;

proc gchart data=CandyBars;
  vbar Filling / sumvar=Sales name='out20_2';
run;
quit;


/* Figure 20.3, 20.4, 20.5, 20.6 */
title;
footnote;

ODS LISTING STYLE=ocean;
ODS HTML PATH='.' (URL=NONE)
                         FILE='MovieStats.HTML' STYLE=ANALYSIS;
ODS GRAPHICS ON;
ODS SELECT BasicMeasures PPPlot;
proc univariate data=movieplots;
  var ticketssold;
  ppplot;
run;

ODS SELECT BoxPlot;
proc anova data = movieplots;
  class Theme;
  model ticketssold = Theme;
run; quit;

ODS SELECT FitStatistics FitPlot;
proc reg data = movieplots;
  model ticketssold = concessions;
run;
quit;

ODS GRAPHICS OFF;
ODS _ALL_ CLOSE;


/* Figure 20.8, 20.9 */
title;
footnote;

ODS HTML PATH='.' (URL=NONE)
         FILE='SalesPlots_20_7.html' STYLE=EGDEFAULT;

proc sgplot data=movieplots;
  title "PROC SGPLOT Output";
  vbox ticketssold / category=year;
run;

proc sgpanel data=movieplots;
  title "PROC SGPANEL Output";
  panelby theme;
  vbox ticketssold / category=year;
run;
ODS _ALL_ CLOSE;


/* Figure 20.10 */
title;
footnote;

ODS LISTING CLOSE;

ods path work.mvtemp(update)
         sasuser.templat(update)
         sashelp.tmplmst(read);

proc template;
  define statgraph compare;
    begingraph;
      layout gridded / columns=2;
        layout overlay /
             xaxisopts=(label="Theme")
             yaxisopts=(label="Sales")
             cycleattrs=true;
             barchart x=theme y=Sales ;
        endlayout;
        layout overlay /
             xaxisopts=(label="Theme")
             yaxisopts=(label="Concessions")
             cycleattrs=true;
             barchart x=theme y=Concessions ;
        endlayout;
      endlayout;
    endgraph;
  end;
run;

proc sort data=movieplots;
  by year;
run;
ODS HTML PATH='.' (URL=NONE)
         FILE='ThemeStats_20_10.html' STYLE=styles.egdefault;
proc sgrender data=movieplots template=compare;
  by year;
run;
ODS HTML CLOSE;
ODS LISTING;



/* Figure 20.11 */
title;
footnote;

ODS HTML PATH='.' (URL=NONE)
         BODY='Pies_20_11.html'
         STYLE=ANALYSIS;
GOPTIONS DEVICE=GIF BORDER;
OPTIONS GSTYLE;
title 'Pie Chart: Annual Sales by Flavor';
proc gchart data=PieStats;
  pie PieType / sumvar=Sales
                other=0
                midpoints='Blueberry' 'Apple' 'Cherry'
                          'Banana Creme' 'Pecan' 'Lemon Meringue'
                value=none
                percent=arrow
                slice=arrow
                noheading;
run; quit;
ODS HTML CLOSE;

/* Figure 20.12 */
title;
footnote;

ODS HTML PATH='.' (URL=NONE)
         BODY='Pies_20_12.html'
         STYLE=ANALYSIS;
GOPTIONS DEVICE=GIF BORDER;
OPTIONS NOGSTYLE;
title 'Pie Chart: Annual Sales by Flavor';
proc gchart data=PieStats;
  pie PieType / sumvar=Sales
                other=0
                midpoints='Blueberry' 'Apple' 'Cherry'
                          'Banana Creme' 'Pecan' 'Lemon Meringue'
                value=none
                percent=arrow
                slice=arrow
                noheading;
run; quit;
ODS HTML CLOSE;
OPTIONS GSTYLE;



/* Figure 20.13 */
title;
footnote;

ODS HTML PATH='.' (URL=NONE)
         BODY='Pies_20_13.html' NOGTITLE
         STYLE=ANALYSIS;

GOPTIONS DEVICE=GIF BORDER;
title 'Pie Chart: Annual Sales by Flavor';
proc gchart data=PieStats;
  pie PieType / sumvar=Sales
                other=0
                midpoints='Blueberry' 'Apple' 'Cherry'
                          'Banana Creme' 'Pecan' 'Lemon Meringue'
                cfill=gray
                value=none
                percent=arrow
                slice=arrow
                noheading;
run;
quit;
ODS HTML CLOSE;


/* Figure 20.14 */
title;
footnote;

OPTIONS GSTYLE;
GOPTIONS RESET=ALL;
ODS HTML PATH='.' (URL=NONE)
         BODY='Output_20_14.html' NOGTITLE
         STYLE=ANALYSIS ;
ODS RTF FILE='Output_20_14.rtf' STYLE=ANALYSIS ;
ODS PDF FILE='Output_20_14.pdf' STYLE=ANALYSIS ;
title 'Default Driver';
proc gchart data=CandyBars;
  vbar Filling / sumvar=Sales
                 name='DEF';
run;
quit;
ODS _ALL_ CLOSE;

/* Figure 20.15 */
title;
footnote;

OPTIONS GSTYLE;
GOPTIONS RESET=ALL;
ODS RTF FILE='Output_20_15.rtf' STYLE=ANALYSIS ;
ODS PDF FILE='Output_20_15.pdf' STYLE=ANALYSIS ;
GOPTIONS DEVICE=PNG;

title 'PNG Driver';
proc gchart data=CandyBars;
  vbar Filling / sumvar=Sales
                 name='PNG';
run;
quit;
ODS _ALL_ CLOSE;

/* Figure 20.16 */
title;
footnote;

OPTIONS GSTYLE;
GOPTIONS RESET=ALL;
ODS RTF FILE='Output_20_16.rtf' STYLE=ANALYSIS ;
ODS PDF FILE='Output_20_16.pdf' STYLE=ANALYSIS ;
GOPTIONS DEVICE=JPEG;

title 'JPEG Driver';
proc gchart data=CandyBars;
  vbar Filling / sumvar=Sales
                 name='JPEG';
run;
quit;
ODS _ALL_ CLOSE;


/* Figure 20.17 */
title;
footnote;

OPTIONS GSTYLE;
GOPTIONS RESET=ALL;
ODS HTML PATH='.' (URL=NONE)
         BODY='Output_20_17.html' NOGTITLE
         STYLE=ANALYSIS ;
ODS PDF FILE='Output_20_17.pdf' STYLE=ANALYSIS;
ODS RTF FILE='Output_20_17.rtf' STYLE=ANALYSIS ;
GOPTIONS DEVICE=ACTXIMG;

title 'ACTXIMG Driver';
proc gchart data=CandyBars;
  vbar Filling / sumvar=Sales
                  name='AXIMG';
run; quit;
ODS _ALL_ CLOSE;


/* Figure 20.18, 20.19 */
title;
footnote;

GOPTIONS RESET=ALL;
data PieStatsDrill;
  set PieStats;
  format rpt $40.;
  if PieType='Apple' then rpt='href="DrillDowns.html#pie1"';
  else if PieType='Banana Creme' then rpt='href="DrillDowns.html#pie2"';
  else if PieType='Blueberry' then rpt='href="DrillDowns.html#pie3"';
  else if PieType='Cherry' then rpt='href="DrillDowns.html#pie4"';
  else if PieType='Lemon Meringue' then rpt='href="DrillDowns.html#pie5"';
  else if PieType='Pecan' then rpt='href="DrillDowns.html#pie6"';
run;
proc sort data=PieStatsDrill;
  by PieType;
run;
ODS HTML BODY='DrillDowns.html' ANCHOR='pie1' STYLE=ANALYSIS;
proc means data=PieStatsDrill mean nonobs maxdec=0;
  by PieType;
  class year;
  var Sales;
run;
ODS HTML CLOSE;
ODS HTML BODY='PieDrill_20_18.html'
         STYLE=ANALYSIS;
title 'Pie Chart: Annual Sales by Flavor';
proc gchart data=PieStatsDrill;
   pie PieType / sumvar=sales
      percent=arrow slice=arrow value=none
      HTML=rpt;
run; quit;
ODS HTML CLOSE;


/* Figure 20.20, 20.21 */
title;
footnote;

ODS LISTING CLOSE;
GOPTIONS RESET=ALL;

ODS HTML PATH='.' (URL=NONE)
         BODY='JavaBar_20_20.html' NOGTITLE STYLE=ANALYSIS;
GOPTIONS DEVICE=JAVA;
title 'Candy Bar Chart';
title2 'Annual Sales by Type of Chocolate and Filling';
proc gchart data=CandyBars;
   vbar3d Filling / sumvar=Sales
                    group=Chocolate;
run;
quit;
ODS HTML CLOSE;
ODS LISTING;


/* Figure 20.22, 20.23 */
title;
footnote;

ODS LISTING CLOSE;
GOPTIONS RESET=ALL;
ODS HTML PATH='.' (URL=NONE)
         BODY='ActiveXBar_20_22.html' NOGTITLE
         STYLE=ANALYSIS;
GOPTIONS DEVICE=ACTIVEX;
title 'Candy Bar Chart';
title2 'Annual Sales by Type of Chocolate and Filling';
proc gchart data=CandyBars;
   vbar3d Filling / sumvar=Sales
                    group=Chocolate;
run; quit;
ODS HTML CLOSE;


/* Figure 20.24, 20.25 */
title;
footnote;

ODS LISTING CLOSE;
GOPTIONS RESET=ALL;

ODS RTF FILE='ActiveXPlot_20_24.rtf' STYLE=ANALYSIS;
GOPTIONS DEVICE=ACTIVEX;
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
  plot Theaters*TicketsSold=Theme;
run; quit;
ODS RTF CLOSE;
ODS LISTING;


/* Figure 20.26 */
title;
footnote;

GOPTIONS RESET=ALL;

GOPTIONS DEVICE=PNG XPIXELS=480 YPIXELS=360 GSFMODE=REPLACE;
title 'Candy Bar Chart';
title2 'Annual Sales by Chocolate Type and Filling';
proc gchart data=CandyBars GOUT=work.CandyBarChart;
   vbar3d Filling / name='SalesBar'
                    sumvar=Sales
                    group=Chocolate
                    raxis=0 to 12000000 by 2000000;
run;
quit;
title;
ODS HTML BODY='CandyBarReport_20_26.html'
         STYLE=ANALYSIS;
proc report data=CandyBars nowd;
   columns Chocolate Filling Sales;
   define Chocolate / group;
   define Filling / Group;
   define Sales / analysis sum format=dollar10.;
   compute before _page_ / center;
      call define( _ROW_, "GRSEG", "work.CandyBarChart.SalesBar" );
   endcomp;
run; quit;
ODS HTML CLOSE;


/******************************************************************************/
/* End Chapter 20 - Understanding ODS Graphics Output                         */
/******************************************************************************/


/******************************************************************************/
/* Start Appendix - Operating System Differences                              */
/******************************************************************************/

/* Windows Example */
ODS HTML FRAME="OSframe.html"
         BODY="OSbody.html"
         CONTENTS="OScontents.html"
         PATH="c:\temp\" (URL=NONE);

ODS RTF FILE="c:\temp\OSfile.rtf";

ODS PDF FILE="c:\temp\OSfile.pdf";
proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age / normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;



/* UNIX Example */
ODS HTML FRAME="OSframe.html"
         BODY="OSbody.html"
         CONTENTS="OScontents.html"
         PATH="/tmp" (URL=NONE);

ODS RTF FILE="/tmp/OSfile.rtf";

ODS PDF FILE="/tmp/OSfile.pdf";

proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age /normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;


/* z/OS Example */
filename odsout '.temp.html'
                  dsntype=library dsorg=po
                  disp=(new, catlg, delete);
ODS HTML FRAME="OSframe"
         BODY="OSbody" (URL="OSbody.html")
         CONTENTS="OSconten" (URL="OSconten.html")
         PATH=ODSOUT (URL=NONE)
         RECORD_SEPARATOR=NONE;
ODS RTF FILE=".temp.html(RTFfile)";
ODS PDF FILE=".temp.html(PDFfile)";
proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age /normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;

/* z/OS -- moving to ASCII */
filename ODSOUT ".temp.html"
         dsntype=library dsorg=po
         disp=(new, catlg, delete);
ODS HTML PATH=ODSOUT (URL=NONE)
         FRAME="OSframe"
         BODY="OSbody" (URL="OSbody.html")
         CONTENTS="OSconten" (URL="OSconten.html")
         TRANTAB=ASCII;

ODS RTF FILE=".temp.html(RTFfile)" TRANTAB=ASCII;
ODS PDF FILE=".temp.html(PDFfile)";
proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age /normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;

/* z/OS -- using HFS/UFS */
options filesystem='hfs';

filename odsout '/u/userid/temp_html';

ODS HTML PATH=ODSOUT (URL=NONE)
         FRAME="OSframe.HTML"
         BODY="OSbody.HTML"
         CONTENTS="OSconten.HTML";
ODS RTF BODY="/u/userid/temp_html/RTFfile.RTF";
ODS PDF FILE="/u/userid/temp_html/PDFfile.PDF";
proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age /normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;

/* z/OS -- using HFS/UFS -- moving to ASCII */
ODS HTML PATH=ODSOUT (URL=NONE)
         FRAME="OSframe.HTML"
         BODY="OSbody.HTML"
         CONTENTS="OSconten.HTML"
         TRANTAB=ASCII;
ODS RTF BODY="/u/userid/temp_html/RTFfile.RTF" TRANTAB=ASCII;
ODS PDF FILE="/u/userid/temp_html/PDFfile.PDF";
proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age /normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;


/* VMS Example */
filename odsout "device:[temp]";
ODS HTML FRAME="OSframe.html"
         BODY="OSbody.html"
         CONTENTS="OScontents.html"
         PATH=ODSOUT (URL=NONE);

ODS RTF FILE="device:[temp]OSfile.rtf";
ODS PDF FILE="device:[temp]OSfile.pdf";

proc univariate data=clinical;
   var Age;
   symbol value=star;
   probplot Age /normal(mu=est sigma=est) pctlminor;
run;
ODS _ALL_ CLOSE;

/******************************************************************************/
/* End Appendix - Operating System Differences                                */
/******************************************************************************/
