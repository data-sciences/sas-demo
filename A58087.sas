/*----------------------------------------------------------------------------*/
/*                                                                            */ 
/*                     Output Delivery System: The Basics                     */
/*                          By Lauren E. Haworth                              */
/*              Copyright (c) 2001 by SAS Institute Inc., Cary, NC, USA       */
/*                    SAS Publications Order Number 58087                     */
/*                         ISBN 1-58025-859-X                                 */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/*                                                                            */
/* This material is provided "as is" by SAS Institute Inc. There are no       */
/* warranties, expressed or implied, as to merchantability or fitness for     */
/* a particular purpose regarding the materials or code contained herein. The */
/* Institute is not responsible for errors in this material as it now exists  */
/* or will exist, nor does the Institute provide technical support for it.    */ 
/*                                                                            */
/*----------------------------------------------------------------------------*/                                                               /*                                                                            */
/* Date last updated: March 7, 2001                                           */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/*                                                                            */
/* Questions or problem reports concerning this material may be addressed to  */ 
/* the author:                                                                */
/*                                                                            */
/* SAS Institute Inc.                                                         */
/* Books by Users Press                                                       */
/* Attn: Lauren E. Haworth                                                    */
/* SAS Campus Drive                                                           */
/* Cary, NC 27513                                                             */
/*                                                                            */
/* If you prefer, you can send email to: sasbbu@sas.com                       */                                         
/* Use this for subject field:                                                */
/*              Comments for Lauren E. Haworth                                */
/*----------------------------------------------------------------------------*/                                                                            


/*----------------------------------------------------------------------------*/
/*                                                                            */
/* Note: Because of the nature of the topics in Chapter 2 and Chapter 6, the  */
/* author chose not to include code for those two chapters here.              */
/*                                                                            */
/*----------------------------------------------------------------------------*/

/* Chapter 1 - Why Use ODS? */

options nocenter nodate nonumber;
proc format;
    value prod 0='Kona'
                           1='Colombian'
                           2='French Roast'
                           3='Italian Roast'
                           4='Guatemalan'
                           5='Sumatran';
        value dept 0,1='Wholesale'
                           2,3,4='Internet'
                           5='Mail Order'
                           6='Retail';
        value emp  0='Smith'
                           1='Knight'
                           2='Haworth'
                           3='Jones'
                           4='Platt';
        value cust 0='Cuppa Coffee Co.'
                           1='Smith'
                           2='Jones'
                           3='Doe'
                           4='XYZ Assoc.';
run;
data sales;
  format ProductName prod. 
             Department dept. 
             EmployeeName emp. 
             SalesDate mmddyy10.
             CustomerName cust.
     ItemsSold 5.
     ItemPrice dollar8.2;
  label ProductName='Product'
        Department='Department'
            EmployeeName='Employee'
            SalesDate='Date of Sale'
            CustomerName='Customer'
            ItemsSold='Items Sold'
            ItemPrice='Item Price';
  do i=1 to 500;
   ProductName=floor(ranuni(12345)*6);
   Department=floor(ranuni(23456)*7);
   EmployeeName=floor(ranuni(34567)*5);
   SalesDate='1JAN1999'd+(floor(ranuni(45678)*750));
   CustomerName=floor(ranuni(56789)*5);
   ItemsSold=floor(50+(ranuni(67890)*500));
   ItemPrice=round(4+(5-ProductName)+((6-Department)/2)+(SalesDate/10000),.01);
   output;
  end;
run;

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

ods html file='c:\temp\ch1_1_body.htm'
         frame='c:\temp\ch1_1_frame.htm'
                 contents='c:\temp\ch1_1_contents.htm'
         style=CustomDefault;
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


ods rtf file='c:\temp\ch1_1.rtf';
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


ods pdf file='c:\temp\ch1_1.pdf';
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


/* Chapter 3 - HTML Output */

options nodate nocenter nonumber;
title; footnote;
ods listing close;

proc format;
    value div  0='Applications'
                           1='Analysis'
                           2='Reporting'
                           3='Systems'
                           4='Documentation'
                           5='QA';
        value typex 0,1='In-house'
                           2,3,4='Consulting'
                           5='Contract';
        value emp  0='Smith'
                           1='Knight'
                           2='Haworth'
                           3='Jones'
                           4='Platt';
        value cust 0='IPO.com'
                           1='Bricks and Mortar, Inc.'
                           2='Virtual Co.'
                           3='Sweat Shops Athletic'
                           4='Smith & Smith';
   value monthfmt 1='January'
                  2='February'
                                  3='March'
                                  4='April'
                                  5='May'
                                  6='June'
                                  7='July'
                                  8='August'
                                  9='September'
                                  10='October'
                                  11='November'
                                  12='December';
run;
data billings;
 format Division div. 
            JobType typex. 
            EmployeeName emp. 
            WorkDate mmddyy10.
            CustomerName cust.
            Hours 8.1
    BillableAmt dollar8.2;
 label Division='Division'
       JobType='Job Type'
           EmployeeName='Employee'
           WorkDate='Date Work Completed'
           CustomerName='Customer'
           Hours='Hours Worked'
           BillableAmt='Amount Billable'
   Quarter='Quarter';
 do i=1 to 500;
   Division=floor(ranuni(1357)*6);
   JobType=floor(ranuni(2468)*6);
   EmployeeName=floor(ranuni(3579)*5);
   WorkDate='1JAN1999'd+(floor(ranuni(4680)*750));
   CustomerName=floor(ranuni(5791)*5);
   Hours=1+round((ranuni(6802)*10),.5);
   BillableAmt=
     round((50*Hours)+(20-(Division*2))+(20-JobType)+(WorkDate/10000),.01);
   Quarter=put(workdate,yyqd6.);
   output;
 end;
run;
proc summary data=Billings nway;
   class EmployeeName;
   var BillableAmt;
   output out=Totals sum=;
run;

filename myfile 'myhtmlfile.html';
ODS HTML BODY=myfile;
proc means data=billings;
   class WorkDate;
   var Hours BillableAmt;
run;
ODS HTML CLOSE;

ODS HTML BODY='procmeans.html';
proc means data=billings nonobs maxdec=2 mean min max;
   var BillableAmt;
run;
ODS HTML CLOSE;

GOPTIONS DEVICE=GIF;
ODS HTML BODY='c:\temp\mygraph.html' GPATH='c:\temp' (URL=NONE); 
proc gchart data=Billings;
   vbar3d Quarter / 
      name="billqtr"
      sumvar=BillableAmt type=mean;
run; quit;
ODS HTML CLOSE;

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

title 'Quarterly Report';
ODS HTML BODY='body.html'
         CONTENTS='contents.html'
         FRAME='frame.html';
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

ODS HTML BODY='body1.html' NEWFILE=PROC
         CONTENTS='contents.html'
         FRAME='main.html'; 
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

ODS HTML BODY='body.html'
         CONTENTS='contents.html'
         FRAME='main.html'; 
ODS PROCLABEL 'Hours Billed by Customer';
title2 'Hours Billed by Customer';
proc means data=Billings nonobs mean sum;
    class CustomerName;
        var Hours;
run;
ODS HTML CLOSE;

ODS HTML BODY='body.html'
         CONTENTS='contents.html'
         FRAME='main.html'; 
