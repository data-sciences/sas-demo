/*------------------------------------------------------------------*/
/* SAMPLE CODE                                                      */
/* SAS/OR User's Guide: Project Management,                         */
/* Version 6, Second Edition                                        */
/* Publication book code:  56137                                    */
/*                                                                  */
/* Each sample begins with a comment that states the                */
/* chapter and page number where the code is located.               */
/*------------------------------------------------------------------*/


/* Example found on pages 10-11 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM1                                              */
 /*   TITLE: Project Definition                                  */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: NETDRAW                                             */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data survey;
   input id        $ 1-20
         activity  $ 22-29
         duration
         succ1     $ 34-41
         succ2     $ 43-50
         succ3     $ 52-59
         phase     $ 61-69;
   label phase = 'Project Phase'
         id    = 'Description';
   cards;
Plan Survey          plan sur 4  hire per design q          Plan
Hire Personnel       hire per 5  trn per                    Prepare
Design Questionnaire design q 3  trn per  select h print q  Plan
Train Personnel      trn per  3  cond sur                   Prepare
Select Households    select h 3  cond sur                   Prepare
Print Questionnaire  print q  4  cond sur                   Prepare
Conduct Survey       cond sur 10 analyze                    Implement
Analyze Results      analyze  6                             Implement
;

   title ' ';
   title2 h=3 c=black f=swiss 'Conducting a Market Survey';
   pattern1 v=e c=green;
   pattern2 v=e c=blue;
   pattern3 v=e c=red;

   goptions hpos=100 vpos=65 border;
   goptions hsize=8 in vsize=5.75 in;

   proc netdraw data=survey graphics;
       actnet/act=activity font=swiss
              succ=(succ1-succ3)
              lwidth=3 lwoutline=5
              separatearcs
              xbetween=3
              id=(id) carcs=black
              zone=phase zonepat frame
              nodefid nolabel;
    run;


/* Example found on page 13 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM2                                              */
 /*   TITLE: Work Breakdown Structure                            */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: NETDRAW                                             */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data wbs;
   input parent  $ 1-10
         child   $ 12-21
         style;
   cards;
Survey     Plan          1
Survey     Prepare       1
Survey     Implement     1
Plan       Plan S.       2
Plan       Design Q.     2
Prepare    Hire P.       3
Prepare    Train P.      3
Prepare    Select H.     3
Prepare    Print Q.      3
Implement  Conduct S.    4
Implement  Analyze R.    4
Plan S.                  2
Design Q.                2
Hire P.                  3
Train P.                 3
Select H.                3
Print Q.                 3
Conduct S.               4
Analyze R.               4
;

   goptions border rotate=portrait;
   goptions hpos=50 vpos=90 border;
   goptions hsize=5.75 in vsize=8 in;

   title  a=90 h=3   c=blue f=swiss 'Conducting a Market Survey';
   title2 a=90 h=2   c=red f=swiss 'Work Breakdown Structure';
   pattern1 v=s c=black;
   pattern2 v=s c=green;
   pattern3 v=s c=blue;
   pattern4 v=s c=red;

   proc netdraw data=wbs graphics;
       actnet/act=parent font=swiss
              succ=child coutline=black tree rotatetext
              lwidth=3 lwoutline=5  ctext=white rectilinear
              ybetween=3 xbetween=8 pattern=style
              centerid;
    run;


/* Example found on pages 15-16 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM3                                              */
 /*   TITLE: Project Scheduling and Reporting                    */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS:                                                     */
 /*   PROCS: CPM, GANTT                                          */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data survey;
   input id        $ 1-20
         activity  $ 22-29
         duration
         succ1     $ 34-41
         succ2     $ 43-50
         succ3     $ 52-59
         phase     $ 61-69;
   label phase = 'Project Phase'
         id    = 'Description';
   cards;
Plan Survey          plan sur 4  hire per design q          Plan
Hire Personnel       hire per 5  trn per                    Prepare
Design Questionnaire design q 3  trn per  select h print q  Plan
Train Personnel      trn per  3  cond sur                   Prepare
Select Households    select h 3  cond sur                   Prepare
Print Questionnaire  print q  4  cond sur                   Prepare
Conduct Survey       cond sur 10 analyze                    Implement
Analyze Results      analyze  6                             Implement
;

   data holidata;
      format hol date7.;
      hol = '3jul92'd;
      run;

   proc cpm data=survey date='1jul92'd out=survschd
            interval=weekday holidata=holidata;
      activity   activity;
      successor  succ1-succ3;
      duration   duration;
      id         id phase;
      holiday    hol;
      run;

   proc sort;
      by e_start;
      run;

   title c=white 'Conducting a Market Survey';
   title2 c=white 'Early and Late Start Schedule';
   proc print;
      run;

   pattern1 v=s  c=green;
   pattern2 v=e  c=green;
   pattern3 v=s  c=red;
   pattern4 c=red   v=e;
   pattern5 c=red   v=r2;
   pattern6 c=red   v=l2;
   pattern7 c=black v=e;

   goptions hpos=80 vpos=43;

   title c=black f=swiss 'Conducting a Market Survey';
   title2 c=black f=swiss h=1.5 'Early and Late Start Schedule';
   proc gantt graphics data=survschd holidata=holidata;
      chart / holiday=(hol)
              interval=weekday
              font=swiss skip=2 height=1.2
              nojobnum
              compress lwidth=2 noextrange
              activity=activity succ=(succ1-succ3)
              cprec=blue caxis=black ;
      id   id phase;
   run;


/* Example found on page 17 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM4                                              */
 /*   TITLE: Conducting a Market Survey: Summarized Schedule     */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS:                                                     */
 /*   PROCS: CPM, GANTT                                          */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data survey;
   input id        $ 1-20
         activity  $ 22-29
         duration
         succ1     $ 34-41
         succ2     $ 43-50
         succ3     $ 52-59
         phase     $ 61-69;
   label phase = 'Project Phase'
         id    = 'Description';
   cards;
Plan Survey          plan sur 4  hire per design q          Plan
Hire Personnel       hire per 5  trn per                    Prepare
Design Questionnaire design q 3  trn per  select h print q  Plan
Train Personnel      trn per  3  cond sur                   Prepare
Select Households    select h 3  cond sur                   Prepare
Print Questionnaire  print q  4  cond sur                   Prepare
Conduct Survey       cond sur 10 analyze                    Implement
Analyze Results      analyze  6                             Implement
;


   data holidata;
      format hol date7.;
      hol = '3jul92'd;
      run;

   proc cpm data=survey date='1jul92'd out=survschd
            interval=weekday holidata=holidata;
      activity   activity;
      successor  succ1-succ3;
      duration   duration;
      id         id phase;
      holiday    hol;
      run;


   proc sort data=survschd;
      by phase;
      run;

   proc summary data=survschd;
      by phase;
      output out=sumsched min(e_start)= max(e_finish)= ;
      var e_start e_finish;
      run;

   proc sort data=sumsched;
      by e_start;
      format e_start e_finish date7.;
      run;

   pattern1 v=s  c=green;
   pattern2 v=e  c=green;
   pattern3 v=s  c=red  ;
   pattern4 v=e  c=red  ;
   pattern5 v=r2 c=red  ;
   pattern6 v=l2 c=red  ;
   pattern7 v=e  c=black;


   goptions hpos=80 vpos=43;

   title c=black f=swiss  h=3 'Conducting a Market Survey';
   title2 c=black f=swiss h=2 'Summarized Schedule';
   proc gantt data=sumsched graphics
        holidata=holidata;
      id phase;
      chart / nojobnum
              nolegend font=swiss
              interval=weekday
              lwidth=2
              height=2 skip=4
              ref='01jul92'd to '15aug92'd by week
              holiday=(hol);
      run;


/* Example found on pages 18-22 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM5                                              */
 /*   TITLE: Scheduling Programming Tasks                        */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS:                                                     */
 /*   PROCS: CPM, GANTT, GPLOT                                   */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

   data program;
      input task $ 1-10
            succ $ 11-20
            dur
            procesr ;
cards;
Sort A    Merge 1    5   1
Sort B    Merge 1    4   1
Sort C    Merge 1    3   1
Sort D    Merge 2    6   1
Sort E    Merge 2    4   1
Sort F    Merge 2    6   1
Merge 1   Compare    5   1
Merge 2   Compare    4   1
Compare              5   1
;


   data resin;
      input per procesr;
      cards;
0  2
;

   proc cpm data=program resin=resin
            out=progschd resout=progrout;
      activity  task;
      duration  dur;
      successor succ;
      resource  procesr / per=per;
      run;


   title 'Scheduling Programming Tasks';
   title3 'Data Set PROGSCHD';
   proc print data=progschd;
      run;

   title ' ';
   title3 'Data Set PROGROUT';
   proc print data=progrout;
      run;

   * set up required pattern and symbol statements;
   pattern1 v=x2 c=green;
   pattern2 v=l1 c=green;
   pattern3 v=x2 c=red  ;
   pattern4 v=e  c=red  ;
   pattern5 v=r2 c=red  ;
   pattern6 v=l2 c=red  ;
   pattern7 v=e  c=black;
   pattern8 v=r2 c=blue ;

   goptions hpos=80 vpos=43;

   title f=swiss 'Scheduling Programming Tasks';
   title2 f=swiss h=1.5 'Comparison of Schedules';
   proc gantt data=progschd graphics;
      chart / font=swiss increment=2 caxis=black;
      id task;
      run;

   /* Create a data set for use with PROC GPLOT */
   data plotout;
      set progrout;
      label _time_='Time of Usage';
      label procesr='Number of Processors';
      label resource='Type of Schedule Followed';
      resourcE= 'Constrained';
      procesr=rprocesr;
      output;
      resource= 'Early Start';
      procesr=eprocesr;
      output;
      run;

   axis1 minor=none width=3 ;
   axis2 width=3 length = 80 pct;

   symbol1 i=steplj w=4 c=red;
   symbol2 i=steplj w=4 l=3 c=green;

   goptions ftext=swiss;
   title2 h=1.5 'Comparison of Processor Usage';
   proc gplot data=plotout;
      plot procesr * _time_ = resource/ vaxis=axis1
                                        haxis=axis2;
      run;


/* Example found on pages 24-27 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM6                                              */
 /*   TITLE: Multiple Projects                                   */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS:                                                     */
 /*   PROCS: NETDRAW                                             */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

   data book;
   input id $ 1-16 task $ 20-23 dur succ $ 29-32
         editor  artist;
   cards;
Preliminary Edit   PEDT  1  REV   1   .
Preliminary Edit   PEDT  1  GRPH  1   .
Revise Book        REV   2  CEDT  1   .
Graphics           GRPH  3  CEDT  .   1
Copy Edit Book     CEDT  1  PRF   1   .
Proof Read Book    PRF   1  PRNT  1   .
Print Book         PRNT  2        .   .
;

   goptions hsize=5.75 in vsize=4 in;
   goptions hpos=80 vpos=48 border;

   pattern1 v=e c=black;
   title c=black f=swiss  'Publishing a Book';
   title2 c=black f=swiss h=1.5 'Network Template';
   proc netdraw data=book graphics;
      actnet / act=task succ=succ compress font=swiss
               id=(id dur) nodefid nolabel
               lwidth=3
               xbetween=3 boxht=4 novcenter vmargin=5;
      run;

   title2 'Template Data Set';
   proc print data=book;
      run;

   data book1;
      length act $6. succ $6.;
      set book;
      subproj = "Book 1";
      act = "B1"||task;
      if succ ^= " " then succ = "B1"||succ;
      run;

   title 'Publishing Book 1';
   proc print data=book1;
      var subproj task act succ id dur editor artist;
      run;

   data book2;
      length act $6. succ $6.;
      set book;
      subproj = "Book 2";
      act  = "B2"||task;
      if act = "B2PEDT" then dur = 2;
      if succ ^= " "    then succ = "B2"||succ;
      run;

   title 'Publishing Book 2';
   proc print data=book2;
      var subproj task act succ id dur editor artist;
      run;


   data books;
      set book1 book2;
      if subproj = "Book 1" then priority = 1;
      else                       priority = 2;
      run;

   title 'Publishing Books 1 and 2';
   proc print data=books;
      var subproj priority task act succ id dur editor artist;
      run;

   data resource;
      input avdate date7. editor artist;
      format avdate date7.;
      cards;
1jan93   1   1
;


   title 'Resources Available';
   proc print data=resource;
      run;

   proc cpm data=books resin=resource
            out=bookschd resout=booksout
            date='1jan93'd interval=week;
      act      act;
      dur      dur;
      succ     succ;
      resource editor artist / per=avdate
                               avp rcp
                               rule=actprty
                               actprty=priority
                               delayanalysis;
      id       id task subproj;
      run;

   title 'Schedule for Project BOOKS';
   proc print data=bookschd;
      run;

   title 'Resource Usage for Project BOOKS';
   proc print data=booksout;
      run;

   goptions hpos=98 vpos=60;
   pattern1 v=e c=green;
   pattern2 v=e c=red;
   title c=black f=swiss h=4 'Schedule for Project Books';
   proc netdraw data=bookschd graphics;
      actnet / act=act succ=succ font=swiss
               id=(task) nodefid nolabel
               lwidth=3 lwoutline=5 xbetween=3
               zone=subproj zonepat zonespace
               align=s_start separatearcs;
      label subproj = 'Sub-Project';
      run;


/* Example found on pages 28-30 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM7                                              */
 /*   TITLE: Sequential Scheduling of Projects                   */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS:                                                     */
 /*   PROCS: CPM, PRINT                                          */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

   data book;
   length task succ $8.;
   input id $ 1-16 task $ 20-23 dur succ $ 29-32
         editor  artist;
   cards;
Preliminary Edit   PEDT  1  REV   1   .
Preliminary Edit   PEDT  1  GRPH  1   .
Revise Book        REV   2  CEDT  1   .
Graphics           GRPH  3  CEDT  .   1
Copy Edit Book     CEDT  1  PRF   1   .
Proof Read Book    PRF   1  PRNT  1   .
Print Book         PRNT  2        .   .
;

   data book1;
      set book;
      subproj = "Book 1";
      act  = "B1"||task;
      if succ ^= " " then succ = "B1"||succ;
      run;

   data book2;
      set book;
      subproj = "Book 2";
      act  = "B2"||task;
      if act  = "B2PEDT" then dur = 2;
      if succ ^= " "    then succ = "B2"||succ;
      run;

   data resource;
      input avdate date7. editor artist;
      format avdate date7.;
      cards;
1jan93   1   1
;

   /* Schedule the higher priority project first */
   proc cpm data=book1 resin=resource
            out=bk1schd resout=bk1out
            date='1jan93'd interval=week;
      act      act;
      dur      dur;
      succ     succ;
      resource editor artist / per=avdate avp rcp;
      id       id;
      run;

   /* Construct the Resource availability data set */
   /* with proper resource names                   */
   data remres;
      set bk1out;
      avdate=_time_;
      editor=aeditor;
      artist=aartist;
      keep avdate editor artist;
      format avdate date7.;
      run;

   proc cpm data=book2 resin=remres
          out=bk2schd resout=bk2out
          date='1jan93'd interval=week;
    act      act;
    dur      dur;
    succ     succ;
    resource editor artist / per=avdate avp rcp;
    id       id;
    run;


   TITLE 'Schedule for sub-project BOOK1';
   proc print data=bk1schd;
      run;

   TITLE 'Resource Usage for sub-project BOOK1';
   proc print data=bk1out;
      run;

   TITLE 'Schedule for sub-project BOOK2';
   proc print data=bk2schd;
      run;

   title 'Resource Usage for sub-project BOOK2';
   proc print data=bk2out;
      run;


/* Example found on pages 31-36 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM8                                              */
 /*   TITLE: Cost Analysis                                       */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS:                                                     */
 /*   PROCS: CPM, PRINT                                          */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data survcost;
   input id        $ 1-20
         activity  $ 22-29
         duration
         succ1     $ 34-41
         succ2     $ 43-50
         succ3     $ 52-59
         cost;
   cards;
Plan Survey          plan sur 4  hire per design q          300
Hire Personnel       hire per 5  trn per                    350
Design Questionnaire design q 3  trn per  select h print q  100
Train Personnel      trn per  3  cond sur                   500
Select Households    select h 3  cond sur                   300
Print Questionnaire  print q  4  cond sur                   250
Conduct Survey       cond sur 10 analyze                    200
Analyze Results      analyze  6                             500
;

data holidata;
   format hol date7.;
   hol = '3jul92'd;
   run;

data costavl;
   input per date7. otype $ cost;
   format per date7.;
   cards;
.       restype   2
1jul92  reslevel  12000
;


   proc cpm date='1jul92'd interval=weekday
            data=survcost  resin=costavl
            out=sched      resout=survrout
            holidata=holidata;
      activity   activity;
      successor  succ1-succ3;
      duration   duration;
      holiday    hol;
      id         id;
      resource   cost / period  = per
                        obstype = otype
                        cumusage;
      run;

   data basecost (keep = _time_ bcws);
      set survrout;
      bcws = ecost;
      run;


data actual;
   input id $ 1-20 as date9. af date9. actcost;
   format as af date7.;
   cards;
Plan Survey           1JUL92   8JUL92   275
Hire Personnel        9JUL92  15JUL92   350
Design Questionnaire 10JUL92  14JUL92   150
Train Personnel      16JUL92  17JUL92   800
Select Households    15JUL92  17JUL92   450
Print Questionnaire  15JUL92  20JUL92   250
Conduct Survey       21JUL92   .        200
;

   data update;
      merge survcost actual;
      run;

   Title 'Updated Project Data';
   proc print;
      run;

data costavl2;
   input per date7. otype $ cost actcost;
   format per date7.;
   cards;
