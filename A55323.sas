/***************************************************************/
/* SAS Guide to the REPORT Procedure, Reference, Release 6.11. */
/*                                                             */
/* SAS Publications order # 55323                              */
/* ISBN 1-55544-265-X                                          */
/* Copyright 1995 by SAS Institute, Cary, NC, USA              */
/*                                                             */
/* These examples are also available through the online        */
/* documentation and online help for Release 6.11. You can     */
/* cut and paste the code from the display into your SAS       */
/* session, submit it as is, or modify it.                     */
/***************************************************************/

/*********************************************************/
/* Example 1                                             */
/* Code for Example 1 is on pages 49 and 50.             */
/*********************************************************/

data sasuser.grocery;
   input sector $ manager $ dept $ sales @@;
   cards;
se 1 np1 50    se 1 p1 100   se 1 np2 120   se 1 p2 80
se 2 np1 40    se 2 p1 300   se 2 np2 220   se 2 p2 70
nw 3 np1 60    nw 3 p1 600   nw 3 np2 420   nw 3 p2 30
nw 4 np1 45    nw 4 p1 250   nw 4 np2 230   nw 4 p2 73
nw 9 np1 45    nw 9 p1 205   nw 9 np2 420   nw 9 p2 76
sw 5 np1 53    sw 5 p1 130   sw 5 np2 120   sw 5 p2 50
sw 6 np1 40    sw 6 p1 350   sw 6 np2 225   sw 6 p2 80
ne 7 np1 90    ne 7 p1 190   ne 7 np2 420   ne 7 p2 86
ne 8 np1 200   ne 8 p1 300   ne 8 np2 420   ne 8 p2 125
;

proc format library=sasuser;
   value $sctrfmt 'se' = 'Southeast'
                  'ne' = 'Northeast'
                  'nw' = 'Northwest'
                  'sw' = 'Southwest';

   value $mgrfmt '1' = 'Smith'   '2' = 'Jones'
                 '3' = 'Reveiz'  '4' = 'Brown'
                 '5' = 'Taylor'  '6' = 'Adams'
                 '7' = 'Alomar'  '8' = 'Andrews'
                 '9' = 'Pelfrey';

   value $deptfmt 'np1' = 'Paper'
                  'np2' = 'Canned'
                  'p1'  = 'Meat/Dairy'
                  'p2'  = 'Produce';
run;

options nodate nonumber ps=18 ls=70 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd;
   column manager dept sales;
   where sector='se';
   format manager $mgrfmt.;
   format dept $deptfmt.;
   format sales dollar11.2;
   title 'Sales for the Southeast Sector';
   title2 "for &sysdate";
run;

/*********************************************************/
/* Example 2                                             */
/* Code for Example 2 is on page 51.                     */
/*********************************************************/

options nodate nonumber ps=18 ls=70 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd
            colwidth=10
            spacing=5
            headline headskip
            split='*';
   column manager sector dept sales;

   define sector / 'Sector of*the City' format=$sctrfmt.;
   define manager / 'Store*Manager' format=$mgrfmt.;
   define dept / 'Department' format=$deptfmt.;
   define sales / 'Sales' format=dollar7.2;

   rbreak after / dol summarize;
   where sector='se';
   title 'Sales for the Southeast Sector';
   title2 "for &sysdate";
run;

/*********************************************************/
/* Example 3                                             */
/* Code for Example 3 is on pages 52 - 54.               */
/*********************************************************/

options nodate nonumber ps=18 ls=70 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd headline headskip;
   column manager dept sales
          sales=salesmin
          sales=salesmax;
   define manager /order
                   order=formatted
                   'Manager'
                   format=$mgrfmt.;
   define dept    /order
                   order=internal
                   'Department'
                   format=$deptfmt.;
   define sales /analysis sum 'Sales' format=dollar7.2;
   define salesmin /analysis min noprint;
   define salesmax /analysis max noprint;

   compute after;
      line ' ';
      line @11 53*'-';
      line @11 '| Departmental sales ranged from'
           salesmin dollar7.2  +1 'to' +1 salesmax dollar7.2
           '. |';
      line @11 53*'-';
   endcomp;
   where sector='se';
   title 'Sales for the Southeast Sector';
run;

/*********************************************************/
/* Example 4                                             */
/* Code for Example 4 is on pages 55 - 57.               */
/*********************************************************/

