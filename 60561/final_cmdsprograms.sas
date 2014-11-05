/*************** START CHAPTER 2 ********************************************/
/****************************************************************************/
/* Example 2.1                                                              */
/****************************************************************************/
data springgrads;
  input student $ 1-20 concentration $ 22-38 gpa;
datalines;
Johnson, Allison     Biochemistry      3.86
Davis, Jeffrey       General Biology   3.91
Hall, Daniel         Genetics          3.43
Hill, Courtney       Ecology           4.00
Scott, Tiffany       Plant Biology     3.58
Martinez, Teresa     Zoology           3.21
;;;
proc print data=springgrads;
  title "SPRINGGRADS";
run;
data summergrads;
  input student $ 1-20 concentration $ 22-38 gpa;
datalines;
Robinson, Adam       Biophysics        3.87
Cox, William         Zoology           3.61
;;;;
proc print data=summergrads;
  title "SUMMERGRADS";
run;
data fallgrads;
  input student $ 1-20 concentration $ 22-38 gpa;
datalines;
Mitchell, Frank      Biochemistry      3.25
Rogers, Melissa      Microbiology      4.00
Brown, Beverly       Molecular Biology 3.42
;;;
proc print data=fallgrads;
  title "FALLGRADS";
run;

data allgrads;
  set springgrads(in=inspring)
      summergrads(in=insummer)
      fallgrads(in=infall);

  attrib graduated length=$6 label='Semester Graduated';

  if inspring then graduated='Spring';
  else if insummer then graduated='Summer';
  else if infall then graduated='Fall';
run;
proc print data=allgrads;
  title "Example 2.1 ALLGRADS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 2.1 Related Technique 1                                          */
/****************************************************************************/
proc sql;
  create table allgrads as
    select *,
        'Spring' as graduated length=6 label='Semester Graduated'
          from springgrads
      outer union corr
    select *, 'Summer' as graduated length=6 label='Semester Graduated'
          from summergrads
      outer union corr
    select *, 'Fall' as graduated length=6 label='Semester Graduated'
          from fallgrads;
quit;
proc print data=allgrads;
  title "Example 2.1 Related Technique ALLGRADS Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 2.1 Related Technique 2                                          */
/****************************************************************************/
proc datasets library=work nolist;
  delete allgrads;
run;
quit;
proc append base=allgrads data=springgrads;
run;
proc append base=allgrads data=summergrads;
run;
proc append base=allgrads data=fallgrads;
run;
proc print data=allgrads;
  title "Example 2.1 Related Technique ALLGRADS Data Set Created with PROC APPEND";
run;


/****************************************************************************/
/* Example 2.2 Use data sets SPRINGGRADS, SUMMERGRADS, and FALLGRADS created*/
/* for Example 2.1                                                          */
/****************************************************************************/
proc sort data=springgrads;
  by descending gpa student;
run;
proc sort data=summergrads;
  by descending gpa student;
run;
proc sort data=fallgrads;
  by descending gpa student;
run;
data gpagrads;
  set springgrads(in=inspring)
      summergrads(in=insummer)
      fallgrads(in=infall);

  by descending gpa student;

  attrib graduated length=$6 label='Semester Graduated';

  if inspring then graduated='Spring';
  else if insummer then graduated='Summer';
  else if infall then graduated='Fall';
run;
proc print data=gpagrads;
  title "Example 2.2 GPAGRADS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 2.2 Related Technique Use data sets SPRINGGRADS, SUMMERGRADS, and*/
/* FALLGRADS created for Example 2.1                                        */
/****************************************************************************/
proc sql;
  create table gpagrads as
    select *,
        'Spring' as graduated length=6 label='Semester Graduated'
          from springgrads
      outer union corr
    select *, 'Summer' as graduated length=6 label='Semester Graduated'
          from summergrads
      outer union corr
    select *, 'Fall' as graduated length=6 label='Semester Graduated'
          from fallgrads
    order by gpa desc, student;
quit;
proc print data=gpagrads;
  title "Example 2.2 Related Technique GPAGRADS Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 2.3                                                              */
/****************************************************************************/
data ytdprices(drop=week) week22(drop=boardmtg);
  format tradedate mmddyy10. price dollar7.2;
  length boardmtg $ 1;
  drop i dj;
  do i=2 to 157;
    if i in (1,18,46,151) then continue;
    dj=cats('2010',put(i,z3.));
    tradedate=datejul(input(dj,7.));
    if weekday(tradedate) in (1,7) then continue;
    price=round(40*(1+exp(i*.0018)) + ceil(rannor(123)*3),.01);

    if tradedate in ('12jan2010'd, '09feb2010'd, '09mar2010'd,
                     '13apr2010'd, '11may2010'd) then boardmtg='X';
    else boardmtg=' ';

    if i le 151 then output ytdprices;
    else do;
      week=week(tradedate,'U');
      output week22;
    end;
  end;
run;
proc print data=ytdprices(obs=10);
  title "YTDPRICES (first 10 observations)";
run;
proc print data=ytdprices(firstobs=99);
  title "YTDPRICES (last 5 observations)";
run;
proc print data=week22;
  title "WEEK22";
run;

proc append base=ytdprices data=week22 force;
run;
proc print data=ytdprices(firstobs=99);
  title "Example 2.3 YTDPRICES Data Set (last 9 observations) Created with PROC APPEND";
run;

/****************************************************************************/
/* Example 2.3 Related Technique                                            */
/****************************************************************************/
proc datasets library=work nolist;
  append base=ytdprices data=week22 force;
run;
quit;
proc print data=ytdprices(firstobs=99);
  title "Example 2.3 Related Technique YTDPRICES (last 9 observations) Updated with PROC APPEND";
run;

/****************************************************************************/
/* Example 2.3 A Closer Look                                                */
/****************************************************************************/
data ytdprices;
  set ytdprices week22(drop=week);
run;

proc sql;
  create table ytdprices as
    select * from ytdprices
      outer union corr
    select tradedate, price from week22;
quit;



/****************************************************************************/
/* Example 2.4                                                              */
/****************************************************************************/
data marchrunners aprilrunners mayrunners;
  length runner $ 20;
  input runner $ 1-20;

  array basetimes{6} _temporary_ (35, 36, 37, 38, 39, 40);
  format racetime mmss7.2;
  drop minutes seconds i mar apr may;

  array mo{3} mar apr may;

  do i=1 to 3;
    mo{i}=0;
  end;

  if _n_ le 12 or _n_ in (15,21) then mar=1;
  if mod(_n_,3)=0 then apr=1;
  if _n_ ge 12 then may=1;


  do i=1 to 3;
    if mo{i} then do;
      minutes=basetimes{ceil(ranuni(6)*6)};
      seconds=ceil(ranuni(59)*59)+round(ranuni(5900),.01);
      racetime=hms(0,minutes,seconds);
      if i=1 then output marchrunners;
      else if i=2 then output aprilrunners;
      else if i=3 then output mayrunners;
    end;
  end;
datalines;
Sanchez, SO
Flores, RX
Martinez, KF
Hayes, MU
Carter, RT
Rogers, LX
Clark, SQ
Taylor, TP
Smith, JD
Green, TF
Brown, GL
Lee, AO
Williams, JO
Martin, JF
Jones, LW
Young, MX
Brown, NV
Patterson, BB
Johnson, AY
Cox, SR
Smith, KB
Martin, MG
Johnson, GR
Alexander, SW
Martinez, WL
Miller, JN
Young, SX
Wilson, WU
run;
proc print data=marchrunners;
  title "MARCHRUNNERS";
run;
proc print data=aprilrunners;
  title "APRILRUNNERS";
run;
proc print data=mayrunners;
  title "MAYRUNNERS";
run;

proc sql;
  create table springrunners as
    select runner from marchrunners
      union
    select runner from aprilrunners
      union
    select runner from mayrunners;
quit;
proc print data=springrunners;
  title "Example 2.4 SPRINGRUNNERS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 2.4 Related Technique                                            */
/****************************************************************************/
data allentries;
  set marchrunners aprilrunners mayrunners;
  keep runner;
run;
proc sort data=allentries out=springrunners nodupkey;
  by runner;
run;
proc print data=springrunners;
  title "Example 2.4 Related Technique SPRINGRUNNERS Data Set Created with DATA Step and PROC SORT";
run;



/****************************************************************************/
/* Example 2.5   Use MARCHRUNNERS, APRILRUNNERS, MAYRUNNERS data sets       */
/*   created in Example 2.4                                                 */
/****************************************************************************/
proc sql;
  create table ran3times as
    select runner from marchrunners
      intersect
    select runner from aprilrunners
      intersect
    select runner from mayrunners
    order by runner;
quit;
proc print data=ran3times;
  title "Example 2.5 RAN3TIMES Table Created with PROC SQL";
run;



/****************************************************************************/
/* Example 2.6  Use MARCHRUNNERS, APRILRUNNERS, MAYRUNNERS data sets        */
/*   created in Example 2.4                                                 */
/****************************************************************************/
proc sort data=marchrunners;
  by runner;
run;
proc sort data=aprilrunners;
  by runner;
run;
proc sort data=mayrunners;
  by runner;
run;
data ranonce;
  merge marchrunners(in=inmar) aprilrunners(in=inapr) mayrunners(in=inmay);
    by runner;
  if inmar+inapr+inmay=1;
run;
proc print data=ranonce;
  title "Example 2.6 RANONCE Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 2.6 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table ranonce as
    select runner from
      (select runner from marchrunners
         outer union corr
       select runner from aprilrunners
         outer union corr
       select runner from mayrunners)
      group by runner
      having count(*)=1;
quit;
proc print data=ranonce;
  title "Example 2.6 Related Technique RANONCE Table Created with PROC SQL";
run;

/*************** END CHAPTER 2 **********************************************/


/*************** START CHAPTER 3 ********************************************/
/****************************************************************************/
/* Example 3.1                                                              */
/****************************************************************************/
data tasks;
  input id $ name $ dept $ task $;
datalines;
MSG01 Miguel A12 Document
FXB03 Fred B45 Survey
DDQ02 Diana B45 Document
MRF08 Monique A12 Document
VTN18 Vien D03 Survey
;;;
proc sort data=tasks;
  by id;
run;
proc print data=tasks;
  title "TASKS";
run;

data hours;
  input id $ name $ available_hours;
datalines;
FXB03 Fred 35
DDQ02 Diana 40
SWL14 Steve 0
MRF08 Monique 37
VTN18 Vien 42
;;;
proc sort data=hours;
  by id;
run;
proc print data=hours;
  title 'HOURS';
run;

data task_status;
  length origin $ 5;

  merge tasks(in=intasks) hours(in=inhours);
  by id;

  if intasks and inhours then origin='both';
  else if intasks then origin='tasks';
  else if inhours then origin='hours';

  if missing(dept) then dept='NEW';
  if missing(task) then task='NONE';
  if missing(available_hours) then available_hours=0;
run;
proc print data=task_status;
  title "Example 3.1 TASK_STATUS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 3.1 Related Technique 1                                          */
/****************************************************************************/
proc sql;
  create table task_status as
    select case when tasks.id is not missing and hours.id is not missing then 'both'
                when hours.id is not missing then 'hours'
                when tasks.id is not missing then 'tasks'
                else '?????'
            end as origin length=5,
        coalesce(tasks.id,hours.id) as id,
        coalesce(tasks.name,hours.name) as name,
        coalesce(tasks.task,'NONE') as task,
        coalesce(tasks.dept,'NEW') as dept,
        coalesce(hours.available_hours,0)as available_hours
      from tasks full join hours on tasks.id=hours.id;
quit;
proc print data=task_status;
  title "Example 3.1 Related Technique TASK_STATUS Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 3.2                                                              */
/****************************************************************************/
data agents;
  input id lname $;
datalines;
0991 Wong
5144 Johnson
8170 Cross
8173 Chan
9381 Ames
;;;
proc print data=agents;
  title "AGENTS";
run;
data properties;
  input id salesprice;
  format salesprice dollar12.2;
datalines;
0991 345000
5144  80000
5144 644000
8170  72000
8170  64000
8170 426500
8173 198400
9381 278000
;;;
proc print data=properties;
  title "PROPERTIES";
run;
data rates;
  input id rate;
datalines;
0991 .04
5144 .035
8170 .08
8173 .06
9381 .05
;;;
proc print data=rates;
  title "RATES";
run;
data payouts;
  merge agents properties rates;
  by id;
  commission=rate*salesprice;
  format commission salesprice dollar12.2;
run;
proc print data=payouts;
  title "Example 3.2 PAYOUTS Related Technique Created with DATA Step";
run;

/****************************************************************************/
/* Example 3.2 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table payouts as
    select agents.id, lname, salesprice format=dollar12.2, rate,
           salesprice*rate as commission format=dollar12.2
      from agents,properties,rates
      where agents.id=properties.id and properties.id=rates.id;
quit;
proc print data=payouts;
  title "Example 3.2 Related Technique PAYOUTS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 3.3                                                              */
/****************************************************************************/
data batch_one;
  input samptime datetime18. sample;
  format samptime datetime20.;
datalines;
23nov2009:09:01:00 100
23nov2009:10:03:00 101
23nov2009:10:58:00 102
23nov2009:11:59:00 103
23nov2009:13:00:00 104
23nov2009:14:02:00 105
23nov2009:16:00:00 106
;;;;
proc print data=batch_one;
  title "BATCH_ONE";
run;

data batch_two;
  input samptime datetime18. sample;
  format samptime datetime20.;
datalines;
23nov2009:09:00:00 200
23nov2009:09:59:00 201
23nov2009:11:04:00 202
23nov2009:12:02:00 203
23nov2009:14:01:00 204
23nov2009:14:59:00 205
23nov2009:15:59:00 206
23nov2009:16:59:00 207
23nov2009:18:00:00 208
;;;;
proc print data=batch_two;
  title "BATCH_TWO";
run;

proc sql;
  create table match_approx as
    select one.samptime as samptime1, one.sample as sample1,
           two.samptime as samptime2, two.sample as sample2
      from batch_one one
             full join
           batch_two two
      on abs(one.samptime-two.samptime)<=300;
quit;proc print data=match_approx;
  title "Example 3.3 MATCH_APPROX Table Created with PROC SQL";
run;




/****************************************************************************/
/* Example 3.4                                                              */
/****************************************************************************/
data prizes;
  input @1 completed mmddyy10. prize $ 12-33;
  format completed mmddyy10.;
datalines;
01/31/2009 Restaurant Certificate
02/28/2009 Audio Player
03/31/2009 Theater Tickets
04/30/2009 Baseball Tickets
;;;;
proc sort data=prizes;
  by completed;
run;
proc print data=prizes;
  title "PRIZES";
run;
data participants;
  input name $ 1-20 @22 completed mmddyy10.;
  format completed mmddyy10.;
datalines;
Moore, Kathryn       12/27/2008
Jackson, Barbara     01/15/2009
Brown, Shannon       03/23/2009
Williams, Debra      03/26/2009
Harris, Joseph       02/01/2009
Brown, Patricia      01/08/2009
Johnson, Christopher 02/17/2009
Rodriguez, Shawn     03/31/2009
Gonzalez, Patrick    01/14/2009
Wright, Nicholas     03/02/2009
Jones, Robert        02/28/2009
Miller, Christopher  03/25/2009
;;;
proc print data=participants;
  title "PARTICIPANTS";
run;
proc sort data=participants;
  by completed;
run;
data partic_prizes;
  merge prizes(in=inz) participants(in=inp);
    by completed groupformat;
  format completed monyy7.;
  if inp;

  if not inz then prize='(unknown)';
run;
proc print data=partic_prizes;
  title "Example 3.4 PARTIC_PRIZES Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 3.4 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table partic_prizes as
    select p.completed format=monyy7., name,
           coalesce(prize,'(unknown)') as Prize
      from participants p
        left join
      prizes z
        on put(p.completed,monyy7.)=put(z.completed,monyy7.)
      order by p.completed;
quit;
proc print data=partic_prizes;
  title "Example 3.4 Related Technique PARTIC_PRIZES Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 3.5                                                              */
/****************************************************************************/
data webclasses;
  input classid $  maxstudents @8 class_title $35.;
datalines;
101 25 Web Design 1
201 15 Web Design 2
301 15 Web Design 3
210 35 Increasing Website Traffic
203 20 Web Graphics 1
303 15 Web Graphics 2
;;;
proc print data=webclasses;
  title "WEBCLASSES";
run;
data class_updates;
  input classid $3. maxstudents @8 class_title $35.;
datalines;
101 30 Basic Web Design
201 20 Intermediate Web Design
301 15 Advanced Web Design
220 15 Internet Security
010 40 Keyboarding
;;;;
proc print data=class_updates;
  title "CLASS_UPDATES";
run;
data webclass_schedule;
  input classid sessionid $ startdate :mmddyy10.;
  format startdate mmddyy10.;
datalines;
101 A 09/03/2009
101 B 10/05/2009
201 A 10/05/2009
210 A 09/15/2009
220 A 09/21/2009
010 A 09/02/2009
010 B 10/07/2009
010 C 10/27/2009
;;;
proc print data=webclass_schedule;
  title "WEBCLASS_SCHEDULE";
run;
proc sql;
  create table allwebclasses as
    select coalesce(c.classid,put(s.classid,z3.-l)) as classid,
           coalesce(sessionid,'none') as sessionid,
           startdate, class_title, maxstudents
           from webclass_schedule s
      full join
        (select coalesce(old.classid,new.classid) as classid length=3,
                coalesce(new.maxstudents,old.maxstudents) as maxstudents,
                coalesce(new.class_title,old.class_title) as class_title
            from webclasses old
                   full join
                 class_updates new
            on old.classid=new.classid)
          c
      on c.classid=put(s.classid,z3.-l)
      order by classid, startdate;
quit;
proc print data=allwebclasses;
  title "Example 3.5 ALLWEBCLASSES Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 3.5 Related Technique                                            */
/****************************************************************************/
data schedule2;
  set webclass_schedule(rename=(classid=nclassid));
  length classid $ 3;
  drop nclassid;
  classid=put(nclassid,z3.-l);
run;
proc sort data=webclasses;
  by classid;
run;
proc sort data=class_updates;
  by classid;
run;
proc sort data=schedule2;
  by classid startdate;
run;
data allwebclasses;
  length classid $ 3;
  merge webclasses class_updates schedule2(in=insched);
  by classid;
  if not insched then sessionid='none';
run;

proc print data=allwebclasses;
  title "Example 3.5 Related Technique ALLWEBCLASSES Data Set Created with PROC SORT and DATA Step";
run;



/****************************************************************************/
/* Example 3.6                                                              */
/****************************************************************************/
data build_projects;
  input start_date end_date project $;
  informat start_date end_date mmddyy10.;
  format start_date end_date mmddyy10.;
datalines;
01/08/2010 01/27/2010 Basement
02/01/2010 02/12/2010 Frame
02/15/2010 02/20/2010 Roofing
02/22/2010 02/27/2010 Plumb
03/02/2010 03/05/2010 Wire
03/08/2010 03/29/2010 Brick
;;;;
proc print data=build_projects;
  title "BUILD_PROJECTS";
run;

data build_bills;
  input workid completion_date charge;
  informat completion_date mmddyy10.;
  format completion_date mmddyy10. charge dollar8.2;
datalines;
1234 01/18/2010 944.80
2225 02/18/2010 1280.94
3879 03/04/2010 888.90
8888 03/19/2010 2280.87
;;;;
proc print data=build_bills;
  title "BUILD_BILLS";
run;

proc sql;
  create table build_complete as
    select *
      from build_projects, build_bills
      where completion_date between start_date and end_date;
quit;
proc print data=build_complete;
  title "Example 3.6 BUILD_COMPLETE Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 3.6 Related Technique                                            */
/****************************************************************************/
data build_complete;
  set build_projects;

  drop found;

  found=0;

  do i=1 to n until (found);
    set build_bills point=i nobs=n;

    if start_date le completion_date le end_date then do;
      found=1;
      output;
    end;
  end;
run;
proc print data=build_complete;
  title "Example 3.6 Related Technique BUILD_COMPLETE Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 3.7                                                              */
/****************************************************************************/
data engineers;
  input engineer : $8. availhours;
datalines;
Inge 33
Jane 100
Eduardo 12
Fred 16
Kia 130
Monique 44
Sofus 23
;;;
proc print data=engineers;
  title "ENGINEERS";
run;
data eng_projects;
  input project_id : $12. hours;
datalines;
AERO041 31
BRANDX 150
CHEM005 18
CONTRACTA 41
ENGDESIGN2 6
ENGDESIGN3 29
;;;
proc print data=eng_projects;
  title "ENG_PROJECTS";
run;

data engineers eng_assign(keep=engineer project_id);
  set eng_projects;
  found=0;

  do i=1 to 1000 while (not found);
    ranobsno=ceil(ranuni(12345)*n);
    modify engineers point=ranobsno nobs=n;

    if availhours => hours then do;
      output eng_assign;
      availhours=availhours-hours;
      replace engineers;
      found=1;
    end;
  end;

  if found=0 then do;
    engineer='**NONE**';
    output eng_assign;
  end;
run;
proc print data=engineers;
  title "Example 3.7 Updated ENGINEERS data set";
run;
proc print data=eng_assign;
  title "Example 3.7 ENG_ASSIGN data set";
run;




/****************************************************************************/
/* Example 3.8                                                              */
/****************************************************************************/
data maintenance;
  input vehicle_id task_code $ discount mechanic $;
datalines;
195331 M001 0   REW
195331 M005 .05 REW
321551 M003 .08 PFG
371616 M006 .12 KJH
371616 M003 0   JNB
911192 M002 0   TRA
;;;;
proc print data=maintenance;
  title "MAINTENANCE";
run;
data vehicles;
  input vehicle_id @8 type $9. @18 customer $15.;