.       restype   2      2
1jul92  reslevel  12000  12000
;

   proc cpm date='1jul92'd interval=weekday
            data=update    resin=costavl2
            out=updsched   resout=updtrout
            holidata=holidata;
      activity   activity;
      successor  succ1-succ3;
      duration   duration;
      holiday    hol;
      id         id;
      resource   cost actcost / per     = per
                                obstype = otype
                                maxdate = '21jul92'd
                                cumusage;
      actual / a_start=as a_finish=af;
      run;

   Title 'Updated Schedule: Data Set UPDSCHED';
   proc print data=updsched;
      run;

   data updtcost (keep = _time_ bcwp acwp);
      set updtrout;
      bcwp = ecost;
      acwp = eactcost;
      run;

   /* Create a combined data set to contain the BCWS, BCWP, ACWP */
   /* per day and the cumulative values for these costs.         */
   data costs;
      merge basecost updtcost;
      run;

   title 'BCWS, BCWP, and ACWP';
   proc print data=costs;
      run;


   /* Plot the cumulative costs */
   data costplot (keep=date dollars id);
      set costs;
      format date date7.;
      date = _time_;
      if bcws ^= . then do;
         dollars = BCWS; id = 1; output;
         end;
      if bcwp ^= . then do;
         dollars = BCWP; id = 2; output;
         end;
      if acwp ^= . then do;
         dollars = ACWP; id = 3; output;
         end;
      run;

   legend1 frame
           value=(f=swiss c=black j=l f=swiss 'BCWS' 'BCWP' 'ACWP')
           label=(f=swiss c=black);
   axis1 width=2
         order=('1jul92'd to '1aug92'd by week)
         length=60 pct
         value=(f=swiss c=black)
         label=(f=swiss c=black);
   axis2 width=2
         order=(0 to 12000 by 2000)
         length = 55 pct
         value=(f=swiss c=black)
         label=(f=swiss c=black);

   symbol1 i=join v=none c=green  w=4 l=1;
   symbol2 i=join v=none c=blue   w=4 l=2;
   symbol3 i=join v=none c=red    w=4 l=3;
   title f=swiss c=black 'Comparison of Costs';

   proc gplot data=costplot;
      plot dollars * date = id / legend=legend1
                                 haxis=axis1
                                 vaxis=axis2;
      run;


/* Example found on pages 38-39 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: INTPM9                                              */
 /*   TITLE: DTREE Example for Introduction to Project Management*/
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: OR GRAPHICS                                         */
 /*   PROCS: DTREE                                               */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/


title "Sub-Contracting Decision";

 /* create the STAGEIN= data set */
data stage;
   input _STNAME_ $12. _STTYPE_  $4. _OUTCOM_ $12.
         _REWARD_ dollar12.0 _SUCCES_ $12.;
   format _REWARD_ comma12. ;
   cards;
Assignment  D   In_House    .           Complete
.           .   Consult1    -$20,000    Act_Finish
.           .   Consult2    -$18,000    Act_Finish
Complete    C   On_Time     .           Cost
.           .   Delay       -$10,000    Cost
Act_Finish  C   Early       .           .
            .   Late        .           .
            .   Delay2      -$1,000     .
Cost        C   High        .           .
.           .   Low         .           .
;

title2 'The Stage Data Set';
proc print;
   run;

 /* create the PROBIN= data set */
data prob;
   input _GIVEN_ $12. _EVENT_ $12. _PROB_ 8.2;
   cards;
.           High        0.5
.           Low         0.5
.           On_Time     0.6
.           Delay       0.4
Consult1    Early       0.6
Consult1    Late        0.35
Consult1    Delay2      0.05
Consult2    Early       0.5
Consult2    Late        0.4
Consult2    Delay2      0.1
;

title2 'The Probability Data Set';
proc print;
   run;

 /* create PAYOFFS= data set */
data payoff;
   input (_STATE1-_STATE2) ($12.)
         _VALUE_           dollar12.0;
   format _VALUE_ comma12. ;
   cards;
On_Time     High        -$12,000
On_Time     Low          -$9,500
Delay       High        -$15,000
Delay       Low         -$11,500
Early       .             $3,500
Late        .             $1,500
Delay2      .                  0
;

title2 'The Payoffs Data Set';
proc print;
   run;

title2;

 /* PROC DTREE statements */
proc dtree stagein=stage
           probin=prob
           payoffs=payoff
           nowarning
           ;
   evaluate;
   treeplot / graphics
              compress ybetween=1 cell
              lwidth=5 lwidthb=10 hsymbol=2
              ;
quit;


/* Example found on page 48 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM0                                                */
 /*   TITLE: Software Development Project                        */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM, PRINT                                          */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF: Getting Started section of the CPM Chapter          */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data software;
   input descrpt  $char20.
         duration 23-24
         activity $ 27-34
         succesr1 $ 37-44
         succesr2 $ 47-54;
   cards;
Initial Testing       20  TESTING   RECODE
Prel. Documentation   15  PRELDOC   DOCEDREV  QATEST
Meet Marketing        1   MEETMKT   RECODE
Recoding              5   RECODE    DOCEDREV  QATEST
QA Test Approve       10  QATEST    PROD
Doc. Edit and Revise  10  DOCEDREV  PROD
Production            1   PROD
;

proc cpm data=software
         out=intro1
         interval=day
         date='01mar92'd;
   id descrpt;
   activity activity;
   duration duration;
   successor succesr1 succesr2;
run;

title 'Project Schedule';
proc print data=intro1;
run;


/* Example found on pages 120-121 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM3                                                */
 /*   TITLE: Meeting Project Deadlines                           */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Arc representation of the project */
data widgaoa;
   input task $ 1-12 days tail head;
   cards;
Approve Plan   5   1   2
Drawings      10   2   3
Anal. Market   5   2   4
Write Specs    5   2   3
Prototype     15   3   5
Mkt. Strat.   10   4   6
Materials     10   5   7
Facility      10   5   7
Init. Prod.   10   7   8
Evaluate      10   8   9
Test Market   15   6   9
Changes        5   9  10
Production     0  10  11
Marketing      0   6  12
Dummy          0   8   6
;

proc cpm data=widgaoa fbdate='1mar92'd interval=day;
   tailnode tail;
   headnode head;
   duration days;
   id task;
   run;

options ps=60 ls=78;

proc sort;
   by e_start;
   run;

title 'Meeting Project Deadlines';
title2 'Specification of Project Finish Date';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;

proc cpm data=widgaoa
   fbdate='1mar92'd date='2dec91'd interval=day;
   tailnode tail;
   headnode head;
   duration days;
   id task;
   run;

proc sort;
   by e_start;
   run;

title2 'Specifying Project Start and Completion Dates';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;


/* Example found on pages 124-125 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM5                                                */
 /*   TITLE: Precedence Gantt Chart                              */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM, GANTT                                          */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Arc representation of the project */
data widgaoa;
   input task $ 1-12 days tail head;
   cards;
Approve Plan   5   1   2
Drawings      10   2   3
Anal. Market   5   2   4
Write Specs    5   2   3
Prototype     15   3   5
Mkt. Strat.   10   4   6
Materials     10   5   7
Facility      10   5   7
Init. Prod.   10   7   8
Evaluate      10   8   9
Test Market   15   6   9
Changes        5   9  10
Production     0  10  11
Marketing      0   6  12
Dummy          0   8   6
;

data details;
   input task $ 1-12 dept $ 15-27 descrpt $ 30-59;
   label dept = "Department"
         descrpt = "Activity Description";
   cards;
Dev. Concept  Planning       Develop Concept
Drawings      Engineering    Prepare Drawings
Anal. Market  Marketing      Analyze Potential Markets
Write Specs   Engineering    Write Specifications
Prototype     Engineering    Build Prototype
Mkt. Strat.   Marketing      Develop Marketing Concept
Materials     Manufacturing  Procure Raw Materials
Facility      Manufacturing  Prepare Manufacturing Facility
Init. Prod.   Manufacturing  Initial Production Run
Evaluate      Testing        Evaluate Product In-House
Test Market   Testing        Test Product in Sample Market
Changes       Engineering    Engineering Changes
Production    Manufacturing  Begin Full Scale Production
Marketing     Marketing      Begin Full Scale Marketing
Dummy                        Production Milestone
;

data widgeta;
   merge widgaoa details;
   run;

proc cpm data=widgeta out=save
     date='2dec91'd interval=day;
   tailnode tail;
   headnode head;
   duration days;
   id task descrpt;
   run;

proc sort;
   by e_start;
   run;

* specify the device on which you want the chart printed;

goptions vpos=50 hpos=80 border;

goptions hsize=5.75 in vsize=4 in;

* set up required pattern statements;

pattern1 v=x1 c=green;
pattern2 v=l2 c=green;
pattern3 v=x2 c=red;
title f=swiss 'Precedence Gantt Chart';
title2 f=swiss 'Early and Late Start Schedule';
proc gantt graphics data=save;
   chart / compress tailnode=tail headnode=head
           font=swiss height=1.5 nojobnum skip=2
           cprec=cyan cmile=magenta
           dur=days increment=7 nolegend;
   id descrpt;
   run;


/* Example found on pages 125-128 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM6                                                */
 /*   TITLE: Changing Duration Units                             */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

proc cpm data=widget out=save
     date='2dec91'd interval=weekday;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   run;

options ls=78;
title 'Changing Duration Units';
title2 'INTERVAL=WEEKDAY';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;

proc sort;
   by e_start;
   run;

 /* truncate schedule: print only for december */
data december; set save;
   e_finish = min('31dec91'd, e_finish);
   if e_start <= '31dec91'd;
   run;

title3 'Calendar of Schedule';
proc calendar data=december schedule weekdays;
   id e_start;
   finish e_finish;
   var task;
   run;

data widgwk;
   set widget;
   weeks = days / 5;
   run;

proc cpm data=widgwk date='2dec91'd interval=week;
   activity task;
   succ     succ1 succ2 succ3;
   duration weeks;
   id task;
   run;

title2 'INTERVAL=WEEK';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;


/* Example found on pages 131-135 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM8                                                */
 /*   TITLE: Scheduling Around Holidays                          */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 .       .
;

TITLE 'Scheduling Around Holidays';
title2 'Data Set HOLIDAYS';
proc print;
   run;

proc cpm data=widget holidata=holidays
         out=saveh date='2dec91'd ;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   run;

proc sort data=saveh;
   by e_start;
   run;

TITLE 'Scheduling Around Holidays';

title2 'Project Schedule';

goptions vpos=50 hpos=80 border;
goptions ftext=swiss cback=white ctext=black colors=(black);
goptions hsize=5.75 in vsize=4 in;

* set up required pattern statements;

pattern1 v=x1 c=black;
pattern2 v=l2 c=black;
pattern3 v=x2 c=black;
pattern4 v=e  c=black r=4;
proc gantt graphics data=saveh holidata=holidays;
   chart / compress
           font=swiss height=1.5 nojobnum skip=2
           dur=days increment=7
           holiday=(holiday) holifin=(holifin);
   id task;
   run;

proc cpm data=widget holidata=holidays
         out=saveh1 date='2dec91'd
         interval=day;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holidur=(holidur);
   run;
proc sort data=saveh1;
   by e_start;
   run;

TITLE2 'Variable Length Holidays : INTERVAL=DAY';
proc gantt graphics data=saveh1 holidata=holidays;
   chart / compress
           font=swiss height=1.5 nojobnum skip=2
           dur=days increment=7
           holiday=(holiday) holidur=(holidur) interval=day;
   id task;
   run;



proc cpm data=widget holidata=holidays
         out=saveh2 date='2dec91'd
         interval=weekday;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holidur=(holidur);
   run;

proc sort data=saveh2;
   by e_start;
   run;

TITLE2 'Variable Length Holidays : INTERVAL=WEEKDAY';
proc gantt graphics data=saveh2 holidata=holidays;
   chart / compress
           font=swiss height=1.5 nojobnum skip=2
           dur=days increment=7
           holiday=(holiday) holidur=(holidur) interval=weekday;
   id task;
   run;

proc cpm data=widget holidata=holidays
         out=saveh3 date='2dec91'd
         interval=workday;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holidur=(holidur);
   run;

proc sort data=saveh3;
   by e_start;
   run;

TITLE2 'Variable Length Holidays : INTERVAL=WORKDAY';
proc gantt graphics data=saveh3 holidata=holidays;
   chart / compress
           font=swiss height=1.5 nojobnum skip=2
           dur=days increment=7
           holiday=(holiday) holidur=(holidur) interval=workday;
   id task;
   run;


/* Example found on pages 137-139 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM9                                                */
 /*   TITLE: CALEDATA and WORKDATA Data Sets                     */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

TITLE 'Scheduling on the 6-Day Week';

 /* Activity-on-Node representation of the project */
data widget9;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan 5.5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs  4.5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

title2 'Data Set WIDGET9';
proc print;
   run;

data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 .       .
;

 /* Set up a 6-day work week, with Sundays off */
 data calendar;
    _sun_='holiday';
    run;

proc cpm data=widget9 holidata=holidays
         out=savec date='2dec91:07:00'dt
         interval=dtday daylength='08:30't
         calendar=calendar;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   run;

proc print;
   var task days e_start e_finish l_start l_finish
       t_float f_float;
   run;


TITLE 'Scheduling on a Five-and-a-Half-Day Week';

 /* Set up two work patterns: one from 8 a.m. to 4 p.m.
    and the other from 8 a.m. to 12 noon */
data workdat;
   input fullday time8. halfday time8.;
   format fullday halfday time6.;
   cards;
08:00   08:00
16:00   12:00
;


proc print;
   title2 'Workdays Data Set';
   run;

 /* Define a work week with holiday on Sunday and half day on
    Saturday */
data caldat;
   input _sun_ $ _mon_ $ _tue_ $ _wed_ $
         _thu_ $ _fri_ $ _sat_ $ d_length time6.;
   format d_length time6.;
   cards;
holiday   fullday  fullday  fullday  fullday  fullday  halfday  08:00
;

proc print;
   title2 'Calendar Data Set';
   run;

proc cpm data=widget9 holidata=holidays
         out=savecw date='2dec91'd
         interval=day
         workday=workdat calendar=caldat;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   run;

proc print;
   var task days e_start e_finish l_start l_finish
       t_float f_float;
   run;

 /* To visualize the breaks, use following "dummy" data set
    to plot a schedule bar showing holidays and breaks */
data temp;
   e_start='20dec91:08:00'dt;
   e_finish='28dec91:23:59:59'dt;
   task='Schedule Breaks';
   label task='Project Calendar';
   format e_start e_finish datetime16.;
   run;

options ps=20;
proc gantt data=temp
           calendar=caldat holidata=holidays
           workday=workdat;
   chart / interval=dtday mininterval=dthour skip=0
           holiday=(holiday) holifin=(holifin) markbreak
           nojobnum nolegend increment=8 holichar='*';
   id task;
   run;


/* Example found on pages 142-149 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM10                                               */
 /*   TITLE: Multiple Calendars                                  */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget9;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan 5.5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs  4.5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

title 'Multiple Calendars';

data workdata;
   input fullday time8. halfday time8. ovtday time8.
         s1 time8. s2 time8. s3 time8.;
   format fullday halfday ovtday s1 s2 s3 time6.;
   cards;
08:00   08:00   08:00   .       08:00   .
16:00   12:00   18:00   06:00   18:00   06:00
.       .       .       08:00   20:00   08:00
.       .       .       18:00   .       18:00
.       .       .       20:00   .       .
.       .       .       .       .       .
;

proc print;
   title2 'Workdays Data Set';
   run;


data calendar;
   input  cal $ _sun_ $ _mon_$ _tue_$  _wed_$ _thu_$ _fri_$ _sat_ $;
   cards;
DEFAULT  holiday fullday fullday fullday fullday fullday holiday
OVT_CAL  holiday ovtday  ovtday  ovtday  ovtday  ovtday  halfday
PROD_CAL holiday s2      s1      s1      s1      s1      s3
;

proc print;
   title2 'CALENDAR Data Set';
   run;

data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 1jan92  .
;

title2 'Holidays Data Set';
proc print;
   run;

 /* To visualize the breaks, use following "dummy" data set
    to plot a schedule bar showing holidays and breaks for
    each calendar */
data cals;
   e_start='2dec91:00:00'dt;
   e_finish='2jan92:08:00'dt;
   label cal ='Schedule Breaks / Holidays';
   format e_start e_finish datetime16.;
   length cal $8.;
   cal='DEFAULT' ; output;
   cal='PROD_CAL'; output;
   cal='OVT_CAL' ; output;
   run;

goptions cback=white colors=(black);
goptions hsize=5.75 in vsize=2 in;
goptions hpos=160 vpos=25 ftext=swiss;
pattern1 v=e c=black r=6;
pattern2 v=s c=black;

title h=1.5 'Multiple Calendars';
title2 'Breaks and Holidays for the Different Calendars';
proc gantt data=cals graphics
           calendar=calendar holidata=holidays
           workday=workdata;
   chart / interval=dtday mininterval=dthour skip=2
           holiday=(holiday) holifin=(holifin)
           markbreak daylength='08:00't calid=cal
           ref='2dec91:00:00'dt to '2jan92:00:00'dt by dtday
           nolegend nojobnum increment=16;
   id cal;
   run;

data widgcal;
   set widget9;
   if task = 'Production' then       cal = 'PROD_CAL';
   else if task = 'Prototype' then   cal = 'OVT_CAL';
   else                              cal = 'DEFAULT';
   run;

proc cpm date='02dec91'd data=widgcal out=scheddef
   holidata=holidays daylength='08:00't
   workday=workdata
   calendar=calendar;
   holiday holiday / holifin = holifin;
   activity task;
   duration days;
   successor succ1 succ2 succ3;
   run;

title2 'Project Schedule: Default calendar';
proc print;
   var task days e_start e_finish l_start l_finish
       t_float f_float;
   run;

proc cpm date='02dec91'd data=widgcal out=schedmc
   holidata=holidays daylength='08:00't
   workday=workdata
   calendar=calendar;
   holiday holiday / holifin = holifin;
   activity task;
   duration days;
   successor succ1 succ2 succ3;
   calid cal;
   run;

title2 'Project Schedule: Three Calendars';
proc print;
   var task days cal e_start e_finish l_start l_finish
       t_float f_float;
   run;

data holidata;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur cal $;
   cards;
09dec91 .        7  Eng_cal
25dec91 27dec91  .  .
01jan92 01jan92  .  .
;

proc print;
   title2 'Holidays Data Set';
   run;

data caledata;
   input  cal $ _sun_ $ _mon_$ _tue_$  _wed_$ _thu_$ _fri_$ _sat_ $;
   cards;
DEFAULT  holiday fullday fullday fullday fullday fullday holiday
OVT_CAL  holiday ovtday  ovtday  ovtday  ovtday  ovtday  halfday
PROD_CAL holiday s2      s1      s1      s1      s1      s3
Eng_cal  .       .       .       .       .       .       .
;

proc print;
   title2 'Calendar Data Set';
   run;

data cals2;
   e_start='2dec91:00:00'dt;
   e_finish='19dec91:00:00'dt;
   label cal ='Schedule Breaks / Holidays';
   format e_start e_finish datetime16.;
   length cal $8.;
   cal='DEFAULT' ; output;
   cal='Eng_cal' ; output;
   run;