options nodate pageno=1 ps=60 ls=72 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd headskip;
   column sector manager sales;
   define sector / group format=$sctrfmt. 'Sector' '--';
   define manager / group format=$mgrfmt. 'Manager' '--';
   define sales / analysis sum format=comma10.2 'Sales' '--';

   break after sector / ol
                        summarize
                        skip
                        suppress;
   rbreak after / dol summarize;

   compute sales;
      if manager=' ' and sector=' ' then
      call define(_col_,"format","dollar11.2");
   endcomp;

   title "Sales Figures for Northern Sectors for &sysdate";
   where sector contains 'n';
run;

/*********************************************************/
/* Example 5                                             */
/* Code for Example 5 is on pages 58 and 59.             */
/*********************************************************/

options nodate pageno=1 ps=60 ls=72 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd headskip headline split='*';
   column sector manager dept,sales perish;
   define sector / group format=$sctrfmt. 'Sector' '';
   define manager / group format=$mgrfmt. 'Manager* ';
   define dept / across format=$deptfmt. '_Department_';
   define sales / analysis sum format=dollar11.2 ' ';
   define perish / computed format=dollar11.2 'Perishable Total';

   break after manager / skip;

   compute perish;
      perish=_c3_+_c4_;
   endcomp;

   title "Sales Figures for Perishables in Northern Sectors";
   where sector contains 'n' and (dept='p1' or dept='p2');
run;

/*********************************************************/
/* Example 6                                             */
/* Code for Example 6 is on pages 60 and 61.             */
/*********************************************************/

options number pageno=1 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd headline headskip
            ls=66 ps=18;
   column sector manager (sum min max range mean std),sales;
   define manager/group format=$mgrfmt. id;
   define sector/group format=$sctrfmt.;
   define sales / format=dollar11.2 ;

   title 'Sales Statistics for All Sectors';
run;

/*********************************************************/
/* Example 7                                             */
/* Code for Example 7 is on pages 62 and 63.             */
/*********************************************************/

options nodate nonumber fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd
            named
            wrap
            ls=64 ps=18
            outrept=sasuser.reports.namewrap;
   column sector manager dept sales;
   define sector / format=$sctrfmt.;
   define manager / format=$mgrfmt.;
   define dept / format=$deptfmt.;
   define sales / format=dollar11.2;

   where manager='1';
   title "Sales Figures for Smith on &sysdate";
run;

proc report data=sasuser.grocery report=sasuser.reports.namewrap
            nowd;
   where sector='sw';
   title "Sales Figures for the Southwest Sector on &sysdate";
run;

/*********************************************************/
/* Example 8                                             */
/* Code for Example 8 is on page 64.                     */
/*********************************************************/

options nodate nonumber fmtsearch=(sasuser);
options formchar='|~---|+|---+=|-/\<>*';

proc report data=sasuser.grocery nowd headline
            panels=99 pspace=8
            ps=18 ls=68;
   column manager dept sales;
   define manager/ order order=formatted format=$mgrfmt. 'Manager';
   define dept / order order=internal format=$deptfmt.
                'Department';
   define sales / format=dollar7.2 'Sales';

   break after manager / skip;
   where sector='nw' or sector='sw';
   title "Sales for the Western Sectors";

run;

options formchar='|----|+|---+=|-/\<>*';

/*********************************************************/
/* Example 9                                             */
/* Code for Example 9 is on pages 66 - 68.               */
/*********************************************************/

options nodate pageno=1 ps=60 ls=66 fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd
            noheader;
   title;

   column sector manager dept sales profit;
   define sector / group noprint;
   define manager / group noprint;
   define profit / computed format=dollar11.2;
   define sales / analysis sum format=dollar11.2;
   define dept / group format=$deptfmt.;

   compute profit;
      if dept='np1' or dept='np2' then profit=0.4*sales.sum;
      else profit=0.25*sales.sum;
   endcomp;

   compute before manager;
      line @3 sector $sctrfmt. ' Sector';
      line @3 'Store managed by ' manager $mgrfmt.;
      line ' ';
      line ' ';
      line @19 'Department' +7 'Sales' +8 'Profit';
      line @19 36*'-';
      line ' ';
   endcomp;


   break after manager / ol summarize page;

   compute after manager;
      length text $ 35;
      if sales.sum lt 500 then
         text='Sales are below the target region.';
      else if sales.sum ge 500 and sales.sum lt 1000 then
         text='Sales are in the target region.';
      else if sales.sum ge 1000 then
         text='SALES EXCEEDED GOAL!';
      line ' ';
      line text $35.;
   endcomp;