ODS PROCLABEL ' ';
title2 'Hours Billed by Customer';
proc means data=Billings nonobs mean sum;
    class CustomerName;
        var Hours;
run;
ODS HTML CLOSE;

ODS HTML BODY='body.html'
         CONTENTS='contents.html'
         FRAME='main.html'; 
title2 'Hours Billed by Customer';
ODS PROCLABEL 'Hours Billed';
proc means data=Billings nonobs mean sum;
   class CustomerName;
        var Hours;
run;
title2 'Hours Billed by Division';
proc means data=Billings nonobs mean sum;
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


ODS HTML BODY='body.html'
         CONTENTS='contents.html'
         FRAME='main.html'; 
proc univariate data=Billings plots;
        var Hours;
run;
ODS HTML CLOSE;

ODS HTML BODY='body.html'; 
proc univariate data=Billings plots;
        var Hours;
run;
ODS HTML CLOSE;

ODS HTML BODY='overtime2.html'; 
title '<H1>Employees Billing Overtime</H1>';
footnote '<FONT SIZE=2>Overtime defined as >10 hours</FONT>';
proc print data=Billings noobs label;
   where Hours>8;
   label Hours='<I>Overtime Hours</I>';
   var WorkDate JobType Hours;
run;
ODS HTML CLOSE;

footnote;
data BillMonth; set Billings;
   format Month monthfmt.;
   Month=month(WorkDate);
   if hours>8 then Overtime=1; else Overtime=0;
run; 
ODS HTML BODY='avghours.html'; 
title 'Average Hours Billed';
proc report data=BillMonth nowd;
    where Month <=3;
        column Month JobType Hours;
        define Month / group order=internal;
        define JobType / group;
        define Hours / analysis mean format=10.1;
run;
ODS HTML CLOSE;

ODS HTML BODY='logistic.html'; 
title 'Logistic Regression Analysis: Overtime Hours';
proc logistic data=BillMonth;
        class JobType Division;
    model Overtime=JobType Division;
run;
ODS HTML CLOSE;


/* Chapter 4 - RTF Output */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value dept 0='Administration'
                           1='Marketing'
                           2='R&D'
                           3,4,5='Manufacturing';
        value typej 0,1='Hourly'
                           2,3,4='Salaried'
                           5='Contract';
   value salft  0-34999='<$35,000'
                35000-39999='$35,000-$39,999'
                40000-44999='$40,000-$44,999'
                45000-49999='$45,000-$49,999'
                50000-54999='$50,000-$54,999'
                55000-59999='$55,000-$59,999'
                60000-64999='$60,000-$64,999'
                65000-69999='$65,000-$69,999'
                70000-74999='$70,000-$74,999'
                75000-79999='$75,000-$79,999'
                80000-84999='$80,000-$84,999'
                85000-89999='$85,000-$89,999'
                90000-94999='$90,000-$94,999'
                95000-99999='$95,000-$99,999'
                100000-high='$100,000+';
run;
data hr;
        format Department dept. 
                   Category typej. 
                   AnnualSalary dollar8.
           HoursWeek 8.1;
        label Department='Department'
              Category='Position Category'
                  AnnualSalary='Annual Salary'
                  HoursWeek='Usual Weekly Hours';
        do i=1 to 397;
                Department=floor(ranuni(1357)*6);
                Category=floor(ranuni(2468)*6);
                HoursWeek=1+round((ranuni(6802)*39),.5);
                If HoursWeek>40 then HoursWeek=40;
                else if HoursWeek<12 then HoursWeek=12;
                AnnualSalary=ranuni(3579)*125000;
                AnnualSalary=floor(AnnualSalary*(HoursWeek/40));
                If AnnualSalary<30000 then AnnualSalary=30000;
                output;
        end;
run;

ODS RTF FILE='payroll.rtf';
title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;

ODS NOPTITLE;
ODS RTF FILE='SalaryWide.rtf';
title 'Salary Report';
proc freq data=hr;
   format AnnualSalary salft.;
   tables Department*AnnualSalary / norow nocol nopct;
run;
ODS RTF CLOSE;
ODS PTITLE;

ODS RTF FILE='SalaryTall.rtf';
title 'Salary Report';
proc freq data=hr;
   tables AnnualSalary / nopct nocum;
run;
ODS RTF CLOSE;

ODS RTF FILE='payroll2.rtf' BODYTITLE;
title 'Payroll Report';
proc means data=hr nonobs maxdec=0 mean sum;
   class Department;
   var AnnualSalary;
run;
ODS RTF CLOSE;


/* Chapter 5 - Printer Output */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value prod 0,1,2='Books'
                                3,4='CDs'
                                5='Videos';
        value locate 0,1='New York'
                                2,3,4='Boston'
                                5='Washington, D.C.';
        value comp      0='Damaged'
                                1='Not Delivered'
                                2='Wrong Product'
                                3='Not Satisfied'
                                4='Salesperson'
                                5='Price';
    value outc  0,1,2='Refund'
                3,4='Apology'
                5='Unresolved';
run;
data complaints;
        format Product prod. 
                   Complaint comp. 
                   Outcome outc.
           Location locate.;
        label Product='Type of Product'
              Complaint='Complaint Category'
                  Outcome='Outcome of Complaint'
                  Location='Store Location'
          Count='Number of Complaints'
          NumComplaints='Number of Complaints';
        do i=1 to 582;
                Count=1; 
                Product=floor(ranuni(1357)*6);
                Complaint=floor(ranuni(2468)*6);
                Outcome=floor(ranuni(8642)*6);
                Location=floor(ranuni(7531)*6);
        NumComplaints=floor(ranuni(34567)*8);
                output;
        end;
run;
data uniforms;
  format UniformType $80. Color $10.;
  label UniformType='Type of Uniform'
        Color='Color'
        Sales='Units Sold';
  do I=1 to 800;
     if I<200 then UniformType='Maid';
         else UniformType='Extremely Pretentious Doorman';
         sales=floor(ranuni(12345)*500);
         if sales>300 then color='Red';
         else if sales<100 then color='Green';
         else color='White';
         output;
  end;
run;
data damagedcds;
   set complaints;
   where product in(3,4) and complaint=1;
run;
proc summary data=complaints nway; 
   class location complaint product; 
   var count;
   output out=ComplaintSummary n=;
run;

ODS PRINTER;
title 'Monthly Complaint Summary';
proc freq data=complaints;
   tables location*outcome / norow nocol nopct;
run;
ODS PRINTER CLOSE;

ODS PRINTER FILE='DamagedCD.ps';
title 'Damaged CDs Report';
proc print data=DamagedCDs label noobs;
   id location;
   var outcome;
run;
ODS PRINTER CLOSE;

ODS PRINTER PS FILE='MySharedFile.ps';
title 'Damaged CDs Report';
proc print data=DamagedCDs label noobs;
   id location;
   var outcome;
run;
ODS PRINTER CLOSE;

ODS PRINTER COLOR=NO STYLE=DEFAULT;
title 'Damaged CDs Report';
proc print data=DamagedCDs label noobs;
   id location;
   var outcome;
run;
ODS PRINTER CLOSE;

ODS PRINTER NOCOLOR STYLE=DEFAULT;
title 'Damaged CDs Report';
proc print data=DamagedCDs label noobs;
   id location;
   var outcome;
run;
ODS PRINTER CLOSE;