title2 'Breaks and Holidays for Eng_cal and the DEFAULT Calendar';
proc gantt data=cals2 graphics
           calendar=caledata holidata=holidata
           workday=workdata;
   chart / interval=dtday mininterval=dthour skip=2
           holiday=(holiday) holifin=(holifin) holidur=(holidur)
           markbreak daylength='08:00't calid=cal
           ref='2dec91:00:00'dt to '19dec91:00:00'dt by dtday
           nojobnum nolegend increment=16;
   id cal;
   run;

data widgvac;
   set widgcal;
   if task = 'Write Specs' then cal = 'Eng_cal';
   run;

proc cpm date='02dec91'd data=widgvac out=schedvac
   holidata=holidata daylength='08:00't
   workday=workdata
   calendar=caledata;
   holiday holiday / holifin = holifin holidur=holidur;
   activity task;
   duration days;
   successor succ1 succ2 succ3;
   calid cal;
   run;

title2 'Project Schedule: Four Calendars';
proc print;
   var task days cal e_start e_finish l_start l_finish
       t_float f_float;
   run;



/* Example found on pages 151-153 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM11                                               */
 /*   TITLE: Nonstandard Relationships                           */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/


 /* Activity-on-Node representation of the project with lags */
data widglag;
   input task $ 1-12 days succ $ 19-30 lagdur $ 33-37 lagdurc $ 40-52;
   cards;
Approve Plan   5  Drawings
Approve Plan   5  Anal. Market
Approve Plan   5  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     ss_9   ss_9
Prototype     15  Facility      ss_9   ss_9
Mkt. Strat.   10  Test Market
Mkt. Strat.   10  Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.   fs_2   fs_2_SEVENDAY
Init. Prod.   10  Test Market
Init. Prod.   10  Marketing
Init. Prod.   10  Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

data calendar;
   input  _cal_ $ _sun_ $ _mon_$ _tue_$  _wed_$ _thu_$ _fri_$ _sat_ $;
   cards;
SEVENDAY workday workday workday workday workday workday workday
;

proc cpm data=widglag date='2dec91'd
         interval=weekday collapse out=lagsched;
   activity task;
   succ     succ / lag = (lagdur);
   duration days;
   run;

title 'Non-standard Relationships';
title2 'Lag Type and Duration: Default LAG Calendar';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;

proc cpm data=widglag date='2dec91'd calendar=calendar
         interval=weekday collapse out=lagsched;
   activity task;
   succ     succ / lag = (lagdurc);
   duration days;
   run;

title2 'Lag Type, Duration and Calendar: Default Lag Calendar';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;

proc cpm data=widglag date='2dec91'd calendar=calendar
         interval=weekday collapse out=lagsched;
   activity task;
   succ     succ / lag = (lagdur) alagcal=sevenday;
   duration days;
   run;

title2 'Lag Type and Duration: LAG Calendar = SEVENDAY';
proc print;
   id task;
   var e_: l_: t_float f_float;
   run;

pattern1 v=l2 c=green;
pattern2 v=e  c=green;
pattern3 v=x2 c=red;

goptions cback=white colors=(black);
goptions hpos=100 vpos=60;
title  c=black f=swiss 'Non-standard Relationships';
title2 c=black f=swiss 'Precedence Gantt Chart';
proc gantt graphics data=lagsched logic=widglag;
   chart / compress act=task succ=(succ) dur=days
           font=swiss ctext=black caxis=black
           cprec=black cmile=blue
           dur=days increment=7 lag=(lagdur);
   id task;
   run;



/* Example found on pages 156-160 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM13                                               */
 /*   TITLE: Progress Update and Target Schedules                */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 .       .
;

* store early schedule as the baseline schedule;

proc cpm data=widget holidata=holidays
         out=widgbase date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   baseline / set=early;
   run;

title 'Progress Update and Target Schedules';
title2 'Set Baseline Schedule';
proc print data=widgbase;
   run;

* actual schedule at timenow = 20dec91;
data actual;
   input task $ 1-12 sdate date9. fdate date9. pctc rdur;
   format sdate date9. fdate date9.;
   cards;
Approve Plan  02dec91 06dec91  .    .
Drawings      07dec91 17dec91  .    .
Anal. Market  06dec91 .        100  .
Write Specs   08dec91 13dec91  .    .
Prototype     .       .        .    .
Mkt. Strat.   11dec91 .        .    3
Materials     .       .        .    .
Facility      .       .        .    .
Init. Prod.   .       .        .    .
Evaluate      .       .        .    .
Test Market   .       .        .    .
Changes       .       .        .    .
Production    .       .        .    .
Marketing     .       .        .    .
;

title2 'Progress Data';
proc print;
   run;

* merge the baseline information with progress update;

data widgact;
   merge  actual widgbase;
   run;

* estimate schedule based on actual data;

proc cpm data=widgact holidata=holidays
         out=widgnupd date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   baseline / compare=early;
   actual / as=sdate af=fdate timenow='20dec91'd
            remdur=rdur pctcomp=pctc
            noautoupdt;
   run;

proc print data=widgnupd;
   title2 'Updated Schedule vs. Target Schedule: NOAUTOUPDT';
   run;

proc cpm data=widgact holidata=holidays
         out=widgupdt date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   baseline / compare=early;
   actual / as=sdate af=fdate timenow='20dec91'd
            remdur=rdur pctcomp=pctc
            autoupdt showfloat;
   run;

proc print data=widgupdt;
   title2 'Updated Schedule vs. Target Schedule: AUTOUPDT';
   run;


/* Example found on pages 161-162 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM14                                               */
 /*   TITLE: Summarizing Resource Utilization                    */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM, FORMAT, CALENDAR, CHART                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Arc representation of the project */
data widgres;
   input task $ 1-12 days tail head engineer;
   cards;
Approve Plan   5   1   2  2
Drawings      10   2   3  1
Anal. Market   5   2   4  .
Write Specs    5   2   3  2
Prototype     15   3   5  4
Mkt. Strat.   10   4   6  .
Materials     10   5   7  .
Facility      10   5   7  2
Init. Prod.   10   7   8  4
Evaluate      10   8   9  1
Test Market   15   6   9  .
Changes        5   9  10  2
Production     0  10  11  4
Marketing      0   6  12  .
Dummy          0   8   6  .
;

title 'Summarizing Resource Utilization';
title2 'Activity Data Set';
proc print;
   run;

data holdata;
   format hol date7.;
   input hol date7. name $ 10-18;
   cards;
25dec91  Christmas
01jan92  New Year
;

proc print;
   title2 'Holidays Data Set HOLDATA';
   run;

TITLE 'Summarizing Resource Utilization';
proc cpm date='2dec91'd interval=weekday
         resourceout=rout data=widgres
         holidata=holdata;
   id task;
   tailnode tail;
   duration days;
   headnode head;
   resource engineer / maxdate='31dec91'd;
   holiday  hol;
   run;

title2 'Resource Usage';
proc print;
   run;

proc format;                  /* format the Engineer variables */
   picture efmt other='9 E Eng';
   picture lfmt other='9 L Eng';

   /* print the usage on a calendar */
proc calendar legend weekdays
     data=rout holidata=holdata;
   id _time_;
   var  eengieer lengieer;
   format eengieer efmt.
          lengieer lfmt.;
   holiday hol;
   holiname name;
   run;

proc chart data=rout;         /* plot the usage in a bar chart */
   hbar _time_/sumvar=eengieer discrete;
   run;

proc chart data=rout;         /* plot the usage in a bar chart */
   hbar _time_/sumvar=lengieer discrete;
   run;


/* Example found on pages 164-169 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM15                                               */
 /*   TITLE: Resource Allocation                                 */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Arc representation of the project */
data widgres;
   input task $ 1-12 days tail head engineer;
   cards;
Approve Plan   5   1   2  2
Drawings      10   2   3  1
Anal. Market   5   2   4  .
Write Specs    5   2   3  2
Prototype     15   3   5  4
Mkt. Strat.   10   4   6  .
Materials     10   5   7  .
Facility      10   5   7  2
Init. Prod.   10   7   8  4
Evaluate      10   8   9  1
Test Market   15   6   9  .
Changes        5   9  10  2
Production     0  10  11  4
Marketing      0   6  12  .
Dummy          0   8   6  .
;

data widgres;
   set widgres;
   if engineer ^= . then engcost = engineer * 200;
   run;

data widgrin;
   input per date7. otype $ 11-18 engineer engcost;
   format per date7.;
   cards;
.         restype  1  2
.         suplevel 1  .
02dec91   reslevel 3  40000
27dec91   reslevel 4  .
;

title 'Resource Allocation';
title2 'Data Set WIDGRIN';
proc print;
   run;

data holdata;
   format hol date7.;
   input hol date7. name $ 10-18;
   cards;
25dec91  Christmas
01jan92  New Year
;

proc cpm date='02dec91'd interval=weekday
         data=widgres holidata=holdata resin=widgrin
         out=widgschd resout=widgrout;
   tailnode tail;
   duration days;
   headnode head;
   holiday hol;
   resource engineer engcost / period=per obstype=otype
                               rule=shortdur
                               delayanalysis;
   id task;
   run;

title2 'Resource Constrained Schedule: Rule = SHORTDUR';
proc print data=widgschd;
   run;

proc print data=widgrout;
   title2 'Usage Profiles for Constrained Schedule: Rule = SHORTDUR';
   run;

proc cpm date='02dec91'd interval=weekday
         data=widgres holidata=holdata resin=widgrin
         out=widgsch2 resout=widgrou2;
   tailnode tail;
   duration days;
   headnode head;
   holiday hol;
   resource engineer engcost / period=per obstype=otype
                               rule=lst
                               delayanalysis;
   id task;
   run;

title2 'Resource Constrained Schedule: Rule = LST';
proc print data=widgsch2;
   run;

proc print data=widgrou2;
   title2 'Usage Profiles for Constrained Schedule: Rule = LST';
   run;


/* Example found on pages 197-198 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM21                                               */
 /*   TITLE: PERT Assumptions and Calculations                   */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

title 'PERT Assumptions and Calculations';
 /* Activity-on-Arc representation of the project
    with three duration estimates */
data widgpert;
   input task $ 1-12 tail head tm tp to;
   dur = (tp + 4*tm + to) / 6;
   cards;
Approve Plan    1   2    5   7   3
Drawings        2   3   10  11   6
Anal. Market    2   4    5   7   3
Write Specs     2   3    5   7   3
Prototype       3   5   15  12   9
Mkt. Strat.     4   6   10  11   9
Materials       5   7   10  12   8
Facility        5   7   10  11   9
Init. Prod.     7   8   10  12   8
Evaluate        8   9    9  13   8
Test Market     6   9   14  15  13
Changes         9  10    5   6   4
Production     10  11    0   0   0
Marketing       6  12    0   0   0
Dummy           8   6    0   0   0
;

proc cpm data=widgpert out=sched
     date='2dec91'd;
   tailnode tail;
   headnode head;
   duration dur;
   id task;
   run;

proc sort;
   by e_start;
   run;

 /* specify the device on which you want the chart printed */

goptions vpos=50 hpos=80 border;
goptions hsize=5.75 in vsize=4 in;
goptions cback=white colors=(black);

 /* set up required pattern statements */
pattern1 v=x1 c=black;
pattern2 v=l2 c=black;
pattern3 v=x2 c=black;
title2 f=swiss 'Project Schedule';
proc gantt graphics data=sched;
   chart / compress tailnode=tail headnode=head
           font=swiss height=1.5 nojobnum skip=2
           dur=dur increment=7 nolegend;
   id task;
   run;


/* Example found on pages 201-203 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: CPM22                                               */
 /*   TITLE: Scheduling Course / Teacher Combinations            */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: CPM                                                 */
 /*   PROCS: CPM                                                 */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

title 'Scheduling Course / Teacher Combinations';

data classes;
   input class $  succ $ dur  c1-c4  t1-t3  nrooms;
   cards;
c1t1  .   1   1  .  .  .  1  .  .   1
c1t2  .   1   1  .  .  .  .  1  .   1
c1t3  .   1   1  .  .  .  .  .  1   1
c2t1  .   1   .  1  .  .  1  .  .   1
c2t3  .   1   .  1  .  .  .  .  1   1
c3t1  .   1   .  .  1  .  1  .  .   1
c3t2  .   1   .  .  1  .  .  1  .   1
c3t3  .   1   .  .  1  .  .  .  1   1
c4t1  .   1   .  .  .  1  1  .  .   1
c4t2  .   1   .  .  .  1  .  1  .   1
;

data resource;
   input per c1-c4  t1-t3  nrooms;
   cards;
1       1   1  1  1  1  .  1   3
4       .   .  .  .  .  1  .   .
;

proc cpm data=classes out=sched
     resin=resource;
   activity   class;
   duration   dur;
   successor  succ;
   resource   c1-c4 t1-t3 nrooms / period=per stopdate=6;
run;

proc format;
   value classtim
      1 = 'Saturday  9:00-10:00'
      2 = 'Saturday 10:00-11:00'
      3 = 'Saturday 11:00-12:00'
      4 = 'Sunday    9:00-10:00'
      5 = 'Sunday   10:00-11:00'
      6 = 'Sunday   11:00-12:00'
      7 = 'Not Scheduled'
      ;
   value $classt
      c1t1 = 'Class 1, Teacher 1'
      c1t2 = 'Class 1, Teacher 2'
      c1t3 = 'Class 1, Teacher 3'
      c2t1 = 'Class 2, Teacher 1'
      c2t2 = 'Class 2, Teacher 2'
      c2t3 = 'Class 2, Teacher 3'
      c3t1 = 'Class 3, Teacher 1'
      c3t2 = 'Class 3, Teacher 2'
      c3t3 = 'Class 3, Teacher 3'
      c4t1 = 'Class 4, Teacher 1'
      c4t2 = 'Class 4, Teacher 2'
      c4t3 = 'Class 4, Teacher 3'
      ;

data schedtim;
   set sched;
   format classtim classtim.;
   format class    $classt.;
   if (s_start <= 6) then classtim = s_start;
   else                   classtim = 7;
   run;

Title2 'Schedule of Classes';
proc print;
   id class;
   var classtim;
   run;


data resourc2;
   input per c1-c4  t1-t3  nrooms;
   cards;
1       1   1  1  1  1  .  1   1
2       .   .  .  .  .  .  .   3
3       .   .  .  .  .  .  .   2
4       .   .  .  .  .  1  .   1
5       .   .  .  .  .  .  .   3
;

proc cpm data=classes out=sched2
     resin=resourc2;
   activity   class;
   duration   dur;
   successor  succ;
   resource   c1-c4 t1-t3 nrooms / period=per stopdate=6;
   run;

data schedtim;
   set sched2;
   format classtim classtim.;
   format class    $classt.;
   if (s_start <= 6) then classtim = s_start;
   else                   classtim = 7;
   run;

Title2 'Alternate Schedule with Additional Constraints';
proc print;
   id class;
   var classtim;
   run;


/* Example found on pages 211-247 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE0                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR PPLOT                                          */
 /*   PROCS: DTREE PRINT                                       */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                -- */
data dtoils1;
   input _STNAME_ $12. _STTYPE_  $4. _OUTCOM_ $12.
         _SUCCES_ $12.;
   cards;
Drill       D   Drill       Cost
.           .   Not_Drill   .
Cost        C   Low         Oil_Deposit
.           .   Fair        Oil_Deposit
.           .   High        Oil_Deposit
Oil_Deposit C   Dry         .
.           .   Wet         .
.           .   Soaking     .
;


 /* -- create the PROBIN= data set                 -- */
data dtoilp1;
   input _EVENT1 $12. _PROB1
         _EVENT2 $12. _PROB2
         _EVENT3 $12. _PROB3;
   cards;
Low         0.2     Fair        0.6     High        0.2
Dry         0.5     Wet         0.3     Soaking     0.2
;


 /* -- create PAYOFFS= data set                    -- */
data dtoilu1;
   input (_STATE1-_STATE3) ($12.) ;
   format _VALUE_ dollar12.0;

   /* determine the cost for this scenario */
   if _STATE1='Low' then _COST_=150000;
   else if _STATE1='Fair' then _COST_=300000;
   else _COST_=500000;

   /* determine the oil deposit and the corresponding */
   /* net payoff for this scenario                    */
   if _STATE2='Dry' then _PAYOFF_=0;
   else if _STATE2='Wet' then _PAYOFF_=700000;
   else _PAYOFF_=1200000;

   /* calculate the net return for this scenario */
   if _STATE3='Not_Drill' then _VALUE_=0;
   else _VALUE_=_PAYOFF_-_COST_;

   /* drop unneeded variables */
   drop _COST_ _PAYOFF_;

cards;
Low         Dry         Not_Drill
Low         Dry         Drill
Low         Wet         Not_Drill
Low         Wet         Drill
Low         Soaking     Not_Drill
Low         Soaking     Drill
Fair        Dry         Not_Drill
Fair        Dry         Drill
Fair        Wet         Not_Drill
Fair        Wet         Drill
Fair        Soaking     Not_Drill
Fair        Soaking     Drill
High        Dry         Not_Drill
High        Dry         Drill
High        Wet         Not_Drill
High        Wet         Drill
High        Soaking     Not_Drill
High        Soaking     Drill
;

 /* -- print the payoff table                      -- */
title "Oil Wildcatter's Problem";
title3 "The Payoffs";

proc print data=dtoilu1;
   run;


 /* -- PROC DTREE statements                       -- */
title "Oil Wildcatter's Problem";

proc dtree stagein=dtoils1
           probin=dtoilp1
           payoffs=dtoilu1
           nowarning
           ;

   evaluate / summary;

   OPTIONS LINESIZE=100;

   treeplot;

   OPTIONS LINESIZE=76;

   evaluate / criterion=maxce rt=700000 summary;

   vpi Oil_Deposit;

   vpi Cost;

   save;
   move Cost before Drill;
   evaluate;
   recall;

   vpc Cost;

quit;



 /* -- create the STAGEIN= data set                -- */
data dtoils2;
   input _STNAME_ $12. _STTYPE_ $3.  _OUTCOM_ $16.
         _SUCCES_ $12. _REWARD_ dollar12.0;
   cards;
Drill       D  Drill           Cost                 .
.           .  Not_Drill       .                    .
Cost        C  Low             Oil_Deposit          .
.           .  Fair            Oil_Deposit          .
.           .  High            Oil_Deposit          .
Oil_Deposit C  Dry             .                    .
.           .  Wet             .                    .
.           .  Soaking         .                    .
Sounding    D  Noseismic       Drill                .
.           .  Seismic         Structure     -$60,000
Structure   C  No_Struct       Drill                .
.           .  Open_Struct     Drill                .
.           .  Closed_Struct   Drill                .
;


 /* -- create PROBIN= data set                     -- */