datalines;
195331 Minivan   Lee, HG
152843 Sedan     Gomez, UR
321551 SUV       Carlson, BG
430912 Sedan     Quinn, IP
371616 Minivan   Monte, YR
843200 Hatchback Weeks, CA
911192 SUV       Lane, NH
;;;;
proc print data=vehicles;
  title "VEHICLES";
run;
data maintcharges;
  input task_code $ @5 task_desc $20. charge;
  format charge dollar8.2;
datalines;
M001 Oil change          25
M002 Filters             30
M003 Tire rotation       40
M004 Brake pads          100
M005 Radiator flush      100
M006 Battery replacement 120
;;;;
proc print data=maintcharges;
  title "MAINTCHARGES";
run;

proc sql;
  create table maintbills as
    select m.vehicle_id, customer, type,
           m.task_code, task_desc,
          (charge-discount*charge) as cost format=dollar8.2
      from maintenance as m,
           vehicles as v,
            maintcharges as c
      where m.vehicle_id=v.vehicle_id and
            m.task_code=c.task_code
      order by m.vehicle_id, m.task_code;
quit;
proc print data=maintbills;
  title "Example 3.8 MAINTBILLS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 3.8 Related Technique                                            */
/****************************************************************************/
data maintbills;
  attrib vehicle_id length=8
         customer length=$15
         type     length=$9
         task_code length=$8
         task_desc length=$20
         cost      length=8 format=dollar10.2
         charge    length=8
         discount  length=8;
   keep vehicle_id customer type task_code task_desc cost;
   if _n_=1 then do;
     declare hash v(dataset:"work.vehicles");
     v.defineKey('vehicle_id');
     v.definedata('type','customer');
     v.definedone();

     declare hash c(dataset:"work.maintcharges");
     c.defineKey('task_code');
     c.definedata('task_desc','charge');
     c.definedone();

     call missing(type,customer,task_desc,charge);
   end;
   set maintenance;

   rcv=v.find(key: vehicle_id);
   rcc=c.find(key: task_code);

   if rcv=0 and rcc=0 then cost=charge-discount*charge;
run;
proc print data=maintbills;
  title "Example 3.8 Related Technique MAINTBILLS Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 3.9                                                              */
/****************************************************************************/
data trial_a;
  retain fullstring 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  drop i j fullstring;
  length patientid $ 4 patientinits $ 3;
  do i=1 to 5;
    patientid=' ';
    patientinits=' ';
    do j=1 to 4;
      patientid=cats(patientid,substr(fullstring,ceil(uniform(151+j+i)*36),1));
    end;
    do j=1 to 3;
      patientinits=cats(patientinits,substr(fullstring,ceil(uniform(151+j+i)*26),1));
    end;
    output;
  end;
run;
proc print data=trial_a;
  title "TRIAL_A";
run;
data trial_tests;
  length testcode $ 4 testtype $ 15;
  input testcode $ testtype $;
datalines;
L001 Cholesterol
L002 Glucose
L003 HDL
L004 LDL
L005 Triglycerides
;;;
proc print data=trial_tests;
  title "TRIAL_TESTS";
run;
proc sql;
  create table alltests as
    select *,
           'Not done yet' length=12 as result
           from trial_a, trial_tests;
quit;
proc print data=alltests;
  title "Example 3.9 ALLTESTS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 3.9 Related Technique                                           */
/****************************************************************************/
data alltests;
  set trial_a;
  do test=1 to ntests;
    set trial_tests nobs=ntests point=test;
    output;
  end;
run;
proc print data=alltests;
  title "Example 3.9 Related Technique ALLTESTS Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 3.10                                                             */
/****************************************************************************/
data meetings;
  input @1 meetingdate mmddyy10. event $ 12-41 approx_attendance;
  format meetingdate mmddyy10.;
datalines;
09/14/2009 Civil Engineering Seminar 1    25
09/14/2009 Economics Panel Discussion     150
09/14/2009 Psychology Working Group       15
09/14/2009 Statistics Users Group         45
09/15/2009 Civil Engineering Seminar 2    25
09/15/2009 Energy Solutions Committee     50
09/15/2009 Language Arts Teachers         60
09/15/2009 Management Certification       25
09/15/2009 Transit Planning Hearing       40
;;;
proc print data=meetings;
  title "MEETINGS";
run;
data meetingrooms;
  input @1 meetingdate mmddyy10. room_number $ 12-15 capacity;
  format meetingdate mmddyy10.;
datalines;
09/14/2009 A140 100
09/14/2009 A020  40
09/14/2009 B200 300
09/14/2009 B220  75
09/14/2009 C030  15
09/14/2009 C125  30
09/15/2009 A140 100
09/15/2009 A120  25
09/15/2009 A200 300
09/15/2009 B110  50
09/15/2009 B220  25
09/15/2009 C050  25
09/15/2009 C070  10
09/15/2009 C125  20
;;;
proc print data=meetingrooms;
  title "MEETINGROOMS";
run;
proc sql;
  create table possible_locs as
    select m.*, room_number, capacity
      from meetings m, meetingrooms r
      where m.meetingdate=r.meetingdate and
            approx_attendance le capacity
      order by meetingdate, event, room_number;
quit;
proc print data=possible_locs;
  title "Example 3.10 POSSIBLE_LOCS Table Created with PROC SQL";
run;



/****************************************************************************/
/* Example 3.10 Related Technique 1                                         */
/****************************************************************************/
data possible_locs;
  attrib meetingdate length=8 format=mmddyy10.
         event length=$30
         approx_attendance length=8
         roomdate length=8 format=mmddyy10.
         capacity length=8
         room_number length=$4;

  if _n_=1 then do;
    declare hash rooms(dataset: 'work.meetingrooms(rename=(meetingdate=roomdate))',
                       multidata: 'yes',
                       ordered: 'a');
    declare hiter iter('rooms');

    rooms.definekey('roomdate');
    rooms.definedata(all:'yes');
    rooms.definedone();
    call missing(roomdate, room_number, capacity);
  end;

  set meetings;

  drop rc roomdate;

  rc=iter.first();
  do while (rc=0);
    if meetingdate=roomdate and approx_attendance le capacity then output;
    if roomdate > meetingdate then leave;
    rc=iter.next();
  end;
run;
proc print data=possible_locs;
  title "Example 3.10 Related Technique POSSIBLE_LOCS Data Set Created with DATA Step Hash Iterator";
run;



/****************************************************************************/
/* Example 3.11                                                             */
/****************************************************************************/
data furniture_sales;
  attrib product length=4
         salesrep length=$15
         orderno  length=$10;

  input product salesrep $ orderno $;
datalines;
309 J.Corrigan   09173JC018
310 K.Roland     09173KR001
310 Y.Alvarez    09173YA015
312 J.Corrigan   09173JC021
313 J.Corrigan   09173JC031
313 K.Roland     09173KR008
;;;;
proc sort data=furniture_sales;
  by product;
run;
proc print data=furniture_sales;
  title "FURNITURE_SALES";
run;
data furniture_stock;
  attrib product length=4
         product_desc length=$25
         pieceid length=$8
         piece_desc length=$15;
  input product product_desc $ 5-23 pieceid $ 25-32 piece_desc $ 34-47;
datalines;
310 oak pedestal table  310.0103 tabletop
310 oak pedestal table  310.0203 pedestal
310 oak pedestal table  310.0303 two leaves
311 upholstered chair   311.0103 chair base
311 upholstered chair   311.0203 one cushion
311 upholstered chair   311.0303 two arm covers
312 brass floor lamp    312.0102 lamp base
312 brass floor lamp    312.0202 lamp shade
313 oak bookcase, short 313.0102 bookcase
313 oak bookcase, short 313.0202 two shelves
;;;;
proc print data=furniture_stock;
  title "FURNITURE_STOCK";
run;
proc datasets library=work;
  modify furniture_stock;
  index create product;
run;
quit;

data shiplist(drop=multsameprod instock)
     nostockinfo(keep=product salesrep orderno);
  set furniture_sales;
  by product;

  multsameprod=0;
  instock=0;

  do until(_iorc_=%sysrc(_dsenom));
    if multsameprod then product=0;
    set furniture_stock key=product;

    select (_iorc_);
      when (%sysrc(_sok)) do;
        instock=1;
        output shiplist;
      end;
      when (%sysrc(_dsenom)) do;
        _error_=0;
        if not last.product and multsameprod=0 then do;
          multsameprod=1;
          _iorc_=0;
        end;
      end;
      otherwise do;
        putlog 'ERROR: Unexpected ERROR: _IORC_= ' _iorc_;
        stop;
      end;
    end;
  end;
  if not instock then output nostockinfo;
run;
proc print data=shiplist;
  title "Example 3.11 SHIPLIST Data Set Created with DATA Step";
run;
proc print data=nostockinfo;
  title "Example 3.11 NOSTOCKINFO Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 3.11 Related Technique                                           */
/****************************************************************************/
proc sql;
  create table shiplist as
    select * from furniture_sales as s,
                  furniture_stock as k
      where s.product=k.product;
  create table nostockinfo as
    select * from furniture_sales
      where product not in (select distinct product from furniture_stock);
quit;
proc print data=shiplist;
  title "Example 3.11 Related Technique SHIPLIST Table Created with PROC SQL";
run;
proc print data=nostockinfo;
  title "Example 3.11 Related Technique NOSTOCKINFO Table Created with PROC SQL";
run;



/****************************************************************************/
/* Example 3.12                                                             */
/****************************************************************************/
data weight_loss;
  input id $ goal_weight;
datalines;
S001 190
S002 176
S003 136
S004 118
S005 135
;;;
proc print data=weight_loss;
  title "WEIGHT_LOSS";
run;
proc sort data=weight_loss;
  by id;
run;
data weights;
  input id $ week weight;
datalines;
S001 1 231
S002 1 187
S003 1 154
S004 1 134
S001 2 223
S003 2 151
S004 2 133
S002 3 176
S003 3 148
S004 4 129
S003 4 142
;;;;
proc print data=weights;
  title "WEIGHTS";
run;
proc sort data=weights;
  by id week;
run;
proc transpose data=weights out=transwt(drop=_name_)
               prefix=wt_week;
  by id;
  var weight;
  id week;
run;
data weight_updates;
  merge weight_loss(in=ingroup) transwt;
    by id;

  if ingroup;
run;
proc print data=weight_updates;
  title "Example 3.12 WEIGHT_UPDATES Data Set Created with PROC TRANSPOSE and DATA Step";
run;

/****************************************************************************/
/* Example 3.12 Related Technique                                           */
/****************************************************************************/
data weight_updates;
  merge weight_loss(in=ingroup) weights;
    by id;

  array wt_week{4};
  retain wt_week:;

  drop  weight week;


  if first.id then call missing(of wt_week[*]);

  if 1 le week le dim(wt_week) then wt_week{week}=weight;

  if last.id then output;
run;
proc print data=weight_updates;
  title "Example 3.12 Related Technique WEIGHT_UPDATES Created with DATA Step";
run;



/****************************************************************************/
/* Example 3.13                                                             */
/****************************************************************************/
data kids_ids;
  attrib id length=$5
         dob informat=mmddyy10. format=mmddyy10.;
  input id $ dob;
datalines;
C0402 07/15/2001
C1593 06/30/2003
C1374 04/23/2007
C3811 02/01/2009
C1901 03/18/2009
;;;
proc print data=kids_ids;
  title "KIDS_IDS";
run;
data immunizations;
  attrib id length=$5
         type length=$10
         sequence length=3
         received informat=mmddyy10. format=mmddyy10.;
  input id $ type $ sequence received;
datalines;
C3811 POLIO 1 04/01/2009
C0402 DTAP  1 09/12/2001
C0402 POLIO 1 09/12/2001
C0402 DTAP  2 11/16/2001
C0402 POLIO 2 11/16/2001
C0402 DTAP  3 01/10/2002
C0402 POLIO 3 04/14/2002
C0402 CPOX  1 07/30/2002
C0402 MMR   1 07/30/2002
C0402 DTAP  4 11/20/2002
C0402 CPOX  2 04/15/2006
C0402 MMR   2 04/15/2006
C0402 DTAP  5 08/15/2006
C0402 POLIO 4 08/15/2006
C1593 DTAP  1 09/05/2003
C1593 POLIO 1 09/05/2003
C1593 DTAP  2 10/29/2003
C1593 POLIO 2 10/29/2003
C1593 DTAP  3 01/03/2004
C1593 CPOX  1 08/04/2004
C1593 MMR   1 08/04/2004
C1593 DTAP  4 10/20/2004
C1593 DTAP  5 07/16/2008
C1593 POLIO 3 07/16/2008
C1593 CPOX  2 08/23/2008
C1593 MMR   2 08/23/2008
C1374 DTAP  1 06/28/2007
C1374 POLIO 1 06/28/2007
C1374 DTAP  2 08/22/2007
C1374 POLIO 2 08/22/2007
C1374 DTAP  3 10/20/2007
C1374 POLIO 3 01/22/2008
C1374 CPOX  1 05/03/2008
C1374 MMR   1 05/03/2008
C0054 DTAP  1 07/01/2000
C0054 POLIO 1 07/01/2000
;;;;
proc datasets library=work;
  modify immunizations;
  index create id;
run;
quit;
proc print data=immunizations;
  title "IMMUNIZATIONS";
run;
data dtap_kids;
  set kids_ids;

  array allshots{5} dtap_date1-dtap_date5;
  format dtap_date1-dtap_date5 mmddyy10.;

  drop sequence received type;

  do until (_iorc_=%sysrc(_dsenom));
    set immunizations key=id;

    select (_iorc_);
      when(%sysrc(_sok)) do;
        if type='DTAP' then do;
          if 1 le sequence le 5 then allshots{sequence}=received;
          else putlog 'ERROR: DTAP_DATE cannot be updated. Value of SEQUENCE is not 1-5.'/
                      id= sequence= received=;
        end;
      end;
      when (%sysrc(_dsenom)) do;
        if allshots1 ne . then output;
        _error_=0;
      end;
      otherwise do;
        putlog "ERROR: Unexpected error _IORC_=" _iorc_;
        stop;
      end;
    end;
  end;
run;
proc print data=dtap_kids;
  title "Example 3.13 DTAP_KIDS Data Set Created with DATA Step";
run;
/*************** END CHAPTER 3 **********************************************/


/*************** START CHAPTER 4*********************************************/
/****************************************************************************/
/* Example 4.1                                                              */
/****************************************************************************/
data salaries;
  input empnum salary;
  format salary dollar10.;
datalines;
1234 125000
3333 85000
4876 54000
5489 29000
;;;;
proc print data=salaries;
  title "SALARIES";
run;

data brackets;
  input empnum tax_bracket;
datalines;
1111 0.28
1234 0.33
3333 0.28
4222 0.15
4876 0.25
;;;;
proc print data=brackets;
  title "BRACKETS";
run;

proc sql;
  create table netpay as
    select s.empnum, s.salary,
           case when tax_bracket eq . then 0.10
                else tax_bracket
           end as tax_bracket format=4.2,
           salary*(1-calculated tax_bracket)
             as net_pay format=dollar10.

        from salaries s left join brackets
        on s.empnum=brackets.empnum;
quit;
proc print data=netpay;
  title "Example 4.1 NETPAY Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 4.1 Related Technique 1                                          */
/****************************************************************************/
data netpay;
  attrib empnum length=8
         salary length=8 format=dollar10.
         tax_bracket length=8 format=4.2
         net_pay length=8 format=dollar10.;

  retain default_bracket .10;
  drop default_bracket rc;

  if _n_=1 then do;
    declare hash b(dataset:'brackets');
    b.defineKey('empnum');
    b.defineData('tax_bracket');
    b.defineDone();
  end;

  set salaries;

  rc=b.find();
  if rc ne 0 or tax_bracket=. then tax_bracket=default_bracket;

  net_pay=salary*(1-tax_bracket);
run;

proc print data=netpay;
  title "Example 4.1 Related Technique 1 NETPAY Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 4.1 Related Technique 2                                          */
/****************************************************************************/
proc sort data=salaries;
  by empnum;
run;
proc sort data=brackets;
  by empnum;
run;
data netpay;
  merge salaries(in=insal) brackets;
    by empnum;
  if insal;

  format net_pay dollar10.;

  if tax_bracket=. then tax_bracket=.1;
  net_pay=salary*(1-tax_bracket);
run;
proc print data=netpay;
  title "Example 4.1 Related Technique 2 NETPAY Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 4.2                                                              */
/****************************************************************************/
data bteam;
  infile datalines;
  input lname : $10. gender $ height weight type;
datalines;
Adams M 67 160 2
Alexander M 69 115 1
Apple M 69 139 1
Arthur M 66 125 2
Avery M 66 152 2
Barefoot M 68 158 2
Baucom M 70 170 3
Blair M 69 133 1
Blalock M 68 148 2
Bostic M 74 170 3
;;;
proc print data=bteam;
  title "BTEAM";
run;
data ideal;
  infile datalines;
  input height small medium large;
datalines;
66 126 138 149
67 130 141 154
68 134 145 158
69 138 149 162
70 142 153 167
71 146 157 172
72 150 161 177
73 154 165 181
74 158 169 185
75 162 173 189
;;;
proc print data=ideal;
  title "IDEAL";
run;

data inshape outofshape;
  keep lname height weight type;

  array wt(66:75,3) _temporary_;

  if _n_=1 then do;
    do i=1 to all;
      set ideal nobs=all;
      wt(height,1)=small;
      wt(height,2)=medium;
      wt(height,3)=large;
    end;
  end;

  set bteam;

  if gender='M' and (1 le type le 3) and (66 le height le 75) then do;
    if wt(height,type)-5 le weight le wt(height,type)+5 then output inshape;
    else output outofshape;
  end;
  else putlog 'WARNING: Observation out of lookup range: ' _all_;
run;

proc print data=inshape;
  title "Example 4.2 INSHAPE Data Set Created with DATA Step";
run;
proc print data=outofshape;
  title "Example 4.2 OUTOFSHAPE Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 4.2 Related Technique                                            */
/****************************************************************************/
data inshape outofshape;
  attrib lname length=$10
         gender length=$1
         height length=8
         weight length=8;
  keep lname gender height weight;

  if _n_=1 then do;
    declare hash wt(dataset:'ideal');
    wt.defineKey('height');
    wt.defineData('small','medium','large');
    wt.defineDone();
    call missing(small,medium,large);
  end;

  set bteam;

  if 66 le height le 75 and gender='M' and type in (1,2,3) then do;
    rc=wt.find();
    if rc=0 then do;
      if type=1 then ideal=small;
      else if type=2 then ideal=medium;
      else if type=3 then ideal=large;

      if ideal-5 le weight le ideal+5 then output inshape;
      else output outofshape;
    end;
    else putlog 'WARNING: Height not found in hash object: ' _all_;
  end;
  else putlog 'WARNING: Observation out of range: ' _all_;
run;

proc print data=inshape;
  title "Example 4.2 Related Technique INSHAPE Data Set Created with DATA Step";
run;
proc print data=outofshape;
  title "Example 4.2 Related Technique OUTOFSHAPE Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 4.3                                                              */
/****************************************************************************/
data providers;
  array spname{13} $ 35 _temporary_
    ('Family Medicine' 'Internal Medicine' 'Pediatrics'
     'Obstetrics and Gynecology' 'Endocrinology' 'Opthamology'
     'Psychiatry' 'Dermatology' 'Allegies and Immunology'
     'Surgery' 'Gastroenterology' 'Cardiology' 'Podiatry');
  array wt{13} _temporary_ (153,35,18,24,8,5,5,1,3,15,2,4,6);
  /* Note some names replaced from random generated list created with GENNAMES */
  array lastnames{279} $ 15 _temporary_  (
'Williams' 'Anderson' 'Scott' 'Martin' 'Bean' 'Howard' 'Thompson' 'Roberts' 'Martinez' 'Miller' 'Lee' 'Jones' 'Kelly'
'Perez' 'Morgan' 'Smith' 'Hill' 'Miller' 'Taylor' 'Ward' 'Smith' 'Hall' 'Howard' 'Jones' 'Butler' 'Reed' 'Peterson' 'Price'
'Rodriguez' 'Bell' 'Harris' 'Allen' 'Adams' 'Morgan' 'Perez' 'Bell' 'Smith' 'Foster' 'Smith' 'Gray' 'Johnson' 'Kelly' 'Davis'
'Morgan' 'Scott' 'Phillips' 'White' 'Moore' 'Gonzalez' 'Sanchez' 'Williams' 'Wilson' 'Scott' 'Alexander' 'Gonzalez'
'Williams' 'Clark' 'Williams' 'Moore' 'Ross' 'Hernandez' 'White' 'James' 'Smith' 'Adams' 'Williams' 'Williams' 'Baker'
'Lewis' 'Bell' 'Edwards' 'Johnson' 'Phillips' 'Stewart' 'Gonzales' 'Davis' 'Green' 'Jones' 'Perry' 'Brooks' 'Brown' 'Cox'
'Hughes' 'White' 'Carter' 'Hernandez' 'Martinez' 'Bryant' 'Wilson' 'Chang' 'Thompson' 'Hall' 'Martin' 'Baker' 'Simmons'
'Prasad' 'White' 'Long' 'Cox' 'Baker' 'Harris' 'Peterson' 'Rodriguez' 'Alexander' 'Green' 'Long' 'Lee' 'Russell' 'Thomas'
'Bennett' 'Nelson' 'Martin' 'Williams' 'Brown' 'Butler' 'Garcia' 'Davis' 'Sanders' 'Jones' 'Murphy' 'Chua' 'Jones'
'Nelson' 'Miller' 'Smith' 'Thomas' 'Hernandez' 'Anderson' 'Thomas' 'Henderson' 'Brooks' 'Patterson' 'Adams' 'Parker'
'King' 'Murphy' 'Johnson' 'Lewis' 'Foster' 'Davis' 'Moore' 'Gray' 'Scott' 'Garcia' 'White' 'Williams' 'Peterson'
'Washington' 'Williams' 'Clark' 'Brown' 'Smith' 'Johnson' 'Jones' 'Patterson' 'Diaz' 'Baker' 'Perry' 'Davis' 'Thomas'
'Morgan' 'Baker' 'Stewart' 'Miller' 'Morris' 'Parker' 'Harris' 'Washington' 'Smith' 'Hall' 'Taylor' 'Martinez' 'Thompson'
'Davis' 'Davis' 'Brown' 'Brown' 'Williams' 'Parker' 'Moore' 'Davis' 'Thompson' 'Moore' 'Smith' 'Roberts' 'Jones' 'Bryant'
'Jackson' 'Baker' 'Campbell' 'Brown' 'Hill' 'Smith' 'Cox' 'Miller' 'Robinson' 'Blauvelt' 'Adams' 'Johnson' 'Turner' 'Smith'
'Chou' 'Martinez' 'Reed' 'Jackson' 'White' 'Mitchell' 'Nelson' 'Smith' 'Adams' 'Ward' 'Cook' 'Chang' 'Williams'
'Perez' 'Mitchell' 'Anderson' 'Davis' 'Phillips' 'Thomas' 'Stewart' 'Smith' 'Kelly' 'White' 'Stewart' 'Taylor' 'Wilson'
'Jones' 'Parker' 'Scott' 'Jones' 'Thomas' 'Walker' 'Cox' 'Thomas' 'Lee' 'Ramirez' 'Brown' 'Johnson' 'Coleman' 'Johnson'
'Davis' 'Butler' 'Mitchell' 'Rodriguez' 'Mitchell' 'Hernandez' 'Cooper' 'Cooper' 'Jones' 'Moore' 'Martinez' 'Brown'
'Adams' 'Coleman' 'Torres' 'Brown' 'Brown' 'Turner' 'Chang' 'Jones' 'Wilson' 'Edwards' 'Jackson' 'Johnson' 'Davis'
'Sanders' 'Miller' 'Clark' 'Long' 'Smith' 'Baker' 'Richardson' 'Jones' 'Smith' 'Martin' 'Gray' 'Bryant' 'Hernandez'
);

  length provider_id $ 4 provider_name $ 15 specialty $ 35 provider_type $ 3;

  retain string 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  drop i w string;

  do i=1 to 13;
    provider_id=' ';
    specialty=spname{i};
    provider_type='MD';
    do w=1 to wt{i};
      if i=1 then do;
        if 133 le w le 140 then provider_type='NP';
        else if w ge 141 then provider_type='PA';
      end;
      else if i=4 then do;
        if 11 le w le 15 then provider_type='NP';
        else if w ge 16 then provider_type='NM';
      end;
      else if i=13 then provider_type='DPM';

      provider_name=catx(' ',cats(lastnames{i+(i-1)*13+w},','),
                    cats(substr(string,ceil(ranuni(20)*26),1),substr(string,ceil(ranuni(21)*26),1)) );

      output;
    end;
  end;