OPTIONS NOCOLORPRINTING;
ODS PRINTER STYLE=DEFAULT;
title 'Damaged CDs Report';
proc print data=DamagedCDs label noobs;
   id location;
   var outcome;
run;
ODS PRINTER CLOSE;

OPTIONS COLORPRINTING;
ODS PRINTER STYLE=DEFAULT;
title 'Damaged CDs Report';
proc print data=DamagedCDs label noobs;
   id location;
   var outcome;
run;
ODS PRINTER CLOSE;

ODS PDF FILE='ComplaintReport.pdf';
proc report data=Complaints nowd;
   column Product Complaint Location NumComplaints;
   define Product / group order=formatted;
   define Complaint / group order=formatted;
   define Location / group order=formatted;
   define NumComplaints / analysis sum;
   break after Product / page summarize ;
run;
ODS PDF CLOSE;

title 'Analysis of Consumer Complaints';
ODS PDF FILE='ComplaintAnalysis.pdf';
proc rsreg data=Complaints;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

title 'Analysis of Consumer Complaints';
ODS PROCLABEL 'Analysis of Consumer Complaints';
ODS PDF FILE='ComplaintAnalysis.pdf';
proc rsreg data=Complaints;
   model NumComplaints=Product Location;
run;
ODS PDF CLOSE;

ODS PRINTER FILE='uniform1.ps' POSTSCRIPT;
proc print data=Uniforms label noobs;
   var UniformType Color Sales;
run;
ODS PRINTER CLOSE;

ODS PRINTER FILE='uniform2.ps' POSTSCRIPT UNIFORM;
proc print data=Uniforms label noobs;
   var UniformType Color Sales;
run;
ODS PRINTER CLOSE;


/* Chapter 7 - Output Data Sets */

**********************************************************
*                                                        *
* NOTE: THIS CODE IS DESIGNED TO PRODUCE ONE WARNING     *
*       MESSAGE AND ONE ERROR MESSAGE. THESE ILLUSTRATE  *
*       TWO COMMON PROBLEMS YOU MAY ENCOUNTER. SEE THE   *
*       CORRESPONDING EXAMPLES IN THE BOOK FOR AN        *
*       EXPLANATION                                  ;   *
*                                                        *
**********************************************************

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value hwy 0,1,2='80'
                                3,4='101'
                                5='280';
        value locate 0,1='East Bay'
                                2,3,4='San Francisco'
                                5='South Bay';
        value accid     0='Disabled'
                                1='Minor'
                                2='Injury'
                                3='Fatal';
    value outc  0-<25='Major Jam'
                25-<45='Slowdown'
                45-high='Unaffected';
run;
data traffic;
        format Highway hwy. 
                   Location locate. 
                   Event accid.;
        label Event='Type of Event'
                  Impact='Effect on Traffic'
          MPH='Average Speed'
                  TimeOfDay='Time (24 hour format)';
        do i=1 to 189;
                Highway=floor(ranuni(1357)*6);
                Location=floor(ranuni(2468)*6);
                Event=floor(ranuni(8642)*4);
                MPH=floor(ranuni(7531)*66);

                if highway in(3,4) and locate in(0,1) then locate=2;
                else if highway=5 then locate=2;

        TimeOfDay=floor(ranuni(8642)*25);
        If TimeOfDay in(6,7,8,15,16,17) then MPH=MPH/2;
                Impact=put(MPH,outc.);

                If event=3 then fatal=1; else fatal=0;

                output;
        end;
run;

ODS RTF FILE="procmeans.rtf";
proc means data=Traffic;
   var MPH;
run;
ODS RTF CLOSE;

ODS OUTPUT "Summary Statistics"=Stats;
proc means data=Traffic;
   var MPH;
run;
ODS OUTPUT CLOSE;
ODS RTF FILE="procmeansout.rtf";
proc print data=Stats;
run;
ODS RTF CLOSE;

ODS RTF FILE="PearsonCorr.rtf";
proc corr data=Traffic nosimple;
   var TimeOfDay;
   with MPH;
run;
ODS RTF CLOSE;

ODS OUTPUT "Pearson Correlations"=PearsonCorr;
proc corr data=Traffic nosimple;
   var TimeOfDay;
   with MPH;
run;
ODS OUTPUT CLOSE;
ODS RTF FILE="PearsonCorrOut.rtf";
proc print data=PearsonCorr;
run;
ODS RTF CLOSE;

ODS OUTPUT "Variables Information"=VarInfo;
proc corr data=Traffic nosimple;
   var TimeOfDay;
   with MPH;
run;
ODS OUTPUT CLOSE;
ODS RTF FILE="VarInfoOut.rtf";
proc print data=VarInfo;
run;
ODS RTF CLOSE;

ODS OUTPUT "Cross-Tabular Freq Table"=FreqTable;
ODS OUTPUT "Chi-Square Tests"=FreqChiSq;
proc freq data=Traffic;
   tables highway*event / chisq norow nocol nopct;
run;
ODS OUTPUT CLOSE;
ODS RTF FILE="FreqTableChiSq.rtf";
proc print data=FreqTable; run;
proc print data=FreqChiSq; run;
ODS RTF CLOSE;

ODS OUTPUT "Cross-Tabular Freq Table"=FreqTable
           "Chi-Square Tests"=FreqChiSq;
proc freq data=Traffic;
   tables highway*event / chisq norow nocol nopct;
run;
ODS OUTPUT CLOSE;

ODS OUTPUT "Moments"=UnivMPH;
proc univariate data=Traffic;
   class Highway;
   var MPH;
run;
ODS OUTPUT CLOSE;

ODS OUTPUT "Odds Ratios"=FatalOdds;
proc logistic data=Traffic;
   model Fatal=MPH;
run;
proc logistic data=traffic;
   model Fatal=Location;
run;
proc logistic data=traffic;
   model Fatal=Location Highway;
run;
ODS OUTPUT CLOSE;

ODS OUTPUT "Odds Ratios"(MATCH_ALL=OddsDS PERSIST=PROC)=FatalOdds;
proc logistic data=Traffic;
   model Fatal=MPH;
run;
proc logistic data=traffic;
   model Fatal=Location;
run;
proc logistic data=traffic;
   model Fatal=Location Highway;
run;
ODS OUTPUT CLOSE;

data AllOdds;
   set &OddsDS;
run;

ODS OUTPUT "Parameter Estimates"=Params;
proc reg data=traffic NOPRINT;
   model mph=highway location;
quit;
ODS OUTPUT CLOSE;

ODS LISTING CLOSE;
ODS OUTPUT "Parameter Estimates"=Params;
proc reg data=traffic;
   model mph=highway location;
quit;
ODS OUTPUT CLOSE;
ODS LISTING;

ODS OUTPUT "T-Tests"(MATCH_ALL PERSIST=PROC)=TTests;
proc ttest data=traffic;
   class fatal;
   var MPH;
run;
proc ttest data=traffic;
   class fatal;
   var MPH;
ODS OUTPUT CLOSE;
proc print data=TTests;
run;
proc print data=TTests1;
run;

ODS OUTPUT "T-Tests"(MATCH_ALL PERSIST=PROC)=TTests;
proc ttest data=traffic;
   class fatal;
   var MPH;
proc ttest data=traffic;
   class fatal;
   var MPH;
run;
ODS OUTPUT CLOSE;
proc print data=TTests;
run;
proc print data=TTests1;
run;