data dtoilp2;
   input _GIVEN_ $8. _EVENT1 $10. _PROB1
                     _EVENT2 $12. _PROB2
                     _EVENT3 $14. _PROB3 ;
   cards;
.       Low       0.2 Fair        0.6 High          0.2
.       Dry       0.5 Wet         0.3 Soaking       0.2
Dry     No_Struct 0.6 Open_Struct 0.3 Closed_Struct 0.1
Wet     No_Struct 0.3 Open_Struct 0.4 Closed_Struct 0.3
Soaking No_Struct 0.1 Open_Struct 0.4 Closed_Struct 0.5
;


 /* -- create PAYOFFS= data set                    -- */
data dtoilu1;
   input (_STATE1-_STATE3) ($12.) ;
   format _VALUE_ dollar12.0;

   /* determine the cost for this scenario */
   if _STATE1='Low' then _COST_=150000;
   else if _STATE1='Fair' then _COST_=300000;
   else _COST_=500000;

   /* determine the oil deposit and the corresponding */
   /* net payoff for this scenario                    */
   if _STATE2='Dry' then _PAYOFF_=0;
   else if _STATE2='Wet' then _PAYOFF_=700000;
   else _PAYOFF_=1200000;

   /* calculate the net return for this scenario */
   if _STATE3='Not_Drill' then _VALUE_=0;
   else _VALUE_=_PAYOFF_-_COST_;

   /* drop unneeded variables */
   drop _COST_ _PAYOFF_;

cards;
Low         Dry         Not_Drill
Low         Dry         Drill
Low         Wet         Not_Drill
Low         Wet         Drill
Low         Soaking     Not_Drill
Low         Soaking     Drill
Fair        Dry         Not_Drill
Fair        Dry         Drill
Fair        Wet         Not_Drill
Fair        Wet         Drill
Fair        Soaking     Not_Drill
Fair        Soaking     Drill
High        Dry         Not_Drill
High        Dry         Drill
High        Wet         Not_Drill
High        Wet         Drill
High        Soaking     Not_Drill
High        Soaking     Drill
;


 /* -- PROC DTREE statements                       -- */
title "Oil Wildcatter's Problem";

proc dtree stagein=dtoils2
           probin=dtoilp2
           payoffs=dtoilu1
           nowarning
           ;

   evaluate;

   summary / target=Sounding;
   summary / target=Drill;

   save;
   modify Seismic reward 0;
   evaluate;
   recall;

quit;



 /* -- create the STAGEIN= data set                -- */
data dtoils3;
   input _STNAME_ $12. _STTYPE_  $4. _OUTCOM_ $12.
         _REWARD_ dollar12.0  _SUCCES_ $12.;
   cards;
Drill       D   Drill              .    Cost
.           .   Not_drill          .    .
Cost        C   Low           -$150,000 Oil_deposit
.           .   Fair          -$300,000 Oil_deposit
.           .   High          -$500,000 Oil_deposit
Oil_deposit C   Dry                .    .
.           .   Wet            $700,000 .
.           .   Soaking      $1,200,000 .
;


 /* -- create PAYOFFS= data set                    -- */
data dtoilp3;
   input _EVENT1 $12. _PROB1 8.1 _EVENT2 $12. _PROB2 8.1;
   cards;
Low         0.2     Dry         0.5
Fair        0.6     Wet         0.3
High        0.2     Soaking     0.2
;


 /* -- PROC DTREE statements                       -- */
title "Oil Wildcatter's Problem";

proc dtree stagein=dtoils3
           probin=dtoilp3
           nowarning
           ;

  evaluate / summary;

  move COST before DRILL;
  evaluate / summary;

quit;


 /* -- clear up                                    -- */
title ;


/* Example found on pages 260-263 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE1                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR                                                */
 /*   PROCS: DTREE PRINT                                       */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                     -- */
data dtoils4;
   input STAGE $12. STYPE  $4. OUTCOME $16. SUCC $12.
         PREMIUM dollar12.0;
   cards;
Drill       D   Drill           Insurance              .
.           .   Not_Drill       .                      .
Insurance   D   Buy_Insurance   Cost           -$130,000
.           .   Do_Not_Buy      Cost                   .
Cost        C   Low             Oil_Deposit            .
.           .   Fair            Oil_Deposit            .
.           .   High            Oil_Deposit            .
Oil_Deposit C   Dry             .                      .
.           .   Wet             .                      .
.           .   Soaking         .                      .
;

 /* -- create the PROBIN= data set                      -- */
data dtoilp4;
   input (V1-V3) ($12.) (P1-P3) (8.2);
   cards;
Low         Fair        High        0.2     0.6     0.2
Dry         Wet         Soaking     0.5     0.3     0.2
;

 /* -- create PAYOFFS= data set                         -- */
data dtoilu4;
   input (COST DEPOSIT DRILL INSURAN ) ($16.) ;
   format PAYOFF dollar12.0;

   /* determine the cost for this scenario */
   if      COST='Low'  then RCOST=150000;
   else if COST='Fair' then RCOST=300000;
   else                     RCOST=500000;

   /* determine the oil deposit and the corresponding  */
   /* net payoff for this scenario                     */
   if      DEPOSIT='Dry' then RETURN=0;
   else if DEPOSIT='Wet' then RETURN=700000;
   else                       RETURN=1200000;

   /* calculate the net return for this scenario */
   if      DRILL='Not_Drill' then PAYOFF=0;
   else                           PAYOFF=RETURN-RCOST;

   /* determine redeem received for this scenario */
   if INSURAN='Buy_Insurance' and DEPOSIT='Dry' then
      PAYOFF=PAYOFF+200000;

   /* drop unneeded variables */
   drop RCOST RETURN;

cards;
Low             Dry             Not_Drill       .
Low             Dry             Drill           Buy_Insurance
Low             Dry             Drill           Do_Not_Buy
Low             Wet             Not_Drill       .
Low             Wet             Drill           Buy_Insurance
Low             Wet             Drill           Do_Not_Buy
Low             Soaking         Not_Drill       .
Low             Soaking         Drill           Buy_Insurance
Low             Soaking         Drill           Do_Not_Buy
Fair            Dry             Not_Drill       .
Fair            Dry             Drill           Buy_Insurance
Fair            Dry             Drill           Do_Not_Buy
Fair            Wet             Not_Drill       .
Fair            Wet             Drill           Buy_Insurance
Fair            Wet             Drill           Do_Not_Buy
Fair            Soaking         Not_Drill       .
Fair            Soaking         Drill           Buy_Insurance
Fair            Soaking         Drill           Do_Not_Buy
High            Dry             Not_Drill       .
High            Dry             Drill           Buy_Insurance
High            Dry             Drill           Do_Not_Buy
High            Wet             Not_Drill       .
High            Wet             Drill           Buy_Insurance
High            Wet             Drill           Do_Not_Buy
High            Soaking         Not_Drill       .
High            Soaking         Drill           Buy_Insurance
High            Soaking         Drill           Do_Not_Buy
;

 /* -- print the payoff table                           -- */
title "Oil Wildcatter's Problem";
title3 "The Payoffs";

proc print data=dtoilu4;
   run;


 /* -- PROC DTREE statements                            -- */
title "Oil Wildcatter's Problem";

proc dtree stagein=dtoils4
           probin=dtoilp4
           payoffs=dtoilu4
           nowarning
           ;

  variables / stage=STAGE type=STYPE outcome=(OUTCOME)
              reward=(PREMIUM) successor=(SUCC)
              event=(V1 V2 V3) prob=(P1 P2 P3)
              state=(COST DEPOSIT DRILL INSURAN)
              payoff=(PAYOFF);

  evaluate;

  summary / target=Insurance;

  reset criterion=maxce rt=1200000;
  summary / target=Insurance;
quit;


 /* -- clear up                                         -- */
title ;


/* Example found on pages 265-275 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE2                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR GRAPHICS                                       */
 /*   PROCS: DTREE PRINT FORMAT GPLOT                          */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                        -- */
data dtoils4;
   input _STNAME_ $16. _STTYPE_  $12. _OUTCOM_ $16.
                                      _SUCCES_ $16. ;
   cards;
Divestment      Decision    No_Divestment      Insurance
.               .           10%_Divestment     Insurance
.               .           20%_Divestment     Insurance
.               .           30%_Divestment     Insurance
.               .           40%_Divestment     Insurance
.               .           50%_Divestment     Insurance
.               .           60%_Divestment     Insurance
.               .           70%_Divestment     Insurance
.               .           80%_Divestment     Insurance
.               .           90%_Divestment     Insurance
.               .           100%_Divestment    .
Insurance       Decision    Buy_Insurance      Cost
.               .           Do_Not_Buy         Cost
Cost            Chance      Low                Oil_Deposit
.               .           Fair               Oil_Deposit
.               .           High               Oil_Deposit
Oil_Deposit     Chance      Dry                .
.               .           Wet                .
.               .           Soaking            .
;

 /* -- create the PROBIN= data set                         -- */
data dtoilp4;
   input _EVENT1 $12. _PROB1 8.2 _EVENT3 $12. _PROB3 8.2;
   cards;
Low         0.2     Dry         0.5
Fair        0.6     Wet         0.3
High        0.2     Soaking     0.2
;

 /* -- create the PAYOFFS= data set                        -- */
data dtoilu4(drop=i j k l);
   length _STATE1-_STATE4 $16. ;
   format _VALUE_ dollar12.0;

   /* define and initialize arrays */
   array DIVEST{11}  $16. _TEMPORARY_ ('No_Divestment',
                                       '10%_Divestment',
                                       '20%_Divestment',
                                       '30%_Divestment',
                                       '40%_Divestment',
                                       '50%_Divestment',
                                       '60%_Divestment',
                                       '70%_Divestment',
                                       '80%_Divestment',
                                       '90%_Divestment',
                                       '100%_Divestment'  );
   array INSUR{3} $16.    _TEMPORARY_ ('Do_Not_Buy',
                                       'Buy_Insurance',
                                       ''                 );
   array COST{4} $        _TEMPORARY_ ('Low',
                                       'Fair',
                                       'High',
                                       ''                 );
   array DEPOSIT{4} $     _TEMPORARY_ ('Dry',
                                       'Wet',
                                       'Soaking',
                                       ''                 );

   do i=1 to 10;            /* loop for each divestment */
      _STATE1=DIVEST{i};

      /*
       * determine the percentage of ownership retained
       * for this scenario
       */
      PCT=1.0-((i-1)*0.1);

      do j=1 to 2;       /* loop for insurance decision */
         _STATE2=INSUR{j};

         /*
          * determine the premium need to pay for this
          * scenario
          */
         if _STATE2='Buy_Insurance' then PREMIUM=130000;
         else                            PREMIUM=0;

         do k=1 to 3;        /* loop for each well cost */
            _STATE3=COST{k};

            /* determine the cost for this scenario */
            if      _STATE3='Low' then  _COST_=150000;
            else if _STATE3='Fair' then _COST_=300000;
            else                        _COST_=500000;

            do l=1 to 3;  /* loop for each deposit type */
               _STATE4=DEPOSIT{l};

               /*
                * determine the oil deposit and the
                * corresponding net payoff for this scenario
                */
               if      _STATE4='Dry' then _PAYOFF_=0;
               else if _STATE4='Wet' then _PAYOFF_=700000;
               else                       _PAYOFF_=1200000;

               /* determine redeem received for this scenario */
               if _STATE2='Buy_Insurance' and _STATE4='Dry' then
                    REDEEM=200000;
               else REDEEM=0;

               /* calculate the net return for this scenario */
               _VALUE_=(_PAYOFF_-_COST_-PREMIUM+REDEEM)*PCT;

               /* drop unneeded variables */
               drop _COST_ _PAYOFF_ PREMIUM REDEEM PCT;

               /* output this record */
               output;
            end;
         end;
      end;
   end;

   /* output an observation for the scenario 100%_Divestment */
   _STATE1=DIVEST{11};
   _STATE2=INSUR{3};
   _STATE3=COST{4};
   _STATE4=DEPOSIT{4};
   _VALUE_=0;
   output;

run;

 /* -- print the payoff table                              -- */
title "Oil Wildcatter's Problem";
title3 "The Payoffs";

proc print data=dtoilu4;
   run;


 /* -- PROC DTREE statements                               -- */
title "Oil Wildcatter's Problem";

proc dtree stagein=dtoils4
           probin=dtoilp4
           payoffs=dtoilu4
     criterion=maxce rt=1200000
     nowarning ;

  evaluate;
  summary / target=Divestment;
  summary / target=Insurance;

quit;


 /*  create a data set for the return corresponds to each  */
 /*  divestment possibilities and the insurance options    */
data data2g;
   input  INSURE DIVEST VALUE;
   cards;
       1       0   45728
       0       0   44499
       1      10   46552
       0      10   48021
       1      20   46257
       0      20   49907
       1      30   44812
       0      30   50104
       1      40   42186
       0      40   48558
       1      50   38350
       0      50   45219
       1      60   33273
       0      60   40036
       1      70   26927
       0      70   32965
       1      80   19284
       0      80   23961
       1      90   10317
       0      90   12985
       1     100       0
       0     100       0
;

 /* -- define a format for INSURE variable                 -- */
proc format;
   value sample 0='Do_Not_Buy'
                1='Buy_Insurance';
run;

 /* -- set text font                                       -- */
goptions ftext=centb;

 /* define symbol characteristics of the data points and the   */
 /* interpolation line for returns vs divestment when INSURE=0 */
symbol1 c=blue i=join v=diamond l=1 w=4 h=2;

 /* define symbol characteristics of the data points and the   */
 /* interpolation line for returns vs divestment when INSURE=1 */
symbol2 c=green i=join v=star l=2 w=4 h=2;

 /* -- define title                                        -- */
title f=centb h=3 "Oil Wildcatter's Problem";
footnote f=centb "   ";

 /* -- define axis characteristics                         -- */
axis1 label=('Divestment (in percentage)');
axis2 label=(angle=90 'Certainty Equivalent');

 /* -- plot VALUE vs DIVEST using INSURE as third variable -- */
proc gplot data=data2g ;
   plot VALUE*DIVEST=INSURE / haxis=axis1
                              vaxis=axis2
                              name="dt2"
                              ;
   format INSURE SAMPLE.;
   run;

quit;


 /* -- reset title                                         -- */
title;




/* Example found on pages 277-278 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE3                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR GRAPHICS                                       */
 /*   PROCS: DTREE                                             */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                    -- */
data stage3;
   input _STNAME_ $16. _STTYPE_ $4. _OUTCOM_ $16.
         _SUCCES_ $16. _REWARD_ dollar8.0;
   cards;
Choose          D   Build_Prototype Cost_Prototype       .
.               .   No_Prototype    Bid                  .
Cost_Prototype  C   Expensive       Bid              -$4,500
.               .   Moderate        Bid              -$2,500
.               .   Inexpensive     Bid              -$1,000
Bid             D   High_Bid        Contract             .
.               .   Low_Bid         Contract             .
Contract        C   Win_Contract    .                    .
.               .   Lose_Contract   .                    .
;


 /* -- create the PROBIN= data set                     -- */
data prob3;
   input (_GIVEN1_ _GIVEN2_ _EVENT_) ($16.) _PROB_;
   cards;
.               .               Expensive       0.4
.               .               Moderate        0.5
.               .               Inexpensive     0.1
Build_Prototype High_Bid        Win_Contract    0.4
Build_Prototype High_Bid        Lose_Contract   0.6
Build_Prototype Low_Bid         Win_Contract    0.8
Build_Prototype Low_Bid         Lose_Contract   0.2
No_Prototype    High_Bid        Win_Contract    0.2
No_Prototype    High_Bid        Lose_Contract   0.8
No_Prototype    Low_Bid         Win_Contract    0.7
No_Prototype    Low_Bid         Lose_Contract   0.3
;

 /* -- create the PAYOFFS= data set                    -- */
data payoff3;
   input (_STATE1_ _STATE2_ _ACTION_) ($16.)
         _VALUE_  dollar8.0;
   cards;
Win_Contract    .               Low_Bid         $35,000
Win_Contract    .               High_Bid        $75,000
Win_Contract    Expensive       Low_Bid         $25,000
Win_Contract    Expensive       High_Bid        $65,000
Win_Contract    Moderate        Low_Bid         $35,000
Win_Contract    Moderate        High_Bid        $75,000
Win_Contract    Inexpensive     Low_Bid         $45,000
Win_Contract    Inexpensive     High_Bid        $85,000
;

 /* -- define title                                    -- */
title1 font=swissb h=2 "Contract Bidding Example" ;

 /* -- define colors list                              -- */
goptions cback=white ctex=black;
goptions colors=(black red blue green);

 /* -- PROC DTREE statements                           -- */
proc dtree stagein=stage3 probin=prob3 payoffs=payoff3
     graphics
     nowarning
     ;
  evaluate;
  treeplot / name="dt3" compress ybetween=1 cell
             ftext=swissbu htext=1 hsymbol=3
             lstyleb=3 lwidth=20 lwidthb=25;
quit;


 /* -- reset title                                     -- */
title;


/* Example found on pages 281-283 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE4                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR GRAPHICS ANNOTATE SYMBOL                       */
 /*   PROCS: DTREE                                             */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                   -- */
data stage4;
   input _STNAME_ $ 1-16 _STTYPE_ $ 17-20
         _OUTCOM_ $ 21-32 _REWARD_ dollar12.0
         _SUCC_ $ 45-60;
   cards;
R_and_D         D   Not_Conduct .           .
.               .   Conduct     -$350,000   RD_Outcome
RD_Outcome      C   Success     .           Production
.               .   Failure     .           .
Production      D   Produce     .           Sales
.               .   Abandom     .           .
Sales           C   Great       .           .
.               .   Good        .           .
.               .   Fair        .           .
.               .   Poor        .           .
;

 /* -- create the PROBIN= data set                    -- */
data prob4;
   input _EVENT1_ $12. _PROB1_ _EVENT2_ $12. _PROB2_;
   cards;
Success     0.6     Failure   0.4
Great       0.25    Good      0.35
Fair        0.30    poor      0.1
;

 /* -- create the PAYOFFS= data set                   -- */
data payoff4;
   input _STATE_ $12. _VALUE_ dollar12.0;
   cards;
Great       $1,000,000
Good        $500,000
Fair        $200,000
Poor        -$250,000
;

 /* -- create the ANNOTATE= data set for legend       -- */