run;

/*********************************************************/
/* Example 10                                            */
/* Code for Example 10 is on pages 69 and 70.            */
/*********************************************************/

options nodate nonumber fmtsearch=(sasuser);

proc report data=sasuser.grocery nowd headline ls=70 ps=18;
   title;

   column ('Individual Store Sales as a Percent of All Sales'
            sector manager sales,(sum pctsum) comment);
   define manager/group format=$mgrfmt. 'Manager';
   define sector/group format=$sctrfmt. 'Sector';
   define sales / format=dollar11.2 '';
   define sum / 'Total Sales' format=dollar9.2 ;
   define pctsum / 'Percent of Sales' format=percent6. width=8;
   define comment / computed width=25 '' flow;

   compute comment  / char length=40;
      if sales.pctsum gt .15 and manager ne ' '
         then comment='Sales substantially above expectations.';
      else comment=' ';
   endcomp;

   rbreak after / ol summarize;
run;

/*********************************************************/
/* Example 11                                            */
/* Code for Example 11 is on page 71.                    */
/*********************************************************/

data sasuser.grocmiss;
     input sector $ manager $ dept $ sales @@;
cards;
se 1 np1 50    .  1 p1 100   se . np2 120   se 1 p2 80
se 2 np1 40    se 2 p1 300   se 2 np2 220   se 2 p2 70
nw 3 np1 60    nw 3 p1 600   .  3 np2 420   nw 3 p2 30
nw 4 np1 45    nw 4 p1 250   nw 4 np2 230   nw 4 p2 73
nw 9 np1 45    nw 9 p1 205   nw 9 np2 420   nw 9 p2 76
sw 5 np1 53    sw 5 p1 130   sw 5 np2 120   sw 5 p2 50
.  . np1 40    sw 6 p1 350   sw 6 np2 225   sw 6 p2 80
ne 7 np1 90    ne . p1 190   ne 7 np2 420   ne 7 p2 86
ne 8 np1 200   ne 8 p1 300   ne 8 np2 420   ne 8 p2 125
;

title;
options nodate nonumber ps=18 ls=70 fmtsearch=(sasuser);

proc report data=sasuser.grocmiss nowd headline;
   column sector manager n sales;
   define sector/group format=$sctrfmt.;
   define manager/group format=$mgrfmt.;
   define sales/ format=dollar9.2;
   rbreak after/dol summarize;
run;

proc report data=sasuser.grocmiss nowd headline missing;
   column sector manager n sales;
   define sector/group format=$sctrfmt.;
   define manager/group format=$mgrfmt.;
   define sales/ format=dollar9.2;
   rbreak after/dol summarize;
run;

/*********************************************************/
/* Example 12                                            */
/* Code for Example 12 is on page 73.                    */
/*********************************************************/

options nodate nonumber ps=18 ls=70 fmtsearch=(sasuser);
proc report data=sasuser.grocery nowd
            out=sasuser.temp( where=(sales gt 1000 ));
   column manager sales;
   define manager / group noprint;
   define sales / analysis sum noprint;
run;

proc report data=sasuser.temp box nowd;
   column  manager sales;
   define manager / group format=$mgrfmt.;
   define sales / analysis sum format=dollar11.2;
   title 'Managers with Daily Sales of over One Thousand Dollars';
run;

/*********************************************************/
/* Example 13                                            */
/* Code for Example 13 is on page 75.                    */
/*********************************************************/

options nodate pageno=1 ps=60 ls=66 fmtsearch=(sasuser);

title;
proc report data=sasuser.grocery nowd out=sasuser.profit;
   column sector manager dept sales profit;
   define sector / 'Sector'  group format=$sctrfmt.;
   define manager / 'Manager' group format=$mgrfmt.;
   define profit / 'Profit' computed format=dollar11.2;
   define sales / 'Sales' analysis sum format=dollar11.2;
   define dept / group ;

   /* Compute values for PROFIT. */
   compute profit;
      if dept='np1' or dept='np2' then profit=0.4*sales.sum;
      else profit=0.25*sales.sum;
   endcomp;
run;

proc chart data=sasuser.profit;
   block sector / sumvar=profit;
   format sector $sctrfmt.;
   format profit dollar7.2;
run;