ODS OUTPUT "Parameter Estimates"=Params;
proc rsreg data=traffic;
   model fatal=mph;
run;
ODS OUTPUT CLOSE;
data Params2;
   set Params (keep=Parameter Estimate Probt
                rename=(Probt=Pvalue));
run;

ODS OUTPUT "Parameter Estimates"=Params 
   (KEEP=Parameter Estimate Probt RENAME=(Probt=Pvalue));
proc rsreg data=traffic;
   model fatal=mph;
run;
ODS OUTPUT CLOSE;


/* Chapter 8 - Limiting ODS Output */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value sex 0="Male"
                  1="Female";
        value age 18-24="18-24"
                  25-34="25-34"
                          35-44="35-44"
                          45-54="45-54"
                          55-64="55-64"
                          65-high="65+";
        value party 0,1="Republican"
                    2="Independent"
                                3,4="Democrat";
        value vote 0="No"
                   1="Yes";
run;
data voters;
    format gender sex.
                   age age.
                   party party.
                   voted vote.
                   income dollar12.;
        label gender="Gender"
              age="Age"
                  party="Political Affiliation"
                  voted="Voted in Last General Election"
                  income="Income";
        do I=1 to 276;
              gender=floor(ranuni(1234)*2);
                  age=floor(ranuni(2345)*60)+18;
                  party=floor(ranuni(3456)*5);
                  voted=floor(ranuni(4567)*2);
                  income=floor(ranuni(5678)*200000)+20000;
                  if income<50000 then party=4;
                  output;
        end;
run;
proc summary data=voters nway;
   class gender age party;
   var voted;
   output out=turnout mean=PctTurnout;
run;

ODS RTF FILE='Univariate.rtf';
proc univariate data=voters;
   var income;
run;
ODS RTF CLOSE;

ODS SELECT BasicMeasures;
ODS RTF FILE='UnivariateSelect.rtf';
proc univariate data=voters;
   var income;
run;
ODS RTF CLOSE;

ODS SELECT FitStatistics ParameterEstimates;
ODS HTML BODY='SelectReg.htm';
proc reg data=Turnout;
   model PctTurnout = Gender Age Party;
quit;
ODS HTML CLOSE;

ODS SELECT Attributes;
ODS HTML BODY='SelectContents.htm';
proc contents data=voters;
run;
ODS HTML CLOSE;

ODS SELECT Moments BasicMeasures TestsForLocation Quantiles;
ODS PDF FILE='SelectUniv.pdf';
proc univariate data=voters;
   var income;
run;
ODS PDF CLOSE;

ODS EXCLUDE ExtremeObs;
ODS PDF FILE='SelectUniv2.pdf';
proc univariate data=voters;
   var income;
run;
ODS PDF CLOSE;

ODS SELECT ChiSq;
ODS RTF FILE='SelectFreq.rtf';
proc freq data=voters;
   table voted*party / chisq;
run;
proc freq data=voters;
   table voted*age / chisq;
run;
ODS RTF CLOSE;

ODS SELECT ChiSq (PERSIST);
ODS RTF FILE='SelectFreq.rtf';
proc freq data=voters;
   table voted*party / chisq;
run;
proc freq data=voters;
   table voted*age / chisq;
run;
ODS RTF CLOSE;
ODS SELECT ALL;

ODS HTML BODY='SelectCorr.html';
ODS HTML SELECT PearsonCorr;
proc corr data=voters;
   var income;
   with age;
run;
ODS HTML CLOSE;

ODS LISTING CLOSE;
ODS HTML BODY='SelectMany.htm';
ODS HTML SELECT Freq.Gender.OneWayFreqs 
                Age.OneWayFreqs
                "Table Party"."One-Way Frequencies"
                "One-Way Chi-Square Test";
proc freq data=voters;
   tables gender age party / chisq;
run;
ODS HTML SELECT ExtremeObs#1 Quantiles#2; 
proc univariate data=voters;
   var income age;
run;
ODS HTML CLOSE;

ODS RTF FILE='selectshow.rtf';
ODS RTF EXCLUDE CrossTabFreqs(Persist);
ODS SHOW;
ODS RTF SHOW;
proc freq data=voters;
   tables party*gender / chisq;
run;
proc freq data=voters;
   tables party*age / chisq;
run;
ODS RTF CLOSE;

/* Chapter 9 - Style Definitions */

options nodate nonumber nocenter;
title; footnote;

proc format;
    value skirtl 1='Mini'
                     2,3='Above knees'
                                 4,5='Below knees'
                                 6='Maxi';
        value heelh  1,2='Flats'
                     3,4='1-2 inch'
                                 5='3-4 inch'
                                 6='Spike';
    value colorn 1,2,3,4='Black'
                     5,6='Navy'
                                 7='Gray'
                                 8='Red'
                                 9,10='White'
                                 11='Green'
                                 12='Purple'
                                 13='Gold';
run;

data fashions;
    label Skirts='Skirt length'
              Heels='Heel height'
                  Colors='Clothing colors';
        format Skirts skirtl. Heels heelh. Colors colorn.;
        do i=1 to 510;
                Skirts=ceil(ranuni(1360)*6);
                Heels=ceil(ranuni(2536)*6);
                Colors=ceil(ranuni(3647)*13);
                Sales=ceil(ranuni(5869)*100000)+10000;
                output;
        end;
run;

PROC TEMPLATE;
   LIST STYLES;
RUN:

ODS PDF STYLE=Brick;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS PDF CLOSE;

ODS PDF STYLE=Brown;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS PDF CLOSE;

ODS PDF STYLE=FancyPrinter;
proc means data=fashions maxdec=0 sum;
   class Skirts;
   var Sales;
run;
ODS PDF CLOSE;

PROC TEMPLATE;
   SOURCE Styles.Default;
RUN;

PROC TEMPLATE;
   DEFINE STYLE DefaultNewTitle;
   PARENT=styles.default;
   REPLACE fonts /
      'TitleFont2' = ("Arial, Helvetica, Helv",4,Bold Italic)
      'TitleFont' = ("Times New Roman, Times",5,Bold Italic)
      'StrongFont' = ("Arial, Helvetica, Helv",4,Bold)
      'EmphasisFont' = ("Arial, Helvetica, Helv",3,Italic)
      'FixedEmphasisFont' = ("Courier",2,Italic)
      'FixedStrongFont' = ("Courier",2,Bold)
      'FixedHeadingFont' = ("Courier",2)
      'BatchFixedFont' = ("SAS Monospace, Courier",2)
      'FixedFont' = ("Courier",2)
      'headingEmphasisFont' = ("Arial,Helvetica,Helv",4,Bold Italic)
      'headingFont' = ("Arial, Helvetica, Helv",4,Bold)
      'docFont' = ("Arial, Helvetica, Helv",3);
   END;
RUN;

PROC TEMPLATE;
   LIST / STORE=SASUSER.TEMPLAT;
RUN;


/* Chapter 10 - Modifying Output Fonts */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value dept   1='Administration'
                     2,3='Sales'
                                 4,5='Technical';
        value grade  1,2='I'
                     3,4='II'
                                 5='III'
                                 6='IV';
    value title  1='Trainee'
                                 2,3,4,5='Specialist'
                     6,7='Manager'
                             8,9='Associate'
                                 10='VP'
                                 ;
run;