data legend;
   length FUNCTION STYLE $ 8;
   WHEN = 'B';  POSITION='0';
   XSYS='4';  YSYS='4';
   input FUNCTION $ X Y STYLE $ SIZE COLOR $ TEXT $ & 16.;
   cards;
move       8   2.1  .        .   .       .
draw      12   2.1  .        8   red     .
label     14   2    swiss    0.7 black   BEST ACTION
symbol     9   3.5  marker   0.7 red     A
label     14   3.2  swiss    0.7 black   END NODE
symbol     9   4.7  marker   0.7 blue    P
label     14   4.4  swiss    0.7 black   CHANCE NODE
symbol     9   5.9  marker   0.7 green   U
label     14   5.6  swiss    0.7 black   DECISION NODE
label      8   7.0  swiss    0.7 black   LEGEND:
move       5   8.5  .        .   black   .
draw      27   8.5  .        2   black   .
draw      27   1    .        2   black   .
draw       5   1    .        2   black   .
draw       5   8.5  .        2   black   .
;

 /* -- set graphics enviroment                        -- */
goptions cback=white ctex=black;
goptions ftext=swissbu ;

 /* define symbol characteristics for chance nodes and   */
 /* links except those that represent optimal decisions  */
symbol1 f=marker h=2 v=P c=blue w=5 l=1;

 /* define symbol characteristics for decision nodes and */
 /* links that represent optimal decisions               */
symbol2 f=marker h=2 v=U cv=green ci=red w=10 l=1;

 /* define symbol characteristics for end nodes          */
symbol3 f=marker h=2 v=A cv=red;

 /* -- define title                                   -- */
title f=swissb h=2 'Research and Development Decision';

 /* -- PROC DTREE statements                          -- */
proc dtree
     stagein=stage4 probin=prob4 payoffs=payoff4
     criterion=maxce rt=1800000
     graphics annotate=legend nolg ;

   evaluate;

   treeplot / linka=1 linkb=2 symbold=2 symbolc=1 symbole=3
              compress name="dt4";

quit;


 /* -- reset title                                    -- */
title;


/* Example found on pages 286-294 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE5                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR                                                */
 /*   PROCS: DTREE PRINT                                       */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                    -- */
data stage6;
   input _STNAME_ $ 1-16 _STTYPE_ $ 17-20
         _OUTCOM_ $ 21-44  _SUCC_ $ 45-60;
   cards;
Application     D   Approve loan            Payment
.               .   Deny loan               .
Payment         C   Pay off                 .
.               .   Default                 .
Investigation   D   Order investigation     Recommendation
.               .   Do not order            Application
Recommendation  C   Positive                Application
.               .   Negative                Application
;

 /* -- create the PROBIN= data set                     -- */
data prob6;
   length _GIVEN_ _EVENT1_ _EVENT2_ $16;

   _EVENT1_='Pay off';   _EVENT2_='Default';
   _PROB1_=664/700;      _PROB2_=1.0-_PROB1_;
   output;

   _GIVEN_='Pay off';
   _EVENT1_='Positive';   _EVENT2_='Negative';
   _PROB1_=570/664;       _PROB2_=1.0-_PROB1_;
   output;

   _GIVEN_='Default';
   _EVENT1_='Positive';   _EVENT2_='Negative';
   _PROB1_=6/26;          _PROB2_=1.0-_PROB1_;
   output;

run;

 /* -- create the PAYOFFS= data set                    -- */
data payoff6(drop=loan);
   length _STATE_ _ACT_ $24;

   loan=30000;

   _ACT_='Deny loan';   _VALUE_=loan*0.08;   output;
   _STATE_='Pay off';   _VALUE_=loan*0.08;   output;
   _STATE_='Default';   _VALUE_=loan*0.08;   output;

   _ACT_='Approve loan';
   _STATE_='Pay off';   _VALUE_=loan*0.15;   output;
   _STATE_='Default';   _VALUE_=-1.0*loan;   output;

run;

 /* -- define title                                    -- */
title 'Loan Grant Decision';

 /* -- PROC DTREE statements                           -- */
proc dtree
     stagein=stage6 probin=prob6 payoffs=payoff6
     summary target=investigation
     nowarning
     ;

   modify 'Order investigation' reward -500;
   evaluate;
   summary / target=Application;

   save;
   move payment before investigation;
   evaluate;
   recall;
   vpi payment;

   modify payment type;
   evaluate;
   recall;
   vpc payment;

   quit;


 /* -- create the alternative PAYOFFS= data set        -- */
data payoff6a(drop=loan);
   length _STATE_ _ACT_ $24;

   loan=1;

   _ACT_='Deny loan';   _VALUE_=loan*0.08;   output;
   _STATE_='Pay off';   _VALUE_=loan*0.08;   output;
   _STATE_='Default';   _VALUE_=loan*0.08;   output;

   _ACT_='Approve loan';
   _STATE_='Pay off';   _VALUE_=loan*0.15;   output;
   _STATE_='Default';   _VALUE_=-1.0*loan;   output;
run;

 /* -- PROC DTREE statements                           -- */
title 'Loan Grant Decision';

proc dtree
     stagein=stage6 probin=prob6 payoffs=payoff6a
     nowarning
     ;

   evaluate / summary target=investigation;

   save;
   move payment before investigation;
   evaluate;
   recall;

   modify payment type;
   evaluate;

   quit;


 /* -- create the data set for value of loan
       and corresponding values of services            -- */
data datav6(drop=k ratio1 ratio2 ratio3);

   label loan="Value of Loan"
         vci="Value of Current Credit Investigation"
         vpi="Value of Perfect Credit Investigation"
         vpc="Value of Perfect Collecting Service";

   /* calculate ratios */
   ratio1=0.1242-0.0909;
   ratio2=0.1464-0.0909;
   ratio3=0.15-0.0909;

   Loan=0;

   do k=1 to 10;
      /* set the value of loan */
      loan=loan+10000;

      /* calculate the values of various services */
      vci=loan*ratio1;
      vpi=loan*ratio2;
      vpc=loan*ratio3;

      /* output current observation */
      output;
   end;

run;

 /* -- print the table of the value of loan
       and corresponding values of services            -- */
title 'Value of Services via Value of Loan';

proc print label;
   format loan vci vpi vpc dollar12.0;
run;


 /* -- clear up                                        -- */
title ;


/* Example found on pages 296-304 */

 /**************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y               */
 /*                                                            */
 /*    NAME: DTREE6                                            */
 /*   TITLE: Examples for PROC DTREE                           */
 /* PRODUCT: OR                                                */
 /*  SYSTEM: ALL                                               */
 /*    KEYS: OR GRAPHICS PATTERN SYMBOL                        */
 /*   PROCS: DTREE PRINT GPLOT                                 */
 /*    DATA:                                                   */
 /*                                                            */
 /* SUPPORT:                             UPDATE:               */
 /*     REF:                                                   */
 /*    MISC:                                                   */
 /*                                                            */
 /**************************************************************/

OPTIONS PAGESIZE=54 LINESIZE=76;


 /* -- create the STAGEIN= data set                       -- */
data stage7;
   input _STNAME_ $ 1-10  _STTYPE_ $ 11-14 _OUTCOM1 $ 15-30
         _SUCC1   $ 30-40 _OUTCOM2 $ 41-56 _SUCC2   $ 57-66;
   cards;
Action    D   Invoking        Response  Not_Invoking    .
Response  C   Accept          .         Refuse          Lawsuit
Lawsuit   C   Press_Issue     .         Settle          .
              Sue             Last
Last      C   3_Years         Result    4_Years         Result
              5_Years         Result
Result    C   No_Damages      .         Normal_Damages  .
              Double_Damages  .
;

 /* -- create the PROBIN= data set                        -- */
data prob7;
   input _EVENT1_ $ 1-16  _PROB1_ 17-24
         _EVENT2_ $ 25-40 _PROB2_ 41-48;
   cards;
Accept          0.1     Refuse          0.9
Press_Issue     0.1     Settle          0.45
Sue             0.45
3_Years         0.3     4_Years         0.4
5_Years         0.3
No_Damages      0.15    Normal_Damages  0.65
Double_Damages  0.20
;

 /* -- create the PAYOFFS= data set                       -- */
data payoff7(drop=i j k D PCOST);
   length _ACTION_ _STATE1-_STATE4 $16;

   /* possible outcomes for the case last */
   array YEARS{3}   $16. _TEMPORARY_ ('3_Years',
                                      '4_Years',
                                      '5_Years' );
   /* numerical values for the case last  */
   array Y{3}            _TEMPORARY_ (3, 4, 5);

   /* possible outcomes for the size of judgment */
   array DAMAGES{3} $16. _TEMPORARY_ ('No_Damages',
                                      'Normal_Damages',
                                      'Double_Damages' );
   /* numerical values for the size of judgment  */
   array C{3}            _TEMPORARY_ (0, 1500, 3000);

   D=0.1;                             /* discount rate */

   /*
    * payoff for the scenario which the 10 percent
    * clause is not invoked
    */
   _ACTION_='Not_Invoking';   _VALUE_=-450;   output;

   /* the clause is invoked */
   _ACTION_='Invoking';

   /*
    * payoffs for scenarios which the clause is invoked
    * and the customer accepts the invocation
    */
   _STATE1='Accept';           _VALUE_=600;   output;

   /* the customer refuses the invocation */
   _STATE1='Refuse';

   /*
    * payoffs for scenarios which the clause isinvoked
    * and the customer refuses the invocation but
    * decline to press the issue
    */
   _STATE2='Press_Issue';   _VALUE_=500;      output;

   /*
    * payoffs for scenarios which the clause isinvoked
    * and the customer refuses the invocation but
    * willing to settle out of court for 900K
    */
   _STATE2='Settle';        _VALUE_=500-900;   output;

   /* the customer will sue for damages  */
   _STATE2='Sue';

   do i=1 to 3;
      _STATE3=YEARS{i};

      /* determine the cost of proceedings             */
      PCOST=30;     /* initial cost of the proceedings */

      /*
       * additional cost for every years
       * in present value
       */
      do k=1 to Y{i};
         PCOST=PCOST+(20/((1+D)**k));
      end;

      /* loop for all poss. of the lawsuit result */
      do j=1 to 3;
         _STATE4=DAMAGES{j}; /* the damage have to paid */

         /* compute the net return in present value    */
         _VALUE_=500-PCOST-(C{j}/((1+D)**Y{i}));

         /*
          * output an observation for the payoffs
          * of this scenario
          */
         output;
      end;
   end;

run;


 /* -- print the payoff table                             -- */
title "Petroleum Distributor's Decision";
title3 "Payoff table";

proc print;
   run;


 /* -- define colors list                                 -- */
goptions colors=(green red blue);

 /* -- define title                                       -- */
title f=zapfb h=2.5 "Petroleum Distributor's Decision";

 /* -- PROC DTREE statements                              -- */
proc dtree stagein=stage7 probin=prob7 payoffs=payoff7;
   evaluate / summary;
   treeplot / graphics compress nolg font=swissbu name="dt6p1"
              ybetween=1 cell lwidth=8 lwidthb=16 hsymbol=3;

quit;


 /* -- create data set for decision diagram               -- */
data data7(drop=i);
   P=0.0;               /* initialize P */

   /* loop for all pssible values of P  */
   do i=1 to 21;

      /* determine the corresponding Q  */
      Q=(86-(1136*P))/(1036*(1.0-P));
      if Q < 0.0 then Q=0.0;

      /* output this data point */
      output;

      /* set next possible value of P   */
      P=P+0.005;
   end;

run;

 /* -- create the ANNOTATE= data set for labels
       of decision diagram                                -- */
data label;
   length FUNCTION STYLE COLOR $8;
   length XSYS YSYS            $1;
   length WHEN POSITION        $1;
   length X Y                   8;
   length SIZE ROTATE           8;

   WHEN = 'A';
   POSITION='0';
   XSYS='2';
   YSYS='2';
   input FUNCTION $ X Y STYLE $ SIZE COLOR $
         ROTATE TEXT $ & 16.;
   cards;
label   0.01    0.04    centx   2       black   .       Do Not
label   0.01    0.03    centx   2       black   .       Invoke
label   0.01    0.02    centx   2       black   .       The Clause
label   0.06    0.06    centx   2       black   .       Invoke The
label   0.06    0.05    centx   2       black   .       Clause
;


 /* -- set graphics enviroment                            -- */
goptions cback=white ctex=black;
goptions ftext=centx;

 /* -- define symbol characteristics for boundary         -- */
goptions reset=global;
symbol1 i=joint v=NONE l=1 w=2 ci=black;

 /* -- define pattern for area fill                       -- */
pattern1 value=msolid color=blue;
pattern2 value=msolid color=green;

 /* -- define axis characteristics                        -- */
axis1 label=('Pr(Accept the Invocation)')
      order=(0 to 0.1 by 0.01);
axis2 label=(angle=90 'Pr(Press the Issue)')
      order=(0 to 0.1 by 0.01);

 /* -- plot decision diagram                              -- */
title f=centx h=2.5 "Petroleum Distributor's Decision";
proc gplot data=data7;
   plot Q*P=1 / haxis=axis1
                vaxis=axis2
                hminor=4
                vminor=4
                annotate=label
                name="dt6p2"
                frame
                areas=2;
   run;

quit;


 /* -- reset title                                        -- */
title;


/* Example found on pages 314-315 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT0                                              */
 /*   TITLE: Software Development Project                        */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF: Getting Started section of the GANTT Chapter        */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
options ps=60 ls=78;

data software;
   input descrpt  $char20.
         duration 23-24
         activity $ 27-34
         succesr1 $ 37-44
         succesr2 $ 47-54;
   cards;
Initial Testing       20  TESTING   RECODE
Prel. Documentation   15  PRELDOC   DOCEDREV  QATEST
Meet Marketing        1   MEETMKT   RECODE
Recoding              5   RECODE    DOCEDREV  QATEST
QA Test Approve       10  QATEST    PROD
Doc. Edit and Revise  10  DOCEDREV  PROD
Production            1   PROD
;

proc cpm data=software
         out=intro1
         interval=day
         date='01mar92'd;
   id descrpt;
   activity activity;
   duration duration;
   successor succesr1 succesr2;
run;


title 'Project Schedule';
proc print data=intro1;
run;


options ls=100;

title 'Line-Printer Gantt Chart';
proc gantt;
run;


goptions ftext=swiss colors=(black) cback=white
         hpos=80 vpos=32;

 /* define the fill patterns for Gantt chart bars */

pattern1 v=r1;
pattern2 v=e;
pattern3 v=x1;


title 'Graphics Gantt Chart';
proc gantt graphics data=intro1;
chart / compress;
run;


title 'Logic Gantt Chart';
   proc gantt graphics data=intro1 precdata=software;
      chart / compress activity=activity successor=(succesr1-succesr2);
   run;


/* Example found on page 379 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT2                                              */
 /*   TITLE: Customizing the Gantt Chart                         */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

   options ls=120 ps=60;

   data;
      format activity $20. success1 $20. success2 $20. success3 $20.
                           success4 $20.;
      input activity dur success1-success4;
      cards;
   form                 4 pour . . .
   pour                 2 core . . .
   core                14 strip spray_fireproof insulate_walls .
   strip                2 plumbing curtain_wall risers doors
   strip                2 electrical_walls balance_elevator . .
   curtain_wall         5 glaze_sash . . .
   glaze_sash           5 spray_fireproof insulate_walls . .
   spray_fireproof      5 ceil_ducts_fixture . . .
   ceil_ducts_fixture   5 test . . .
   plumbing            10 test . . .
   test                 3 insulate_mechanical . . .
   insulate_mechanical  3 lath . . .
   insulate_walls       5 lath . . .
   risers              10 ceil_ducts_fixture . . .
   doors                1 port_masonry . . .
   port_masonry         2 lath finish_masonry . .
   electrical_walls    16 lath . . .
   balance_elevator     3 finish_masonry . . .
   finish_masonry       3 plaster marble_work . .
   lath                 3 plaster marble_work . .
   plaster              5 floor_finish tiling acoustic_tiles .
   marble_work          3 acoustic_tiles . . .
   acoustic_tiles       5 paint finish_mechanical . .
   tiling               3 paint finish_mechanical . .
   floor_finish         5 paint finish_mechanical . .
   paint                5 finish_paint . . .
   finish_mechanical    5 finish_paint . . .
   finish_paint         2 caulking_cleanup . . .
   caulking_cleanup     4 finished . . .
   ;

   * invoke cpm to find the optimal schedule;

   proc cpm finishbefore date='1sep92'd;
      activity activity;
      duration dur;
      successors success1-success4;

   * sort the schedule by the early start date;

   proc sort; by e_start;


   title 'Gantt Example 2';
   title2 'Customizing the Gantt Chart';

   proc gantt;
      chart / ref='10jun92'd to '30aug92'd by 15 summary fill nolegend
              increment=5 skip=2 critflag nojobnum between=2;
      id activity;
   run;


/* Example found on pages 402-403 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT8                                              */
 /*   TITLE: Multiple Calendars                                  */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
options ps=60 ls=100;

title 'Multiple Calendars';

 /* Activity-on-Node representation of the project */
data widget9;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan 5.5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs  4.5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;


data widgvac;
   set widget9;
   if task = 'Production' then       cal = 'PROD_CAL';
   else if task = 'Prototype' then   cal = 'OVT_CAL';
   else if task = 'Write Specs' then cal = 'Eng_cal';
   else                              cal = 'DEFAULT';
   run;


data holidata;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur cal $;
   cards;
09dec91 .        7  Eng_cal
25dec91 27dec91  .  .
01jan92 01jan92  .  .
;


data workdata;
   input fullday time8. halfday time8. ovtday time8.
         s1 time8. s2 time8. s3 time8.;
   format fullday halfday ovtday s1 s2 s3 time6.;
   cards;
08:00   08:00   08:00   .       08:00   .
16:00   12:00   18:00   06:00   18:00   06:00
.       .       .       08:00   20:00   08:00
.       .       .       18:00   .       18:00
.       .       .       20:00   .       .
.       .       .       .       .       .
;


data caledata;
   input  cal $ _sun_ $ _mon_$ _tue_$  _wed_$ _thu_$ _fri_$ _sat_ $;
   cards;
DEFAULT  holiday fullday fullday fullday fullday fullday holiday
OVT_CAL  holiday ovtday  ovtday  ovtday  ovtday  ovtday  halfday
PROD_CAL holiday s2      s1      s1      s1      s1      s3
Eng_cal  .       .       .       .       .       .       .
;