run;
data providers;
  set providers;
  retain string 'ABCDXYZ012345678901234567890123456789';
  drop n string;
  do n=1 to 4;
    provider_id=cats(provider_id,substr(string,ceil(ranuni(8331)*37),1));
  end;
run;
proc sort data=providers;
  by provider_id;
run;
proc print data=providers(obs=12);
  title "PROVIDERS";
run;
data patient_list;
  length patient_id $ 8 patient_name $ 20 dob 8 gender $ 1
         appt_date appt_time 8 provider_id $ 4;
  retain string 'ABCDXYZ012345678901234567890123456789'
         appt_date '04mar2010'd;
  drop string n;
  format appt_time time5. appt_date dob mmddyy10.;

  input patient_name $ 1-20 @22 dob mmddyy10. gender $ provider_id $;

  if _n_ le 5 then appt_time=hms(8,30,0);
  else appt_time=hms(8,40,0);

  do n=1 to 8;
    patient_id=cats(patient_id,substr(string,ceil(ranuni(55)*37),1));
  end;
  output;
datalines;
Evans, Diane        04/15/1973 F 624Z
Brown, Michael      12/12/1951 M X747
Miller, Lisa        07/08/1981 F 0BBB
Allen, Nancy        08/14/1952 F 0595
Campbell, Jeremy    03/12/1989 M X5A1
Lopez, Nicholas     06/28/1969 M C116
Walker, Patricia    02/01/1964 F 3214
Williams, Amanda    09/21/1986 F 1C28
Ramirez, Gail       03/17/1947 F 4Z25
Walker, Amanda      11/08/2005 F 49Z6
Mitchell, Lori      01/06/1962 F Z902
;;;;
proc sort data=patient_list;
  by appt_time patient_name;
run;
proc print data=patient_list;
  title "PATIENT_LIST";
run;

data provfmts;
  set providers(rename=(provider_id=start specialty=label)) end=lastobs;
  retain fmtname '$speclty';
  keep fmtname start label hlo;
  output;
  if lastobs then do;
    hlo='O';
    label='**Provider ID Not Found';
    output;
  end;
run;
proc format cntlin=provfmts;
run;

data patients_spec;
  set patient_list;
  appt_type=put(provider_id,$speclty.);
run;
proc print data=patients_spec;
  title "Example 4.3 PATIENTS_SPEC Created with DATA Step";
run;


/****************************************************************************/
/* Example 4.3 Related Technique                                                             */
/****************************************************************************/
data patients_spec;
  attrib patient_id length=$8
         patient_name length=$20
         dob format=mmddyy10.
         gender length=$1
         appt_date format=mmddyy10.
         appt_time format=time5.
         provider_id length=$4
         appt_type length=$35
         specialty length=$35;

  if _n_=1 then do;
    declare hash p(dataset:'providers');
    p.defineKey('provider_id');
    p.defineData('specialty');
    p.defineDone();
    call missing(specialty);
  end;

  drop rc specialty;

  set patient_list;

  rc=p.find();
  if rc=0 then appt_type=specialty;
  else appt_type='**Provider ID Not Found';
run;

proc print data=patients_spec;
  title "Example 4.3 Related Technique PATIENTS_SPEC Created with DATA Step";
run;



/****************************************************************************/
/* Example 4.4                                                              */
/****************************************************************************/
data supplements;
  input suppid $ 1-4 suppname $ 6-20 fullsuppname $ 22-46;
datalines;
V001 Vitamin A       Beta Carotene
V002 Vitamin B-1     Thiamine
V003 Vitamin B-2     Riboflavin
V004 Vitamin B-3     Niacinamide
V005 Vitamin B-6     Pyridoxine Hydrochloride
V006 Vitamin B-9     Folic Acid
V007 Vitamin B-12    Cyanocobalamin
V008 Vitamin C       Ascorbic Acid
V009 Vitamin D       Cholecalciferol
V010 Vitamin E       DL-Alpha-Tocopherol
S001 Gingko          Gingko Biloba
S002 Glucosamine     Glucosamine Sulfate
S003 Lycopene        Lycopene
M001 Calcium         Calcium Carbonate
M002 Calcium         Calcium Citrate
M003 Iron            Ferrous Fumarate
M004 Magnesium       Magnesium Citrate
M005 Selenium        L-Selenomethionine
M006 Zinc            Zinc Gluconate
;;;
proc print data=supplements;
  title "SUPPLEMENTS";
run;
data studysubjects;
  input id 1-3 inits $ 5-7 nurseid 9-11 dieticianid 13-15
        @17 (supp1-supp3) ($4. +1);
datalines;
101 GHY 461 582 V003 V005 V006 S002 V002
102 REA 391 592 M002 M004 V003
103 PLK 391 387
104 MIJ 461 592 M003
105 NHC 240 439 V004 M005
;;;
proc print data=studysubjects;
  title "STUDYSUBJECTS";
run;
data studystaff;
  input staffid 1-3 unit $ 5-11 staffname $ 14-24 degree $ 26-28;
datalines;
371 Nursing  EN Cameron  RN
461 Nursing  YU Garcia   CNP
104 Dietary  RD Hong     RD
240 Nursing  TR Howe     RN
439 Dietary  KA Izzo     RD
592 Dietary  HS James    RD
387 Dietary  HN Lee      RD
391 Nursing  MR Smith    CNP
;;;;
proc print data=studystaff;
  title "STUDYSTAFF";
run;
data study_supp(keep=id inits nurse dietician supplement1-supplement3);
  length suppid $ 4 suppname $ 15 staffid 4
         staffname $ 25 degree $ 3;
  if _n_=1 then do;
    declare hash s(dataset:"work.supplements");
    s.defineKey('suppid');
    s.definedata('suppname');
    s.definedone();

    declare hash f(dataset:"work.studystaff");
    f.defineKey('staffid');
    f.definedata('staffname','degree');
    f.definedone();

    call missing(suppid,suppname,staffid,staffname,degree);
    s.add(key:' ', data:'(none)');
  end;

  set studysubjects;

  array suppcodes{3} $ supp1-supp3;
  array suppnames{3} $ 15 supplement1-supplement3;

  array ids{2} nurseid dieticianid;
  array names{2} $ 25 nurse dietician;

  do i=1 to dim(suppcodes);
    rc = s.find(key:suppcodes{i});
    if rc = 0 then suppnames{i} = suppname;
    else suppnames{i} = '(error)';
  end;

  do i=1 to dim(ids);

    if rc=0 then names{i}=catx(' ',cats(staffname,','),degree);
    else names{i}='(unknown)';
  end;
run;
proc print data=study_supp;
  title "Example 4.4 STUDY_SUPP Created with DATA Step";
run;

/****************************************************************************/
/* Example 4.4 Related Technique                                            */
/****************************************************************************/
data suppfmt;
  set supplements(rename=(suppid=start suppname=label)) end=eof;

  keep fmtname start label hlo;
  retain fmtname '$supp';
  output;
  if eof then do;
    start=' ';
    label='(none)';
    output;
    hlo='O';
    label='(error)';
    output;
  end;
run;
proc format cntlin=suppfmt;
run;
data stafffmt;
  set studystaff(rename=(staffid=start)) end=eof;

  retain fmtname 'staff';
  keep fmtname start label hlo;
  length label $ 25;

  label=catx(' ',cats(staffname,','),degree);
  output;
  if eof then do;
    hlo='O';
    label='(unknown)';
    output;
  end;
run;
proc format cntlin=stafffmt;
run;
proc sql;
  create table study_supp as
    select put(nurseid,staff.) as nurse length=25,
           put(dieticianid,staff.) as dietician length=25,
           id,inits,
           put(supp1,$supp.) as supplement1 length=25,
           put(supp2,$supp.) as supplement2 length=25,
           put(supp3,$supp.) as supplement3 length=25
      from studysubjects;
quit;
proc print data=study_supp;
  title "Example 4.4 Related Technique STUDY_SUPP Table Created with PROC FORMAT and PROC SQL";
run;




/****************************************************************************/
/* Example 4.5                                                              */
/****************************************************************************/
data invoices;
  input id $ 1-12 @14 salesdate mmddyy10. amount;
  format salesdate mmddyy10. amount dollar7.2;
datalines;
JL80SHJ0981I 05/01/2009 543.22
LZJ4NWZOPH1W 05/01/2009 910.09
6VIKYDYXMC8I 05/02/2009 961.73
9VOEB36I3F2D 05/02/2009 402.63
70QAL1JLV1FF 05/03/2009 733.54
;;;;
proc print data=invoices;
  title "INVOICES";
run;

data policies;
  length id $ 12 lname $ 15 policy_type $ 1;
  retain chars 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  drop chars i;

  input lname $ lastpayment mmddyy10. policy_type $;

  format lastpayment mmddyy10.;

  do i=1 to 12;
    id=cats(id,substr(chars,ceil(ranuni(654321)*36),1));
  end;
datalines;
Aamodt 01/10/2009 A
Ababa 01/15/2009 A
Abad 10/04/2008 A
Abate 03/22/2009 B
Abbas 06/12/2008 B
Abbey 07/31/2008 C
Abbott 02/27/2009 A
Abbott 12/06/2008 B
Abel 11/01/2008 A
Abell 07/12/2008 A
Abraham 02/15/2009 B
Abraham 09/12/2008 C
;;;;
proc print data=policies;
  title "POLICIES";
run;
proc datasets library=work;
  modify policies;
  index create id;
quit;

data rebates(drop=status)
     notfound;
  set invoices;

  set policies key=id;

  format amount rebate dollar7.2;
  retain status 'NOT FOUND';
  select (_iorc_);
    when (%sysrc(_sok)) do;
      if policy_type='A' then rebate=.1*amount;
      else if policy_type='B' then rebate=.08*amount;
      else if policy_type='C' then rebate=.05*amount;
      output rebates;
    end;
    when (%sysrc(_dsenom)) do;
      lname=' ';
      lastpayment=.;
      policy_type=' ';
      rebate=.;
      output notfound;
      _error_=0;
    end;
    otherwise do;
      putlog 'ERROR: _IORC_=' _iorc_ '**** Program stopped.';
      stop;
    end;
  end;
run;
proc print data=rebates;
  title "Example 4.5 REBATES Data Set Created with DATA Step";
run;
proc print data=notfound;
  title "Example 4.5 NOTFOUND Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 4.5 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table rebates as
    select salesdate, amount, lname, policy_type,
      case when policy_type='A' then .1*amount
           when policy_type='B' then .08*amount
           when policy_type='C' then .05*amount
           else .
      end as rebate format=dollar7.2
      from invoices inner join policies on invoices.id=policies.id;
  create table notfound as
    select *,
           'NOT FOUND' as status
      from invoices where id not in (select id from policies);
quit;
proc print data=rebates;
  title "Example 4.5 Related Technique REBATES Table Created with PROC SQL";
run;
proc print data=notfound;
  title "Example 4.5 Related Technique NOTFOUND Table Created with PROC SQL";
run;




/****************************************************************************/
/* Example 4.6                                                              */
/****************************************************************************/
data fleet_registration;
  input vehicle_id $ 1-9 action $ 11-14 registration $ 16-20 new_reg $ 22-26 @28 effective mmddyy10.;
  format effective mmddyy10.;
datalines;
SEDAN0238 XFER WI008 IL302 05/01/2001
TRUCK0081 XFER IN082 IL235 01/15/2002
TRUCK0081 XFER IL235 WI371 03/29/2003
SEDAN0238 XFER IL302 IL419 07/21/2004
SEDAN0238 TERM IL419       11/03/2008
MINIV0761 NEW  IL658       09/19/2008
TRUCK0081 XFER WI371 IN454 08/22/2008
;;;
proc print data=fleet_registration;
  title "FLEET_REGISTRATION";
run;
data fleet_history(rename=(registration=current));
  keep vehicle_id registration history nxfers firstxfer lastxfer;
  length vehicle_id $ 9 registration $ 5 nxfers 3 history $ 100 already_used 4;
  format firstxfer lastxfer mmddyy10.;
  if _n_=1 then do;
    already_used=0;
    declare hash f();
    f.definekey('vehicle_id','registration');
    f.definedata('vehicle_id','registration','new_reg','action','effective','already_used');
    f.definedone();
    do until(done);
      set fleet_registration end=done;
      rc=f.add();
    end;
  end;
  do until(done);
    set fleet_registration end=done;

    notfound=f.find();
    if notfound=0 and already_used=1 then continue;

    nxfers=0;

    if new_reg ne ' ' then do;
      firstxfer=effective;
      lastxfer=effective;
      history=catx('; ',registration,cats(new_reg,'(',put(effective,mmddyy10.),')'));
      nxfers+1;
      registration=new_reg;
      do until(rc ne 0);
        rc=f.find();

        if rc=0 then do;
          if new_reg ne ' ' then do;
            history=catx('; ',history,cats(new_reg,'(',put(effective,mmddyy10.),')'));
            lastxfer=effective;
            nxfers+1;
          end;
          already_used=1;
          f.replace();
          registration=new_reg;
        end;
        else do;
          if action='TERM' then history=catx('; ',history,catx(' ',"REMOVED",put(effective,mmddyy10.)));
          output;
        end;
      end;
    end;
    else if action="NEW" then do;
      firstxfer=.;
      lastxfer=.;
      history=cats(registration,catx(' ',"(NEW",put(effective,mmddyy10.)),')');
      output;
    end;
    else do;
      putlog "ERROR: Unexpected error. Program stopped at " _all_;
      stop;
    end;
  end;
run;
proc print data=fleet_history;
  title "Example 4.6 FLEET_HISTORY Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 4.6 Related Technique                                            */
/****************************************************************************/
proc sort data=fleet_registration;
  by vehicle_id effective;
run;
data fleet_history;
  set fleet_registration;
  by vehicle_id;

  keep vehicle_id current history nxfers firstxfer lastxfer;

  length vehicle_id $ 9 current $ 5 nxfers 3 history $ 100;
  format firstxfer lastxfer mmddyy10.;

  retain history nxfers firstxfer lastxfer;

  if first.vehicle_id then do;
    history=registration;
    nxfers=0;
    firstxfer=.;
    lastxfer=.;
  end;
  if new_reg ne ' ' then do;
    if action='XFER' then do;
      history=catx('; ',history,cats(new_reg,'(',put(effective,mmddyy10.),')'));
      if firstxfer=. then firstxfer=effective;
      lastxfer=effective;
      current=new_reg;
      nxfers+1;
    end;
    else link errmsg;
  end;
  else do;
    if action='NEW' then history=cats(registration,catx(' ',"(NEW",put(effective,mmddyy10.)),')');
    else if action='TERM' then do;
      current=' ';
      history=catx('; ',history,catx(' ',"REMOVED",put(effective,mmddyy10.)));
    end;
    else link errmsg;
  end;
  if last.vehicle_id then output;
  return;

  errmsg:
    putlog "ERROR: Unexpected error. Program stopped at " _all_;
    stop;

run;
proc print data=fleet_history;
  title "Example 4.6 Related Technique FLEET_HISTORY Data Set Created with DATA Step";
run;
/*************** END CHAPTER 4***********************************************/



/*************** START CHAPTER 5*********************************************/
/****************************************************************************/
/* Example 5.1                                                              */
/****************************************************************************/
data students0;
  do student_id=101 to 300;
    score=rannor(89);
    output;
  end;
run;
proc standard data=students0 out=students mean=77 std=6;
  var score;
run;
data students;
  set students;
  score=ceil(score);
  if score lt 65 then score=score+36;
run;
proc print data=students(obs=10);
  title "STUDENTS (first 10 observations)";
  var student_id score;
run;
proc means data=students noprint;
  var score;
  output out=overall p10=p10 p25=p25;
run;
proc print data=overall;
  title "OVERALL Data Set";
run;
data pcstudents(drop=p10 p25);
  if _n_=1 then set overall(keep=p10 p25);

  set students;

  top10pc='N';
  top25pc='N';
  if score ge p10 then top10pc='Y';
  if score ge p25 then top25pc='Y';
run;
proc print data=pcstudents(obs=10);
  title "Example 5.1 PCSTUDENTS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 5.1 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table pcstudents as
    select student_id, score,
           case when score ge p10 then 'Y'
                else 'N'
           end as top10pc length=1,
           case when score ge p25 then 'Y'
                else 'N'
           end as top25pc length=1
      from overall,students;
quit;
proc print data=pcstudents(obs=10);
  title "Example 5.1 Related Technique PCSTUDENTS Table Created with PROC SQL";
run;



/****************************************************************************/
/* Example 5.2                                                              */
/****************************************************************************/
data managers;
  input mgrdate mmddyy10. manager : & $15.;
  format mgrdate mmddyy10.;
datalines;
07/12/2005 Butler, RE
01/15/2006 Wright, MV
11/15/2006 Freeman, OG
06/10/2007 Jenkins, UI
12/03/2007 Phillips, OB
01/15/2008 Myers, SC
05/15/2008 Brown, HU
;;;
proc print data=managers;
  title "MANAGERS";
run;

data emplist;
  input empid empname : & $25.;
datalines;
827 Torres, Anthony T
887 Perry, Deborah C
660 Gray, Lisa U
111 White, Elizabeth Q
104 Mitchell, Edward Y
777 Evans, William I
127 Jones, Donald W
215 Anderson, Barbara V
345 Green, Daniel B
688 Butler, Sandra X
677 Lee, Mark I
323 Griffin, Linda K
;;;
proc print data=emplist;
  title "EMPLIST";
run;

data empmgr;
  if _n_=1 then set managers point=last nobs=last;
  set emplist;
run;
proc print data=empmgr;
  title "Example 5.2 EMPMGR Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 5.2 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table empmgr as
    select * from managers,emplist
      where mgrdate=(select max(mgrdate) from managers);
quit;
proc print data=empmgr;
  title "Example 5.2 Related Technique EMPMGR Table Created with PROC SQL";
run;




/****************************************************************************/
/* Example 5.3                                                              */
/****************************************************************************/
data sessions;
  attrib session length=$8 label='Session Attended';
  array groups{4} group_a group_b group_c group_d;
  array months{3} $ _temporary_ ('March' 'June' 'August');

  drop i j;

  do j=1 to 3;
    session=months{j};
    do i=1 to 4;
      groups{i}=ceil(uniform(747)*43);
    end;
    output;
  end;
run;
proc print data=sessions;
  title "SESSIONS Data Set";
run;
data attendance_figures;
  attrib session length=$8 label='Session Attended';

  array groups{*} group_a group_b group_c group_d;
  array totals{*} total_a total_b total_c total_d;
  array pcts{*} pct_a pct_b pct_c pct_d;

  drop i;

  if _n_=1 then do until(eof);
    set sessions end=eof;
    do i=1 to dim(totals);
      totals{i}+groups{i};
      overall+groups{i};
    end;
  end;
  set sessions;

  tot_session=0;
  do i=1 to dim(pcts);
    pcts{i}=round(100*groups{i}/totals{i},1);
    tot_session+groups{i};
  end;
  pct_session=round(100*tot_session/overall,1);