data positions;
    label Department='Department'
              Grade='Experience Level'
                  Title='Position Title'
          Salary='Annual Compensation';
        format Department dept. Grade grade. Title title.;
        do i=1 to 777;
                Department=ceil(ranuni(1360)*5);
                Grade=ceil(ranuni(2536)*6);
                Title=ceil(ranuni(3647)*10);
                Salary=ceil(ranuni(5869)*200000)+10000;
                If Department in(6,7,8,9) then Salary=Salary*1.8;
                Else If Department=10 then Salary=Salary*5;
        Else if Department=1 then Salary=Salary/2;
                Salary=Salary*Grade/6;
                If Salary<25000 then Salary=Salary+20000;
                output;
        end;
run;
ODS LISTING;
options nocenter;

PROC TEMPLATE;
   DEFINE STYLE DefaultSmaller;
      PARENT=Styles.Default;
      REPLACE fonts /
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

ODS HTML FILE='DefaultSmaller.html' STYLE=DefaultSmaller;
proc freq data=positions;
   tables Department;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE PrinterSmaller;
      PARENT=Styles.Printer;
   REPLACE fonts /
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

ODS PDF FILE='PrinterSmaller.pdf' STYLE=PrinterSmaller;
proc freq data=positions;
   tables Department;
run;
ODS PDF CLOSE;

PROC TEMPLATE;
   DEFINE STYLE RTFSmaller;
      PARENT=Styles.RTF;
   REPLACE fonts /
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

ODS RTF FILE='RTFDefault.rtf' STYLE=RTF;
proc freq data=positions;
   tables Department;
run;
ODS RTF CLOSE;

ODS RTF FILE='RTFSmaller.rtf' STYLE=RTFSmaller;
proc freq data=positions;
   tables Department;
run;
ODS RTF CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultNewFonts;
      PARENT=Styles.Default;
      REPLACE fonts /
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

ODS HTML FILE='DefaultNewFonts.html' STYLE=DefaultNewFonts;
proc freq data=positions;
   tables Department;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE RTFNoItalics;
      PARENT=Styles.RTF;
   REPLACE fonts /
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

ODS RTF FILE='RTFItalics.rtf';
proc freq data=positions;
   tables Grade;
run;
ODS RTF CLOSE;
ODS RTF FILE='RTFNoItalics.rtf' STYLE=RTFNoItalics;
proc freq data=positions;
   tables Grade;
run;
ODS RTF CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultNewFonts2;
      PARENT=Styles.Default;
      REPLACE fonts /
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
   REPLACE SystemFooter from TitlesAndFooters /
      font = Fonts('FootnoteFont');
   END;
RUN;

ODS HTML FILE='DefaultNewFonts2.html' STYLE=DefaultNewFonts2;
proc freq data=positions;
   tables Department;
run;
ODS HTML CLOSE;

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

ODS RTF FILE='RTFFixed.rtf' STYLE=RTF;
title 'This CHART procedure output uses fixed-width fonts';
proc chart data=positions;
   vbar grade / discrete axis=0 to 300 by 100 ;
run;
ODS RTF CLOSE;

ODS RTF FILE='RTFFixed2.rtf' STYLE=RTFFixed;
title 'This CHART procedure output uses fixed-width fonts';
proc chart data=positions;
   vbar grade / discrete axis=0 to 300 by 100 ;
run;
ODS RTF CLOSE;


/* Chapter 11 - Modifying Output Structure */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value material 1,2='Wood'
                     3,4='Concrete'
                                 5,6='Brick'
                 7='Steel';
        value height  1,2='1 story'
                     3,4='2 stories'
                                 5='mid-rise'
                                 6='high-rise';
    value type  1='Retail'
                                 2,3,4,5='Residential'
                     6,7='Office'
                             8,9='Warehouse';
run;

data buildings;
    label Material='Primary construction material'
              Height='Building height'
                  Type='Building type'
          CostSqFt='Cost per square foot';
        format Material material. Height height. Type type. CostSqFt dollar10.;
        do i=1 to 342;
                Material=ceil(ranuni(1360)*7);
                Height=ceil(ranuni(2536)*6);
                Type=ceil(ranuni(3647)*9);
                CostSqFt=ceil(ranuni(5869)*200)+80;
                If Height=6 then do;
            material=7;
            type=6;
            end;
                if Height=5 then do;
                    if material in(1,2) then material=3;
                        else if material in(5,6) then material=7;
                        if type=2 then type=1;
                        else if type in(3,4) then type=6;
                        else if type=5 then type=8;
                end;
                if type in(2,3,4,5) and material=7 then material=1;
                output;
        end;
run;

PROC TEMPLATE;
   DEFINE STYLE DefaultBorder;
      PARENT=Styles.Default;
      REPLACE Output from Container /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 10;
   END;
RUN;

ODS HTML FILE='DefaultBorder.htm' STYLE=DefaultBorder;
proc means data=buildings maxdec=2;
   class type;
   var costsqft;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule;
      PARENT=Styles.Default;
      REPLACE Output from Container /
         background = colors('tablebg')
         rules = NONE
         frame = VOID
         cellpadding = 7
         cellspacing = 0
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;

ODS HTML FILE='DefaultNoBorderRule.htm' STYLE=DefaultNoBorderRule;
proc means data=buildings maxdec=2;
   class type;
   var costsqft;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE PrinterNoBorder;
      PARENT=Styles.Printer;
      REPLACE Table from Output /
         rules = NONE
         frame = VOID
         cellpadding = 4pt
         cellspacing = 0
         borderwidth = 1;   
   END;
RUN;

ODS PRINTER PDF FILE='PrinterNoBorder.pdf' STYLE=PrinterNoBorder;
proc means data=buildings maxdec=2;
   class type;
   var costsqft;
run;
ODS PRINTER CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultSqueeze;
      PARENT=Styles.Default;
      REPLACE Output from Container /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 3
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;

ODS HTML FILE='DefaultSqueeze.htm' STYLE=DefaultSqueeze;
proc means data=buildings maxdec=2;
   class height;
   var costsqft;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultStretch;
      PARENT=Styles.Default;
      REPLACE Output from Container /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 10
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;

ODS HTML FILE='DefaultStretch.htm' STYLE=DefaultStretch;
proc means data=buildings maxdec=2;
   class height;
   var costsqft;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultBlank;
      PARENT=Styles.Default;
      REPLACE ContentProcName FROM IndexProcName /
         BULLET=NONE;
   END;
RUN;

ODS HTML BODY='blankbody1.htm'
         CONTENTS='blankcontents1.htm'
         FRAME='blankmain1.htm'
         STYLE=DefaultBlank; 
ODS PROCLABEL ' ';
title 'Construction Materials';
proc freq data=Buildings;
    tables material; 
run;
ODS HTML CLOSE;

ODS PDF FILE='NoProcedure.pdf';
ODS NOPTITLE;
title 'Construction Materials';
proc freq data=Buildings;
    tables material*type / norow nocol nopercent; 
run;
ODS PDF CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultWidth;
      PARENT=Styles.Default;
      REPLACE Table from Output /
         outputwidth=400;
      REPLACE Frame from Document /
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

ODS HTML FRAME='framewidth1.htm'
         BODY='bodywidth1.htm'
         CONTENTS='contentswidth1.htm'
         STYLE=DefaultWidth;