proc print data=workdata;
   title3 'Workdays Data Set';
   run;

title1 " ";
title3;

proc print data=caledata;
   title2 'Calendar Data Set';
   run;

proc print data=holidata;
   title2 'Holidays Data Set';
   run;

proc print data=widgvac;
title2 'Project Data Set';
run;



proc cpm date='02dec91'd data=widgvac out=schedvac interval=workday
   holidata=holidata workday=workdata calendar=caledata;
   holiday holiday / holifin=holifin holidur=holidur;
   activity task;
   duration days;
   successor succ1 succ2 succ3;
   calid cal;
   run;


title 'Gantt Example 8';
title2 'Multiple Calendars';


proc gantt data=schedvac holidata=holidata
     workday=workdata calendar=caledata ;
     chart / holiday=(holiday) holiend=(holifin)
           markbreak scale=12 calid=cal
           mindate='28dec91:00:00'dt maxdate='02jan92:08:00'dt ;
     id task;
     run;


/* Example found on page 410 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT11                                             */
 /*   TITLE: Using the COMBINE option                            */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
options ps=70 ls=100;

title 'Gantt Example 11';


 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;


data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 .       .
;


 * store early schedule as the baseline schedule;

proc cpm data=widget holidata=holidays
         out=widgbase date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   baseline / set=early;
   run;


title2 'Set Baseline Schedule';
proc print data=widgbase;
   run;


 * actual schedule at timenow = 20dec91;

data actual;
   input task $ 1-12 sdate date9. fdate date9. pctc rdur;
   format sdate date9. fdate date9.;
   cards;
Approve Plan  02dec91 06dec91  .    .
Drawings      07dec91 17dec91  .    .
Anal. Market  06dec91 .        100  .
Write Specs   08dec91 13dec91  .    .
Prototype     .       .        .    .
Mkt. Strat.   11dec91 .        .    3
Materials     .       .        .    .
Facility      .       .        .    .
Init. Prod.   .       .        .    .
Evaluate      .       .        .    .
Test Market   .       .        .    .
Changes       .       .        .    .
Production    .       .        .    .
Marketing     .       .        .    .
;


title2 'Progress Data';
proc print;
   run;


 * merge the baseline information with progress update;

data widgact;
   merge  actual widgbase;
   run;


 * estimate schedule based on actual data;

proc cpm data=widgact holidata=holidays
         out=widgupdt date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   baseline / compare=early;
   actual / as=sdate af=fdate timenow='20dec91'd
            remdur=rdur pctcomp=pctc
            autoupdt;
   run;


 * sort the data;

proc sort; by e_start;


 * print the data;

proc print;
   var task e_: l_: a_start a_finish b_: ;
   run;


title 'Gantt Example 11';
title2 'Using the COMBINE Option';

 * plot the combined and baseline schedules using proc gantt;

proc gantt data=widgupdt holidata=holidays;
   chart / holiday=(holiday) holifin=(holifin)
           overlapch='@' combine nolegend
           timenow='20dec91'd dur=days;
   id task;
   run;


/* Example found on page 416 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT13                                             */
 /*   TITLE: Specifying the Schedule Data Directly               */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
options ps=60 ls=100;

title 'Gantt Example 13';

 /* Activity-on-Node representation of the project */
data widgdir;
   input task $ 1-12 segmt_no zdur rs: date7. rf: date7.
         e_start: date7. e_finish: date7. sdate: date7.  fdate: date7.;
   format rs rf e_start e_finish sdate fdate date7.;
   cards;
Approve Plan  . 1  02dec91  06dec91  02dec91  06dec91  02dec91  06dec91
Drawings      . 1  09dec91  24dec91  09dec91  20dec91  09dec91  20dec91
Drawings      1 1  09dec91  10dec91  09dec91  20dec91  09dec91  20dec91
Drawings      2 1  13dec91  24dec91  09dec91  20dec91  09dec91  20dec91
Anal. Market  . 1  09dec91  13dec91  09dec91  13dec91  22jan92  28jan92
Write Specs   . 1  09dec91  13dec91  09dec91  13dec91  16dec91  20dec91
Prototype     . 1  26dec91  16jan92  23dec91  14jan92  23dec91  14jan92
Mkt. Strat.   . 1  16dec91  21jan92  16dec91  30dec91  29jan92  11feb92
Mkt. Strat.   1 1  16dec91  24dec91  16dec91  30dec91  29jan92  11feb92
Mkt. Strat.   2 1  17jan92  21jan92  16dec91  30dec91  29jan92  11feb92
Materials     . 1  17jan92  30jan92  15jan92  28jan92  15jan92  28jan92
Facility      . 1  17jan92  30jan92  15jan92  28jan92  15jan92  28jan92
Init. Prod.   . 1  31jan92  13feb92  29jan92  11feb92  29jan92  11feb92
Evaluate      . 1  14feb92  27feb92  12feb92  25feb92  19feb92  03mar92
Test Market   . 1  14feb92  05mar92  12feb92  03mar92  12feb92  03mar92
Changes       . 1  06mar92  12mar92  04mar92  10mar92  04mar92  10mar92
Production    . 0  13mar92  13mar92  11mar92  11mar92  11mar92  11mar92
Marketing     . 0  14feb92  14feb92  12feb92  12feb92  11mar92  11mar92
;


data holdata;
   format hol date7.;
   input hol date7.;
   cards;
25dec91
01jan92
;


proc print;
   title2 'Holidays Data Set';
   run;


title2 'Specifying the Schedule Data Directly';


proc gantt data=widgdir holidata=holdata;
   chart / holiday=(hol) skip=0 dur=zdur
           ss=rs sf=rf ls=sdate lf=fdate ;
   id task;
   run;


/* Example found on pages 418-419 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT14                                             */
 /*   TITLE: BY Processing                                       */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

options ps=60 ls=100;
title 'Gantt Example 14';

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;


data details;
   input task $ 1-12 dept $ 15-27 descrpt $ 30-59;
   label dept = "Department"
         descrpt = "Activity Description";
   cards;
Approve Plan  Planning       Finalize and Approve Plan
Drawings      Engineering    Prepare Drawings
Anal. Market  Marketing      Analyze Potential Markets
Write Specs   Engineering    Write Specifications
Prototype     Engineering    Build Prototype
Mkt. Strat.   Marketing      Develop Marketing Concept
Materials     Manufacturing  Procure Raw Materials
Facility      Manufacturing  Prepare Manufacturing Facility
Init. Prod.   Manufacturing  Initial Production Run
Evaluate      Testing        Evaluate Product In-House
Test Market   Testing        Mail Product to Sample Market
Changes       Engineering    Engineering Changes
Production    Manufacturing  Begin Full Scale Production
Marketing     Marketing      Begin Full Scale Marketing
;


data widgetn;
   merge widget details;
   run;


proc cpm date='02dec91'd data=widgetn;
   activity task;
   duration days;
   successor succ1 succ2 succ3;
   id dept;
   run;


proc print;
   run;


proc sort;
   by dept e_start;


title2 'BY Processing';

proc gantt;
   chart / scale=1 dur=days;
   by dept;
   id task;
   run;


/* Example found on pages 442-448 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT25                                             */
 /*   TITLE: Specifying the MAXDISLV=, MININTGV=, MINOFFGV=, and */
 /*                         MINOFFLV= Options.                   */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
options ps=60 ls=100;

title f=swiss 'Gantt Example 25';

 /* Activity-on-Arc representation of the project */
data widgaoa;
   input task $ 1-12 days tail head;
   cards;
Approve Plan   5   1   2
Drawings      10   2   3
Anal. Market   5   2   4
Write Specs    5   2   3
Prototype     15   3   5
Mkt. Strat.   10   4   6
Materials     10   5   7
Facility      10   5   7
Init. Prod.   10   7   8
Evaluate      10   8   9
Test Market   15   6   9
Changes        5   9  10
Production     0  10  11
Marketing      0   6  12
Dummy          0   8   6
;


data details;
   input task $ 1-12 dept $ 15-27 descrpt $ 30-59;
   label dept = "Department"
         descrpt = "Activity Description";
   cards;
Approve Plan  Planning       Finalize and Approve Plan
Drawings      Engineering    Prepare Drawings
Anal. Market  Marketing      Analyze Potential Markets
Write Specs   Engineering    Write Specifications
Prototype     Engineering    Build Prototype
Mkt. Strat.   Marketing      Develop Marketing Concept
Materials     Manufacturing  Procure Raw Materials
Facility      Manufacturing  Prepare Manufacturing Facility
Init. Prod.   Manufacturing  Initial Production Run
Evaluate      Testing        Evaluate Product In-House
Test Market   Testing        Mail Product to Sample Market
Changes       Engineering    Engineering Changes
Production    Manufacturing  Begin Full Scale Production
Marketing     Marketing      Begin Full Scale Marketing
Dummy                        Production Milestone
;


data widgeta;
   merge widgaoa details;
   run;


data holdata;
   format hol date7.;
   input hol date7.;
   cards;
25dec91
01jan92
;


 * schedule the project subject to holidays and weekends;

proc cpm data=widgeta holidata=holdata out=savehp
         date='2dec91'd interval=weekday;
   tailnode tail;
   headnode head;
   duration days;
   holiday  hol;
   id task dept descrpt;
   run;


 * sort the schedule by the early start date ;

proc sort;
   by e_start;
   run;


 * print the schedule;

proc print;
   id descrpt;
   var dept e_: l_: t_float f_float;
   run;


 * set background to white, text to black and font to triplex;

goptions cback=white ctext=black ftext=triplex;


 * set vpos to 50 and hpos to 100;

goptions vpos=50 hpos=100;


 * set up required pattern statements;

pattern1 c=green v=s;
pattern2 c=green v=e;
pattern3 c=red   v=s;
pattern4 c=red   v=e;
pattern5 c=red   v=r2;
pattern6 c=cyan  v=s;
pattern7 c=blue v=x1;


 * plot the logic Gantt chart using AOA representation;

title2 'Logic Gantt Chart: AOA Representation';

proc gantt graphics data=savehp holidata=holdata;
   chart / compress cprec=blue caxis=black cmile=cyan
           increment=7
           dur=days holiday=(hol)
           head=head tail=tail;
   id task;
   run;


 * illustrate the minintgv and minoffgv options;

title2
'Logic Gantt Chart: AOA Representation, MININTGV=2 and MINOFFGV=2.5';

proc gantt graphics data=savehp holidata=holdata;
   chart / compress cprec=blue caxis=black cmile=cyan
           increment=7
           dur=days holiday=(hol)
           head=head tail=tail
           minintgv=2.0 minoffgv=2.5;
   id task;
   run;


 * illustrate the maxdislv option;

title2 'Logic Gantt Chart: AOA Representation and MAXDISLV=.3';

proc gantt graphics data=savehp holidata=holdata;
   chart / compress cprec=blue caxis=black cmile=cyan
           dur=days holiday=(hol)
           head=head tail=tail
           maxdislv=.3 minintgv=10
           maxdate='01feb92'd;
   id task;
   run;


title2 'Logic Gantt Chart: AOA Representation and MAXDISLV=2';

proc gantt graphics data=savehp holidata=holdata;
   chart / compress cprec=blue caxis=black cmile=cyan
           dur=days holiday=(hol)
           head=head tail=tail
           maxdislv=2 minintgv=10
           maxdate='01feb92'd;
   id task;
   run;


 * illustrate the minofflv option;

title2 'Logic Gantt Chart: AOA Representation and MINOFFLV=.5';

proc gantt graphics data=savehp holidata=holdata;
   chart / compress cprec=blue caxis=black cmile=cyan
           dur=days holiday=(hol)
           head=head tail=tail
           minofflv=.5
           maxdate='01feb92'd;
   id task;
   run;


/* Example found on pages 453-457 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: GANTT27                                             */
 /*   TITLE: Using the ANNOTATE= Option to                       */
 /*          a) Print Resource Requirements on a Gantt chart     */
 /*          b) Plot Resource Usage and Resource Availability    */
 /*               on a Gantt Chart                               */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: GANTT                                               */
 /*   PROCS: CPM, SORT, GANTT                                    */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

title c=black f=swiss 'Gantt Example 27';

 /* Activity-on-Arc representation of the project */
data widgres;
   input task $ 1-12 days tail head engineer;
   if engineer ^= . then engcost = engineer * 200;
   cards;
Approve Plan   5   1   2  2
Drawings      10   2   3  1
Anal. Market   5   2   4  1
Write Specs    5   2   3  2
Prototype     15   3   5  4
Mkt. Strat.   10   4   6  .
Materials     10   5   7  .
Facility      10   5   7  2
Init. Prod.   10   7   8  4
Evaluate      10   8   9  1
Test Market   15   6   9  .
Changes        5   9  10  2
Production     0  10  11  4
Marketing      0   6  12  .
Dummy          0   8   6  .
;


data widgrin;
   input per date7. otype $ 11-18 engineer engcost;
   format per date7.;
   cards;
.         restype  1  2
.         suplevel 1  .
02dec91   reslevel 3  40000
27dec91   reslevel 4  .
;


title2 'Data Set WIDGRIN';
proc print;
   run;


data holdata;
   format hol date7.;
   input hol date7. name $ 10-18;
   cards;
25dec91  Christmas
01jan92  New Year
;


proc cpm date='02dec91'd interval=weekday
         data=widgres holidata=holdata resin=widgrin
         out=widgsch2 resout=widgrou2;
   tailnode tail;
   duration days;
   headnode head;
   holiday hol;
   resource engineer engcost / period=per obstype=otype
                               rule=lst
                               delayanalysis;
   id task;
   run;


title2 'Resource Constrained Schedule: Rule = LST';
proc print data=widgsch2;
   run;


proc print data=widgrou2;
   title2 'Usage Profiles for Constrained Schedule: Rule = LST';
   run;


 * set background to white and text to black;

goptions ctext=black cback=white ftext=swiss;


 * set vpos to 50 and hpos to 100;

goptions vpos=50 hpos=100;


 * set up required pattern statements;

pattern1 c=green v=s;
pattern2 c=green v=e;
pattern3 c=red v=s;
pattern4 c=red v=e;
pattern5 c=red v=r2;
pattern6 c=cyan v=s;
pattern7 c=black v=x1;
pattern8 c=blue v=s;



 * begin annotate process;


 * compile annotate macros;

%annomac;


 * create annotate data set for first chart;

data anno1;
   %dclanno;       /* set length and type for annotate variables */
   %system(2,2,4); /* define annotate reference system           */
   set widgsch2;
   length lab $20;
   length text $ 37;
   Y1 = _n_;
   lab='    ';

   if _n_=1 then do;
      %label('02dec91'd,13,
             'Format: Engineers per day, Total cost',*,0,0,1.2,brush,6);
      end;

   if engineer ^= . then do;
      /* create a text label */
      lab = put(engineer, 1.) || " Engineer";
      if engineer > 1 then lab = trim(lab) || "s";
      if days > 0 then lab = trim(lab) || ", " ||
                                            put(engcost*days, dollar7.);

      /* position the text label */
      if y1 < 10 then do;
         x1 = max(l_finish, s_finish) + 2;
         %label(x1,y1,lab,black,0,0,1.0,brush, 6);
         end;
      else do;
         x1 = e_start - 2;
         %label(x1,y1,lab,black,0,0,1.0,brush, 4);
         end;
      end;
run;


title2 c=blue f=swiss
       'Displaying Resource Requirements';


 * annotate the Gantt chart;

proc gantt graphics data=widgsch2 holidata=holdata annotate=anno1;
chart / compress holiday=(hol) interval=weekday increment=7
        /* mindate='1dec91'd maxdate='22mar92'd */
        ref='1dec91'd to '22mar92'd by week cref=blue lref=2
        dur=days cmile=cyan caxis=black;
id task;
run;



 * calculate scaling factor for cost curve;

data _null_;
   set widgrou2 end=final;
   retain maxcost;
   if aengcost > maxcost then maxcost=aengcost;
   if final then call symput('cscale',14/maxcost);
   run;


 * create annotate data set for second chart;


data anno2;
   %dclanno;       /* set length and type for annotate variables */
   %system(2,2,4); /* define annotate reference system           */
   set widgrou2;
   length lab $16;
   length text $27;
   x1=_time_;
   y1=15-aengcost*symget('cscale');
   y2=15-rengieer;
   lab='    ';

   if _n_=1 then do;
      /* print labels */
      do i = 1 to 14 by 1;
         lab=put( (15-i) / symget('cscale'), dollar7.);
         %label('22mar92'd,i,lab,black,0,0,1.0,swiss,4);
         end;
      do i = 0 to 4 by 1;
         lab=put(i,1. );
         %label('01dec91'd,15-i,lab,black,0,0,1.0,swiss,6);
         end;
      %label('01dec91'd,10,
             'Resource Usage: Engineers',*,0,0,1.2,swiss,6);
      %label('03jan92'd,4,
             'Resource Availability: Cost',*,0,0,1.2,swiss,6);
      %move(x1,y1);
      %push;
      end;
   else do;
      /* draw cost availability curve */
      %pop;
      when='a';
      %draw(x1,y1,black,1,2);
      %push;
      /* draw engineer usage barchart */
      when='b';
      if y2 <= 14 then do;
         %bar(x1,15,x1+1,y2,blue,0,l1);
         end;
      end;
   run;


title2 c=blue f=swiss
       'Plotting Resource Usage and Resource Availability';

 * annotate the Gantt chart;

proc gantt graphics data=widgsch2 holidata=holdata annotate=anno2;
chart / compress holiday=(hol) interval=weekday increment=7
        mindate='1dec91'd maxdate='22mar92'd
        ref='1dec91'd to '22mar92'd by week cref=blue lref=2
        dur=days cmile=cyan caxis=black;
id task;
run;



/* Example found on pages 465-468 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW0                                            */
 /*   TITLE: Software Development Project                        */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF: Getting Started section of the CPM Chapter          */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data software;
   input descrpt  $char20.
         duration 23-24
         activity $ 27-34
         succesr1 $ 37-44
         succesr2 $ 47-54;
   cards;
Initial Testing       20  TESTING   RECODE
Prel. Documentation   15  PRELDOC   DOCEDREV  QATEST
Meet Marketing        1   MEETMKT   RECODE
Recoding              5   RECODE    DOCEDREV  QATEST
QA Test Approve       10  QATEST    PROD
Doc. Edit and Revise  10  DOCEDREV  PROD
Production            1   PROD
;

title f=swiss 'Software Project';
title2 f=swiss 'Data Set SOFTWARE';
proc print;
   run;

goptions colors=(black) cback=white border;