run;
proc print data=attendance_figures;
  title "Example 5.3 ATTENDANCE_FIGURES Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 5.3 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table attendance_figures as
    select *,
      round(group_a/sum(group_a)*100,1) as pct_a,
      round(group_b/sum(group_b)*100,1) as pct_b,
      round(group_c/sum(group_c)*100,1) as pct_c,
      round(group_d/sum(group_d)*100,1) as pct_d,
      group_a+group_b+group_c+group_d as tot_session,
      sum(group_a)+sum(group_b)+sum(group_c)+sum(group_d) as overall,
      round( calculated tot_session/calculated overall*100,1) as pct_session
  from sessions;
quit;
proc print data=attendance_figures;
  title "Example 5.3 Related Technique ATTENDANCE_FIGURES Tablet Created with PROC SQL";
run;

/****************************************************************************/
/* Example 5.3 A Closer Look                                                */
/****************************************************************************/
proc means data=sessions;
  var group_a group_b group_c group_d;
  output out=groupsums sum=total_a total_b total_c total_d;
run;
data attendance_figures;
  attrib session length=$8 label='Session Attended';

  if _n_=1 then do;
    set groupsums(keep=total_a total_b total_c total_d);
    overall+total_a+total_b+total_c+total_d;
  end;

  array groups{*} group_a group_b group_c group_d;
  array totals{*} total_a total_b total_c total_d;
  array pcts{*} pct_a pct_b pct_c pct_d;

  drop i;

  set sessions;
  tot_session=0;
  do i=1 to dim(pcts);
    pcts{i}=round(100*groups{i}/totals{i},1);
    tot_session+groups{i};
  end;
  pct_session=round(100*tot_session/overall,1);
run;
proc print data=attendance_figures;
  title "Example 5.3 A Closer Look ATTENDANCE_FIGURES Data Set Created with PROC MEANS and DATA Step";
run;



/****************************************************************************/
/* Example 5.4                                                              */
/****************************************************************************/
data soybeans;
  input region $ 1-3 farmid yield acres;
  format farmid z3.;
datalines;
NW  456 33 95
NW  269 38 346
NW  295 31 59
NW  689 22 373
NW  080 30 289
NW  319 28 83
NW  703 29 114
SW  700 36 122
SW  178 28 214
SW  358 31 817
SW  045 32 9
SW  741 24 66
SW  262 29 39
SE  983 44 370
SE  628 40 165
SE  042 43 576
SE  996 46 142
SE  257 40 168
SE  749 41 63
SE  869 43 965
SE  042 36 159
MID 894 42 151
MID 806 41 49
MID 848 44 114
MID 479 35 11
MID 959 33 831
MID 493 37 25
MID 939 43 691
MID 752 35 229
MID 077 48 316
;;;;
proc print data=soybeans;
  title "SOYBEANS";
run;
proc sql;
  create table avgplus as
    select *,
      avg(yield) format=5.1 as region_avg
      from soybeans
      group by region
      having yield > calculated region_avg
      order by region, yield descending;
quit;
proc print data=avgplus;
  title "Example 5.4 AVGPLUS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 5.4 Related Technique                                           */
/****************************************************************************/
proc means data=soybeans noprint;
  class region;
  types region;
  var yield;
  output out=yieldavg(drop=_type_ _freq_) mean=region_avg;
run;
proc sort data=soybeans;
  by region descending yield;
run;
data avgplus;
  merge soybeans yieldavg;
  by region;

  format region_avg 5.1;
  if yield gt region_avg;
run;
proc print data=avgplus;
  title "Example 5.4 Related Technique AVGPLUS Data Set Created with PROC MEANS and DATA Step";
run;



/****************************************************************************/
/* Example 5.5                                                              */
/****************************************************************************/
data techcertif;
  input techid @6 event_date mmddyy10. event_type $ 17-26 event_credits;
  format event_date mmddyy10.;
datalines;
1935 05/03/2008 Conference  75
1935 08/22/2008 Seminar      5
1935 09/12/2008 Practice   100
1935 10/15/2008 Class       50
1935 12/02/2008 Practice   125
1935 03/12/2009 Seminar      5
1935 06/12/2009 Conference 105
1756 08/22/2008 Seminar      5
1756 09/12/2008 Practice   100
1756 09/22/2008 Service     20
1756 01/15/2009 Class      100
1756 03/02/2009 Practice    75
1756 05/23/2009 Practice   125
9185 01/15/2009 Class      100
9186 04/22/2009 Seminar     10
9186 05/23/2009 Practice   125
9186 07/29/2009 Conference 150
2234 05/23/2009 Practice   125
;;;
proc sort data=techcertif;
  by techid event_date;
run;
proc print data=techcertif;
  title "TECHCERTIF";
run;
data cumcredits(drop=total_practice_credits)
     grandcredits(rename=(event_date=last_event cum_credits=total_credits)
                  drop=event_type event_credits);
  set techcertif;
  by techid;

  if first.techid then do;
    cum_credits=0;
    total_practice_credits=0;
  end;

  cum_credits+event_credits;
  if event_type="Practice" then total_practice_credits+event_credits;

  output cumcredits;
  if last.techid then output grandcredits;
run;
proc print data=cumcredits;
  title "Example 5.5 CUMCREDITS Data Set Created with DATA Step";
run;
proc print data=grandcredits;
  title "Example 5.5 GRANDCREDITS Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 5.5 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table grandcredits as
    select techid,
           max(event_date) as last_event format=mmddyy10.,
           sum(event_credits) as total_credits,
           sum(case when event_type='Practice' then event_credits
                    else 0
               end) as total_practice_credits
         from techcertif
         group by techid;
quit;
proc print data=grandcredits;
  title "Example 5.5 Related Technique GRANDCREDITS Table Created with PROC SQL";
run;



/****************************************************************************/
/* Example 5.6                                                              */
/****************************************************************************/
data districtlevy;
  input town $ 1-11 precinct pop registered yes no;
  drop pop registered;
datalines;
Blue Hills  1 3524 2079 335 264
Blue Hills  2 6446 3287 631 497
Blue Hills  3 4758 2522 529 375
Collegetown 1 12272 6872 909 1300
Collegetown 2 6944 3819 677 573
Collegetown 3 14300 7865 1314 1117
Collegetown 4 14593 8902 1135 1054
Collegetown 5 13074 7844 1153 1135
Fairview    1 10169 6305 721 906
Fairview    2 5195 3013 428 611
Fairview    3 10000 5500 788 962
Fairview    4 6717 3762 335 471
West Ridge  1 8891 5157 818 738
West Ridge  2 9524 5905 768 851
West Ridge  3 6853 4454 692 610
West Ridge  4 11048 6187 892 931
West Ridge  5 10303 5564 838 965
West Ridge  6 22119 12608 1533 1453
;;;;
proc print data=districtlevy;
  title "DISTRICTLEVY";
run;
proc sql;
  create table levyresults as
    select *, count(precinct) as nprecincts,
           sum(yes+no) as total_voters_town,
           100*(yes+no)/calculated total_voters_town as pct_precinct_town format=5.1,
           100*yes/(yes+no) as pct_precinct_yes format=5.1,
           case
             when max(calculated pct_precinct_yes)=calculated pct_precinct_yes then 'Yes'
             else 'No'
           end as most_yes_pct
      from districtlevy
      group by town
      order by town, precinct;
quit;
proc print data=levyresults;
  title "Example 5.6 LEVYRESULTS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 5.6 Related Technique                                            */
/****************************************************************************/
proc sort data=districtlevy;
  by town precinct;
run;
proc means data=districtlevy noprint;
  class town;
  types town;
  var yes no;
  output out=sumlevy(drop=_type_ _freq_)
               sum=town_yes town_no n=nprecincts;
run;
data levystep1;
  merge districtlevy sumlevy;
  by town;

  drop town_yes town_no;

  total_voters_town=sum(town_yes,town_no);
  pct_precinct_town=100*(yes+no)/total_voters_town;
  pct_precinct_yes=100*yes/(yes+no);
run;
proc means data=levystep1 noprint;
  class town;
  types town;
  var pct_precinct_yes;
  output out=maxlevy(drop=_type_ _freq_) max=max_pct_yes;
run;
data levyresults;
  merge levystep1 maxlevy;
  by town;

  length most_yes_pct $ 3;
  format pct_precinct_town pct_precinct_yes 5.1;

  drop max_pct_yes;

  if pct_precinct_yes=max_pct_yes then most_yes_pct='Yes';
  else most_yes_pct='No';
run;
proc print data=levyresults;
  title "Example 5.6 Related Technique LEVYRESULTS Data Set Created with PROC MEANS and DATA Steps";
run;
/*************** END CHAPTER 5***********************************************/


/*************** START CHAPTER 6*********************************************/
/****************************************************************************/
/* Example 6.1                                                               */
/****************************************************************************/
data booklist;
  input bookid $ 1-6 booktitle $ 8-25 chapter author $ 30-49 duedate : mmddyy10.
        editor $ 62-80;
  format duedate mmddyy10.;
datalines;
NF0586 Current Narratives 1  Smith, Rebecca      09/04/2010  Williams, Stephanie
NF0586 Current Narratives 2  Williams, Susan     09/04/2010  Williams, Stephanie
NF0586 Current Narratives 3  Torres, Christopher 09/11/2010  Williams, Stephanie
NF0586 Current Narratives 4  Torres, Christopher 09/11/2010  Williams, Stephanie
NF0586 Current Narratives 5  Powell, George      09/11/2010  Williams, Stephanie
NF0586 Current Narratives 6  Thompson, Tonya     09/11/2010  Williams, Stephanie
NF0586 Current Narratives 7  Allen, Linda        09/11/2010  Williams, Stephanie
NF0586 Current Narratives 8  Johnson, Tammy      09/11/2010  Williams, Stephanie
NF0586 Current Narratives 9  Kelly, Melissa      09/11/2010  Williams, Stephanie
NF0586 Current Narratives 10 Thompson, Tonya     09/11/2010  Williams, Stephanie
NF2413 Political Comments 1  Jones, Robin        07/31/2010  White, Michelle
NF2413 Political Comments 2  Sanchez, Brandon    08/07/2010  White, Michelle
NF2413 Political Comments 3  Jones, Robin        07/31/2010  White, Michelle
NF2413 Political Comments 4  Perez, Joshua       07/31/2010  White, Michelle
NF2413 Political Comments 5  Williams, Nicholas  07/31/2010  White, Michelle
NF2413 Political Comments 6  Patterson, Mary     08/14/2010  White, Michelle
NF2413 Political Comments 7  Torres, Christopher 08/07/2010  White, Michelle
NF2413 Political Comments 8  Robinson, Bonnie    08/07/2010  White, Michelle
NF2413 Political Comments 9  Brown, Patricia     08/07/2010  White, Michelle
NF8141 Favorite Essays    1  Clark, Todd         10/02/2010  Patterson, Daniel
NF8141 Favorite Essays    2  Barnes, David       10/02/2010  Patterson, Daniel
NF8141 Favorite Essays    3  Young, Richard      09/18/2010  Patterson, Daniel
NF8141 Favorite Essays    4  Barnes, David       10/02/2010  Patterson, Daniel
NF8141 Favorite Essays    5  Anderson, Daniel    09/18/2010  Patterson, Daniel
NF8141 Favorite Essays    6  Anderson, Daniel    09/18/2010  Patterson, Daniel
NF8141 Favorite Essays    7  Morris, Laura       09/18/2010  Patterson, Daniel
NF8141 Favorite Essays    8  Powell, George      09/18/2010  Patterson, Daniel
;;;
proc print data=booklist;
  title "BOOKLIST";
run;
data bookupdates;
  input bookid $ 1-6 chapter author $ 11-30 duedate : mmddyy10.
        updatedby $ 43-45;
  format duedate mmddyy10.;
datalines;
NF0586 4  Banks, James         .          JWE
NF0586 9  King, Weston         09/18/2010 JWE
NF8141 6                       10/02/2010 SAW
;;;;
proc print data=bookupdates;
  title "BOOKUPDATES";
run;

data revisedlist;
  update booklist bookupdates;

  by bookid chapter;
run;
proc print data=revisedlist;
  title "Example 6.1 REVISEDLIST Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 6.1  Related Technique                                           */
/****************************************************************************/
proc sql;
  create table revisedlist as
    select coalesce(u.bookid,b.bookid) as bookid,
           booktitle,
           coalesce(u.chapter,b.chapter) as chapter,
           coalesce(u.author,b.author) as author,
           coalesce(u.duedate,b.duedate) as duedate format=mmddyy10.,
           editor,
           updatedby
      from booklist b
        full join
      bookupdates u
      on b.bookid=u.bookid and b.chapter=u.chapter;
quit;
proc print data=revisedlist;
  title "Example 6.1 REVISEDLIST Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 6.1  A Closer Look 1                                             */
/****************************************************************************/
data revisedmissing;
  update booklist bookupdates updatemode=nomissingcheck;

  by bookid chapter;
run;
proc print data=revisedmissing;
  title "Example 6.1 A Closer Look 1 REVISEDMISSING Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 6.1  A Closer Look 2                                             */
/****************************************************************************/
data dupdates;
  input bookid $ 1-6 chapter duedate : mmddyy10.;
  format duedate mmddyy10.;
datalines;
NF8141 6  10/02/2010
NF8141 6  10/22/2010
NF8141 6  11/01/2010
;;;;
data upddups;
  update booklist dupdates;
  by bookid chapter;
run;
proc print data=upddups n;
  title "UPDDUPS";
  where bookid='NF8141';
  var bookid chapter duedate;
run;
data mrgdups;
  merge booklist dupdates;
  by bookid chapter;
run;
proc print data=mrgdups n;
  title "MRGDUPS";
  where bookid='NF8141';
  var bookid chapter duedate;
run;


data newtitles;
  input bookid $ 1-6 booktitle $ 8-25  version;
datalines;
NF8141 Popular Essays      2
;;;;
data updtitles;
  update booklist newtitles;
  by bookid ;
run;
proc print data=updtitles;
  title 'UPDTITLES';
  where bookid='NF8141';
  var bookid booktitle chapter version;
run;
data mrgtitles;
  merge booklist newtitles;
  by bookid ;
run;
proc print data=mrgtitles;
  title 'MRGTITLES';
  where bookid='NF8141';
  var bookid booktitle chapter version;
run;

data multtitles;
  input bookid $ 1-6 booktitle $ 8-25 version;
datalines;
NF8141 Popular Essays     2
NF8141 Essays for All     3
;;;;
data updmult;
  update booklist multtitles;
  by bookid ;
run;
proc print data=updmult;
  title 'UPDMULT';
  where bookid='NF8141';
  var bookid booktitle chapter version;
run;
data mrgmult;
  merge booklist multtitles;
  by bookid ;
run;
proc print data=mrgmult n;
  title 'MRGMULT';
  where bookid='NF8141';
  var bookid booktitle chapter version;
run;

/****************************************************************************/
/* Example 6.2 Use data set BOOKLIST created in Example 6.1                 */
/****************************************************************************/
missing _;
data bookmiss;
  input bookid $ 1-6 chapter author $ 11-30 duedate : mmddyy10.;
  format duedate mmddyy10.;
datalines;
NF0586 3                       _
NF0586 4                       _
NF2413 4  Loren, Marie         .
NF2413 7                       _
NF8141 5                       10/03/2010
NF8141 6                       10/03/2010
;;;;
proc print data=bookmiss;
  title "BOOKMISS";
run;

data revisedmiss;
  update booklist bookmiss;

  by bookid chapter;
run;
proc print data=revisedmiss;
  title "Example 6.2 REVISEDMISS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 6.2  Related Technique                                           */
/****************************************************************************/
proc sql;
  create table revisedmiss as
    select coalesce(m.bookid,b.bookid) as bookid,
           booktitle,
           coalesce(m.chapter,b.chapter) as chapter,
           coalesce(m.author,b.author) as author,
           case when m.duedate=._ then .
                else coalesce(m.duedate,b.duedate)
           end as duedate format=mmddyy10.,
           editor
      from booklist b
        full join
      bookmiss m
      on b.bookid=m.bookid and b.chapter=m.chapter;
quit;
proc print data=revisedmiss;
  title "Example 6.2 Related Technique REVISEDMISS Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 6.3 Use data set BOOKLIST created in Example 6.1                 */
/****************************************************************************/
data bookchanges;
  input bookid $ 1-6 duedate: mmddyy10. editor $ 19-37;
  format duedate mmddyy10.;
datalines;
NF2413 09/18/2010 Zhang, Amy
NF8141 10/02/2010 McHale, Andrew
;;;
proc print data=bookchanges;
  title "BOOKCHANGES";
run;
data newbooklist;
  merge booklist(rename=(duedate=holddate editor=holdeditor))
        bookchanges(in=inupd);
    by bookid;

  drop holddate holdeditor;

  if not inupd then do;
    duedate=holddate;
    editor=holdeditor;
  end;
run;
proc print data=newbooklist;
  title "Example 6.3 NEWBOOKLIST Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 6.3  Related Technique                                           */
/****************************************************************************/
proc sql;
  create table newbooklist as
    select coalesce(u.bookid,b.bookid) as bookid,
           booktitle, chapter, author,
           coalesce(u.duedate,b.duedate) as duedate format=mmddyy10.,
           coalesce(u.editor,b.editor) as editor
      from booklist b
        full join
      bookchanges u
      on b.bookid=u.bookid;
quit;
proc print data=newbooklist;
  title "Example 3.11 Related Technique NEWBOOKLIST Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 6.4 Use data set BOOKLIST created in Example 6.1                */
/****************************************************************************/
data submissions;
  input bookid $ 1-6 chapter author $ 11-30 draftdate : mmddyy10.;
  format draftdate mmddyy10.;
datalines;
NF0586 3  Torres, Christopher  05/13/2010
NF0586 3  Torres, Christopher  06/17/2010
NF0586 3  Torres, Christopher  06/30/2010
NF2413 8  Robinson, Bonnie     04/01/2010
NF2413 2  Sanchez, Brandon     04/22/2010
NF2413 2  Sanchez, Brandon     06/02/2010
NF8141 5  Anderson, Daniel     05/26/2010
NF8141 6  Anderson, Daniel     07/01/2010
;;;;
proc sort data=submissions;
  by bookid chapter draftdate;
run;
proc print data=submissions;
  title "SUBMISSIONS";
run;
proc sort data=booklist;
  by bookid chapter;
run;

data alldrafts;
  merge booklist(in=inlist)
        submissions;
  by bookid chapter;

  if inlist;
run;
proc print data=alldrafts;
  title "Example 6.4 ALLDRAFTS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 6.4 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table alldrafts as
    select b.bookid, booktitle, b.chapter,
           b.author, duedate, editor,
           draftdate
      from booklist b
        left join
           submissions s
      on b.bookid=s.bookid and b.chapter=s.chapter;
quit;
proc print data=alldrafts;
  title "Example 6.4 Related Technique ALLDRAFTS Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 6.5 Use data set BOOKLIST created in Example 6.1                 */
/****************************************************************************/
data submissions;
  input bookid $ 1-6 chapter author $ 11-30 draftdate : mmddyy10.;
  format draftdate mmddyy10.;
datalines;
NF0586 3  Torres, Christopher  05/13/2010
NF0586 3  Torres, Christopher  06/17/2010
NF0586 3  Torres, Christopher  06/30/2010
NF2413 8  Robinson, Bonnie     04/01/2010
NF2413 2  Sanchez, Brandon     04/22/2010
NF2413 2  Sanchez, Brandon     06/02/2010
NF8141 5  Anderson, Daniel     05/26/2010
NF8141 6  Anderson, Daniel     07/01/2010
;;;;
proc sort data=submissions;
  by bookid chapter descending draftdate;
run;
proc print data=submissions;
  title "SUBMISSIONS";
run;
proc sort data=booklist;
  by bookid chapter;
run;

data lastdraft;
  inlist=0;
  merge booklist(in=inlist)
        submissions;
  by bookid chapter;

  if inlist;
run;
proc print data=lastdraft;
  title "Example 6.5 LASTDRAFT Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 6.5 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table lastdraft as
    select b.bookid, booktitle, b.chapter,
           b.author, duedate, editor,
           draftdate
      from booklist b
        left join
      (select bookid,chapter,max(draftdate) as draftdate format=mmddyy10.
         from submissions
         group by bookid,chapter) c
      on b.bookid=c.bookid and b.chapter=c.chapter;
quit;
proc print data=alldrafts;
  title "Example 6.5 Related Technique LASTDRAFT Table Created with PROC SQL";
run;
/***********************END CHAPTER 6****************************************/


/*************** START CHAPTER 7*********************************************/
/****************************************************************************/
/* Example 7.1                                                              */
/****************************************************************************/
data dataconference;
  input section $ 1-12 @14 starttime time5. talktime speaker $ 23-41
        topic $ 44-64;
  format starttime timeampm8.2;
datalines;
Applications 08:00 50 Brooks, Jason        Customer Service
Data Mining  08:00 50 Jones, Janet         Direct Marketing
Statistics   08:00 50 Thomas, Linda        New Analytic Features
Tutorials    08:00 50 Evans, Matthew       Graphics
Applications 09:00 50 Washington, Debra    TBD
Data Mining  09:00 50 Edwards, Andrew      Text Mining Overview
Statistics   09:00 50 Cox, David           Mixed Models
Tutorials    09:00 50 Mitchell, Jeremy     Writing Functions
Applications 10:30 50 Robinson, Catherine  Clinical Trials
Data Mining  10:30 50 Wilson, Joshua       Retail Industry
Statistics   10:30 50 Anderson, James      TBD
Tutorials    10:30 50 Nelson, Stephen      Reporting
Applications 13:30 50 Moore, Patrick       Energy Industry
Data Mining  13:30 50 Harris, Michael      Credit Risk
Statistics   13:30 50 Brown, Brandon       Cluster Analysis
Tutorials    13:30 50 White, Elizabeth     External Files
Applications 15:00 50 TBD                  TBD
Data Mining  15:00 50 Johnson, Joshua      Fraud Detection
Statistics   15:00 50 Cox, Mary            Predictive Modeling
Tutorials    15:00 50 Torres, Tara         Efficient Programming
Applications 16:00 50 Sanders, Joyce       Healthcare
Data Mining  16:00 50 White, Kimberly      Decision Making
Statistics   16:00 50 Richardson, Lisa     Bayesian Basics
Tutorials    16:00 50 Morris, Nicole       Customized Output
;;;;
proc print data=dataconference;
  title "DATACONFERENCE";