proc univariate data=Buildings;
    var costsqft; 
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultFrameBorder;
      PARENT=Styles.Default;
      REPLACE Frame from Document /
         contentposition = L
         bodyscrollbar = auto
         bodysize = *
         contentscrollbar = auto
         contentsize = 23%
         framespacing = 1
         frameborderwidth = 4
         frameborder = OFF;
   END;
RUN;

ODS HTML FRAME='frameborder1.htm'
         BODY='bodyborder1.htm'
         CONTENTS='contentsborder1.htm'
         STYLE=DefaultFrameBorder;
proc univariate data=Buildings;
    var costsqft; 
run;
ODS HTML CLOSE;

/* Chapter 12 - Modifying Output Colors and Graphics */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value type 1,2,3='Paint'
                     4,5='Stain'
                                 6='Sealer';
        value base  1,2='Latex'
                     3='Oil';
    value color  1='Gray'
                                 2,3,4,5='White'
                     6,7='Tan'
                             8,9='Yellow';
run;

data paints;
    label Type='Type of Finish'
              Warranty='Year of Warranty';
        format Type type. Base base. Color color.;
        do i=1 to 767;
                Type=ceil(ranuni(9876)*6);
                Base=ceil(ranuni(8765)*3);
                Color=ceil(ranuni(7654)*9);
                Warranty=floor(ranuni(5869)*10)+2;
                Price=(ranuni(4321)*10)+5.99;
                output;
    end;
run;

PROC TEMPLATE;
   DEFINE STYLE DefaultTitle;
      PARENT=Styles.Default;
   REPLACE color_list /
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

ODS HTML FILE='TitleColor.htm' STYLE=DefaultTitle;
proc freq data=paints;
   tables base*type / norow nocol nopercent;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultTitle2;
      PARENT=Styles.Default;
   REPLACE TitlesAndFooters from Container /
      font = Fonts('TitleFont2')
      background = colors('systitlefg')
      foreground = colors('systitlebg');
   END;
RUN;

ODS HTML FILE='TitleColor2.htm' STYLE=DefaultTitle2;
proc freq data=paints;
   tables base*type / norow nocol nopercent;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultBack;
      PARENT=Styles.Default;
   REPLACE color_list /
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

ODS HTML FILE='Background.htm' STYLE=DefaultBack;
proc means data=paints maxdec=1;
   class type;
   var warranty;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultLogoColors;
      PARENT=Styles.Default;
   REPLACE color_list /
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

ODS HTML FILE='TableColor.htm' STYLE=DefaultLogoColors;
proc freq data=paints;
   tables base*color / norow nocol nopercent;
run;
ODS HTML CLOSE;


PROC TEMPLATE;
   DEFINE STYLE DefaultPurpleFN;
      PARENT=Styles.Default;
   REPLACE color_list /
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
   REPLACE colors /
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
      'Conentryfg' = color_list('fgA')
      'Confolderfg' = color_list('fgA')
      'Contitlefg' = color_list('fgA')
      'link2' = color_list('fgB2')
      'link1' = color_list('fgB1')
      'contentfg' = color_list('fgA2')
      'contentbg' = color_list('bgA2')
      'docfg' = color_list('fgA')
      'docbg' = color_list('bgA')
      'footnotefg' = color_list('fgNew');
   REPLACE SystemFooter from TitlesAndFooters
      "Controls system footer text." /
      font = Fonts('TitleFont')
      foreground = colors('footnotefg');
   END;
RUN;

ODS HTML FILE='NewColor.htm' STYLE=DefaultPurpleFN;
ods select basicmeasures;
proc univariate data=paints;
   var price;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultPurpleFN;
      PARENT=Styles.Default;
   REPLACE SystemFooter from TitlesAndFooters
      "Controls system footer text." /
      font = Fonts('TitleFont')
      foreground = cx660066;
   END;
RUN;

ODS HTML FILE='NewColor2.htm' STYLE=DefaultPurpleFN;
ods select basicmeasures;
proc univariate data=paints;
   var price;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE GraySafe;
      PARENT=Styles.Default;
   REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxFFFF33
      'fgA2' = cxFFFFFF
      'bgA2' = cxFF2222
      'fgA1' = cx000000
      'bgA1' = cx000000
      'fgA' = cxFFFF22
      'bgA' = cxFFFFFF;
   END;
RUN;

options colorprinting;
ODS PRINTER PDF FILE='GraySafeC.pdf' style=GraySafe;
proc corr data=paints nosimple;
   var price; with warranty;
run;
ODS PRINTER CLOSE;

options nocolorprinting;
ODS PRINTER PDF FILE='GraySafe.pdf' style=GraySafe;
proc corr data=paints nosimple;
   var price; with warranty;
run;
ODS PRINTER CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultLogo;
      PARENT=Styles.Default;
   REPLACE Body from Document /
      preimage="logo.gif";
   END;
RUN;

ODS HTML FILE='logo.htm' style=DefaultLogo;
proc means data=paints maxdec=2;
   var price;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultLogo2;
      PARENT=Styles.Default;
   REPLACE Body from Document /
      prehtml='<table width=100%><tr><td nowrap align=left>
         <img border="0" src="logo.gif">
         <font face="Arial" size=3><b>SprayTech Corp.</b></font>
         </tr></td></table>';
   END;
RUN;

ODS HTML FILE='logo2.htm' style=DefaultLogo2;
proc means data=paints maxdec=2;
   var price;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultLogoBG;
      PARENT=Styles.Default;
   REPLACE Body from Document /
      backgroundimage="logobg.gif";
   END;
RUN;

ODS HTML FILE='logoBG.htm' style=DefaultLogoBG;
proc means data=paints maxdec=2;
   var price;
run;
ODS HTML CLOSE;

PROC TEMPLATE;
   DEFINE STYLE DefaultLogoBG2;
      PARENT=Styles.Default;
   REPLACE Body from Document /
      prehtml='<table width=100%><tr><td nowrap align=left>
         <font face="Arial" size=5><b>SprayTech Corp.</b></font>
         </tr></td></table>'
      backgroundimage='logobg.gif';
   REPLACE Container /
      font = Fonts('DocFont')
      foreground = colors('docfg');
   REPLACE TitlesAndFooters from Container /
      font = Fonts('TitleFont2')
      foreground = colors('systitlefg');
   END;
RUN;

ODS HTML FILE='logoBG2.htm' style=DefaultLogoBG2;
proc means data=paints maxdec=2;
   var price;
run;
ODS HTML CLOSE;


/* Chapter 13 - Special Cases: The REPORT, TABULATE, and PRINT PROCEDURES */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value type 1,2,3='Dining'
                     4,5='Coffee'
                                 6='End';
        value material 1,2,3='Wood'
                       4,5='Glass/Metal';
    value color  1='White'
                                 2,3,4,5='Natural'
                     6,7='Black';
run;

data tables;
        format Type type. Material material. Color color.;
        do i=1 to 2043;
                Type=ceil(ranuni(9876)*6);
                Material=ceil(ranuni(8765)*5);
                Color=ceil(ranuni(7654)*7);
        If type in(1,2,3) then Height=floor(ranuni(5869)*10)+15;
                Else If type in(4,5) then Height=floor(ranuni(5869)*10)+28;
                Else If type=6 then Height=floor(ranuni(5869)*10)+20;
                Price=(ranuni(4321)*300)+49.99;
                If material in(4,5) then Price=Price*2;
                If type in(4,5,6) then Price=Price/4;
                Price=max(price,49.99);
                output;
    end;