pattern1 v=e r=3;
title f=swiss 'Software Project';
proc netdraw graphics data=software;
   actnet / act=activity succ=(succ:)
            pcompress separatearcs
            font=swiss;
   run;

data softnet;
   input descrpt  $char20.
         duration 23-24
         activity $ 27-34
         succesor $ 37-44
         _x_ _y_ ;
   cards;
Initial Testing       20  TESTING   RECODE    1  1
Meet Marketing        1   MEETMKT   RECODE    1  2
Prel. Documentation   15  PRELDOC   DOCEDREV  1  3
Prel. Documentation   15  PRELDOC   QATEST    1  3
Recoding              5   RECODE    DOCEDREV  2  2
Recoding              5   RECODE    QATEST    2  2
QA Test Approve       10  QATEST    PROD      3  3
Doc. Edit and Revise  10  DOCEDREV  PROD      3  1
Production            1   PROD                4  2
;

title2 'Data Set SOFTNET';
proc print;
   run;

title2 f=swiss 'Controlled Layout';
proc netdraw graphics data=softnet;
   actnet / act=activity succ=(succesor)
            pcompress
            font=swiss;
   run;

proc cpm data=software
         out=intro1
         interval=day
         date='01mar92'd;
   id descrpt;
   activity activity;
   duration duration;
   successor succesr1 succesr2;
run;

title2 'Project Schedule';
proc print data=intro1 noobs;
   id descrpt;
run;

title2 f=swiss 'Time-Scaled Diagram';
proc netdraw graphics data=intro1;
   actnet / act=activity succ=(succ:) separatearcs
            pcompress font=swiss
            timescale
            linear mininterval=week
            id=(activity duration) nolabel nodefid frame;
            run;


/* Example found on page 511 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW3                                            */
 /*   TITLE: Graphics Version of PROC NETDRAW                    */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

title h=3 j=l f=swiss ' Project: Widget Manufacture';

pattern1 c=green v=e;

goptions hpos=100 vpos=70 border;
proc netdraw data=widget graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            carcs=blue
            lwidth=3
            font=swiss;
   run;


/* Example found on page 513 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW4                                            */
 /*   TITLE: Spanning Multiple Pages                             */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

proc cpm data=widget out=sched
         date='2dec91'd;
   activity task;
   successor succ1 succ2 succ3;
   duration days;
   run;

pattern1 c=ltgray v=s;
pattern2 c=ltgray v=s;

goptions hpos=80 vpos=50 border;

title c=blue j=l f=swiss h=1.5 ' Project: Widget Manufacture';
title2 c=blue f=swiss j=l h=1.5 ' Schedule Information';
footnote c=blue f=swiss j=r 'Spanning Multiple Pages ';
proc netdraw data=sched graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            dur = days
            coutline=blue
            ccritout=red
            carcs=blue
            ccritarcs=red
            ctext=blue
            lwidth=3
            lwcrit=5
            separatearcs
            font=swiss;
   run;


/* Example found on page 515 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW4                                            */
 /*   TITLE: The COMPRESS and PCOMPRESS Options                  */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

proc cpm data=widget out=sched
         date='2dec91'd;
   activity task;
   successor succ1 succ2 succ3;
   duration days;
   run;

pattern1 c=green v=e;
pattern2 c=red   v=e;

goptions hpos=120 vpos=80 border;

title j=l f=swiss ' Project: Widget Manufacture';
title2 f=swiss j=l '  Schedule Information';
footnote c=blue f=swiss j=r 'COMPRESS Option ';
proc netdraw data=sched graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            dur = days
            carcs=cyan
            font=swiss
            ccritarcs=red
            separatearcs
            lwidth=3
            compress;
   run;

footnote c=blue f=swiss j=r 'PCOMPRESS Option ';
proc netdraw data=sched graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            dur = days
            carcs=cyan
            font=swiss
            ccritarcs=red
            separatearcs
            lwidth=3
            pcompress
            novcenter;
   run;


/* Example found on pages 518-519 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW6                                            */
 /*   TITLE: Controlling Display Format                          */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data ex  ;
   format activity $20. success1 $20. success2 $20. success3 $20.
                        success4 $20.;
   input activity dur success1-success4;
cards;
form                 4 pour . . .
pour                 2 core . . .
core                14 strip spray_fireproof insulate_walls .
strip                2 plumbing curtain_wall risers doors
strip                2 electrical_walls balance_elevator . .
curtain_wall         5 glaze_sash . . .
glaze_sash           5 spray_fireproof insulate_walls . .
spray_fireproof      5 ceil_ducts_fixture . . .
ceil_ducts_fixture   5 test . . .
plumbing            10 test . . .
test                 3 insulate_mechanical . . .
insulate_mechanical  3 lath . . .
insulate_walls       5 lath . . .
risers              10 ceil_ducts_fixture . . .
doors                1 port_masonry . . .
port_masonry         2 lath finish_masonry . .
electrical_walls    16 lath . . .
balance_elevator     3 finish_masonry . . .
finish_masonry       3 plaster marble_work . .
lath                 3 plaster marble_work . .
plaster              5 floor_finish tiling acoustic_tiles .
marble_work          3 acoustic_tiles . . .
acoustic_tiles       5 paint finish_mechanical . .
tiling               3 paint finish_mechanical . .
floor_finish         5 paint finish_mechanical . .
paint                5 finish_paint . . .
finish_mechanical    5 finish_paint . . .
finish_paint         2 caulking_cleanup . . .
caulking_cleanup     4 finished . . .
finished             0 . . . .
;

proc cpm finishbefore date='1jan92'd out=sched;
   activity activity;
   duration dur;
   successors success1-success4;
run;
proc sort; by e_start;
run;


goptions hpos=130 vpos=75 border;

pattern1 c=green v=e;
pattern2 c=red   v=e;

title f=swiss j=l h=1.75 ' Site: Multi-Story Building';
title2 f=swiss j=l h=1.75 ' Date: January 1, 1992';
footnote f=swiss j=r h=1 'Controlling Display Format ';
proc netdraw data=sched graphics;
   actnet / act = activity
            succ = (success1-success4)
            font=triplex
            id = ( activity dur )
            nolabel nodefaultid
            boxwdth = 6
            ybetween = 6
            lwidth = 2
            separatearcs;
   run;


/* Example found on pages 521-522 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW7                                            */
 /*   TITLE: Controlling Arc Routing Algorithm                   */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

  data exmp1;
      input task     $ 1-16
         duration
         succesr1 $ 21-35
         succesr2 $ 36-50
         succesr3 $ 51-65;
      cards;
Drill Well       4  Pump House
Pump House       3  Install Pipe
Power Line       3  Install Pipe
Excavate         5  Install Pipe   Install Pump   Foundation
Deliver Material 2  Assemble Tank
Assemble Tank    4  Erect Tower
Foundation       4  Erect Tower
Install Pump     6
Install Pipe     2
Erect Tower      6
;

proc cpm data=exmp1 date='1jan92'd out=sched;
   activity task;
   duration duration;
   successor succesr1 succesr2 succesr3;
   run;

goptions hpos=90 vpos=50 border;

pattern1 c=green v=e;
pattern2 c=red   v=e;

title f=triplex j=l h=2 ' Site: Old Well Road';
title2 f=triplex j=l h=2 ' Date: January 1, 1992';
footnote f=triplex j=r h=1 'Default Layout ';
proc netdraw data=sched graphics;
   actnet / act = task font=triplex
            dur = duration
            succ = (succesr1-succesr3)
            boxht = 3 xbetween = 6
            separatearcs
            lwidth = 3
            carcs=cyan;
      run;

footnote f=triplex j=r h=1 'Controlled Layout ';
proc netdraw data=sched graphics;
   actnet / act = task font=triplex
            dur = duration
            succ = (succesr1-succesr3)
            boxht = 3 xbetween = 6
            separatearcs
            lwidth = 3
            carcs=cyan
            htracks=1
            dp;
      run;


/* Example found on pages 524-525 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW8                                            */
 /*   TITLE: Specifying PATTERN and SHOWSTATUS                   */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 .       .
;

* actual schedule at timenow = 20dec91;
data actual;
   input task $ 1-12 sdate date9. fdate date9. pctc rdur;
   format sdate date9. fdate date9.;
   cards;
Approve Plan  02dec91 06dec91  .    .
Drawings      07dec91 17dec91  .    .
Anal. Market  06dec91 .        100  .
Write Specs   08dec91 13dec91  .    .
Prototype     .       .        .    .
Mkt. Strat.   11dec91 .        .    3
Materials     .       .        .    .
Facility      .       .        .    .
Init. Prod.   .       .        .    .
Evaluate      .       .        .    .
Test Market   .       .        .    .
Changes       .       .        .    .
Production    .       .        .    .
Marketing     .       .        .    .
;

* merge the predicted information with network data;

data widgact;
   merge  actual widget;
   run;

* estimate schedule based on actual data;

proc cpm data=widgact holidata=holidays
         out=widgupdt date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   actual / as=sdate af=fdate timenow='20dec91'd
            remdur=rdur pctcomp=pctc
            autoupdt showfloat;
   run;

 /* Set Pattern Statement for activities that have started */
data netin;
   set widgupdt;
   if a_start ^= . then style = 3;
   run;

goptions hpos=120 vpos=70 border;

pattern1 c=green  v=e;
pattern2 c=red    v=e;
pattern3 c=ltgray v=s;
title  j=l f=swiss h=2 ' Project: Widget Manufacture';
title2 j=l f=swiss h=2 ' Date: December 20, 1991';
footnote1 j=l f=swiss h=1.2 '  Activity';
footnote2 j=l f=swiss h=1.2 '  Start';
footnote3 j=l f=swiss h=1.2 '  Finish'
          j=r f=swiss h=1.2 'PATTERN and SHOWSTATUS Options  ';
proc netdraw data=netin graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            ybetween = 10
            separatearcs
            pcompress
            font=swiss
            id=(task e_start e_finish)
            nodefid nolabel
            carcs=cyan
            ccritarcs=red
            coutline = green
            ccritout = red
            showstatus
            pattern = style
            lwidth = 3
            ;
   run;


/* Example found on pages 526-528 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW9                                            */
 /*   TITLE: Time Scaled Network Diagram                         */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

data holidays;
   format holiday holifin date7.;
   input holiday date8. holifin date8. holidur;
   cards;
25dec91 27dec91 4
01jan92 .       .
;

* actual schedule at timenow = 20dec91;
data actual;
   input task $ 1-12 sdate date9. fdate date9. pctc rdur;
   format sdate date9. fdate date9.;
   cards;
Approve Plan  02dec91 06dec91  .    .
Drawings      07dec91 17dec91  .    .
Anal. Market  06dec91 .        100  .
Write Specs   08dec91 13dec91  .    .
Prototype     .       .        .    .
Mkt. Strat.   11dec91 .        .    3
Materials     .       .        .    .
Facility      .       .        .    .
Init. Prod.   .       .        .    .
Evaluate      .       .        .    .
Test Market   .       .        .    .
Changes       .       .        .    .
Production    .       .        .    .
Marketing     .       .        .    .
;

* merge the predicted information with network data;

data widgact;
   merge  actual widget;
   run;

* estimate schedule based on actual data;

proc cpm data=widgact holidata=holidays
         out=widgupd date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   holiday  holiday / holifin=(holifin);
   actual / as=sdate af=fdate timenow='20dec91'd
            remdur=rdur pctcomp=pctc showfloat;
   run;

goptions hpos=100 vpos=65 border;

pattern1 c=green  v=e;
pattern2 c=red    v=e;
title  j=l f=triplex h=2 ' Project: Widget Manufacture';
title2 j=l f=triplex h=2 ' Date: December 20, 1991';

footnote j=l f=triplex h=1.2 ' Task Name / Early Finish Within Node'
         j=r f=triplex 'Time Scaled: Default Alignment ';
proc netdraw data=widgupd graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            ybetween = 8
            lwidth = 3
            separatearcs
            novcenter
            font=triplex
            id=(task e_finish) nodefid
            nolabel
            showstatus
            carcs=blue
            ccritarcs=red
            vmargin=5
            hmargin=5
            timescale;
   run;

footnote j=l f=triplex h=1.2 ' Task Name / Late Finish Within Node'
         j=r f=triplex 'Time Scaled: Align = Late Start ';

proc netdraw data=widgupd graphics;
   actnet / act=task
            succ=(succ1 succ2 succ3)
            ybetween = 10
            lwidth = 2
            lwoutline = 3
            separatearcs
            pcompress
            novcenter
            font=triplex
            id=(task l_finish) nodefid
            nolabel
            boxwdth=5
            showstatus
            carcs=cyan
            ccritarcs=red
            vmargin=10
            align=l_start
            frame
            autoref
            lref=33
            cref=cyan
            showbreak;
   run;


/* Example found on pages 529-531 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW10                                           */
 /*   TITLE: Time Scale Options                                  */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

  data exmp1;
      input task     $ 1-16
         duration
         succesr1 $ 21-35
         succesr2 $ 36-50
         succesr3 $ 51-65;
      cards;
Drill Well       4  Pump House
Pump House       3  Install Pipe
Power Line       3  Install Pipe
Excavate         5  Install Pipe   Install Pump   Foundation
Deliver Material 2  Assemble Tank
Assemble Tank    4  Erect Tower
Foundation       4  Erect Tower
Install Pump     6
Install Pipe     2
Erect Tower      6
;

proc cpm data=exmp1 date='1jan92'd out=sched;
   activity task;
   duration duration;
   successor succesr1 succesr2 succesr3;
   run;

goptions hpos=80 vpos=45 border;

pattern1 c=green v=e;
pattern2 c=red   v=e;

title f=triplex j=l h=1.5 ' Site: Old Well Road';
title2 f=triplex j=l h=1.5 ' Date: January 1, 1992';
footnote f=triplex j=r h=1 'Time Scale Options: Reference Breaks ';
proc netdraw data=sched graphics;
   actnet / act = task font=triplex
            dur = duration
            succ = (succesr1-succesr3)
            dp
            compress
            separatearcs
            lwidth = 1
            lwoutline = 3
            ybetween = 10
            carcs=cyan
            timescale
            refbreak
            crefbrk = blue
            lrefbrk = 33;
      run;

footnote f=triplex j=r h=1 'Time Scale Options: Linear Diagram ';
proc netdraw data=sched graphics;
   actnet / act = task font=triplex
            dur = duration
            succ = (succesr1-succesr3)
            dp
            pcompress
            novcenter
            vmargin = 10
            separatearcs
            lwidth = 1
            lwoutline = 3
            carcs=cyan
            id=(task)
            nodefid
            nolabel
            boxwidth=7
            timescale
            linear
            frame;
      run;


/* Example found on pages 533-535 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW11                                           */
 /*   TITLE: Zoned Network Diagrams                              */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Activity-on-Node representation of the project */
data widget;
   input task $ 1-12 days succ1 $ 19-30 succ2 $ 33-44 succ3 $ 47-58;
   cards;
Approve Plan   5  Drawings      Anal. Market  Write Specs
Drawings      10  Prototype
Anal. Market   5  Mkt. Strat.
Write Specs    5  Prototype
Prototype     15  Materials     Facility
Mkt. Strat.   10  Test Market   Marketing
Materials     10  Init. Prod.
Facility      10  Init. Prod.
Init. Prod.   10  Test Market   Marketing     Evaluate
Evaluate      10  Changes
Test Market   15  Changes
Changes        5  Production
Production     0
Marketing      0
;

data details;
input task $ 1-12 phase $ 15-27 descrpt $ 30-59;
cards;
Approve Plan  Planning       Develop Concept
Drawings      Engineering    Prepare Drawings
Anal. Market  Marketing      Analyze Potential Markets
Write Specs   Engineering    Write Specifications
Prototype     Engineering    Build Prototype
Mkt. Strat.   Marketing      Develop Marketing Concept
Materials     Manufacturing  Procure Raw Materials
Facility      Manufacturing  Prepare Manufacturing Facility
Init. Prod.   Manufacturing  Initial Production Run
Evaluate      Testing        Evaluate Product In-House
Test Market   Testing        Test Product in Sample Market
Changes       Engineering    Engineering Changes
Production    Manufacturing  Begin Full Scale Production
Marketing     Marketing      Begin Full Scale Marketing
;

data network;
   merge widget details;
   run;


goptions hpos=150 vpos=78 border;

pattern1 v=e c=green;
pattern2 v=e c=red;
pattern3 v=e c=magenta;
pattern4 v=e c=blue;
pattern5 v=e c=cyan;

title  j=l f=triplex h=2 ' Project: Widget Manufacture';
title2 j=l f=triplex h=2 ' Date: December 2, 1991';

footnote j=r f=triplex h=1.5 'Zoned Network Diagram ';

proc netdraw data=network graphics;
   actnet / act=task succ=(succ1 succ2 succ3)
            font = triplex
            lwidth = 3
            carcs = blue
            separatearcs
            zone=phase
            zonepat;
   label phase = 'Department';
   run;

proc cpm data=network interval=weekday
         out=sched date='2dec91'd;
   activity task;
   succ     succ1 succ2 succ3;
   duration days;
   id phase;
   run;

footnote j=r f=triplex h=1.5 'Zone and Timescale ';
proc netdraw data=sched graphics;
   actnet / act=task succ=(succ1 succ2 succ3)
            pcompress
            font = triplex
            lwidth = 1   /* lwidth = 3 */
            carcs = blue
            cref = cyan
            caxis = magenta
            lref = 33
            id = (task)
            nodefid
            nolabel
            boxwidth = 8
            lwoutline = 3
            separatearcs
            timescale
            mininterval=week
            autoref
            linear
            zone=phase
            zonespace;
   label phase = 'Department';
   run;


/* Example found on pages 537-540 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW12                                           */
 /*   TITLE: Data Flow                                           */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: CPM, NETDRAW                                        */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

   data dataflow;
   input a $ b $ id1 $20.  id2 $20. id3 $20. style;
   cards;
A B Data Definition:    PROC FSEDIT,        SAS/AF, etc.          2
B C Data Manipulation:  Sort, Merge,        Concatenate, etc.     2
B D Data Manipulation:  Sort, Merge,        Concatenate, etc.     2
D C                     PROC NETDRAW                              1
C E                     PROC CPM                                  1
C F                     PROC CPM                                  1
E H Resource Usage                          Data                  3
F G                     Schedule Data                             3
G I Data Manipulation:  Sort, Merge,        Subset, etc.          2
G J Data Manipulation:  Sort, Merge,        Subset, etc.          2
H K Data Manipulation:  Sort, Merge,        Subset, etc.          2
I . Other Reporting     PROC's: PRINT,      CALENDAR, etc.        2
J . PROC GANTT                              PROC NETDRAW          1
K . Reporting PROC's:   PLOT, CHART,        GPLOT, GCHART, etc.   2
;