run;

data dataconference;
  modify dataconference;
  if starttime le '12:00'T then talktime=40;
  else talktime=45;
run;
proc print data=dataconference;
  title "Example 7.1 DATACONFERENCE Data Set Modified with DATA Step";
run;

/****************************************************************************/
/* Example 7.1 Related Technique                                            */
/****************************************************************************/
proc sql;
  update dataconference
    set talktime= case
                    when starttime le '12:00'T then 40
                    else 45
                  end;
quit;
proc print data=dataconference;
  title "Example 7.1 Related Technique DATACONFERENCE Table Modified with PROC SQL";
run;



/****************************************************************************/
/* Example 7.2 Use data set DATACONFERENCE created in Example 7.1           */
/****************************************************************************/
data conferencechanges;
  input section $ 1-12 @14 starttime time5. talktime speaker $ 23-41
        topic $ 44-64;
  format starttime time5.;
datalines;
Applications 09:00 .                       Interfaces
Statistics   10:30 .                       Statistical Graphics
Applications 15:00 .  Brown, Cynthia
Tutorials    17:00 30 Richardson, Lisa     Basic Statistics
Break        10:15 15 (none)               (none)
Break        14:45 15 (none)               (none)
Applications 15:00 .                       Quality Control
Data Mining  16:00 .  REMOVE
;;;
proc print data=conferencechanges;
  title "CONFERENCECHANGES";
run;
data dataconference;
  modify dataconference conferencechanges;
  by section starttime;

  select (_iorc_);
    when (%sysrc(_sok)) do;
      if speaker ne 'REMOVE' then replace;
      else remove;
    end;
    when (%sysrc(_dsenmr)) do;
      _error_=0;
      output;
    end;
    otherwise do;
      putlog 'ERROR: Program stopped at record ' _n_ ' of POLICY_UPDATES';
      stop;
    end;
  end;
run;
proc print data=dataconference;
  title "Example 7.2 DATACONFERENCE Data Set Modified with DATA Step";
run;


/****************************************************************************/
/* Example 7.3 Use data set POLICIES create in Example 4.5                  */
/****************************************************************************/
data policy_updates;
  length action $ 1 id $ 12 newlname $ 15 newpolicy_type $ 1;
  format newlastpayment mmddyy10.;
  input action $ id $ 3-14 newlname $ 16-30 newpolicy_type $ 32 @34 newlastpayment mmddyy10.;
datalines;
M CNT2MDT1LP9K Abbot
D WEFSBW6US11T
M 6VIKYDYXMC8I                   05/02/2009
A BS2EHK465VJ8 Aasen           B 06/15/2009
M 43PG0RNFJ43E                 A
;;;;
proc print data=policy_updates;
  title "POLICY_UPDATES";
run;
data policies
     problems(keep=action id newlname newpolicy_type newlastpayment);
  set policy_updates;

  modify policies key=id;

  select (_iorc_);
    when (%sysrc(_sok)) do;
      if action='D' then remove policies;
      else if action='M' then do;
        if newlname ne ' ' then lname=newlname;
        if newpolicy_type ne ' ' then policy_type=newpolicy_type;
        if newlastpayment ne . then lastpayment=newlastpayment;
        replace policies;
      end;
      else if action='A' then output problems;
    end;
    when (%sysrc(_dsenom)) do;
      _error_=0;
      if action='A' then do;
        lname=newlname;
        policy_type=newpolicy_type;
        lastpayment=newlastpayment;
        output policies;
      end;
      else output problems;
    end;
    otherwise do;
      putlog 'ERROR: Program stopped at record ' _n_ ' of POLICY_UPDATES';
      stop;
    end;
  end;
run;
proc print data=policies;
  title "Example 7.3 Modified POLICIES Data Set Modified with DATA Step";
run;
proc print data=problems;
  title "Example 7.3 PROBLEMS Data Set Created with DATA Step";
  title2 "Observations Rejected from Update Process";
run;





/****************************************************************************/
/* Example 7.4                                                              */
/****************************************************************************/
data teams(index=(team));
  input team $ member $ points;
datalines;
Blue Mason  275
Blue Brady  350
Blue Stone  395
Blue Amos   280
Gray Taylor 300
Gray Ross   325
Gray Jordan 425
;;;
proc print data=teams;
  title "TEAMS";
run;
data teambonuses;
  input team $ @6 bonusdate mmddyy10. factor bonus;
  format bonusdate mmddyy10.;
datalines;
Gray 04/30/2010 1    100
Blue 04/30/2010 1.25 25
Gray 05/15/2010 1    50
Blue 05/31/2010 2    75
Gray 05/31/2010 2    50
;;;;
proc print data=teambonuses;
  title "TEAMBONUSES";
run;
proc sort data=teambonuses;
  by team;
run;
data teams;
  set teambonuses;
  by team;

  dupteam=0;

  bonuspoints=ceil(factor*bonus);

  do until (_iorc_=%sysrc(_dsenom));
    if dupteam then team=' ';
    modify teams key=team;
    select (_iorc_);
      when (%sysrc(_sok)) do;
        points=points + bonuspoints;
        replace;
      end;
      when (%sysrc(_dsenom)) do;
        _error_=0;
        if not last.team and dupteam=0 then do;
          dupteam=1;
          _iorc_=0;
        end;
      end;
      otherwise do;
        putlog "ERROR: Unexpected error for " team= factor= bonuspoints=;
      end;
    end;
  end;
run;
proc print data=teams;
  title "Example 7.4 TEAMS Data Set Modified with DATA Step";
run;
/***********************END CHAPTER 7****************************************/


/**********************START CHAPTER 8***************************************/
/****************************************************************************/
/* Example 8.1                                                              */
/****************************************************************************/
data cellphones;
  length callhour calllength 8 status $ 11 reason $ 25;
  array service{14} $ 25 _temporary_
        ('Start Service' 'Upgrade Service' 'Downgrade Service'
         'Account Status' 'Billing Change' 'Address Change'
         'Discontinue Service' 'Set Up Phone' 'Text Msg Help'
         'Voice Mail Help' 'Ringtones Help' 'Other Feature Help'
         'Password Question','Other');
  array wts{14} _temporary_ (.15, .03, .01,
                            .17,.03,.01,
                            .03,.08,.05,
                            .05,.04,.1,
                            .15,.1);
  array r{14,3} _temporary_ (.9,0,.1, .8,.1,.1, .9,.05,.15,
                            1,0,0, 1,0,0, 1,0,0,
                            .95,0,.05, .8,.15,.05, .8,.2,0,
                            .75,.1,.15, .85,.15,0, .6,.4,0,
                            .9,0,.1, .2,.5,.3);


  keep callhour calllength status reason order;
  format callhour z2.;
  length reason $ 25;
  do i=1 to 14;
    reason=service{i};
    nresult=r{i,1}*wts{i}*10000;
    ntransfer=r{i,2}*10000+nresult;
    npending=r{i,3}*10000+nresult+ntransfer;
    do j=1 to wts{i}*10000;
      callhour=ranpoi(653838,14)-2;
      calllength=abs(ceil(rannor(7857)*5))+1;
      if callhour lt 0 then callhour=0;
      if callhour gt 23 then callhour=callhour-10;
      if 1 le j le nresult then status='Resolved';
      else if ntransfer ne 0 and nresult lt j le ntransfer then status='Transferred';
      else if npending ne 0 and ntransfer lt j le npending then status='Pending';

      order=uniform(18306);
      output;
    end;
  end;
run;
proc sort data=cellphones out=cellphones(drop=order);
  by callhour order;
run;
proc print data=cellphones(obs=25);
  title "CELLPHONES";
run;

data featurequestions;
  set cellphones;
  where reason contains "Help";
run;
proc print data=featurequestions(obs=25);
  title "Example 8.1 FEATUREQUESTIONS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 8.1 Related Technique                                            */
/****************************************************************************/
proc sql;
  create table featurequestions as
    select * from cellphones
      where reason contains "Help";
quit;
proc print data=featurequestions(obs=25);
  title "Example 8.1 Related Technique FEATUREQUESTIONS Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 8.2                                                              */
/****************************************************************************/
data compscistudents;
  input studentid studentname $ 8-21 department $ 23-45 classid credits;
datalines;
137193 Ross, Martyn   Computer Science            201 3
137193 Ross, Martyn   Technical Communication     201 4
137193 Ross, Martyn   Computer Science            220 2
137193 Ross, Martyn   Technical Communication     201 4
091838 Nguyen, Janie  Computer Science            520 2
091838 Nguyen, Janie  Speech                      476 3
091838 Nguyen, Janie  Speech                      476 3
091838 Nguyen, Janie  Speech                      476 3
103722 Lopez, Fred    Computer Science            210 3
103722 Lopez, Fred    Computer Science            210 3
987175 Young, Kaitlyn Design                      301 4
987175 Young, Kaitlyn Electrical Engineering      301 3
;;;;
proc sort data=compscistudents;
  by studentid department classid;
run;
proc print data=compscistudents;
  title "COMPSCISTUDENTS";
run;
data okclasses dupclasses;
  set compscistudents;
  by studentid department classid;

  if first.classid and last.classid then output okclasses;
  else output dupclasses;
run;
proc print data=okclasses;
  title "Example 8.2 OKCLASSES Data Set Created with DATA Step";
run;
proc print data=dupclasses;
  title "Example 8.2 DUPCLASSES Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 8.3                                                              */
/****************************************************************************/
data pmtemps;
  input location $ @10 temptime time5. tempf dewpoint relhum;
  format temptime time5.;
datalines;
Rooftop  13:00 73 50 44
Rooftop  14:00 72 52 49
Rooftop  15:00 72 53 51
Rooftop  16:00 74 51 45
Rooftop  17:00 75 51 43
Rooftop  17:00 75 51 43
Rooftop  17:00 75 51 43
Rooftop  18:00 74 50 43
Rooftop  18:00 74 50 43
Beach    13:00 67 56 68
Beach    14:00 71 58 63
Beach    15:00 74 59 60
Beach    16:00 76 58 54
Beach    16:00 76 58 54
Beach    17:00 79 58 48
Beach    18:00 81 59 47
Downtown 13:00 68 62 81
Downtown 14:00 69 62 78
Downtown 15:00 69 62 78
Downtown 16:00 71 63 76
Downtown 16:00 71 63 76
Downtown 17:00 70 64 81
Downtown 18:00 73 64 73
;;;;
proc print data=pmtemps;
  title "PMTEMPS";
run;
proc sort data=pmtemps noduprecs
          out=uniquetemps dupout=duptemps
          equals;
  by location temptime;
run;
proc print data=uniquetemps;
  title "Example 8.3 UNIQUETEMPS Data Set Created with PROC SORT";
run;
proc print data=duptemps;
  title "Example 8.3 DUPTEMPS Data Set Created with PROC SORT";
run;

/****************************************************************************/
/* Example 8.3 Related Technique                                            */
/****************************************************************************/
proc sort data=pmtemps;
  by location temptime;
run;
data uniquetemps duptemps;
  set pmtemps;

  drop lagloc lagtemptime lagtempf lagdewpoint lagrelhum;

  lagloc=lag(location);
  lagtemptime=lag(temptime);
  lagtempf=lag(tempf);
  lagdewpoint=lag(dewpoint);
  lagrelhum=lag(relhum);

  if lagloc=location and lagtemptime=temptime and
     lagtempf=tempf and lagdewpoint=dewpoint and
     lagrelhum=relhum then output duptemps;
  else output uniquetemps;
run;
proc print data=uniquetemps;
  title "Example 8.3 Related Technique UNIQUETEMPS Data Set Created with DATA Step";
run;
proc print data=duptemps;
  title "Example 8.3 Related Technique DUPTEMPS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 8.4                                                              */
/****************************************************************************/
data trade_assn;
  input company $ 1-25 membershipyear nemployees revenue;
datalines;
Wise Wizards Consulting    2005    10    3918593
Fairlakes Manufacturing    2006    50    763120
Wise Wizards Consulting    2006    5     645120
Fairlakes Manufacturing    2007    25    5301903
Always Ready Fix-it        2008    4     103929
Fairlakes Manufacturing    2008    31    7928185
Wise Wizards Consulting    2008    2     38371
Always Ready Fix-it        2009    5     198482
Fairlakes Manufacturing    2009    28    8391869
Always Ready Fix-it        2010    3     154105
Fairlakes Manufacturing    2010    27    8678291
Surname Associates         2010    22    10682910
;;;;

proc sort data=trade_assn;
  by company membershipyear;
run;
proc print data=trade_assn;
  title "TRADE_ASSN";
run;
data joined_assn renewed_assn;
  set trade_assn;

  by company;

  if first.company then output joined_assn;
  else output renewed_assn;
run;
proc print data=joined_assn;
  title "Example 8.4 JOINED_ASSN Data Set Created with DATA Step";
run;
proc print data=renewed_assn;
  title "Example 8.4 RENEWED_ASSN Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 8.4 Related Technique                                            */
/****************************************************************************/
proc sort data=trade_assn;
  by company membershipyear;
run;
proc sort data=trade_assn nodupkey
          out=joined_assn dupout=renewed_assn;
  by company;
run;
proc print data=joined_assn;
  title "Example 8.4 Related Technique JOINED_ASSN Data Set Created with PROC SORT";
run;
proc print data=renewed_assn;
  title "Example 8.4 Related Technique RENEWED_ASSN Data Set Created with PROC SORT";
run;


/****************************************************************************/
/* Example 8.5                                                              */
/****************************************************************************/
data bloodpressure;
  input @1 bptime time5. systolic diastolic pulse;
  format bptime time5.;
datalines;
08:20 160 90 99
08:22 171 92 103
08:24 158 88 102
08:30 155 90 93
08:43 144 88 90
08:51 145 82 88
08:59 140 80 86
09:02 138 82 84
09:06 130 80 78
09:09 130 76 75
09:13 128 77 78
09:18 126 75 73
09:25 125 75 72
09:31 122 73 74
09:42 124 75 70
09:45 123 73 68
09:50 120 73 67
09:52 115 70 67
09:55 116 73 66
09:59 115 68 65
;;;;
proc print data=bloodpressure;
  title "BLOODPRESSURE";
run;
data firstlast4bp;
  keep measurement bptime systolic diastolic pulse;

  total1=4;
  total2=4;

  if totalobs ge (total1+total2) then do;
    start1=1;
    end1=start1+total1-1;

    start2=totalobs-total2+1;
    end2=totalobs;

    do i=start1 to end1,start2 to end2;
      measurement=i;
      set bloodpressure point=i nobs=totalobs;
      output;
    end;
  end;
  else do;
    do i=1 to totalobs;
      measurement=i;
      set bloodpressure point=i nobs=totablobs;
      output;
    end;
  end;
  stop;
run;
proc print data=firstlast4bp;
  title "Example 8.5 FIRSTLAST4BP Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 8.6                                                              */
/****************************************************************************/
options ls=64;
data emp_roster;
  input id $ 1-5 hours_week hours_4weeks level $;
datalines;
4GJBU  0  130  Staff
7SFWY  5  43   Staff
AT4S3  28 102  Staff
BGPP9  18 25   Staff
BXPQM  38 152  Staff
EYFYX  29 123  Staff
GSSMJ  14 56   Staff
IRFVM  8  62   Staff
L15GM  41 142  Staff
XCU73  32 115  Staff
Z86ZR  20 40   Staff
62EFL  5  105  Lead
6EI4N  21 87   Lead
7TZ7T  12 31   Lead
E2C61  27 54   Lead
MVZ8P  14 36   Lead
XLFLN  2  28   Lead
YELJB  29 44   Lead
2G8JY  3  21   Senior
63337  14 55   Senior
IHLJF  8  25   Senior
J4V0J  29 71   Senior
URAOV  18 41   Senior
IM76W  03 10   Manager
KULNC  12 20   Manager
;;;;
proc print data=emp_roster;
  title "EMP_ROSTER";
run;
proc sql;
  create table oncall_roster as
    select emp.* from
      (select emp.*,
            case
              when hours_week gt 35 or hours_4weeks gt 120 then 5
              when level='Manager' then 5
              when (level='Lead' or level='Senior') and hours_week le 16 then 2
              when (level='Lead' or level='Senior') and hours_week between 17 and 24 then 3
              when (level='Lead' or level='Senior') and hours_week gt 24 then 4
              when level='Staff' and hours_week gt 30 and hours_4weeks gt 40 then 4
              when level='Staff' and hours_week gt 30 and hours_4weeks le 40 then 3
              when level='Staff' and hours_week le 20 then 1
              when level='Staff' and (hours_week between 21 and 30) and
                        hours_4weeks le 40 then 1
              when level='Staff' and (hours_week between 21 and 30) and
                        hours_4weeks gt 40 then 2
              else 9
            end as sortcolumn
        from emp_roster as emp)
       order by sortcolumn, hours_week;
quit;
proc print data=oncall_roster;
  title "Example 8.6 ONCALL_ROSTER Table Created with PROC SQL";
run;


/****************************************************************************/
/* Example 8.7                                                              */
/****************************************************************************/
data finalsales;
  length year 3;
  format internet networks os apps training dollar8.;

  do year=2001 to 2009;
    internet=60000+ceil(ranuni(38128)*10000);
    networks=45000+ceil(ranuni(31838)*7500);
    os=32000+ceil(ranuni(39185)*5000);
    apps=44000+ceil(ranuni(18381)*3000);
    training=75000+ceil(ranuni(38318)*5000);
    output;
  end;
run;
proc print data=finalsales;
  title "FINALSALES";
run;
data proj_finalsales;
  set finalsales end=eof;

  array dept{*} internet networks os apps training;
  array growth{5} _temporary_ (2.5,0.3,-.5,.1,5);

  length type $ 9;
  retain type 'Final';
  drop i;

  output;
  if eof then do;
    type='Projected';
    do year=2010 to 2012;
      do i=1 to dim(dept);
        dept{i}=round((dept{i} + growth{i}*dept{i}/100),1);
      end;
      output;
    end;
  end;
run;
proc print data=proj_finalsales;
  title "Example 8.7 PROJ_FINALSALES Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 8.8                                                              */
/****************************************************************************/
data newsoftware;
  input task $ 1-10 totaldays ;
datalines;
install    1
benchmarks 2
review 1   2
parallel   5
review 2   3
complete   1
;;;;
proc print data=newsoftware;
  title "NEWSOFTWARE";
run;
data newsoftwaredaily;
  format workdate weekdate25.;
  set newsoftware;

  retain workdate '01mar2010'd;
  drop dayofweek i;

  taskday=0;
  do i=1 to totaldays;
    taskday+1;
    dayofweek=weekday(workdate);
    if dayofweek=7 then workdate+2;
    else if dayofweek=1 then workdate+1;
    output;
    workdate+1;
  end;
run;
proc print data=newsoftwaredaily;
  title "Example 8.8 NEWSOFTWAREDAILY Data Set Created with DATA Step";
  format workdate weekdate23.;
run;


/****************************************************************************/
/* Example 8.9 Data set WEIGHT_BMI is same as used in Example 8.12          */
/****************************************************************************/
data weight_bmi;
  input id $ week weight bmi session $;
datalines;
S001 1 231 29.7 AM1
S002 1 187 28.4 AM1
S003 1 154 27.3 PM1
S004 1 134 25.3 PM3
S001 2 223 28.6 AM2
S003 2 151 26.7 AM1
S004 2 133 25.1 PM3
S002 3 176 26.8 AM2
S003 3 148 26.2 PM1
S004 4 129 24.4 PM3
S003 4 142 25.2 PM1
;;;;
proc sort data=weight_bmi;
  by id week;
run;
proc print data=weight_bmi;
  title "WEIGHT_BMI";
run;
data weight_bmi_4weeks;
  set weight_bmi(rename=(week=holdweek weight=holdweight bmi=holdbmi session=holdsession));
  by id;

  retain week;
  drop holdweek holdweight holdbmi holdsession upper;

  if first.id then week=1;

  if last.id then upper=4;
  else upper=holdweek;

  do week=week to upper;
    if week ne holdweek then do;
      weight=.;
      bmi=.;
      session='   ';
    end;
    else do;
      weight=holdweight;
      bmi=holdbmi;
      session=holdsession;
    end;
    output;
  end;
run;
proc print data=weight_bmi_4weeks;
  title "Example 8.9 WEIGHT_BMI_4WEEKS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 8.9 Related Technique                                            */
/****************************************************************************/
proc means data=weight_bmi completetypes noprint nway;
  class id week;
  id session;
  var weight bmi;
  output out=weight_bmi_4weeks(drop=_freq_ _type_) min=;
run;
proc print data=weight_bmi_4weeks;
  title "Example 8.9  Related Technique WEIGHT_BMI_4WEEKSData Set Created with PROC MEANS";
run;


/****************************************************************************/
/* Example 8.10                                                            */
/****************************************************************************/
data woodpeckers;
  length visit_date 8 tract $ 4 red_bellied sapsucker downy hairy flicker pileated $ 1;
  input visit_date mmddyy10. tract $
        red_bellied sapsucker downy hairy flicker pileated;
  format visit_date mmddyy10.;
datalines;
03/15/2009 JN72 H N S S N N
03/15/2009 MV28 N N S N N N
03/20/2009 JN72 S N S H N H
03/20/2009 KT05 N S S N N N
03/20/2009 MV28 S N H H N S
03/25/2009 JN72 N H S S N N
03/25/2009 MV28 N S S S N H
03/30/2009 JN72 H S N H N N
03/30/2009 KT05 N N H S N H
03/30/2009 LT83 H S S S N H
03/30/2009 MV28 S N S N N S
04/04/2009 LT83 N N S S H N
04/09/2009 JN72 S N S S N S
04/09/2009 LT83 N N S H N N
04/09/2009 MV28 S S S S N H
04/14/2009 LT83 N N S S S H
04/14/2009 MV28 H N S S H S
;;;
proc print data=woodpeckers;
  title "WOODPECKERS";