run;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd
   STYLE(Header)=[FONT_FACE='Times New Roman'];
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.
      STYLE(Column)=[BACKGROUND=cxFFFFFF];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   compute Material;
      count+1;
      if (mod(count,2)) then do;
         CALL DEFINE(_ROW_, "STYLE", "STYLE=[BACKGROUND=cxFFFFFF]");
      end;
   endcomp;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   compute Material;
      count+1;
                if not (mod(count,2)) then do;
                   CALL DEFINE(_ROW_, "STYLE", "STYLE=[BACKGROUND=cxFFFFFF]");
                end;
   endcomp;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   break after Type / summarize;
   rbreak after / summarize;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   break after Type / summarize STYLE=[VJUST=T CELLHEIGHT=50
                                       FONT_WEIGHT=Bold];
   rbreak after / summarize STYLE=[FONT_WEIGHT=Bold];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   compute Price;
      if _C3_ <= 100 then 
         CALL DEFINE(_COL_,"STYLE",
            "STYLE=[FOREGROUND=cx006633 FONT_WEIGHT=Bold]");
      else if _C3_ >= 300 then 
         CALL DEFINE(_COL_,"STYLE",
            "STYLE=[FOREGROUND=cxCC0000 FONT_WEIGHT=Bold]");
      else  
         CALL DEFINE(_COL_,"STYLE",
            "STYLE=[FOREGROUND=cxFF9900 FONT_WEIGHT=Bold]");
   endcomp;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   compute before _page_ / LEFT;
      LINE "Totally Tables, Inc.";
   endcomp;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc report data=tables nowd;
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

ODS LISTING;
proc report data=tables nowd out=tables1;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
run;
ODS LISTING CLOSE;
ODS HTML BODY='tables1.htm';
proc print data=tables1; run;
ODS HTML CLOSE;

ODS LISTING;
proc report data=tables nowd out=tables2;
   column Type Material Price;
   define Type / group 'Table Type';
   define Material / group 'Construction';
   define Price / analysis mean 'Average Price' format=dollar8.;
   break after Type / summarize;
   rbreak after / summarize;
run;
ODS LISTING CLOSE;
ODS HTML BODY='tables2.htm';
proc print data=tables2; run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material / STYLE=[FONT_FACE="Times New Roman"];
   var Price / STYLE=[FONT_FACE="Times New Roman"];
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.
         / Box='Retail Stock Report';
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.
         / Box=[LABEL='Retail Stock Report' STYLE=[JUST=L]];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables 
   STYLE=[BACKGROUND=cxFFFFFF];
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables 
   STYLE=[BACKGROUND=cxFFFFFF FONT_WEIGHT=bold];
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

proc format;
   value typecol 1,3='cxB0B0B0'
                 2='cxFFFFFF';
run;
ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   where type in(1,2,3);
   class Type Material;
   classlev Type / STYLE=[BACKGROUND=typecol.];
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   where type in(1,2,3);
   class Type Material;
   classlev Type / STYLE=[BACKGROUND=typecol.];
   classlev Material / STYLE=<parent>;
   var Price;
   table Type='Table Type'*
         Material='Construction'*[STYLE=<parent>],
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         (Material='Construction' ALL) 
         ALL,
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         (Material='Construction' ALL*[STYLE=[FONT_WEIGHT=bold]]) 
         ALL*[STYLE=[FONT_WEIGHT=bold]],
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS HTML CLOSE;

proc format;
   value traffic low-100='cx006600'
                 100<-300='cxFF9900'
                 300<-high='cxCC0000';
run;
ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.*
         [STYLE=[FOREGROUND=traffic. FONT_WEIGHT=bold]];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.
         / BOX=[LABEL='Totally Tables, Inc.'
                STYLE=[PREIMAGE='dining.gif']];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc tabulate data=tables;
   class Type Material;
   var Price / STYLE=[VJUST=B];
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.
         / BOX=[LABEL='Totally Tables, Inc.' 
                STYLE=[PREIMAGE='dining.gif']];
run;
ODS HTML CLOSE;

ODS LISTING;
proc tabulate data=tables OUT=tables1;
   class Type Material;
   var Price;
   table Type='Table Type'*
         Material='Construction',
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS LISTING CLOSE;
ODS HTML BODY='tables.htm';
proc print data=tables1; run;
ODS HTML CLOSE;

ODS LISTING;
proc tabulate data=tables OUT=tables2;
   class Type Material;
   var Price;
   table Type='Table Type'*
         (Material='Construction' ALL) ALL,
         Price='Average Price'*Mean=" "*f=dollar8.;
run;
ODS LISTING CLOSE;
ODS HTML BODY='tables.htm';
proc print data=tables2; run;
ODS HTML CLOSE;

ODS HTML FILE='tables.htm';
proc print data=tables noobs label;
   var Type Material Price;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc print data=tables noobs label
   STYLE(Header)=[FONT_FACE='Times New Roman'];
   var Type Material Price;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc print data=tables noobs label;
   var Type Material;
   var Price / STYLE=[BACKGROUND=cxFFFFFF];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc print data=tables noobs label;
   var Type Material;
   var Price / STYLE(Data)=[BACKGROUND=cxFFFFFF];
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc print data=tables noobs label;
   var Type Material Price;
   sum Price;
run;
ODS HTML CLOSE;

ODS HTML BODY='tables.htm';
proc print data=tables noobs label;
   var Type Material Price;
   sum Price / Style(Total)=[VJUST=B CELLHEIGHT=50];
run;
ODS HTML CLOSE;

/* Chapter 14 - Graphics Output */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

proc format;
    value Choc 1,2,3='Milk'
                   4,5='Dark'
                           6='White';
        value Filling  1,2='Nougat'
                   3='Peanuts'
                       4,5='Caramel'
                   6,7,8='None';
    value PieType  1='Blueberry'
                                   2,3,4,5='Apple'
                       6,7='Cherry'
                   8='Banana Creme'
                   9='Pecan'
                  10='Lemon Meringue';
        value Theme   1,2,3='Drama'
                      4,5='Comedy'
                                  6,7,8='Action/Adventure'
                                  9='Thriller';
run;

data Graphs;
        do i=1 to 547;
                Chocolate=put(ceil(ranuni(1472)*6),Choc.);
                Filling=put(ceil(ranuni(5836)*8),Filling.);

                PieType=Put(ceil(ranuni(9014)*10),PieType.);
        Sales=(ranuni(3690)*134567)+50000;
                Year=ceil(ranuni(9638)*3)+1999;

                Theme=Put(ceil(ranuni(7258)*9),Theme.);
        TicketsSold=(ranuni(1472)*30000000)+100000;
                If Theme='Action/Adventure' Then TicketsSold=TicketsSold*1.5;
                Else If Theme='Drama' Then TicketsSold=TicketsSold*.5;
                Else If Theme='Comede' Then TicketsSold=TicketsSold*1.25;
                Theaters=(TicketsSold/1000)+ceil(ranuni(5836)*10000);

                output;
    end;
run;
Data CandyBars PieStats MoviePlots; set Graphs; run;

GOPTIONS RESET=ALL;

ODS HTML BODY='c:\temp\PieStats.htm'
         GPATH='c:\temp\' (URL=NONE);