title f=swiss h=1.5 'A Typical Project Management System';
title2 f=swiss h=1  'Schematic Representation of Data Flow';

pattern1 v=s c=red;
pattern2 v=s c=blue;
pattern3 v=s c=green;

proc netdraw data=dataflow graphics;
   actnet / act=a succ=b id = (id1-id3)
            nodefaultid font=swiss
            lwidth = 5
            lwoutline = 1
            nolabel
            pattern=style
            carcs=black coutline=black ctext=white
            hmargin = 2
            ybetween = 15
            rectilinear
            noarrowfill
            pcompress;
   run;


 /* To illustrate backward arcs */
   data outage;
   input a $ b $ id1 $20.  id2 $20. align style;
   cards;
A   B   Project            Definition             1  1
B   C   CPM                Schedule               2  2
C   D   Gantt Chart        Network                3  3
D   E   Start Power        Outage                 4  4
E   F   Project            Update                 5  1
F   G   Schedule           Update                 6  2
G   E   Gantt Chart        Network                7  3
;

goptions hpos=110 vpos=78 border;

title1 h=5 ' ';
title2 f=swiss h=2 'Scheduling an Outage';
title3 f=swiss h=2  'Project Cycle';

pattern1 v=s c=green;
pattern2 v=s c=blue;
pattern3 v=s c=blue;
pattern4 v=s c=red;

proc netdraw data=outage graphics;
   actnet / act=a succ=b id = (id1 id2)
            align=align notimeaxis
            nodefaultid font=swiss centerid
            lwidth = 5  vmargin = 5 hmargin = 0
            lwoutline = 1
            nolabel novcenter
            pattern=style
            carcs=black coutline=black ctext=white
            ybetween = 15 xbetween=3
            noarrowfill;
   run;


/* Example found on pages 542-545 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW13                                           */
 /*   TITLE: Modifying Network Layout                            */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: PRINT, NETDRAW                                      */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
data survey;
   input id        $ 1-20
         activity  $ 22-29
         duration
         succ1     $ 35-42
         succ2     $ 45-52
         succ3     $ 55-62
         phase     $ 64-72;
   cards;
Plan Survey          plan sur 4   hire per  design q           Plan
Hire Personnel       hire per 5   trn per                      Prepare
Design Questionnaire design q 3   trn per   select h  print q  Plan
Train Personnel      trn per  3   cond sur                     Prepare
Select Households    select h 3   cond sur                     Prepare
Print Questionnaire  print q  4   cond sur                     Prepare
Conduct Survey       cond sur 10  analyze                      Implement
Analyze Results      analyze  6                                Implement
;

   goptions hpos=85 vpos=55;

   goptions border;
   title f=swiss j=l ' Project: Market Survey';
   title2 f=swiss j=l h=1.5 ' Changing Node Positions';
   pattern1 v=s c=green;
   footnote f=swiss j=r 'Default Layout ';
   proc netdraw data=survey graphics out=network;
      actnet / act=activity
               succ=(succ1-succ3)
               id=(id) nodefid nolabel
               carcs = blue
               ctext  = white
               coutline=red
               font=swiss
               centerid
               boxht = 3
               lwidth = 3
               ybetween=8;
      run;

   title2 'NETWORK Output Data Set';
   proc print data=network;
      run;

   data nodepos;
      set network;
      if _seq_ = 0;
      drop _seq_;
      if _from_ = 'select h' then _y_=1;
      if _from_ = 'trn per' then _y_=3;
      run;

   title2 'Modified Node Positions';
   proc print data=nodepos;
      run;

   title2 f=swiss j=l h=1.5 ' Changing Node Positions';
   footnote f=swiss j=r 'Modified Network Layout ';
   proc netdraw data=nodepos graphics;
      actnet / id=(id) nodefid nolabel
               carcs = blue
               ctext = white
               coutline = red
               font = swiss
               centerid
               boxht = 3
               lwidth = 3
               ybetween=8;
      run;


/* Example found on page 547 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW14                                           */
 /*   TITLE: A Distribution Network                              */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: PRINT, NETDRAW                                      */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
data arcs;
   input from $  to $  _x_ _y_ _pattern;
CARDS;
PLANT_1  CUST_1      1  5  1
PLANT_1  DEPOT1_1    1  5  1
PLANT_1  DEPOT2_1    1  5  1
DEPOT1_1 CUST_1      2  6  1
DEPOT2_1 CUST_1      2  4  1
PLANT_1  PLANT_2     1  5  1
DEPOT1_1 DEPOT1_2    2  6  1
DEPOT2_1 DEPOT2_2    2  4  1
PLANT_2  CUST_2      4  2  2
PLANT_2  DEPOT1_2    4  2  2
PLANT_2  DEPOT2_2    4  2  2
DEPOT1_2 CUST_2      5  3  2
DEPOT2_2 CUST_2      5  1  2
CUST_1     .         3  5  1
CUST_2     .         6  2  2
;

goptions hpos=80 vpos=50;

goptions border;

title h=2 f=swiss c=blue 'Distribution Network';
pattern1 v=s  c=green;
pattern2 v=s  c=red;
proc netdraw data=arcs graphics out=netout;
   actnet / act=from succ=to separatearcs
            font=swiss
            lwidth=3
            ybetween = 4
            centerid
            ctext = white
            carcs=blue;
   run;


/* Example found on pages 548-550 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW15                                           */
 /*   TITLE: Tree Diagrams and Organizational Charts             */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: FORMAT, NETDRAW                                     */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data document;
   input parent $ child $ id $ 20-43 _pattern;
   cards;
OR      MP         Operations Research       1
OR      PM         Operations Research       1
PM      NETDRAW    Project Management        2
PM      GANTT      Project Management        2
PM      DTREE      Project Management        2
PM      CPM        Project Management        2
MP      TRANS      Mathematical Programming  3
MP      NETFLOW    Mathematical Programming  3
MP      LP         Mathematical Programming  3
MP      ASSIGN     Mathematical Programming  3
CPM     .          CPM Procedure             2
DTREE   .          DTREE Procedure           2
GANTT   .          GANTT Procedure           2
NETDRAW .          NETDRAW Procedure         2
ASSIGN  .          ASSIGN Procedure          3
LP      .          LP Procedure              3
NETFLOW .          NETFLOW Procedure         3
TRANS   .          TRANS Procedure           3
;

goptions ftext=swiss border;

pattern1 v=s c=blue;
pattern2 v=s c=red;
pattern3 v=s c=green;
title j=l h=1.5 ' Operations Research Documentation';
title2 j=l h=1 '  Procedures in Each Volume';
footnote j=r h=.75 'Default Tree Layout ';
proc netdraw graphics data=document;
   actnet / act=parent succ=child id=(id)
            nodefid nolabel pcompress centerid
            tree
            xbetween=15 ybetween=3 arrowhead=0
            rectilinear carcs=black ctext=white;
   run;

footnote j=r h=.75 'Centered Tree Layout ';
proc netdraw graphics data=document;
   actnet / act=parent succ=child id=(id)
            nodefid nolabel pcompress novcenter centerid
            tree separatesons centersubtree
            xbetween=15 ybetween=3 arrowhead=0
            rectilinear carcs=black ctext=white;
   run;


/* Example found on pages 551-553 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW16                                           */
 /*   TITLE: Use of ANNOTATE data set with PROC NETDRAW          */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: FORMAT, NETDRAW                                     */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

 /* Define format for the ALIGN= variable */
proc format;
   value classtim 1 = ' 9:00 - 10:00'
                  2 = '10:00 - 11:00'
                  3 = '11:00 - 12:00'
                  4 = '12:00 - 1:00 '
                  5 = ' 1:00 - 2:00 '
                  6 = ' 2:00 - 3:00 ';
   run;

data schedule;
   input day $ 1-10 class $ 12-24  time daytime $ msucc $;
   format time classtim.;
   label day = "Day \ Time";
   cards;
Monday     Mathematics    1   m1   .
Monday     Language       2   m2   .
Monday     Soc. Studies   3   m3   .
Monday     Art            5   m4   .
Monday     Science        6   m5   .
Tuesday    Language       1   t1   .
Tuesday    Mathematics    2   t2   .
Tuesday    Science        3   t3   .
Tuesday    Music          5   t4   .
Tuesday    Soc. Studies   6   t5   .
Wednesday  Mathematics    1   w1   .
Wednesday  Language       2   w2   .
Wednesday  Soc. Studies   3   w3   .
Wednesday  Phys. Ed.      5   w4   .
Wednesday  Science        6   w5   .
Thursday   Language       1   th1  .
Thursday   Mathematics    2   th2  .
Thursday   Science        3   th3  .
Thursday   Phys. Ed.      5   th4  .
Thursday   Soc. Studies   6   th5  .
Friday     Mathematics    1   f1   .
Friday     Language       2   f2   .
Friday     Soc. Studies   3   f3   .
Friday     Library        5   f4   .
Friday     Science        6   f5   .
;

pattern1 v=s c=magenta;

data anno;
   /* Set up required variable lengths, etc. */
   length function color style   $8;
   length xsys ysys hsys         $1;
   length when position          $1;

   xsys     = '2';
   ysys     = '2';
   hsys     = '4';
   when     = 'a';

   function = 'label   ';
   x = 4;
   size = 1;
   position = '5';
   y=5; text='L'; output;
   y=4; text='U'; output;
   y=3; text='N'; output;
   y=2; text='C'; output;
   y=1; text='H'; output;
   run;

goptions ftext = swiss border ctext=black;

goptions hpos=80 vpos=32;

title h=1 'Class Schedule: 1992-1993';
footnote h=.7 j=l '  Teacher: Mr. A. Smith Hall'
              j=r 'Room: 107  ';
proc netdraw graphics data=schedule anno=anno;
   actnet / act=daytime succ=msucc
            id=(class) nodefid nolabel
            zone=day align=time
            useformat
            linear
            pcompress
            coutline=black
            lwidth = 3
            hmargin = 2
            vmargin = 2;
   run;


/* Example found on pages 554-557 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW17                                           */
 /*   TITLE: Modifying Arc Routing and ANNOTATE                  */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: FORMAT, NETDRAW                                     */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF:                                                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/

data widgaoa;
   input task $ 1-12 days tail head _x_ _y_;
   cards;
Approve Plan   5   1   2   1  2
Drawings      10   2   3   4  2
Anal. Market   5   2   4   4  2
Write Specs    5   2   3   4  2
Prototype     15   3   5   7  1
Mkt. Strat.   10   4   6  10  3
Materials     10   5   7  10  1
Facility      10   5   7  10  1
Init. Prod.   10   7   8  13  1
Evaluate      10   8   9  16  1
Test Market   15   6   9  18  2
Changes        5   9  10  20  1
Production     0  10  11  23  1
Marketing      0   6  12  19  2
Dummy          0   8   6  16  1
.              .  11   .  26  1
.              .  12   .  22  3
;

goptions ftext=swiss;

goptions hpos=120 vpos=80;
title j=l ' Project: Widget Manufacture';
title2 j=l h=1.5 '  Network in Activity-on-Arc Format';

pattern1 v=e c=red;
footnote j=r f=triplex h=1 'Initial Layout ';
footnote2 h=5 ' ';
proc netdraw graphics data=widgaoa out=netout;
   actnet / act=tail succ=head id=(tail)
            align=_x_ zone=_y_  ybetween = 10
            nodefid nolabel compress;
   label _y_=' Y \ X ';
   run;

data netin;
  set netout;
  if _from_=4 and _to_=6 and _seq_>0 then _x_=16.5;
  run;

data anno1;
   set netout;
   if _seq_=0;
   /* Set up required variable lengths, etc. */
   length function color style   $8;
   length xsys ysys hsys         $1;
   length when position          $1;
   length text                   $12;
   xsys     = '2';
   ysys     = '2';
   hsys     = '4';
   when     = 'a';
   function = 'label   ';
   size = 2;
   position = '5';
   text = left(put(tail, f2.));
   x=_x_;
   if _y_ = 1 then y=_y_-.3;
   else            y=_y_+.5;
   run;

data anno2;
   /* Set up required variable lengths, etc. */
   length function color style   $8;
   length xsys ysys hsys         $1;
   length when position          $1;
   length text                   $12;
   xsys     = '2';
   ysys     = '2';
   hsys     = '4';
   when     = 'a';
   function = 'label   ';
   size = 2;
   position = '5';
   x=2.5;  y=1.8;  text='Approve Plan'; output;
   x=5.5;  y=.8;   text='Drawings';     output;
   x=5.7;  y=1.4;  text='Write Specs';  output;
   x=7;    y=3.4;  text='Anal.Market';  output;
   x=8.5;  y=.8;   text='Prototype';    output;
   x=11.5; y=1.4;  text='Facility';     output;
   x=11.5; y=.8;   text='Materials';    output;
   x=14.5; y=.9;   text='Init. Prod';   output;
   x=13.5; y=3.4;  text='Mkt. Strat.';  output;
   x=18;   y=.8;   text='Evaluate';     output;
   x=21.5; y=.8;   text='Changes';      output;
   x=24.5; y=.8;   text='Production';   output;
   x=20;   y=3.4;  text='Marketing';    output;
   position=6;
   x=16.6; y=1.5;  text='Dummy';        output;
   x=18.6; y=1.5;  text='Test Market';  output;
   ;

data anno;
   set anno1 anno2;
   run;

footnote j=r f=triplex h=1 'Annotated and Modified Layout ';
footnote2 h=10 ' ';
pattern1 v=s c=red;

proc netdraw graphics data=netin anno=anno;
   actnet / nodefid
            nolabel
            boxwidth=1
            pcompress
            novcenter
            vmargin=20
            lwidth=3;
   run;


/* Example found on pages 559-562 */

 /****************************************************************/
 /*          S A S   S A M P L E   L I B R A R Y                 */
 /*                                                              */
 /*    NAME: NETDRAW18                                           */
 /*   TITLE: Branch and Bound Tree                               */
 /* PRODUCT: OR                                                  */
 /*  SYSTEM: ALL                                                 */
 /*    KEYS: NETDRAW                                             */
 /*   PROCS: FORMAT, NETDRAW                                     */
 /*    DATA:                                                     */
 /*                                                              */
 /* SUPPORT:                             UPDATE:                 */
 /*     REF: Publc Domain IP Program, STEIN9                     */
 /*    MISC:                                                     */
 /*                                                              */
 /****************************************************************/
 /*** Iteration log obtained from PROC LP

stein9 --- lp3rw149.sas

      1       0     ACTIVE         4 0005     0.667       2      2         .
      2      -1     ACTIVE         4 0002     0.667       2      3         .
      3       2     ACTIVE         4 0004     0.667       2      4         .
      4      -3     ACTIVE 4.3333333 0007     0.667 1.66667      5         .
      5       4 SUBOPTIMAL         5 .            .       .      2         1
      6       3   FATHOMED 4.3333333 .            .       .      1         1
      7       1     ACTIVE         4 0008     0.333       2      2         1
      8      -7     ACTIVE         4 0007     0.667       2      3         1
      9      -8   FATHOMED 4.3333333 .            .       .      2         1
     10       8   FATHOMED 4.3333333 .            .       .      1         1
     11       7     ACTIVE         4 0007     0.667       2      2         1
     12     -11   FATHOMED 4.3333333 .            .       .      1         1
     13      11   FATHOMED       4.5 .            .       .      0         .

   *****/

data net;
  input node problem cond $10. object;
  if cond="ACTIVE"          then _pattern=1;
  else if cond="SUBOPTIMAL" then _pattern=2;
  else                           _pattern=3;
cards;
 1       0     ACTIVE         4
 2      -1     ACTIVE         4
 3       2     ACTIVE         4
 4      -3     ACTIVE 4.3333333
 5       4 SUBOPTIMAL         5
 6       3   FATHOMED 4.3333333
 7       1     ACTIVE         4
 8      -7     ACTIVE         4
 9      -8   FATHOMED 4.3333333
10       8   FATHOMED 4.3333333
11       7     ACTIVE         4
12     -11   FATHOMED 4.3333333
13      11   FATHOMED       4.5
;

data logic;
   keep node succ;
   set net(firstobs=2);
   succ=node;
   node=abs(problem);
run;

proc sort data=logic; by node;
run;

data bbtree;
  length id $ 9;
  merge logic net; by node;
  if node < 10 then id=put(node,1.)||put(object,f8.2);
  else              id=put(node,2.)||put(object,f7.2);
run;

 /* The first graph is drawn in portrait mode */
goptions vsize=5.75 in hsize=4.0 in hpos=80 vpos=32
         border rotate=portrait;

goptions ftext=swissb;
title    a=90 h=1 j=c 'Branch and Bound Tree';
footnote1 a=90 h=.8 c=red j=c 'Optimal  ' c=green '   Active  '
                     c=blue '   Fathomed ';
footnote2 a=90 h=2 ' ';
footnote3 a=90 h=.6 j=l ' Node shows Iteration Number and Objective Value ';
goptions border;
pattern1 v=s c=green;
pattern2 v=s c=red;
pattern3 v=s c=blue;
proc netdraw data=bbtree graphics out=bbout;
  actnet /activity=node successor=succ id=(id) lwidth=3 lwoutline=5
          ctext=white coutline=black xbetween=15 ybetween=3
          font=swiss
          separatearcs tree pcompress rectilinear rotatetext
          carcs=black arrowhead=0 nodefid nolabel;
run;

data netin;
   set bbout;
   if _seq_ = 0; drop _seq_ ;
   _x_ = _from_;
   id = substr(id, 3);
   run;

goptions hsize=5.75 in vsize=4.0 in
         rotate=landscape;

title    h=1 j=c 'Branch and Bound Tree';
title2   h=.75 'Aligned by Iteration Number';
footnote1 h=.8 c=red j=c 'Optimal     ' c=green '      Active     '
                     c=blue '      Fathomed ';
footnote2 h=2 ' ';
footnote3 h=.6 j=l ' Node shows Objective Value ';
pattern1 v=e c=green;
pattern2 v=e c=red;
pattern3 v=e c=blue;
proc netdraw data=netin graphics;
  actnet /id=(id) lwidth=1 lwoutline=3
          ctext=black
          font=swiss align = _from_  frame
          separatearcs pcompress rectilinear
          carcs=black arrowhead=0 nodefid nolabel;
run;