run;
proc freq data=woodpeckers;
  tables visit_date*tract / noprint out=allvisits(keep=visit_date tract) sparse;
run;
proc sql;
  create table fullbirdsurvey as
    select * from allvisits v left join woodpeckers w
      on v.visit_date=w.visit_date and v.tract=w.tract;
quit;
proc print data=fullbirdsurvey;
  title "Example 8.10 FULLBIRDSURVEY Table Created with PROC FREQ and PROC SQL";
run;




/****************************************************************************/
/* Example 8.11                                                             */
/****************************************************************************/
data custresp;
  input customer factor1-factor4 source1-source3 website store event;
  keep customer website store event;

datalines;
  1 . . 1 1 1 1 .  0   1   1
  2 1 1 . 1 1 1 .  0   8   .
  3 . . 1 1 1 1 .  0   4   0
  4 1 1 . 1 . 1 . 10   3   2
  5 . 1 . 1 1 . .  1   .   0
  6 . 1 . 1 1 . .  3   0   0
  7 . 1 . 1 1 . .  0   6   1
  8 1 . . 1 1 1 .  0   2   3
  9 1 1 . 1 1 . .  0   1   0
 10 1 . . 1 1 1 .  0   4   0
 11 1 1 1 1 . 1 .  6   4   1
 12 1 1 . 1 1 1 .  4   4   2
 13 1 1 . 1 . 1 .  9   3   5
 14 1 1 . 1 1 1 .  0   3   0
 15 1 1 . 1 . 1 .  1   0   0
 16 1 . . 1 1 . .  0   2   0
 17 1 1 . 1 1 1 .  0   5   1
 18 1 1 . 1 1 1 1  6   1   2
 19 . 1 . 1 1 1 1  0   7   4
 20 1 . . 1 1 1 .  5   3   0
 21 . . . 1 1 1 .  0   1   0
 22 . . . 1 1 1 .  5   1   3
 23 1 . . 1 . . .  1   0   0
 24 . 1 . 1 1 . .  0   2   0
 25 1 1 . 1 1 . .  1   1   1
;;;;
proc print data=custresp;
  title "CUSTRESP";
run;
data salesvisits;
  set custresp;

  array site{*} website store event;
  array sitename{3} $25 _temporary_ ;

  length salessite $ 7;
  keep customer salessite visits;

  if _n_=1 then do;
    do i=1 to 3;
      call vname(site{i},sitename{i});
    end;
  end;

  do i=1 to dim(site);
    salessite=sitename{i};
    visits=site{i};
    output;
  end;
run;
proc print data=salesvisits(obs=21);
  title "Example 8.11 SALESVISITS Data Set Created with DATA Step (first 21 observations)";
run;


/****************************************************************************/
/* Example 8.11 Related Technique                                            */
/****************************************************************************/
proc sort data=custresp;
  by customer;
run;
proc transpose data=custresp name=salessite
               out=salesvisits(rename=(col1=visits));
  by customer;
  var website store event;
run;
proc print data=salesvisits;
  title "Example 8.11 Related Technique SALESVISITS Data Set Created with PROC TRANSPOSE";
run;



/****************************************************************************/
/* Example 8.12 Data set WEIGHT_BMI is same as used in Example 8.9          */
/****************************************************************************/
data weight_bmi;
  input id $ week weight bmi session $;
datalines;
S001 1 231 29.7 AM1
S002 1 187 28.4 AM1
S003 1 154 27.3 PM1
S004 1 134 25.3 PM3
S001 2 223 28.6 AM2
S003 2 151 26.7 AM1
S004 2 133 25.1 PM3
S002 3 176 26.8 AM2
S003 3 148 26.2 PM1
S004 4 129 24.4 PM3
S003 4 142 25.2 PM1
;;;;
proc print data=weight_bmi;
  title "WEIGHT_BMI";
run;
proc sort data=weight_bmi;
  by id;
run;
data wtresults;
  set weight_bmi;
  by id;

  array wts{*} wt_week1-wt_week4;
  array bmis{*} bmi_week1-bmi_week4;
  array sessions{*} $ 3 session_week1-session_week4;

  drop i week weight bmi session;

  retain wt_week1-wt_week4 bmi_week1-bmi_week4 session_week1-session_week4;

  if first.id then do;
    do i=1 to 4;
      wts{i}=.;
      bmis{i}=.;
      sessions{i}=' ';
    end;
  end;

  if 1 le week le 4 then do;
    wts{week}=weight;
    bmis{week}=bmi;
    sessions{week}=session;
  end;
  else putlog "ERROR: Week value " week "out of range from 1 to 4 for id=" id;

  if last.id then output;
run;
proc print data=wtresults;
  title "Example 8.12 WTRESULTS Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 8.12 Related Technique                                           */
/****************************************************************************/
proc transpose data=weight_bmi out=transwtbmi
               prefix=week;
  by id;
  var weight bmi;
  id week;
run;
proc print data=transwtbmi;
  title "TRANSWTBMI";
run;
proc transpose data=weight_bmi out=transsession
               prefix=session_week;
  by id;
  var session;
  id week;
run;
proc print data=transsession;
  title "TRANSSESSION";
run;
data wtresults;
  merge transwtbmi(where=(upcase(_name_)='WEIGHT')
                   rename=(week1=wt_week1 week2=wt_week2 week3=wt_week3 week4=wt_week4))
        transwtbmi(where=(upcase(_name_)='BMI')
                    rename=(week1=bmi_week1 week2=bmi_week2 week3=bmi_week3 week4=bmi_week4))
        transsession;
  by id;
  drop _name_;
run;
proc print data=wtresults;
  title "Example 8.12 Related Technique WTRESULTS Data Set";
  title2 "Created with PROC TRANSPOSE and DATA Step";
run;




/****************************************************************************/
/* Example 8.13                                                             */
/****************************************************************************/
data production;
  input plant $ 1-11 proddate mmddyy10. units_made;
  format proddate mmddyy10.;
datalines;
Aux Plant  03/02/2009 76
Main Plant 02/27/2009 393
Main Plant 03/03/2009 501
Main Plant 03/04/2009 492
Main Plant 03/05/2009 719
Main Plant 03/06/2009 111
Main Plant 03/09/2009 268
Main Plant 03/10/2009 350
Port Park  02/20/2009 791
Port Park  02/27/2009 658
Port Park  03/10/2009 981
Port Park  03/11/2009 612
Port Park  03/13/2009 664
West Side  02/23/2009 629
West Side  02/24/2009 543
;;;
proc sort data=production;
  by plant proddate;
run;
proc print data=production;
  title "PRODUCTION";
run;
data prodlast3;
  set production;
  by plant;

  drop count i;

  length too_few_days $ 3;
  format run_avg_units 5.;

  array units{3} units_made1-units_made3;

  units_made1=lag1(units_made);
  units_made2=lag2(units_made);
  units_made3=lag3(units_made);

  if first.plant then count=1;

  do i=count to dim(units);
    units{i}=.;
  end;

  if count ge 4 or (last.plant and count lt 4) then do;
    run_avg_units=mean(units_made,units_made1,units_made2,units_made3);
    if n(units_made,units_made,units_made2,units_made3) lt 4 then too_few_days='***';
    output;
  end;

  count+1;
run;
proc print data=prodlast3;
  title "Example 8.13 PRODLAST3 Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 8.13 Related Technique                                           */
/****************************************************************************/
proc sort data=production;
  by plant proddate;
run;
data prodlast3;
  set production;
  by plant;

  drop count i;

  length too_few_days $ 3;
  format run_avg_units 5.;

  array units{4} units_made units_made1-units_made3;

  retain units_made1-units_made3;

  if first.plant then do;
    do i=2 to 4;
      units{i}=.;
    end;
    count=1;
  end;

  if (1 le count lt 4) and last.plant then do;
    too_few_days='***';
    run_avg_units=mean(units_made,units_made1,units_made2,units_made3);
    output;
  end;
  else if count ge 4 then do;
    run_avg_units=mean(units_made,units_made1,units_made2,units_made3);
    output;
  end;

  do i=4 to 2 by -1;
    units{i}=units{i-1};
  end;

  count+1;
run;
proc print data=prodlast3;
  title "Example 8.13 Related Technique PRODLAST3 Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 8.14 Use data set PRODUCTION created in Example 8.13              */
/****************************************************************************/
proc print data=production;
  title "PRODUCTION";
run;
proc sort data=production;
  by plant proddate;
run;
data prodnext;
  merge production
        production(firstobs=2
                   rename=(plant=plant_next proddate=next_proddate units_made=next_units_made));
  drop plant_next;
  if plant ne plant_next then do;
    plant_next=' ';
    next_proddate=.;
    next_units_made=.;
  end;
  else days_btwn=next_proddate-proddate;
run;
proc print data=prodnext;
  title "Example 8.14 PRODNEXT Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 8.15                                                              */
/****************************************************************************/
data glucose;
  input patient_id $
        (glucose_fast eval_fast glucose_1hr eval_1hr glucose_2hr eval_2hr
         glucose_4hr eval_4hr ) (3. $1.);
  eval_fast='?';
  eval_1hr='?';
  eval_2hr='?';
  eval_4hr='?';
datalines;
ARD123 101 135  98 .
DKJ891 75  88  103 79
EWP006 .   .   .   .
TAB234 79  94  126 133
;;;
proc print data=glucose;
  title "GLUCOSE";
run;
data eval_glucose;
  set glucose;

  array glucose{*} _numeric_;
  array eval{*} eval_fast-character-eval_4hr;

  drop i;

  do i=1 to dim(glucose);
    if glucose{i}=. then eval{i}='-';
    else if glucose{i} lt 100 then eval{i}='N';
    else if 100 le glucose{i} le 125 then eval{i}='P';
    else if glucose{i} gt 125 then eval{i}='H';
  end;
run;
proc print data=eval_glucose;
  title "Example 8.15 EVAL_GLUCOSE Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 8.16                                                             */
/****************************************************************************/
data persons;
  input household person relationship $ 9-22 gender $ 24
        @26 dob mmddyy10. education $ 37-38 work_status $ 40-41;
  format dob mmddyy10.;
datalines;
1001 01 reference      F 09/13/1972 AA PT
1001 02 spouse         M 10/25/1970 MS FT
1001 03 child          F 02/12/2002 00 NA
1001 04 child          F 02/12/2002 00 NA
1001 05 child          M 06/21/2005 00 NA
1011 01 reference      F 07/12/1985 BA FT
1012 01 reference      F 01/30/1946 HS RT
1012 02 spouse         M 02/04/1940 HS RT
1012 03 other relative F 12/22/1921 BA RT
1015 01 reference      M 06/28/1990 HS SC
1015 02 other          M 05/25/1990 HS SC
1015 03 other          M 07/16/1989 HS SC
1015 04 other          M 11/02/1988 BS SC
;;;
proc print data=persons;
  title "PERSONS";
run;
proc sql;
  create table household_survey as
    select p.*,
           floor((intck('month',p.dob,'15jun2010'd) -
             (day('15jun2010'd) < day(p.dob)))/12) as age,
           ref.education as reference_educ,
           ref.work_status as reference_work,
           ref.gender as reference_gender,
           floor((intck('month',ref.dob,'15jun2010'd) -
             (day('15jun2010'd) < day(ref.dob)))/12) as reference_age
      from persons p, persons ref
      where p.household=ref.household and ref.relationship='reference'
      order by p.household,p.person;
quit;
proc print data=household_survey;
  title "Example 8.16 HOUSEHOLD_SURVEY Table Created with PROC SQL";
run;

/****************************************************************************/
/* Example 8.16 Related Technique                                           */
/****************************************************************************/
data household_survey;
  merge persons
        persons(where=(relationship='reference')
                       rename=(education=reference_educ
                               work_status=reference_work
                               dob=reference_dob gender=reference_gender)
                       drop=person);
  by household;
  drop reference_dob;
  age=floor((intck('month',dob,'15jun2010'd) -
           (day('15jun2010'd) < day(dob)))/12);
  reference_age=floor((intck('month',reference_dob,'15jun2010'd) -
             (day('15jun2010'd) < day(reference_dob)))/12);
run;
proc print data=household_survey;
  title "Example 8.16 HOUSEHOLD_SURVEY Related Technique Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 8.17                                                             */
/****************************************************************************/

/* Specify a LIBNAME for CITYLIB where you can store the following data sets */
libname citylib '    ';

data citylib.mainlib_jan2010 citylib.mainlib_feb2010
     citylib.mainlib_01mar2010 citylib.mainlib_02mar2010 citylib.mainlib_03mar2010
     citylib.mainlib_04mar2010 citylib.mainlib_05mar2010 citylib.mainlib_06mar2010
     citylib.mainlib_07mar2010 citylib.mainlib_08mar2010;
  length circdate 8 type $ 20;
  input type $ ad juv yp;

  keep circdate type adult juvenile youngpeople;
  array circ{3} adult juvenile youngpeople;
  array base{3} ad juv yp;

  retain year 2010;

  format circdate mmddyy10.;

  jantotal=ceil(uniform(90123)*87000);
  do i=2 to 17,19 to 31;
    circdate=mdy(1,i,year);
    do j=1 to 3;
      pct=base{j}/90123;
      janadj=ceil(uniform(8731)*10000);
      circ{j}=round(pct*(jantotal+janadj)/30,1);
    end;
    output citylib.mainlib_jan2010;
  end;

  febtotal=ceil(uniform(90124)*87000);
  do i=1 to 15,17 to 28;
    circdate=mdy(2,i,year);
    do j=1 to 3;
      pct=base{j}/90123;
      febadj=ceil(uniform(8732)*10000);
      circ{j}=round(pct*(febtotal+febadj)/30,1);
    end;
    output citylib.mainlib_feb2010;
  end;

  martotal=ceil(uniform(90125)*87000);
  do i=1 to 8;
    circdate=mdy(3,i,year);
    do j=1 to 3;
      pct=base{j}/90123;
      maradj=ceil(uniform(8733)*10000);
      circ{j}=round(pct*(martotal+maradj)/30,1);
    end;
    if i=1 then output citylib.mainlib_01mar2010;
    else if i=2 then output citylib.mainlib_02mar2010;
    else if i=3 then output citylib.mainlib_03mar2010;
    else if i=4 then output citylib.mainlib_04mar2010;
    else if i=5 then output citylib.mainlib_05mar2010;
    else if i=6 then output citylib.mainlib_06mar2010;
    else if i=7 then output citylib.mainlib_07mar2010;
    else if i=8 then output citylib.mainlib_08mar2010;
  end;
datalines;
Audiocassettes 1569 546 388
CompactDiscs 4018 2754 370
HardcoverFiction 6753 965 369
HardcoverNonfiction 9063 3346 715
LargeTypeFiction 514 1 2
LargeTypeNonfiction 717 0 0
PaperbackFiction 7866 5833 4695
PaperbackNonfiction 6770 3850 1702
PeriodicalsLargeType 19 0 0
Periodicals 7162 1433 234
AudioBooksFiction 1724 843 124
AudioBooksNonfiction 1590 140 130
DVDFiction 5002 3936 2876
DVDNonfiction 1852 206 46
;;;
proc sort data=citylib.mainlib_jan2010(genmax=7);
  by circdate type;
run;
proc sort data=citylib.mainlib_feb2010(genmax=7);
  by circdate type;
run;
data citylib.mainlib_2010(genmax=12);
  set citylib.mainlib_jan2010;
run;
data citylib.mainlib_2010(genmax=12);
  set citylib.mainlib_2010 citylib.mainlib_feb2010;
run;
data citylib.mainlib_mar2010(genmax=7)
     citylib.mainlib_daily(genmax=3);
  set citylib.mainlib_01mar2010;
run;
%macro domar;
  %do i=2 %to 8;
    data citylib.mainlib_daily;
      set citylib.mainlib_0&i.mar2010;
    run;
    data citylib.mainlib_mar2010;
      set citylib.mainlib_mar2010 citylib.mainlib_daily;
    run;
  %end;
%mend domar;
%domar

proc datasets library=citylib nolist;
  delete mainlib_01mar2010 mainlib_02mar2010 mainlib_03mar2010
         mainlib_04mar2010 mainlib_05mar2010 mainlib_06mar2010
         mainlib_07mar2010 mainlib_08mar2010;
run;
quit;
%macro makecopies;
  %do i=1 %to 30;
    data citylib.mainlib_jan2010;
      set citylib.mainlib_jan2010;
    run;
  %end;
  %do i=1 %to 27;
    data citylib.mainlib_feb2010;
      set citylib.mainlib_feb2010;
    run;
  %end;
%mend makecopies;
%makecopies



proc print data=citylib.mainlib_daily(gennum=-2);
  title "CITYLIB.MAINLIB_DAILY (GENNUM=-2)";
run;
proc print data=citylib.mainlib_daily(gennum=-1);
  title "CITYLIB.MAINLIB_DAILY (GENNUM=-1)";
run;
proc print data=citylib.mainlib_daily(gennum=0);
  title "CITYLIB.MAINLIB_DAILY (GENNUM=0)";
run;
proc datasets library=work nolist;
  delete mostrecent3;
run;
quit;
/* PROC APPEND Relative Generation Number */
proc append base=mostrecent3 data=citylib.mainlib_daily(gennum=-2);
run;
proc append base=mostrecent3 data=citylib.mainlib_daily(gennum=-1);
run;
proc append base=mostrecent3 data=citylib.mainlib_daily(gennum=0);
run;
/* PROC APPEND Absolute Generation Number */
proc append base=mostrecent3 data=citylib.mainlib_daily(gennum=65);
run;
proc append base=mostrecent3 data=citylib.mainlib_daily(gennum=66);
run;
proc append base=mostrecent3 data=citylib.mainlib_daily(gennum=67);
run;
proc print data=mostrecent3;
  title "Example 8.17 MOSTRECENT3 Data Set Created with PROC APPEND";
run;

/* DATA Step Relative Generation Number */
data mostrecent3;
  set citylib.mainlib_daily(gennum=-2)
      citylib.mainlib_daily(gennum=-1)
      citylib.mainlib_daily(gennum=0);
run;
/* DATA Step Absolute Generation Number */
data mostrecent3;
  set citylib.mainlib_daily(gennum=65)
      citylib.mainlib_daily(gennum=66)
      citylib.mainlib_daily(gennum=67);
run;
proc print data=mostrecent3;
  title "Example 8.3 MOSTRECENT3 Data Set Created with DATA Step";
run;

/* PROC SQL Relative Generation Number */
proc sql;
  create table mostrecent3 as
    select * from citylib.mainlib_daily(gennum=-2)
         union
    select * from citylib.mainlib_daily(gennum=-1)
         union
    select * from citylib.mainlib_daily(gennum=0);
quit;
/* PROC SQL Absolute Generation Number */
proc sql;
  create table mostrecent3 as
    select * from citylib.mainlib_daily(gennum=65)
         union
    select * from citylib.mainlib_daily(gennum=66)
         union
    select * from citylib.mainlib_daily(gennum=67);
quit;
proc print data=mostrecent3;
  title "Example 8.3 MOSTRECENT3 Table Created with PROC SQL";
run;
/***********************END CHAPTER 8****************************************/



/*************** START CHAPTER 9 ********************************************/

/****************************************************************************/
/* Example 9.1                                                             */
/****************************************************************************/
data prelim_results;
  infile datalines missover;
  input id $ testdate score $ test_version  ;
datalines;
3205 41509 9  40012
3019 30109 20  103
4310 . .   20101
4817 . 0
4182 11032009 18  251
;;;;
proc print data=prelim_results;
  title "PRELIM_RESULTS";
run;
data recoded_results(drop=cscore nversion);
  set prelim_results(rename=(score=cscore test_version=nversion));
  length score 4 test_version $ 5;
  format testdate mmddyy10.;

  testdate=input(put(testdate,z8.),mmddyy8.);

  score=input(cscore,2.);
  if nversion ne . then test_version=translate(put(nversion,5.-l),'0',' ');
  else test_version='00000';
run;
proc print data=recoded_results;
  title "Example 9.1 RECODED_RESULTS";
run;


/****************************************************************************/
/* Example 9.2                                                             */
/****************************************************************************/
data chemtest;
  infile datalines missover;
  input sample chem_ppb $ 7-18;
datalines;
57175 1250.3
71309 2.53E3
28009 40 ppb
40035 -81
55128 3,900
41930 ~1000
21558 4?23
46801 <1%
18322
11287 <1000
37175 >5000
22195 Sample lost
81675 Invalid: GHK
88810 N/A
;;;;
proc print data=chemtest;
  title "CHEMTEST";
run;
data chemeval;
  set chemtest;

  length eval $ 12 result 8;

  if chem_ppb=' ' then eval='Undefined';
  else do;
    result=input(chem_ppb,?? best12.);
    if result ne . then do;
      if result ge 0 then eval='Numeric';
      else do;
        result=.;
        eval='Error';
      end;
    end;
    else do;
      if upcase(strip(reverse(chem_ppb)))=:'BPP' then do;
        result=input(substr(chem_ppb,1,length(chem_ppb)-3),?? best12.);
        if result ne . then do;
          if result ge 0 then eval='Numeric';
          else do;
            result=.;
            eval='Error';
          end;
        end;
      end;
      else if notalpha(compress(chem_ppb,' ().,-&:'))=0 or
           upcase(chem_ppb)='N/A' then eval='Text';
      else do;
        if char(chem_ppb,1)='<' and input(substr(chem_ppb,2),?? best12.) ne .
           then eval='Below Range';
        else if char(chem_ppb,1)='>' and input(substr(chem_ppb,2),?? best12.)
           then eval='Above Range';
        else eval='Error';
      end;
    end;
  end;