goptions DEVICE=GIF XPIXELS=480 YPIXELS=360; 
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

GOPTIONS RESET=ALL;
ODS HTML BODY='JavaBar.htm' NOGTITLE
         ARCHIVE='graphapp.jar';
GOPTIONS DEVICE=JAVA GSFMODE=REPLACE XPIXELS=480 YPIXELS=360;
title 'Candy Bar Chart';
title2 'Annual Sales by Type of Chocolate and Filling';
proc gchart data=CandyBars;
   vbar3d Filling / sumvar=Sales
                    group=Chocolate;
run; quit;
ODS HTML CLOSE;

GOPTIONS RESET=ALL;
ODS HTML BODY='ActiveXBar.htm' NOGTITLE
         ARCHIVE='sasgraph.exe';
GOPTIONS DEVICE=ACTIVEX GSFMODE=REPLACE;
title 'Candy Bar Chart';
title2 'Annual Sales by Type of Chocolate and Filling';
proc gchart data=CandyBars;
   vbar3d Filling / sumvar=Sales
                    group=Chocolate;
run; quit;
ODS HTML CLOSE;

GOPTIONS RESET=ALL;
ODS RTF FILE='c:\temp\book\PNGplot.rtf';
GOPTIONS DEVICE=PNG;
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
   plot Theaters*TicketsSold=Theme;
run; quit;
ODS RTF CLOSE;

GOPTIONS RESET=ALL;
ODS RTF FILE='c:\temp\book\SASEMFplot.rtf';
GOPTIONS DEVICE=SASEMF;
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
   plot Theaters*TicketsSold=Theme;
run; quit;
ODS RTF CLOSE;

GOPTIONS RESET=ALL;
ODS RTF FILE='ActiveXPlot.rtf';
GOPTIONS DEVICE=ACTIVEX;
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
   plot Theaters*TicketsSold=Theme;
run; quit;
ODS RTF CLOSE;

GOPTIONS RESET=ALL;
ODS PRINTER;
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
   plot Theaters*TicketsSold=Theme;
run; quit;
ODS PRINTER CLOSE;

GOPTIONS RESET=ALL;
ODS PRINTER FILE='Graph.ps';
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
   plot Theaters*TicketsSold=Theme;
run; quit;
ODS PRINTER CLOSE;

GOPTIONS RESET=ALL;
ODS PDF FILE='Graph.pdf';
title 'Movie Plots';
title2 'Ticket Sales by Theme';
proc gplot data=MoviePlots;
   plot Theaters*TicketsSold=Theme;
run; quit;
ODS PDF CLOSE;

GOPTIONS RESET=ALL;
GOPTIONS DEVICE=GIF XPIXELS=480 YPIXELS=360 GSFMODE=REPLACE; 
title 'Candy Bar Chart';
title2 'Annual Sales by Chocolate Type and Filling';
proc gchart data=CandyBars GOUT=work.CandyBarChart;
   vbar3d Filling / name='SalesBar'
                    sumvar=Sales
                    group=Chocolate;
run; quit;
ODS HTML BODY='c:\temp\CandyBarReport.htm'
         GPATH='c:\temp\' (URL=NONE);
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

GOPTIONS RESET=ALL;
Data PieStatsDrill;
   set PieStats;
   format rpt $40.;
   if PieType='Apple' then rpt='href="DrillDowns.htm#pie1"';
   else if PieType='Banana Creme' then rpt='href="DrillDowns.htm#pie2"';
   else if PieType='Blueberry' then rpt='href="DrillDowns.htm#pie3"';
   else if PieType='Cherry' then rpt='href="DrillDowns.htm#pie4"';
   else if PieType='Lemon Meringue' then rpt='href="DrillDowns.htm#pie5"';
   else if PieType='Pecan' then rpt='href="DrillDowns.htm#pie6"';
run;
proc sort data=PieStatsDrill; by PieType; run;
ODS HTML BODY='c:\temp\DrillDowns.htm' ANCHOR='pie1';
proc means data=PieStatsDrill mean nonobs maxdec=0;
   by PieType;
   class year;
   var Sales;
run;
ODS HTML CLOSE;
ODS HTML BODY='c:\temp\PieDrill.htm' GPATH='c:\temp\' (URL=NONE);
goptions device=GIF xpixels=480 ypixels=360; 
title 'Pie Chart: Annual Sales by Flavor';
proc gchart data=PieStatsDrill;
   pie PieType / sumvar=sales 
      percent=arrow slice=arrow value=none
      HTML=rpt;
run; quit;
ODS HTML CLOSE;


/* Appendix 1 - Sample Programs */

options nocenter nodate nonumber;
title; footnote;
ods listing close;

** HTML STYLES **;
* CREATE A DATASET WITH THE STYLE NAMES;
ODS OUTPUT Stats(MATCH_ALL=mvar)=Temp1;
proc template;
    list;
run;
ODS OUTPUT CLOSE;
 
data TemplateListing;
   length type $12 path $255;
   set &mvar;
   if type="Style";         
run;
 
* CREATE MACRO VARIABLES FROM THE STYLE NAMES;
data _null_;
   set TemplateListing end=eof;
   retain Counter 1;
   if eof then call symput('NumStyles',Counter);
   StyleName=Path;
   StyleNum=trim(left(compress("Style"||Counter)));         
   call symput(StyleNum,StyleName);
   Counter+1;
run;
 
* CREATE A SIMPLE DATASET;
Data Test;
        input A B C;
cards;
1 2 3
4 5 6
7 8 9
;
run;
 
* LOOP THROUGH THE STYLES RUNNING A SIMPLE PROCEDURE;
%Macro DisplayStyles;
ODS LISTING CLOSE;
ODS HTML FRAME="styletestframe.html"
         CONTENTS="styletestcont.html"
         BODY="styletestjunk.html";
%Do C=1 %to &NumStyles;
   ODS HTML BODY="styletest&C..html" style=&&Style&C;
   title 'Available Styles';
   title2 "This Style is &&Style&C";
   ODS PROCLABEL "This Style is &&Style&C";         
   proc print data=Test;
   run;
%End;
ODS HTML CLOSE;
%Mend DisplayStyles;
%DisplayStyles;

** RTF STYLES **;
* LOOP THROUGH THE STYLES RUNNING A SIMPLE PROCEDURE;
%Macro DisplayStyles;
ODS LISTING CLOSE;
%Do C=1 %to &NumStyles;
   ODS RTF FILE="styletest&C..rtf" style=&&Style&C;
   title 'Available Styles';
   title2 "This Style is &&Style&C";
   ODS PROCLABEL "This Style is &&Style&C";         
   proc print data=Test;
   run;
%End;
ODS RTF CLOSE;
%Mend DisplayStyles;
%DisplayStyles;

** PRINTER STYLES **;
* LOOP THROUGH THE STYLES RUNNING A SIMPLE PROCEDURE;
%Macro DisplayStyles;
ODS LISTING CLOSE;
%Do C=1 %to &NumStyles;
   ODS PDF FILE="styletest&C..pdf" style=&&Style&C;
   title 'Available Styles';
   title2 "This Style is &&Style&C";
   ODS PROCLABEL "This Style is &&Style&C";         
   proc print data=Test;
   run;
%End;
ODS PDF CLOSE;
%Mend DisplayStyles;
%DisplayStyles;