run;
proc print data=chemeval;
  title "Example 9.2 CHEMEVAL Data Set";
run;

/****************************************************************************/
/* Example 9.3                                                             */
/****************************************************************************/
data entrance_exam;
  length id $ 4 examversion $ 4 examdate 8 examdate 8
         essay speech $ 8 mathematics physics vocabulary 4
         logic $ 8 spatial 4 athletics $ 8;

  keep id--athletics;

  array v{3} $ 8 _temporary_ ('Exceeds' 'Meets' 'Below');
  array loc{4} $ 15 _temporary_ ('Classroom 52','Green Hall 180',
                                 'Univ Park #32','Media Center 3');
  array n{4} mathematics physics vocabulary spatial;

  retain charstring 'ABCDEFGHIJKMLMNOPQRSTUVWXYZ';
  format examdate mmddyy10.;

  do i=1 to 15;
    id=' ';
    examloc=loc{ceil(uniform(4312)*4)};
    examversion=cats('V',put(4+(ceil(uniform(8716)*4))/10,3.1));
    examdate=mdy(7,ceil(uniform(7164)*31),2010);
    do j=1 to 4;
      id=cats(id,substr(charstring,ceil(uniform(431)*26),1));
    end;
    essay=v{ceil(uniform(8175)*dim(v))};
    speech=v{ceil(uniform(8176)*dim(v))};
    logic=v{ceil(uniform(8177)*dim(v))};
    athletics=v{ceil(uniform(88177)*dim(v))};
    do j=1 to dim(n);
      n{j}=ceil(uniform(8718)*20);
    end;
    output;
  end;
run;
proc print data=entrance_exam;
  title "ENTRANCE_EXAM";
run;

data _null_;
  dsid=open('work.entrance_exam','i');
  if dsid=0 then do;
    putlog 'ERROR: Data set ENTRANCE_EXAM could not be opened.';
    stop;
  end;

  length examvarname $ 32 charvars $ 200 numvars $ 200;

  totalvars=attrn(dsid,'nvars');
  do i=1 to totalvars;
    examvarname=varname(dsid,i);
    if index(upcase(examvarname),'ID') gt 0 or
       index(upcase(examvarname),'DATE') gt 0 then continue;

    if vartype(dsid,i)='C' then charvars=catx(' ',charvars,examvarname);
    else if vartype(dsid,i)='N' then numvars=catx(' ',numvars,examvarname);
  end;

  rc=close(dsid);
  if rc ne 0 then putlog 'ERROR: Problem in closing ENTRANCE_EXAM';

  call symputx('CHARLIST',charvars);
  call symputx('NUMLIST',numvars);

run;
proc freq data=entrance_exam;
  title "Example 9.3 ENTRANCE_EXAM";
  tables &charlist;
run;
proc means data=entrance_exam;
  title "Example 9.3 ENTRANCE_EXAM";
  var &numlist;
run;

/****************************************************************************/
/* Example 9.3 Related Technique                                           */
/****************************************************************************/
proc sql noprint;
  select name into :numlist separated by ' '
    from dictionary.columns
    where libname='WORK' and memname='ENTRANCE_EXAM'
          and type='num' and index(upcase(name),'DATE')=0 and
          index(upcase(name),'ID')=0;
    select name into :charlist separated by ' '
    from dictionary.columns
    where libname='WORK' and memname='ENTRANCE_EXAM'
          and type='char' and index(upcase(name),'DATE')=0 and
          index(upcase(name),'ID')=0;

quit;
proc freq data=entrance_exam;
  title "Example 9.3 ENTRANCE_EXAM";
  tables &charlist;
run;
proc means data=entrance_exam;
  title "Example 9.3 ENTRANCE_EXAM";
  var &numlist;
run;



/****************************************************************************/
/* Example 9.4                                                             */
/****************************************************************************/
data global_revenue;
  input country $ 1-8 year revenue;
datalines;
USA     2008  3819501.03
USA     2009  -19391.88
USA     2010  1033.65
Canada  2008 471868.81
Canada  2009 297654.01
Canada  2010 111123.09
Belgium 2008 -1201.30
Belgium 2009 404019.87
Belgium 2010 -55414.86
France  2008 917378.02
France  2009 891785.31
France  2010 953919.07
Germany 2008 1860.03
Germany 2009 -61545.32
Germany 2010 777541.26
Japan   2008 549871.03
Japan   2009 391830.68
Japan   2010 -140001.78
;;;;
proc print data=global_revenue;
  title "GLOBAL_REVENUE";
run;
proc format;
  value $money 'USA','Canada'='dollar'
               'Belgium','France','Germany'='eurox'
               'Japan'='yen';
run;
data global_text;
  set global_revenue;
  length revenue_text $ 50 fmt $ 12;
  keep revenue_text;

  fmt=put(country,$money.);
  if upcase(country) not in ('CANADA','USA') then
      revenue_text=catx(' ',country,put(year,4.),'Revenue:',putn(revenue,fmt,14,2));
  else if upcase(country)='CANADA' then
      revenue_text=catx(' ',country,put(year,4.),'Revenue:',cats('C',putn(revenue,fmt,14,2)));
  else if upcase(country)='USA' then
      revenue_text=catx(' ',country,put(year,4.),'Revenue:',cats('US',putn(revenue,fmt,14,2)));
run;
proc print data=global_text;
  title "Example 9.4 GLOBAL_TEXT Data Set Created with DATA Step";
run;





/****************************************************************************/
/* Example 9.5                                                              */
/****************************************************************************/

/* Specify a LIBNAME for TESTCODE where you can store the following sets    */
libname testcode ' ';

proc format;
  value $gender 'M'='Male'
                'F'='Female';
run;
data testcode.trial3_week01;
  attrib id length=$6 label='Study ID'
         age length=3. label='Age' format=2.
         gender length=$2 label='Gender' format=$gender.
         ht_cm length=4 label='Height(cm)' format=3.
         wt_kg length=4 label='Weight(kg)' format=2.
         systol length=4 label='Systolic Blood Pressure' format=z3.
         diastol length=4 label='Diastolic Blood Pressure' format=z3.
         ekg  length=$25 label='EKG Result'
         init_bmi  length=8 label='Initial BMI (computed)' format=4.1;
  input id $6. age gender $ ht_cm wt_kg systol diastol ekg $;
  init_bmi=(wt_kg/ht_cm**2)*10000;
datalines;
AW37BD 52 M 173 88 131 77 Normal
23GM02 53 M 180 83 144 90 Abnormal-LVH
;;;;
data testcode.trial3_week02;
  input id $6. systol diastol gluc chol tri hdl;
  attrib id length=$6 label='Study ID'
         systol length=4 label='Systolic Blood Pressure' format=z3.
         diastol length=4 label='Diastolic Blood Pressure' format=z3.
         gluc  length=4 label='Glucose Result' format=4.
         chol  length=4 label='Cholesterol Result' format=4.
         tri   length=4 label='Triglycerides Result' format=4.
         hdl   length=4 label='HDL Result' format=4.;
datalines;
AW37BD 132 84 100 224 122 45
23GM02 136 83 86  188 100 51
;;;
data testcode.trial3_week04;
  input id $6. wt_kg systol diastol gluc tri;
  attrib id length=$6 label='Study ID'
         wt_kg length=4 label='Weight(kg)' format=2.
         systol length=4 label='Systolic Blood Pressure' format=z3.
         diastol length=4 label='Diastolic Blood Pressure' format=z3.
         gluc  length=4 label='Glucose Result' format=4.
         tri   length=4 label='Triglycerides Result' format=4.;
datalines;
AW37BD 86 128 85 104 99
23GM02 85 130 79 92 124
;;;;;
data testcode.trial3_week08;
  input id $6. wt_kg systol diastol gluc chol tri hdl;
  attrib id length=$6 label='Study ID'
         wt_kg length=4 label='Weight(kg)' format=2.
         systol length=4 label='Systolic Blood Pressure' format=z3.
         diastol length=4 label='Diastolic Blood Pressure' format=z3.
         gluc  length=4 label='Glucose Result' format=4.
         chol  length=4 label='Cholesterol Result' format=4.
         tri   length=4 label='Triglycerides Result' format=4.
         hdl   length=4 label='HDL Result' format=4.;
datalines;
AW37BD 85 125 80 98 210 100 48
23GM02 82 126 83 90 193 118 53
;;;;
proc print data=testcode.trial3_week01;
  title "TESTCODE.TRIAL3_WEEK01";
run;
proc print data=testcode.trial3_week02;
  title "TESTCODE.TRIAL3_WEEK02";
run;
proc print data=testcode.trial3_week04;
  title "TESTCODE.TRIAL3_WEEK04";
run;
proc print data=testcode.trial3_week08;
  title "TESTCODE.TRIAL3_WEEK08";
run;
proc datasets library=testcode memtype=data;
quit;
proc sql ;
  create table num_studyvars as
    select distinct name,type,length,label,format
        from dictionary.columns
        where type='num' and
              libname='TESTCODE' and
              memname in
                (select memname from dictionary.tables
                   where libname='TESTCODE' and memtype='DATA' and
                         datepart(crdate) between '01may2009'd and '30jun2009'd)
        order by name;
  create table char_studyvars as
    select distinct name,type,length,label,format
        from dictionary.columns
        where type='char' and libname='TESTCODE' and
              memname in
               (select memname from dictionary.tables
                  where libname='TESTCODE' and memtype='DATA' and
                        datepart(crdate) between '01may2009'd and '30jun2009'd )
      order by name;
quit;
proc print data=num_studyvars;
  title "Example 9.5 NUM_STUDYVARS Table Created with PROC SQL";
run;
proc print data=char_studyvars;
  title "Example 9.5 CHAR_STUDYVARS Table Created with PROC SQL";
run;





/****************************************************************************/
/* Example 9.6                                                             */
/****************************************************************************/
data adsurvey;
  infile datalines truncover;
  length surveyid 4 noticed1-noticed3 $ 9;
  input surveyid noticed1 $ noticed2 $ noticed3 $
        amount1 amount2 amount3;
datalines;
106 website flyer MAIL  300 0 0
153 website newspaper email -55 . .
192 email ? email  0 . .
145 Online n/a website 75 95 250
162 insert on-line  . -45 . 10
;;;;
proc print data=adsurvey;
  title "ADSURVEY";
run;
data surveysorted;
  set adsurvey;

  array amount{3} amount1-amount3;
  array ord_amt{3} ord_amt1-ord_amt3;
  array small_amt{3} small_amt1-small_amt3;
  array large_amt{3} large_amt1-large_amt3;

  drop i;

  do i=1 to dim(amount);
    ord_amt{i}=ordinal(i, of amount{*});
    small_amt{i}=smallest(i, of amount{*});
    large_amt{i}=largest(i, of amount{*});
  end;
  call sortc(of noticed1-noticed3);
  call sortn(of amount{*});
run;
proc print data=surveysorted;
  title "Example 9.6 SURVEYSORTED Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 9.6 Related Technique                                           */
/****************************************************************************/
data revsorted;
  set adsurvey;

  array amount{3} amount1-amount3;
  array rev_amt{3} rev_amt1-rev_amt3;

  drop i;

  do i=1 to dim(amount);
    rev_amt{dim(amount)-i+1}=ordinal(i, of amount{*});
  end;
run;
proc print data=revsorted;
  title "Example 9.6 Related Technique REVSORTED Data Set Created with DATA Step";
run;





/****************************************************************************/
/* Example 9.7                                                             */
/****************************************************************************/
data testmonths;
  length applicant $ 6;
  input sept09 oct09 nov09 jan10 feb10 mar10;

  drop fullstring i;
  retain fullstring 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  do i=1 to 6;
    applicant=cats(applicant,substr(fullstring,ceil(uniform(422)*36),1));
  end;
datalines;
387 . . . 381 .
297 327 . 354 . .
252 . 301 . . 276
. . . . . 398
365 . . . . .
;;;;
proc print data=testmonths;
  title "TEST_MONTHS";
run;

data admission_tests;
  set testmonths;

  array months{6} sept09 oct09 nov09 jan10 feb10 mar10;
  array scores{3} score1-score3;

  drop sept09 oct09 nov09 jan10 feb10 mar10 i j;

  j=1;
  do i=1 to dim(months);
    if months{i} ne . then do;
      scores{j}=months{i};
      j+1;
    end;
  end;

  ntimes=n(of months{*});
  besttest=max(of scores{*});
  besttry=whichn(besttest,of scores {*});
run;
proc print data=admission_tests;
  title "Example 9.7 ADMISSION_TESTS Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 9.7 Related Technique                                           */
/****************************************************************************/
data admission_tests(rename=(sept09=score1 oct09=score2 nov09=score3));
  set testmonths;

  array months{6} sept09 oct09 nov09 jan10 feb10 mar10;
  array scores{3} sept09 oct09 nov09;

  drop jan10 feb10 mar10 i j;

  ntimes=n(of months{*});
  besttest=max(of months{*});

  j=1;
  do i=1 to dim(months);
    if months{i} ne . then do;
      scores{j}=months{i};
      j+1;
    end;
  end;

  besttry=whichn(besttest,of scores{*});
run;
proc print data=admission_tests;
  title "Example 9.7 Related Technique ADMISSION_TESTS Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 9.8                                                             */
/****************************************************************************/
data gen_ids;
  drop i j letters seed pos value;
  length id $ 5;
  retain letters 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
         seed 3713;
  do i=1 to 25;
    id=' ';
    do j=1 to 2;
      pos=ceil(ranuni(seed)*26);
      id=cats(id,char(letters,pos));
    end;
    value=ceil(ranuni(seed)*500)+499;
    substr(id,3)=put(value,3.);
    output;
  end;
run;
proc print data=gen_ids;
  title "Example 9.8 GEN_IDS Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 9.9                                                             */
/****************************************************************************/
data study_pool;
  retain string 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  length studyid $ 6 dob 8 dx_age 3 disease_years 8 duration $ 12;
  format dob mmddyy10.;
  keep studyid dob gender disease_years duration dx_age age;
  do i=1 to 443;
    studyid=' ';
    do j=1 to 2;
      studyid=cats(studyid,substr(string,ceil(uniform(1290)*26),1));
    end;
    studyid=cats(studyid,put(floor(uniform(1281)*1000),z3.));
    studyid=cats(studyid,substr(string,ceil(uniform(1290)*26),1));

    if ceil(uniform(4367)*2)=2 then gender='F';
    else gender='M';

    dob=ceil(uniform(1409)*15493)-5400;
    age=2009-year(dob);
    m=.5;
    dx_age=age-(ceil(ranexp(4353))+ranpoi(4353,m));
    adjust=ceil(uniform(3918)*8);
    if dx_age gt age then dx_age=dx_age-adjust;
    disease_years=age-dx_age;
    if mod(i,2)=1 and 2 le disease_years lt 6 then do;
      adjust=ceil(uniform(39318)*8);
      dx_age=dx_age-adjust;
      disease_years=age-dx_age;
    end;
    if 0 le disease_years lt 2 then duration='early';
    else if 2 le disease_years lt 6 then duration='intermediate';
    else if disease_years ge 6 then duration='late';
    output;
  end;
run;
proc print data=study_pool(obs=20);
  title "STUDY_POOL (first 20 observations)";
run;

proc surveyselect data=study_pool method=srs out=sample25 sampsize=25 seed=2525;
run;
proc print data=sample25;
  title "Example 9.9 SAMPLE25 Data Set Created with PROC SURVEYSELECT";
run;

/****************************************************************************/
/* Example 9.9 Related Technique 1                                          */
/****************************************************************************/
data study_pool2;
  set study_pool;

  random=ranuni(54918);
run;
proc sort data=study_pool2;
  by random;
run;
data sample25;
  set study_pool2(obs=25 drop=random);
run;
proc print data=sample25;
  title "Example 9.9 Related Technique 1 SAMPLE25 Data Set Created with PROC SORT and DATA Step";
run;

/****************************************************************************/
/* Example 9.9 Related Technique 2                                        */
/****************************************************************************/
data sample25;
  set study_pool nobs=total;

  drop k n;
  retain k 25 n;

  if _n_=1 then n=total;

  if ranuni(381705) <= k/n then do;
    output;
    k=k-1;
  end;

  n=n-1;

  if k=0 then stop;
run;
proc print data=sample25;
  title "Example 9.9 Related Technique 2 SAMPLE25 Data Set Created with DATA Step";
run;




/****************************************************************************/
/* Example 9.10                                                            */
/****************************************************************************/
data jingle_winners;
  input contestant $ 1-15 address $ 16-41
        category $ 43-55;
datalines;
Adams BK       Osseo, WI 54758            Energy Bar
Adams OT       Morganfield, KY 42437      Energy Bar
Alexander IE   Columbus, WI 53925         Energy Bar
Allen WN       Norfolk, VA 23518          Sport Drink
Anderson EL    McIntire, IA 50455         Energy Bar
Anderson FW    Reelsville, IN 46171       Energy Bar
Anderson GC    Augusta, ME 04330          Sport Drink
Anderson VU    Greensboro, NC 27416       Sport Drink
Bailey DA      Branson, MO 65615          Protein Shake
Bailey IA      Glen Mills, PA 19342       Sport Drink
Bailey NJ      Dover, OK 73734            Protein Shake
Bailey VI      Atkinson, NE 68713         Protein Shake
Bailey ZO      Fleetwood, PA 19522        Sport Drink
Baker KE       Oxford, MD 21654           Sport Drink
Bell FK        Temple, ME 04984           Sport Drink
Bell MQ        Burdick, KS 66838          Protein Shake
Bennett QB     Mount Enterprise, TX 75681 Protein Shake
Brown FU       Browning, MO 64630         Protein Shake
Brown QD       Catlettsburg, KY 41129     Energy Bar
Brown TF       Carnelian Bay, CA 96140    Protein Shake
Brown TX       Walthourville, GA 31333    Sport Drink
Brown WG       Crenshaw, MS 38621         Energy Bar
Brown ZZ       Tilden, IL 62292           Protein Shake
Campbell ZB    Beaverton, OR 97077        Protein Shake
Carter KC      Antimony, UT 84712         Protein Shake
Clark DA       Cawker City, KS 67430      Protein Shake
Clark DO       Lake Worth, FL 33466       Sport Drink
Collins QN     West Memphis, AR 72303     Protein Shake
Cooper GP      Claudville, VA 24076       Sport Drink
Cooper PM      Jackson, NC 27845          Sport Drink
Cooper RH      Christiana, TN 37037       Energy Bar
Cooper ZK      Kitts Hill, OH 45645       Energy Bar
Cox VO         East Granby, CT 06026      Sport Drink
Cox WB         Albany, CA 94706           Protein Shake
Davis CK       Knotts Island, NC 27950    Sport Drink
Davis TC       White Owl, SD 57792        Energy Bar
Davis VH       Ten Mile, TN 37880         Energy Bar
Diaz DS        Walker, SD 57659           Energy Bar
Edwards SX     Bosler, WY 82051           Protein Shake
Edwards YA     Milton, PA 17847           Sport Drink
Evans CH       Sacramento, CA 94204       Protein Shake
Evans LW       Washington, DC 20535       Sport Drink
Flores HO      Munford, TN 38058          Energy Bar
Flores TE      False Pass, AK 99583       Protein Shake
Flores ZA      Patten, ME 04765           Sport Drink
Garcia FR      Aimwell, LA 71401          Protein Shake
Garcia IK      West Poland, ME 04291      Sport Drink
Garcia IW      Springwater, NY 14560      Sport Drink
Garcia NG      Dover, NH 03821            Sport Drink
Gonzales NK    Dryden, TX 78851           Protein Shake
Gonzalez XF    Las Vegas, NV 89157        Protein Shake
Green DN       Seattle, WA 98111          Protein Shake
Green KX       Milwaukee, WI 53220        Energy Bar
Hall AT        Yale, MI 48097             Energy Bar
Harris EL      Le Grand, IA 50142         Energy Bar
Harris EQ      Wesley, IA 50483           Energy Bar
Harris FP      Royse City, TX 75189       Protein Shake
Harris ZU      Shreveport, LA 71152       Protein Shake
Hayes RA       Lower Brule, SD 57548      Energy Bar
Hayes XH       Decatur, IL 62526          Protein Shake
Hernandez GB   Scott, MS 38772            Energy Bar
Hernandez GK   Fort Myers, FL 33908       Energy Bar
Hernandez GS   St. Louis, MO 63115        Protein Shake
Hill LH        Sherrill, AR 72152         Protein Shake
Hill TE        Orlando, FL 32898          Sport Drink
Hill VM        Chardon, OH 44024          Energy Bar
Howard SX      Shellsburg, IA 52332       Energy Bar
Howard YA      Grand Rapids, MI 49516     Energy Bar
Jackson AO     Newville, AL 36353         Energy Bar
Jackson CP     New Kingstown, PA 17072    Sport Drink
Jackson FG     Mount Sherman, KY 42764    Energy Bar
Jackson OP     Durand, MI 48429           Energy Bar
Jackson SP     Freedom, NY 14065          Sport Drink
Jackson WO     Gulf Breeze, FL 32562      Sport Drink
James JW       Higginsville, MO 64037     Protein Shake
James QB       North Charleston, SC 29420 Sport Drink
Jenkins CZ     Adel, IA 50003             Energy Bar
Johnson BT     Alexandria, SD 57311       Energy Bar
Johnson CJ     Edmonton, KY 42129         Energy Bar
Johnson CN     Walston, PA 15781          Sport Drink
Johnson HK     Velma, OK 73491            Protein Shake
Johnson JD     Coolidge, TX 76635         Protein Shake
Johnson TS     Colts Neck, NJ 07722       Sport Drink
Johnson VB     Glen Ellyn, IL 60137       Energy Bar
Johnson WG     Ruby Valley, NV 89833      Protein Shake
Johnson XJ     Larkspur, CO 80118         Protein Shake
Johnson YW     Avis, PA 17721             Sport Drink
Johnson ZC     Suffield, CT 06078         Sport Drink
Jones IH       Belleville, IL 62222       Protein Shake
Jones IL       Pontotoc, MS 38863         Energy Bar
Jones LM       Omaha, NE 68175            Protein Shake
Jones TJ       Ipava, IL 61441            Protein Shake
Jones WQ       Milton, WV 25541           Sport Drink
Kelly FL       Bird City, KS 67731        Protein Shake
King FT        Rockford, IL 61103         Energy Bar
King TL        Henderson Harbor, NY 13651 Sport Drink
Lee DY         Mingus, TX 76463           Protein Shake
Lee JJ         Garrison, UT 84728         Protein Shake
Lee RP         Bowden, WV 26254           Sport Drink
Lee WP         Edgecomb, ME 04556         Sport Drink
Lee ZY         Westmoreland City, PA 1569 Sport Drink
Lewis FP       Starkville, MS 39759       Energy Bar
Lewis JA       Kansas City, MO 64112      Protein Shake
Lewis QL       Pontiac, MI 48340          Energy Bar
Lewis RE       Imperial, MO 63052         Protein Shake
Lewis SY       San Jose, CA 95135         Protein Shake
Long FJ        Panama City, FL 32404      Sport Drink
Long OY        Villamont, VA 24178        Sport Drink
Martin HV      Schiller Park, IL 60176    Energy Bar
Martin IZ      Dallas, TX 75379           Protein Shake
Martin VJ      New Baden, TX 77870        Protein Shake
Miller IC      Vadnais Heights, MN 55127  Energy Bar
Miller IW      Smithville, TN 37166       Energy Bar
Miller OF      Omaha, NE 68137            Protein Shake
Miller PE      Point Lookout, MO 65726    Protein Shake
Miller PW      Wichita, KS 67220          Protein Shake
Miller QE      Clinton, MI 49236          Energy Bar
Miller QG      Shirley, AR 72153          Protein Shake
Miller SD      Sacramento, CA 94284       Protein Shake
Miller SV      Hanover, PA 17333          Sport Drink
Miller SZ      Ferriday, LA 71334         Protein Shake
Miller VG      St. Leonard, MD 20685      Sport Drink
Miller VV      Wasilla, AK 99687          Protein Shake
Miller XY      Monrovia, IN 46157         Energy Bar
Moore AH       Twin Brooks, SD 57269      Energy Bar
Moore GG       San Rafael, CA 94903       Protein Shake
Moore SR       Lewisville, TX 75077       Protein Shake
Morgan MN      Lawrenceville, GA 30043    Sport Drink
Morris KI      Omaha, NE 68197            Protein Shake
Morris LI      Wamego, KS 66547           Protein Shake
Morris NS      Dover, DE 19903            Sport Drink
Nelson MS      Judson, TX 75660           Protein Shake
Nelson UQ      Opheim, MT 59250           Energy Bar
Nelson XS      Mc Clellandtown, PA 15458  Sport Drink
Parker EJ      Marble, PA 16334           Sport Drink
Parker ET      Williams, MN 56686         Energy Bar
Parker GK      Absecon, NJ 08201          Sport Drink
Patterson QV   Bellevue, WA 98015         Protein Shake
Perez GY       Redding, CA 96099          Protein Shake
Perry HC       Prescott, IA 50859         Energy Bar
Phillips GX    Lindley, NY 14858          Sport Drink
Phillips RQ    Miami Beach, FL 33239      Sport Drink
Powell NY      Kirby, AR 71950            Protein Shake
Price JK       Concord, NC 28025          Sport Drink
Ramirez QF     Sparks, NV 89435           Protein Shake
Reed BZ        San Juan Pueblo, NM 87566  Protein Shake
Richardson QY  Sparkill, NY 10976         Sport Drink
Richardson XQ  Lonedell, MO 63060         Protein Shake
Rivera BK      West Willow, PA 17583      Sport Drink
Rivera JT      Bath, OH 44210             Energy Bar
Robinson CL    Lincoln, NE 68522          Protein Shake
Robinson HV    Westover, PA 16692         Sport Drink
Robinson IK    Cushing, MN 56443          Energy Bar
Robinson KO    Auburn, NY 13021           Sport Drink
Robinson VA    Ionia, MO 65335            Protein Shake
Rodriguez JK   Faribault, MN 55021        Energy Bar
Rodriguez QQ   Minidoka, ID 83343         Protein Shake
Rodriguez UX   Plymouth, NC 27962         Sport Drink
Rodriguez XA   Frankford, MO 63441        Protein Shake
Rodriguez ZV   Richards, TX 77873         Protein Shake
Sanchez DJ     Geronimo, TX 78115         Protein Shake
Sanders EV     Mount Summit, IN 47361     Energy Bar
Scott HC       Ottawa, WV 25149           Sport Drink
Scott UZ       Dalton, GA 30721           Sport Drink
Simmons RU     Fernandina Beach, FL 32035 Sport Drink
Smith AS       Raleigh, NC 27617          Sport Drink
Smith BN       Dauphin, PA 17018          Sport Drink
Smith EQ       Fort Thomas, AZ 85536      Protein Shake
Smith HQ       Newtonville, MA 02460      Sport Drink
Smith LE       Centerville, AR 72829      Protein Shake
Smith TM       Camp, AR 72520             Protein Shake
Smith UC       Raymond, IA 50667          Energy Bar
Smith UL       Minden, WV 25879           Sport Drink
Smith UM       Topeka, KS 66607           Protein Shake
Smith XF       Kansas City, MO 64118      Protein Shake
Taylor JF      St. Marys City, MD 20686   Sport Drink
Taylor KV      Goddard, KS 67052          Protein Shake
Thomas GM      Sulphur Rock, AR 72579     Protein Shake
Thomas MA      Drewryville, VA 23844      Sport Drink
Thomas OF      New York, NY 10003         Sport Drink
Thompson EC    Dallas, TX 75301           Protein Shake
Thompson EV    Valley Springs, AR 72682   Protein Shake
Thompson NL    Northville, SD 57465       Energy Bar
Thompson NP    Sacramento, CA 95813       Protein Shake
Thompson YV    Allison Park, PA 15101     Sport Drink
Torres JA      Ashland, KY 41101          Energy Bar
Torres JL      Lacey, WA 98503            Protein Shake
Torres KL      North Easton, MA 02357     Sport Drink
Walker ZD      Fulton, MD 20759           Sport Drink
Ward EN        Elberfeld, IN 47613        Energy Bar
Ward PP        Turtle Creek, PA 15145     Sport Drink
Washington FG  Kingston, PA 18704         Sport Drink
Washington NV  Tampa, FL 33672            Sport Drink
Watson UY      Salem, OR 97302            Protein Shake
White QU       San Diego, CA 92179        Protein Shake
White RV       Arona, PA 15617            Sport Drink
White SK       Culpeper, VA 22701         Sport Drink
Williams KX    Portland, OR 97202         Protein Shake
Williams ND    Mobile, AL 36663           Energy Bar
Williams OO    Los Alamitos, CA 90720     Protein Shake
Williams PY    Lowber, PA 15660           Sport Drink
Wilson KD      Oscar, OK 73561            Protein Shake
Wilson OX      Camden, NJ 08105           Sport Drink
Wood GJ        Betsy Layne, KY 41605      Energy Bar
Wright BR      Silver Star, MT 59751      Energy Bar
Wright ES      Coquille, OR 97423         Protein Shake
Wright MC      Spring Grove, MN 55974     Energy Bar
Young KZ       North Lake, WI 53064       Energy Bar
;;;;
proc print data=jingle_winners(obs=30);
  title "JINGLE_WINNERS (first 30 observations)";
run;
proc freq data=jingle_winners;
  title "JINGLE_WINNERS";
  tables category;
run;
proc sort data=jingle_winners;
  by category;
run;
proc surveyselect data=jingle_winners out=grandprizes
                   method=srs reps=2 sampsize=5 seed=65;
  strata category;
run;
proc print data=grandprizes;
  title "Example 9.10 GRANDPRIZES Data Set Created with PROC SURVEYSELECT";
run;
proc freq data=grandprizes;
  tables category*replicate/list;
run;

/****************************************************************************/
/* Example 9.10 Related Technique                                          */
/****************************************************************************/
data winners2;
  set jingle_winners;

  rn=ranuni(6209193);
run;
proc sort data=winners2;
  by category rn;
run;
data grandprizes;
  set winners2;
  by category;

  drop count rn;

  if first.category then count=0;

  count+1;

  if count le 5 then replicate=1;
  else replicate=2;

  if count le 10 then output;
run;
proc print data=grandprizes;
  title "Example 9.10 Related Technique GRANDPRIZES Data Set Created with PROC SORT and DATA Step";
run;
proc freq data=grandprizes;
  tables category*replicate/list;
run;





/****************************************************************************/
/* Example 9.11                                                            */
/****************************************************************************/
data oct2009_orders;
  length customerid $ 6 orderid $ 6;
  input order_day order_time time5. +1 ship_date mmddyy10. +1
        ship_hour;

  format ship_date mmddyy10. order_time time5.;
  keep customerid orderid order_day order_time ship_date ship_hour;

  retain fullstring 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  do i=1 to 6;
    customerid=cats(customerid,substr(fullstring,ceil(uniform(90010+_n_)*36),1));
  end;
  orderid=cats(orderid,substr(fullstring,ceil(uniform(90010+_n_)*26),1));
  do i=2 to 6;
    orderid=cats(orderid,substr(fullstring,ceil(uniform(90010+_n_)*10)+26,1));
  end;
datalines;
22 23:04 10/24/2009 7
25 07:25 10/25/2009 18
26 15:42 10/30/2009 9
26 15:58 10/27/2009 12
28 14:03 10/30/2009 14
29 10:53 10/29/2009 15
29 16:14 10/31/2009 8
30 08:13 11/01/2009 19
;;;
proc print data=oct2009_orders;
  title "OCT2009_ORDERS";
run;
data order_stats;
  set oct2009_orders;

  format ordered shipped datetime19.;
  keep customerid orderid ordered shipped prephours;

  ordered=dhms(mdy(10,order_day,2009),0,0,order_time);
  shipped=dhms(ship_date,ship_hour,0,0);

  prephours=intck('hour',ordered,shipped);
run;
proc print data=order_stats;
  title "Example 9.11 ORDER_STATS Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 9.12                                                            */
/****************************************************************************/
data incidents;
  input location $ type $ 8-18 in_noted $ 20-30 resp_noted $ 32-42;
datalines;
SW009A Surge       33.49       38.01
N0003Q Drop        9:13.69     12:15.02
ESE01C Transformer 8:00:00.33  10:21:06.43
NW503K Linkage     9:31:09.    10:18:18.
ESE01D Transformer 13:00:00.33 14:48:32.08
;;;
proc print data=incidents;
  title "INCIDENTS";
run;

proc format;
  picture timechar other='99:99:99.99';
run;
data incident_times;
  set incidents;

  drop temp1 temp2 i;
  format time_in time_resp time11.2;

  array noted{2} $ in_noted resp_noted;
  array times{2} time_in time_resp;

  do i=1 to dim(noted);

    temp1=compress(noted{i},':');
    temp2=put(input(temp1,11.2),timechar.);
    times{i}=input(temp2,time11.);
  end;
run;
proc print data=incident_times;
  title "Example 9.12 INCIDENT_TIMES Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 9.13                                                            */
/****************************************************************************/
data march_hires;
  input name $ 1-13 @16 dob mmddyy10.;
  format dob worddate20.;
datalines;
JK Allen       03/01/1972
RT Brown       02/28/1980
WI Carter      03/29/1980
LG Johnson     03/01/1980
MH Johnson     12/12/1980
PO Phillips    02/14/1971
TR Smith       11/09/1967
AG Rodriguez   07/02/1955
EW Washington  07/30/1960
NA Young       04/22/1984
;;;;
proc print data=march_hires;
  title "MARCH_HIRES";
run;
data hireage;
  set march_hires;

  retain hiredate '01mar2009'd;
  format hiredate mmddyy10.;

  age=floor((intck('month',dob,hiredate) -
       (day(hiredate) < day(dob)))/12);
run;
proc print data=hireage;
  title "Example 9.13 HIREAGE Data Set Created with DATA Step";
run;

/****************************************************************************/
/* Example 9.13 A Closer Look                                              */
/****************************************************************************/
data twoages;
  set march_hires;

  retain hiredate '01mar2009'd;
  format hiredate mmddyy10.;

  age=floor((intck('month',dob,hiredate) -
       (day(hiredate) < day(dob)))/12);

  age_notacc=floor((hiredate-dob)/365.25);
run;
proc print data=twoages;
  title "Example 9.18 A Closer Look TWOAGES Data Set";
run;


/****************************************************************************/
/* Example 9.14                                                            */
/****************************************************************************/
data sched_appts;
  length patient $ 4 apptdate 8 interval $ 9 units nappts 8 alignment $ 9;
  infile datalines missover;
  input patient $ @6 apptdate mmddyy10. interval $ units nappts alignment $;
  format apptdate weekdate17.;
datalines;
CVM4 02/20/2008 week  1 3 same
JD3A 01/25/2008 week2 1 3 same
QI1U 02/05/2008 week 10 2 same
W23V 01/21/2008 weekday 10 2 same
AB5U 01/30/2008 month 1 2 same
PO6I 02/15/2008 month 7 1
JA1L 02/15/2008 month 6 1 end
U21B 02/15/2008 semiyear 1 1
TN62 01/10/2008 qtr 1 3
;;;
proc print data=sched_appts;
  title "SCHED_APPTS";
run;
data next_appts;
  set sched_appts;
  keep patient apptdate nextappt1-nextappt3;

  array allappts{*} apptdate nextappt1-nextappt3;
  format nextappt1-nextappt3 mmddyy10.;

  if alignment=' ' then alignment='beginning';

  do i=1 to nappts;
    allappts{i+1}=intnx(interval,allappts{i},units,alignment);
  end;
run;
proc print data=next_appts;
  title "Example 9.14 NEXT_APPTS Data Set Created with DATA Step";
  format nextappt1-nextappt3 weekdate17.;
run;

/****************************************************************************/
/* Example 9.14 A Closer Look                                              */
/****************************************************************************/
data _null_;
  date1=intnx('months','29mar2008'd,3,'same');
  date2=intnx('months3','29mar2008'd,1,'same');
  date3=intnx('qtr','29mar2008'd,1,'same');
  put (date1 date2 date3 ) (=mmddyy10.);
run;
data _null_;
  date1=intnx('months','29mar2008'd,3);
  date2=intnx('months3','29mar2008'd,1);
  date3=intnx('qtr','29mar2008'd,1);
  put (date1 date2 date3 ) (=mmddyy10.);
run;


/****************************************************************************/
/* Example 9.15                                                            */
/****************************************************************************/
data day_ranges;
  input day1 mmddyy10. +1 day2 mmddyy10.;

  format day1 day2 mmddyy10.;
datalines;
07/01/2008 07/05/2008
06/23/2008 06/27/2008
05/19/2008 05/19/2009
04/01/2008 04/05/2011
01/23/2009 01/25/2009
;;;
proc print data=day_ranges;
  title "DAY_RANGES";
run;
data business_days;
  set day_ranges;
  array holiday_list{6} $ 25 _temporary_
     ('NEWYEAR','MEMORIAL','USINDEPENDENCE','LABOR',
      'THANKSGIVING','CHRISTMAS');

  drop i y;

  totaldays=intck('days',day1,day2);
  workdays=intck('weekday',day1,day2);
  holidays=0;

  do y=year(day1) to year(day2);
    do i=1 to dim(holiday_list);
      if (day1 le holiday(holiday_list{i},y) le day2) then do;
        holidays=holidays+1;
        if (2 le weekday(holiday(holiday_list{i},y)) le 6) then workdays=workdays-1;
      end;
    end;
  end;
run;
proc print data=business_days;
  title "Example 9.15 BUSINESS_DAYS Data Set Created with DATA Step";
run;



/****************************************************************************/
/* Example 9.16                                                             */
/****************************************************************************/
data quiz_grades;
  infile datalines truncover;
  input student $3. quiz_string $50.;
datalines;
431 B+,B-,A,I,A+
501 A,A,B,P,C,U,F
289 A,A,B,A,A-,U
130 C+,B-,I,?,W
;;;;
proc print data=quiz_grades;
  title "QUIZ_GRADES";
run;
data quiz_summary;
  set quiz_grades;

  n_quizzes=countw(quiz_string,',');
  super=count(quiz_string,'A+');
  good=countc(quiz_string,'AB')-super;
  fair=countc(quiz_string,'C');
  bad=countc(quiz_string,'UF');
  no_grades=countc(quiz_string,'IW');
  invalid=n_quizzes-super-good-fair-bad-no_grades;
run;
proc print data=quiz_summary;
  title "Example 9.16 QUIZ_SUMMARY Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 9.17                                                            */
/****************************************************************************/
data workplace;
  infile datalines truncover;
  input comments $60.;
datalines;
Cannot discuss work-related issues with my supervisor.
Need flex scheduling&job-sharing options.
Add closer parking areas.
Love the cafeteria
More programs for career advancement
Mentoring? Coaching? Either available?
;;;;
proc print data=workplace;
  title "WORKPLACE";
run;
data trunc_comments;
  set workplace;
  length truncated $ 25;

  keep comments truncated;

  colpunct=anypunct(comments,-25);
  colblank=anyspace(comments,-25);
  cutcol=largest(1,colpunct,colblank);
  truncated=substr(comments,1,cutcol);
run;
proc print data=trunc_comments;
  title "Example 9.17 TRUNC_COMMENTS Data Set Created with DATA Step";
run;




/****************************************************************************/
/* Example 9.18                                                            */
/****************************************************************************/
data lcwords;
  input lcword : $50. @@;
datalines;
a an the at by for in of on to up and as but it or nor
;;;
proc print data=lcwords;
  title "LCWORDS";
run;
data unedited_titles;
  input titletext $80.;
datalines;
of interest to all
up at the crack of dawn
the best of ?
anything but...
OUTSIDE-IN and INSIDE-OUT
;;;;
proc print data=unedited_titles;
  title "UNEDITED_TITLES";
run;
data edited_titles;
  set unedited_titles;

  length lcword temp $ 50 proptitletext edited_title $ 80;
  keep titletext proptitletext edited_title;
  if _n_=1 then do;
    declare hash lc(dataset: 'work.lcwords');
    lc.definekey('lcword');
    lc.definedata('lcword');
    lc.definedone();
    call missing(lcword);
  end;

  nwords=countw(trim(titletext),' ');
  proptitletext=propcase(titletext);

  do i=1 to nwords;
    temp=scan(proptitletext,i,' ');
    if i ne 1 and i ne nwords and lc.check(key:lowcase(temp))=0
      then edited_title=catx(' ',edited_title,lowcase(temp));
    else edited_title=catx(' ',edited_title,temp);
  end;
run;
proc print data=edited_titles;
  title "Example 9.18 EDITED_TITLES Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 9.18 Related Technique                                          */
/****************************************************************************/
proc sql noprint;
  select quote(trim(lcword))
    into :lcwords separated by ','
    from lcwords;
quit;
data edited_titles;
  set unedited_titles;

  length temp $ 50 proptitletext edited_title $ 80;
  keep titletext proptitletext edited_title;

  nwords=countw(trim(titletext),' ');
  proptitletext=propcase(titletext);

  do i=1 to nwords;
    temp=scan(proptitletext,i,' ');
    if i ne 1 and i ne nwords and lowcase(temp) in (&lcwords)
      then edited_title=catx(' ',edited_title,lowcase(temp));
    else edited_title=catx(' ',edited_title,temp);
  end;
run;
proc print data=edited_titles;
  title "Example 9.18 Related Technique EDITED_TITLES Data Set Created with DATA Step";
run;


/****************************************************************************/
/* Example 9.19                                                           */
/****************************************************************************/
data newcontacts;
  input contactname $ 1-20 contactphone $ 22-35 contactemail $ 37-69;
datalines;
Young Wilson, Karen  (315) 555-3210 karen.young.wilson@big-agency.gov
Denise M. Morris     (607)555-0123  denise morris@college.edu
Bonita Ann Henderson 920-555-6719   bahenderson@college3.eud
Brown, Anne-Marie    9255554031     amb!1@more.net
Butler, L. William   612--555-7171  lbb_@state.info.gov
Davis-Lee, Kim       111-555-4444   K.D-L@business.edu
Joseph Mitchell      (505)555-5432  joe_mitch@allwork.com
Sanchez,   R. T.     334   5551234  sanc001@schooledu
;;;
proc print data=newcontacts;
  title "NEWCONTACTS";
run;

data contacts_edited;
  set newcontacts;

  retain name_rx phone_rx email_rx;
  drop name_rx phone_rx email_rx
       areacode prefix extension;

  if _n_=1 then do;
    name_rx=prxparse('s/([a-z]+[-.a-z\s]+),\s*([a-z][-.a-z\s]+)/\2 \1/i');
    phone_rx=prxparse("/\(?([2-9]\d\d)\)?\s*-?\s*([2-9]\d\d)\s*-?\s*(\d{4})/");
    email_rx=prxparse("/(\w+[.-\w]*)@(\w+[.-\w]*)\.(gov|com|edu|net)/i");
  end;

  contactname=prxchange(name_rx,-1,trim(contactname));

  if prxmatch(phone_rx,contactphone) then do;
    areacode=prxposn(phone_rx,1,contactphone);
    prefix=prxposn(phone_rx,2,contactphone);
    extension=prxposn(phone_rx,3,contactphone);
    contactphone=cats('(',areacode,')',prefix,'-',extension);
  end;
  else contactphone='**Invalid**';

  if prxmatch(email_rx,contactemail)^=1 then contactemail='**Invalid**';

run;
proc print data=contacts_edited;
  title "Example 9.19 CONTACTS_EDITED Data Set Created with DATA Step";
run;
/*************** END CHAPTER 9**********************************************/
