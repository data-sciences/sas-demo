/*******************************************************************************/
/*******************************************************************************/
/* Start Chapter 1                                                             */
/*******************************************************************************/
ods rtf file="output1_1a.rtf" style=analysis;
proc print data=emphours;
  title "EMPHOURS";
run;
ods rtf close;
ods rtf file="output1_1b.rtf" style=analysis;
proc print data=employees(obs=20);
  title "EMPLOYEES";
run;
ods rtf close;
/**************************/
/* Example 1.1            */
/**************************/
proc sort data=emphours;
  by empid;
run;
proc sort data=employees;
  by empid;
run;
data empnames;
  merge emphours(in=inhours)
        employees(keep=empid empln empfn empmi in=inall);
    by empid;
  length empname $ 60;
  if inhours;
  if inall then empname=catx(' ',empfn,empmi,empln);
  else empname='** Not Found';
run;
/**************************/
/* Example 1.2            */
/**************************/
data empnames;
  length empid $ 6 empln $ 30 empfn $ 25 empmi $ 1 empname $ 60;

  if _n_=1 then do;
    declare hash e(dataset: 'employees(where=(emppaylevel=:"A")');

    e.definekey('empid');

    e.definedata('empln','empfn','empmi');
    e.definedone();

    call missing(empln,empfn,empmi);
  end;

  set emphours;
  drop rc;

  rc=e.find();

  if rc=0 then empname=catx(' ',empfn,empmi,empln);
  else empname='** Not Found';

run;
/*******************************************************************************/
/* End Chapter 1                                                               */
/*******************************************************************************/
/*******************************************************************************/

/*******************************************************************************/
/*******************************************************************************/
/* Start Chapter 2                                                             */
/*******************************************************************************/
/**************************/
/* Example 2.2            */
/**************************/
data _null_;
  attrib empid length=$6
         empln length=$30
         empfn length=$25
         empmi length=$1
         startdate length=8 format=mmddyy10.
         empyears length=8 label='Number of years worked'
         yearscat length=$10 label='Years worked category';

  if _n_=1 then do;
    declare hash years(ordered: 'yes');
    years.definekey('yearscat','empln','empfn','empmi');
    years.definedata('empid','empln','empfn','empmi','empyears','yearscat');
    years.definedone();
    call missing(empid,empln,empfn,empmi,startdate,empyears,yearscat);
  end;

  set employees end=eof;

  empyears=ceil(('31dec2012'd-startdate)/365.25);

  if empyears ge 10;

  if 10 le empyears lt 15 then yearscat='10+ years';
  else if 15 le empyears lt 20 then yearscat='15+ years';
  else if 20 le empyears lt 25 then yearscat='20+ years';
  else if empyears ge 25 then yearscat='25+ years';

  rc=years.add();

  if eof then rc=years.output(dataset: 'emps10plus');
run;
ods rtf file="output2_1.rtf" style=analysis;
proc print data=emps10plus(obs=10);
  title "EMPS10PLUS";
run;
ods rtf close;

/**************************/
/* Example 2.3            */
/**************************/
ods rtf file="output2_2.rtf" style=analysis;
proc print data=confrooms;
  title "CONFROOMS";
run;
ods rtf close;
ods rtf file="output2_3.rtf" style=analysis;
proc print data=roomschedule;
  title "ROOMSCHEDULE";
run;
ods rtf close;
ods rtf file="output2_4.rtf" style=analysis;
proc print data=roomschedule2;
  title "ROOMSCHEDULE2";
run;
ods rtf close;
data pdvck1;
  if _n_=1 then do;
    declare hash cr(dataset: 'confrooms');
    cr.definekey('roomid');
    cr.definedata('roomno','floor','building','capacity');
    cr.definedone();
  end;

  set roomschedule;
  rc=cr.find();

  put _all_;
run;

/**************************/
/* Example 2.4            */
/**************************/
data pdvck2;
  attrib roomno   length=8
         floor    length=$2
         building length=$20
         capacity length=8;
  if _n_=1 then do;
    declare hash cr(dataset: 'confrooms');
    cr.definekey('roomid');
    cr.definedata('roomno','floor','building','capacity');
    cr.definedone();

    call missing(roomno,floor,building,capacity);
  end;
  set roomschedule;
  rc=cr.find();

  put _all_;
run;

/**************************/
/* Example 2.5            */
/**************************/
data pdvck3;
  attrib roomno   length=8
         floor    length=$2
         building length=$20
         capacity length=8;
  if _n_=1 then do;
    declare hash cr(dataset: 'confrooms');
    cr.definekey('roomid');
    cr.definedata('roomno','floor','building','capacity');
    cr.definedone();

    call missing(roomno,floor,building,capacity);
  end;
  set roomschedule2;
  rc=cr.find();

  put _all_;
run;

/**************************/
/* Example 2.6            */
/**************************/
data pdvck4;
  attrib roomid length=$5;

  declare hash cr(dataset: 'confrooms');
  cr.definekey('roomid');
  cr.definedone();

  call missing(roomid);

  rc=cr.check(key: 'C0P01');
  put 'CHECK 1: ' _all_;
  rc=cr.check(key: 'D0110');
  put 'CHECK 2: ' _all_;
run;

/**************************/
/* Example 2.7            */
/**************************/
data pdvck5;
  if _n_=0 then set confrooms;

  if _n_=1 then do;
    declare hash cr(dataset: 'confrooms');
    cr.definekey('roomid');
    cr.definedata('roomno','floor','building','capacity');
    cr.definedone();

  end;
  set roomschedule2;
  rc=cr.find();

  put _all_;
run;

/**************************/
/* Example 2.8            */
/**************************/
data pdvck6;
  if _n_=0 then set confrooms;

  if _n_=1 then do;
    declare hash cr(dataset: 'confrooms');
    cr.definekey('roomid');
    cr.definedata('roomno','floor','building','capacity');
    cr.definedone();

  end;
  set roomschedule2;
  rc=cr.find();
  if rc ne 0 then call missing(roomno,floor,building,capacity);

  put _all_;
run;


/*******************************************************************************/
/* End Chapter 2                                                               */
/*******************************************************************************/
/*******************************************************************************/


/*******************************************************************************/
/*******************************************************************************/
/* Start Chapter 3                                                             */
/*******************************************************************************/
ods rtf file="output3_1.rtf" style=analysis;
proc print data=codelookup;
  title "CODELOOKUP";
run;
ods rtf close;

/*******************************************/
/* Example 3.1                             */
/*******************************************/
data updates1;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash hashsource(dataset: 'codelookup',ordered: 'y');
  hashsource.definekey('code');
  hashsource.definedata('code','codedesc','codedate');
  hashsource.definedone();

  call missing(code,codedesc,codedate);

  code='AB871K';
  codedesc='Debit';
  codedate='15feb2013'd;
  rc=hashsource.find();
  output;
  code='GG401P';
  codedesc='Credit';
  codedate='23feb2013'd;
  rc=hashsource.find();
  output;
run;
ods rtf file="output3_2.rtf" style=analysis;
proc print data=updates1;
  title "UPDATES1";
run;
ods rtf close;


/*******************************************/
/* Example 3.2                             */
/*******************************************/
data updates2;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash hashsource(dataset: 'codelookup',ordered: 'y');
  hashsource.definekey('code');
  hashsource.definedata('code','codedesc','codedate');
  hashsource.definedone();

  call missing(code,codedesc,codedate);

  code='AB871K';
  codedesc='Debit';
  codedate='15feb2013'd;
  rc=hashsource.check();
  output;
  code='GG401P';
  codedesc='Credit';
  codedate='23feb2013'd;
  rc=hashsource.check();
  output;
run;
ods rtf file="output3_3.rtf" style=analysis;
proc print data=updates2;
  title "UPDATES2";
run;
ods rtf close;

/*******************************************/
/* Example 3.3                             */
/*******************************************/
data updates3;
  attrib code length=$6
         codedesc length=$25
         codedesc_hash length=$25
         codedate length=8 format=mmddyy10.
         codedate_hash length=8 format=mmddyy10.;

  declare hash hashsource(dataset: 'codelookup(rename=
             (codedesc=codedesc_hash codedate=codedate_hash))',ordered: 'y');
  hashsource.definekey('code');
  hashsource.definedata('code','codedesc_hash','codedate_hash');
  hashsource.definedone();
  call missing(code,codedesc_hash,codedate_hash);

  code='AB871K';
  codedesc='Debit';
  codedate='15feb2013'd;
  rc=hashsource.find();
  output;
  code='GG401P';
  codedesc='Credit';
  codedate='23feb2013'd;
  rc=hashsource.find();
  output;
run;
ods rtf file="output3_4.rtf" style=analysis;
proc print data=updates3;
  title "UPDATES3";
run;
ods rtf close;

/*******************************************/
/* Example 3.4                             */
/*******************************************/
ods rtf file="output3_5.rtf" style=analysis;
proc print data=patient_history(obs=15);
  title "PATIENT_HISTORY";
run;
ods rtf close;
ods rtf file="output3_6.rtf" style=analysis;
proc print data=patients_today(obs=15);
  title "PATIENTS_TODAY";
run;
ods rtf close;
data needs_update;
  if _n_=1 then do;
    declare hash
        histdates(dataset: "patient_history(
                                  where=(pthistdate ge '09jul2012'd)");
    histdates.definekey('ptid');
    histdates.defineDone();
  end;

  set patients_today;
  drop rc;

  rc=histdates.check();

  if rc ne 0 then output needs_update;
run;
ods rtf file="output3_7.rtf" style=analysis;
proc print data=needs_update;
  title "NEEDS_UPDATE";
run;
ods rtf close;

/*******************************************/
/* Example 3.5                             */
/*******************************************/
/* Output 3.8 is same as output 1.1a */
/* Output 3.9 is same as output 1.1b */
data empinfo;
  attrib empln length=$30 label='Employee Last Name'
         empfn length=$25 label='Employee First Name'
         empmi length=$1  label='Employee Middle Initial'
         emppaylevel length=$4  label='Pay level';

  if _n_=1 then do;
    declare hash emp(dataset: "employees");
    emp.definekey('empid');
    emp.definedata('empln','empfn','empmi','emppaylevel');
    emp.definedone();
    call missing(empln, empfn, empmi, emppaylevel);
  end;

  set emphours;

  rc=emp.find();
run;
ods rtf file="output3_10.rtf" style=analysis;
proc print data=empinfo;
  title "EMPINFO";
run;
ods rtf close;

/*******************************************/
/* Example 3.6                             */
/*******************************************/
ods rtf file="output3_11.rtf" style=analysis;
proc print data=prizewinners;
  title "PRIZEWINNERS";
run;
ods rtf close;
ods rtf file="output3_12.rtf" style=analysis;
proc print data=prizecatalog;
  title "PRIZECATALOG";
run;
ods rtf close;
data prizelist;
  keep winnername age prize;
  attrib winnername length=$20 label='Patient Name'
         prizecode length=$8 label='Prize Code'
         prize length=$40 label='Prize Description';
  if _n_=1 then do;
    declare hash p(dataset:'prizecatalog');
    p.defineKey('prizecode');
    p.defineData('prize');
    p.defineDone();
    call missing(prize);
  end;

  set prizewinners;

  if upcase(prizetype) ne 'CLASS' then do;
    if age ge 18 then
          prizecode=cats('A',upcase(prizetype),put(prizelevel,1.));
    else if age ne . then
          prizecode=cats('C',upcase(prizetype),put(prizelevel,1.));
  end;
  else prizecode=cats(upcase(prizetype),put(prizelevel,1.));

  rc=p.find();
  if rc ne 0 then prize=catx(' ',"*** Unknown Prize Code:",prizecode);
run;
ods rtf file="output3_13.rtf" style=analysis;
proc print data=prizelist;
  title "PRIZELIST";
run;
ods rtf close;

/*******************************************/
/* Example 3.7                             */
/*******************************************/
ods rtf file="output3_14a.rtf" style=analysis;
proc print data=doctors_southside;
  title "DOCTORS_SOUTHSIDE";
run;
ods rtf close;
ods rtf file="output3_14b.rtf" style=analysis;
proc print data=doctors_maplewood;
  title "DOCTORS_MAPLEWOOD";
run;
ods rtf close;
ods rtf file="output3_14c.rtf" style=analysis;
proc print data=doctors_midtown;
  title "DOCTORS_MIDTOWN";
run;
ods rtf close;
ods rtf file="output3_15.rtf" style=analysis;
proc print data=doctorlist;
  title "DOCTORLIST";
run;
ods rtf close;
data multworklocs noworkloc;
  if _n_=1 then do;
    declare hash ss(dataset: "doctors_southside");
    ss.definekey('empid');
    ss.definedone();

    declare hash mw(dataset: "doctors_maplewood");
    mw.definekey('empid');
    mw.definedone();

    declare hash mt(dataset: "doctors_midtown");
    mt.definekey('empid');
    mt.definedone();
  end;

  drop ssrc mwrc mtrc nlocs;

  set doctorlist;

  attrib location_list length=$50 label='Employee Work Locations';

  ssrc=ss.check();
  mwrc=mw.check();
  mtrc=mt.check();

  nlocs=(ssrc=0) + (mwrc=0) + (mtrc=0);

  if nlocs ge 2 then do;
    if ssrc=0 then location_list="Southside";
    if mwrc=0 then location_list=catx(',',location_list,"Maplewood");
    if mtrc=0 then location_list=catx(',',location_list,"Midtown");
    output multworklocs;
  end;
  else if nlocs=0 then do;
    location_list="**Not at Southside, Maplewood, or Midtown";
    output noworkloc;
  end;
run;
ods rtf file="output3_16.rtf" style=analysis;
proc print data=multworklocs;
  title "MULTWORKLOCS";
run;
ods rtf close;
ods rtf file="output3_17.rtf" style=analysis;
proc print data=noworkloc;
  title "NOWORKLOC";
run;
ods rtf close;


/*******************************************/
/* Example 3.8                             */
/*******************************************/
ods rtf file="output3_18.rtf" style=analysis;
proc print data=studysubjects(obs=5);
  title "STUDYSUBJECTS";
run;
ods rtf close;
ods rtf file="output3_19.rtf" style=analysis;
proc print data=studyappts;
  title "STUDYAPPTS";
run;
ods rtf close;
ods rtf file="output3_20.rtf" style=analysis;
proc print data=studystaff;
  title "STUDYSTAFF";
run;
ods rtf close;
ods rtf file="output3_21.rtf" style=analysis;
proc print data=studysites;
  title "STUDYSITES";
run;
ods rtf close;
data study_baseline;
  attrib studyid   length=$6
         appttype  length=$15
         apptdate  length=8 format=mmddyy10.
         weight    length=8
         systol    length=8
         diast     length=8
         staffid   length=8
         nursename length=$12
         siteid length=8
         sitename length=$30;

  if _n_=1 then do;
    declare hash b(dataset: "studyappts(where=(appttype='Baseline'))");
    b.defineKey('studyid');
    b.definedata(all: 'yes');
    b.definedone();

    declare hash f(dataset:"studystaff(rename=(staffname=nursename))");
    f.defineKey('staffid');
    f.definedata('siteid','nursename');
    f.definedone();

    declare hash t(dataset: "studysites");
    t.definekey('siteid');
    t.definedata('sitename');
    t.definedone();

    call missing(appttype,apptdate,weight,systol,diast,
                     staffid,nursename,siteid,sitename);
  end;

  set studysubjects;

  drop rc staffid;

  rc=b.find();
  if rc ne 0 then appttype='***No appts';
  rc=f.find(key: nurseid);
  if rc=0 then do;
    rc=t.find();
    if rc ne 0 then sitename='**Unknown';
  end;
  else if rc ne 0 then do;
    nursename='**Unknown';
    sitename='**Unknown';
  end;
run;
ods rtf file="output3_22.rtf" style=analysis;
proc print data=study_baseline;
  title "STUDY_BASELINE";
run;
ods rtf close;

/*******************************************/
/* Example 3.9                             */
/*******************************************/
ods rtf file="output3_23.rtf" style=analysis;
proc print data=findsched;
  title "FINDSCHED";
run;
ods rtf close;
ods rtf file="output3_24.rtf" style=analysis;
proc print data=octoberevent;
  title "OCTOBEREVENT";
run;
ods rtf close;
data selectedemps;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID';

  if _n_=1 then do;
    declare hash s(dataset: 'octoberevent');
    s.definekey('eventdate','shift','empid');
    s.definedata('activity');
    s.definedone();

    call missing(activity);
  end;

  set findsched;
  drop rc;
  rc=s.find();
  if rc ne 0 then activity="** Not scheduled";;
run;
ods rtf file="output3_25.rtf" style=analysis;
proc print data=selectedemps;
  title "SELECTEDEMPS";
run;
ods rtf close;

/*******************************************/
/* Example 3.10                            */
/*******************************************/
ods rtf file="output3_26.rtf" style=analysis;
proc print data=bpstudy;
  title "BPSTUDY";
run;
ods rtf close;
data highsystolic;
  attrib ptid length=$8
         examdate format=mmddyy10.
         weight length=8
         systolic length=8
         diastolic length=8;

  declare hash bpck(dataset: 'bpstudy');
  declare hiter bpckiter('bpck');
  bpck.definekey('ptid','examdate');
  bpck.definedata('ptid','examdate','weight','systolic','diastolic');
  bpck.definedone();

  call missing(ptid,examdate,weight,systolic,diastolic);

  drop rc;

  rc=bpckiter.first();
  do until (rc ne 0);
    if systolic gt 140 then output;
    rc=bpckiter.next();
  end;
run;
ods rtf file="output3_27.rtf" style=analysis;
proc print data=highsystolic;
  title "HIGHSYSTOLIC";
run;
ods rtf close;
data highsystolic;
  attrib ptid length=$8
         examdate format=mmddyy10.
         weight length=8
         systolic length=8
         diastolic length=8;

  declare hash bpck(dataset: 'bpstudy', ordered: 'yes');
  declare hiter bpckiter('bpck');
  bpck.definekey('ptid','examdate');
  bpck.definedata('ptid','examdate','weight','systolic','diastolic');
  bpck.definedone();

  call missing(ptid,examdate,weight,systolic,diastolic);

  drop rc;

  rc=bpckiter.first();
  do until (rc ne 0);
    if systolic gt 140 then output;
    rc=bpckiter.next();
  end;
run;
ods rtf file="output3_28.rtf" style=analysis;
proc print data=highsystolic;
  title "HIGHSYSTOLIC";
run;
ods rtf close;

/*******************************************/
/* Example 3.11                            */
/*******************************************/
data summer;
  attrib ptid length=$8
         examdate format=mmddyy10.
         weight length=8
         systolic length=8
         diastolic length=8;

  declare hash bpck(dataset: 'bpstudy',ordered: 'yes');
  declare hiter bpckiter('bpck');
  bpck.definekey('ptid','examdate');
  bpck.definedata('ptid','examdate','weight','systolic','diastolic');
  bpck.definedone();

  call missing(ptid,examdate,weight,systolic,diastolic);

  drop rc;

  rc=bpckiter.setcur(key: '56KJR3D9',key: '01jun2013'd);
  put _all_;
  do while (rc=0);
    if month(examdate) gt 8 then stop;
    else output;
    rc=bpckiter.next();
  end;
run;
data summer;
  attrib ptid length=$8
         examdate format=mmddyy10.
         weight length=8
         systolic length=8
         diastolic length=8;

  declare hash bpck(dataset: 'bpstudy',ordered: 'yes');
  declare hiter bpckiter('bpck');
  bpck.definekey('ptid','examdate');
  bpck.definedata('ptid','examdate','weight','systolic','diastolic');
  bpck.definedone();

  call missing(ptid,examdate,weight,systolic,diastolic);

  drop rc;

  rc=bpckiter.setcur(key: '56KJR3D9',key: '05jun2013'd);
  put _all_;
  do while (rc=0);
    if month(examdate) gt 8 then stop;
    else output;
    rc=bpckiter.next();
  end;
run;
ods rtf file="output3_29.rtf" style=analysis;
proc print data=summer;
  title "SUMMER";
run;
ods rtf close;

/*******************************************/
/* Example 3.12                            */
/*******************************************/
ods rtf file="output3_30.rtf" style=analysis;
proc print data=testgroup;
  title "TESTGROUP";
run;
ods rtf close;
data testcategories;
  attrib testid    length=8
         dob       length=8 format=mmddyy10.
         testdate  length=8 format=mmddyy10.
         age       length=8
         treatment length=$25;

  declare hash tg(dataset: 'testgroup',ordered: 'yes');
  declare hiter tgi('tg');
  tg.definekey('treatment','dob','testid');
  tg.definedata('testid','dob','testdate','treatment');
  tg.definedone();

  call missing(testid,dob,testdate,treatment);

  drop rc;

  rc=tgi.first();
  do while(rc eq 0);
    age=floor((testdate-dob)/365.25);
    if age lt 60 then treatment=catx(' ','Youngest:',treatment);
    else if 60 le age lt 80 then treatment=catx(' ','Middle:',treatment);
    else if 80 le age lt 90 then treatment=catx(' ','Oldest:',treatment);
    else if age ge 90 then treatment=catx(' ','Exempt:',treatment);
    output;
    rc=tgi.next();
  end;
run;
ods rtf file="output3_31.rtf" style=analysis;
proc print data=testcategories;
  title "TESTCATEGORIES";
run;
ods rtf close;

/*******************************************/
/* Example 3.13                            */
/*******************************************/
ods rtf file="output3_32.rtf" style=analysis;
proc print data=hh;
  title "HH";
run;
ods rtf close;
ods rtf file="output3_33.rtf" style=analysis;
proc print data=persons;
  title "PERSONS";
run;
ods rtf close;
data hhsummary;
  attrib hhid length=$4
         tract length=$4
         surveydate length=8 format=mmddyy10.
         hhtype length=$10
         phhid length=$4
         personid length=$4
         age length=3
         gender length=$1
         income length=8 format=dollar12.
         educlevel length=3
         npersons length=3
         nplt18 length=3
         np18_64 length=3
         np65plus length=3
         highested length=3
         hhincome  length=8 format=dollar12.;

  if _n_=1 then do;
    declare hash p(dataset: 'persons(rename=(hhid=phhid))',ordered: 'yes');
    declare hiter pi('p');
    p.definekey('phhid','personid');
    p.definedata('phhid','personid','age','gender','income','educlevel');
    p.definedone();

    call missing(phhid,personid,age,gender,income,educlevel);
  end;

  keep hhid tract surveydate hhtype npersons nplt18 np18_64 np65plus
       highested hhincome;
  array zeroes{*} npersons nplt18 np18_64 np65plus hhincome highested;

  set hh;

  do i=1 to dim(zeroes);
    zeroes{i}=0;
  end;

  rc=pi.setcur(key: hhid, key: 'P01');
  do until(rc ne 0 or hhid ne phhid);
    if rc=0 then do;
      npersons+1;
      if age lt 18 then nplt18+1;
      else if 18 le age le 64 then np18_64+1;
      else if age ge 65 then np65plus+1;
      hhincome+income;
      if educlevel gt highested then highested=educlevel;
    end;
    rc=pi.next();
  end;
run;
ods rtf file="output3_34.rtf" style=analysis;
proc print data=hhsummary;
  title "HHSUMMARY";
run;
ods rtf close;

/*******************************************/
/* Example 3.14                            */
/*******************************************/
ods rtf file="output3_35.rtf" style=analysis;
proc print data=awards;
  title "AWARDS";
run;
ods rtf close;
ods rtf file="output3_36.rtf" style=analysis;
proc print data=finishers;
  title "FINISHERS";
run;
ods rtf close;
data award_list;
  attrib completed length=8 format=mmddyy10.
         awarddate length=8 format=mmddyy10.
         prize     length=$22;

  if _n_=1 then do;
    declare hash az(dataset: 'awards',ordered: 'yes');
    declare hiter azi('az');
    az.definekey('awarddate');
    az.definedata('awarddate','prize');
    az.definedone();
    call missing(awarddate,prize);
  end;
  set finishers;

  drop rc foundmatch;

  foundmatch=0;
  rc=azi.first();
  do until(rc ne 0);
    if completed le awarddate then do;
      foundmatch=1;
      leave;
    end;
    rc=azi.next();
  end;
  if not foundmatch then do;
    awarddate=.;
    prize='** Post contest';
  end;
run;
ods rtf file="output3_37.rtf" style=analysis;
proc print data=award_list;
  title "AWARD_LIST";
run;
ods rtf close;

/*******************************************************************************/
/* End Chapter 3                                                               */
/*******************************************************************************/
/*******************************************************************************/


/*******************************************************************************/
/*******************************************************************************/
/* Start Chapter 4                                                             */
/*******************************************************************************/
/*******************************************/
/* Example 4.1                             */
/*******************************************/
data _null_;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash codelist(ordered: 'yes');
  codelist.definekey('code');
  codelist.definedata('code','codedesc','codedate');
  codelist.definedone();
  call missing(code,codedesc,codedate);

  code='AB234Z';
  codedesc='Credit';
  codedate='05jan2013'd;
  rc=codelist.add();

  /* This statement is incomplete and stops the DATA step */
  ***rc=codelist.add(key: 'JK987B');

  /* This statement is complete */
  rc=codelist.add(key: 'JK987B', data: 'JK987B', data:codedesc, data:codedate);

  /* This statement is complete */
  code='CU824P';
  rc=codelist.add(key: 'ZZ521L', data: code,
      data:codedesc, data: '05mar2013'd);

  codefront='RS';
  codeback='438E';
  rc=codelist.add(key: cats(codefront,codeback),
                  data: cats(codefront,codeback),
                  data: 'Debit', data: '23feb2013'd);

  rc=codelist.output(dataset: 'testcodes1');
run;
ods rtf file="output4_1.rtf" style=analysis;
proc print data=testcodes1;
  title "TESTCODES1";
run;
ods rtf close;

/*******************************************/
/* Example 4.2                             */
/*******************************************/
data _null_;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash codelist(ordered: 'y');
  codelist.definekey('code');
  codelist.definedata('codedesc','codedate');
  codelist.definedone();

  call missing(code,codedesc,codedate);

  code='CU824P';
  codedesc='Credit';
  codedate='05jan2013'd;
  rc=codelist.add();

  rc=codelist.add(key: 'AB234Z',
                  data:codedesc, data: '05mar2013'd);

  rc=codelist.output(dataset: 'testcodes2');
run;
ods rtf file="output4_2.rtf" style=analysis;
proc print data=testcodes2;
  title "TESTCODES2";
run;
ods rtf close;

/*******************************************/
/* Example 4.3                             */
/*******************************************/
ods rtf file="output4_3.rtf" style=analysis;
proc print data=codelookup;
  title "CODELOOKUP";
run;
ods rtf close;
data updates3;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash hashsource(dataset: 'codelookup',ordered: 'y');
  hashsource.definekey('code');
  hashsource.definedata('code','codedesc','codedate');
  hashsource.definedone();

  call missing(code,codedesc,codedate);

  code='AB871K';
  codedesc='Debit';
  codedate='15feb2013'd;
  rc=hashsource.replace();
  output;
  code='GG401P';
  codedesc='Credit';
  codedate='23feb2013'd;
  rc=hashsource.replace();
  output;
  code='MI497Q';
  codedesc='Debit';
  codedate='03feb2013'd;
  rc=hashsource.replace();
  output;
  rc=hashsource.output(dataset: 'newcodelookup');
run;
ods rtf file="output4_4.rtf" style=analysis;
proc print data=updates3;
  title "UPDATES3";
run;
ods rtf close;
ods rtf file="output4_5.rtf" style=analysis;
proc print data=newcodelookup;
  title "NEWCODELOOKUP";
run;
ods rtf close;

/*******************************************/
/* Example 4.4                             */
/*******************************************/
ods rtf file="output4_6.rtf" style=analysis;
proc print data=codes;
  title "CODES";
run;
ods rtf close;
data _null_;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash cd(dataset: 'codes', ordered: 'yes');
  cd.definekey('code');
  cd.definedata('code','codedesc','codedate');
  cd.definedone();

  call missing(code,codedesc,codedate);

  rc=cd.find(key: 'MI497Q');
  rc=cd.replace(key: code, data: 'C1UE23', data: 'NewAcct', data: codedate);

  rc=cd.output(dataset: 'nokeychange');
run;
ods rtf file="output4_7.rtf" style=analysis;
proc print data=nokeychange;
  title "NOKEYCHANGE";
run;
ods rtf close;

/*******************************************/
/* Example 4.5                             */
/*******************************************/
data _null_;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;

  declare hash cd(dataset: 'codes',ordered: 'y');
  cd.definekey('code');
  cd.definedata('code','codedesc','codedate');
  cd.definedone();

  call missing(code,codedesc,codedate);

  rc=cd.find(key: 'MI497Q');
  rc=cd.remove();
  code='C1UE23';
  rc=cd.add(key: code, data: code, data: 'NewAcct', data: codedate);

  rc=cd.output(dataset: 'keychanged');
run;
ods rtf file="output4_8.rtf" style=analysis;
proc print data=keychanged;
  title "KEYCHANGED";
run;
ods rtf close;

/*******************************************/
/* Example 4.6                             */
/*******************************************/
data random10;
  attrib sequence length=8 label='Selection Order'
         random_number length=8 label='Random Number';

  declare hash r();
  r.definekey('sequence');
  r.definedata('sequence','random_number');
  r.definedone();

  call missing(sequence,random_number);
  call streaminit(9876);

  drop rc;

  do sequence=1 to 10;
    random_number=ceil(100*rand('uniform'));
    rc=r.add();
    output;
  end;
  rc=r.output(dataset: 'random10');
run;
data _null_;
  attrib sequence length=8 label='Selection Order'
         random_number length=8 label='Random Number';

  declare hash r();
  r.definekey('sequence');
  r.definedata('sequence','random_number');
  r.definedone();

  call missing(sequence,random_number);
  call streaminit(9876);

  drop rc;

  do sequence=1 to 10;
    random_number=ceil(100*rand('uniform'));
    rc=r.add();
    output;
  end;
  rc=r.output(dataset: 'random10');
run;
ods rtf file="output4_9.rtf" style=analysis;
proc print data=random10;
  title "RANDOM10";
run;
ods rtf close;
data _null_;
  attrib sequence length=8 label='Selection Order'
         random_number length=8 label='Random Number';

  declare hash r(ordered: 'yes');
  r.definekey('sequence');
  r.definedata('sequence','random_number');
  r.definedone();

  call missing(sequence,random_number);
  call streaminit(9876);

  drop rc;

  do sequence=1 to 10;
    random_number=ceil(100*rand('uniform'));
    rc=r.add();
    output;
  end;
  rc=r.output(dataset: 'random10');
run;
ods rtf file="output4_10.rtf" style=analysis;
proc print data=random10;
  title "RANDOM10";
run;
ods rtf close;
data _null_;
  attrib sequence length=8 label='Selection Order'
         random_number length=8 label='Random Number';

  declare hash r(ordered: 'd');
  r.definekey('sequence');
  r.definedata('sequence','random_number');
  r.definedone();

  call missing(sequence,random_number);
  call streaminit(9876);

  drop rc;

  do sequence=1 to 10;
    random_number=ceil(100*rand('uniform'));
    rc=r.add();
    output;
  end;
  rc=r.output(dataset: 'random10');
run;
data _null_;
  attrib sequence length=8 label='Selection Order'
         random_number length=8 label='Random Number';

  declare hash r(ordered: 'yes');
  r.definekey('random_number');
  r.definedata('sequence','random_number');
  r.definedone();

  call missing(sequence,random_number);
  call streaminit(9876);

  drop rc;

  do sequence=1 to 10;
    random_number=ceil(100*rand('uniform'));
    rc=r.add();
    output;
  end;
  rc=r.output(dataset: 'random10');
run;
ods rtf file="output4_11.rtf" style=analysis;
proc print data=random10;
  title "RANDOM10";
run;
ods rtf close;

/*******************************************/
/* Example 4.7                             */
/*******************************************/
ods rtf file="output4_12.rtf" style=analysis;
proc print data=claims2013(obs=20);
  title "CLAIMS2013";
run;
ods rtf close;
data _null_;
  attrib provider_id length=$15 label='Provider ID';

  declare hash providerlist(dataset: 'claims2013', ordered: 'yes');
  providerlist.definekey('provider_id');
  providerlist.definedone();

  call missing(provider_id);

  rc=providerlist.output(dataset: 'claimproviders');
run;
ods rtf file="output4_13.rtf" style=analysis;
proc print data=claimproviders(obs=15);
  title "CLAIMPROVIDERS";
run;
ods rtf close;


/*******************************************/
/* Example 4.8                             */
/*******************************************/
ods rtf file="output4_14.rtf" style=analysis;
proc print data=employees(obs=20);
  title "EMPLOYEES";
run;
ods rtf close;
data _null_;
  attrib empid length=$6
         empname length=$60
         startdate length=8 format=mmddyy10.
         empyears length=8 label='Number of years worked'
         yearscat length=$10 label='Years worked category';

  if _n_=1 then do;
    declare hash years(ordered: 'yes');
    years.definekey('yearscat','empln','empfn','empmi');
    years.definedata('empid','empname','yearscat');
    years.definedone();
    call missing(empid,empname,startdate,empyears,yearscat);
  end;

  set employees end=eof;

  empyears=ceil(('31dec2012'd-startdate)/365.25);

  if empyears ge 10;

  if 10 le empyears lt 15 then yearscat='10+ years';
  else if 15 le empyears lt 20 then yearscat='15+ years';
  else if 20 le empyears lt 25 then yearscat='20+ years';
  else if empyears ge 25 then yearscat='25+ years';

  empname=catx(' ',empfn,empmi,empln);

  rc=years.add();

  if eof then rc=years.output(dataset: 'empnames10plus');
run;
ods rtf file="output4_15.rtf" style=analysis;
proc print data=empnames10plus(obs=20);
  title "EMPNAMES10PLUS";
run;
ods rtf close;

/*******************************************/
/* Example 4.9                             */
/*******************************************/
ods rtf file="output4_16.rtf" style=analysis;
proc print data=booklist;
  title "BOOKLIST";
run;
ods rtf close;
ods rtf file="output4_17.rtf" style=analysis;
proc print data=booksadddel;
  title "BOOKSADDDEL";
run;
ods rtf close;
data _null_;
  attrib bookid  length=$6
         booktitle length=$18
         chapter length=8
         author  length=$20
         duedate length=8 format=mmddyy10.
         editor  length=$20;

  if _n_=1 then do;
    declare hash bl(dataset: 'booklist', ordered: 'y');
    bl.definekey('bookid','chapter');
    bl.definedata(all: 'yes');
    bl.definedone();

    declare hash ids(dataset: 'booklist');
    ids.definekey('bookid');
    ids.definedone();

    call missing(bookid,booktitle,chapter,author,duedate,editor);
  end;

  set booksadddel end=eof;

  if action='DEL' then do;
    rc=bl.remove();
    if rc ne 0 then
        putlog "ERROR: This obs could not be deleted: " bookid= chapter=;
  end;
  else if action='ADD' then do;
    rc=bl.check();
    if rc=0 then putlog
     "ERROR: This obs already exists so it cannot be added: " bookid= chapter=;
    else do;
      rc=ids.check();
      if rc=0 then rc=bl.add();
      else putlog
"ERROR: BOOKID=" bookid "does not exist in BOOKLIST so it cannot be added";
    end;
  end;

  if eof then rc=bl.output(dataset: 'booklist');
run;
ods rtf file="output4_18.rtf" style=analysis;
proc print data=booklist;
  title "BOOKLIST";
run;
ods rtf close;

/*******************************************/
/* Example 4.10                            */
/*******************************************/
ods rtf file="output4_19.rtf" style=analysis;
proc print data=bookedits;
  title "BOOKEDITS";
run;
ods rtf close;
data _null_;
  attrib bookid  length=$6
         booktitle length=$18
         chapter length=8
         author  length=$20
         duedate length=8 format=mmddyy10.
         editor  length=$20;

  if _n_=1 then do;
    declare hash bl(dataset: 'booklist', ordered: 'y');
    bl.definekey('bookid','chapter');
    bl.definedata('bookid','chapter','booktitle','author','duedate','editor');
    bl.definedone();

    declare hash ids(dataset: 'booklist');
    ids.definekey('bookid');
    ids.definedone();

    call missing(bookid,booktitle,chapter,author,duedate,editor);
  end;

  set bookedits end=eof;

  if action='MOD' then do;
    rc=bl.find();
    if rc ne 0 then putlog
"ERROR: This obs does not exist so it cannot be edited: " bookid= chapter=;
    else rc=bl.replace(key: bookid, key: chapter,
                       data: bookid, data: chapter,
                       data: coalescec(newbooktitle,booktitle),
                       data: coalescec(newauthor,author),
                       data: coalesce(newduedate,duedate),
                       data: coalescec(neweditor,editor));
  end;
  else if action='DEL' then do;
    rc=bl.remove();
    if rc ne 0 then
          putlog "ERROR: This obs could not be deleted: " bookid= chapter=;
  end;
  else if action='ADD' then do;
    rc=bl.check();
    if rc=0 then putlog
     "ERROR: This obs already exists so it cannot be added: " bookid= chapter=;
    else do;
      rc=ids.check();
      if rc=0 then do;
        booktitle=newbooktitle;
        author=newauthor;
        duedate=newduedate;
        editor=neweditor;
        rc=bl.add();
      end;
      else putlog
    "ERROR: BOOKID=" bookid "does not exist in BOOKLIST so it cannot be added";
    end;
  end;

  if eof then rc=bl.output(dataset: 'booklist');
run;
ods rtf file="output4_20.rtf" style=analysis;
proc print data=booklist;
  title "BOOKLIST";
run;
ods rtf close;


/*******************************************/
/* Example 4.11                            */
/*******************************************/
ods rtf file="output4_21.rtf" style=analysis;
proc print data=claims2013(obs=20);
  title "CLAIMS2013";
run;
ods rtf close;
data types(keep=provider_type total)
     providers(keep=provider_id total);

  attrib provider_id length=$15 label='Provider ID'
         provider_type length=$11 label='Provider Type'
         total length=8 format=dollar16.2;

  declare hash htypes(suminc: 'charge', ordered: 'a');
  declare hiter itertypes('htypes');
  htypes.definekey('provider_type');
  htypes.definedone();

  declare hash hproviders(suminc: 'charge', ordered: 'a');
  declare hiter iterprov('hproviders');
  hproviders.definekey('provider_id');
  hproviders.definedone();

  do until(eof);
    set claims2013 end=eof;
    htypes.ref();
    hproviders.ref();
  end;

  rc = itertypes.first();
  do while (rc = 0);
    htypes.sum(sum: total);
    output types;
    rc = itertypes.next();
  end;

  rc = iterprov.first();
  do while (rc = 0);
    hproviders.sum(sum: total);
    output providers;
    rc = iterprov.next();
  end;
run;
ods rtf file="output4_22.rtf" style=analysis;
proc print data=types;
  title "TYPES";
run;
ods rtf close;
ods rtf file="output4_23.rtf" style=analysis;
proc print data=providers(obs=10);
  title "PROVIDERS";
run;
ods rtf close;


/*******************************************/
/* Example 4.12                            */
/*******************************************/
ods rtf file="output4_24.rtf" style=analysis;
proc print data=hh;
  title "HH";
run;
ods rtf close;
ods rtf file="output4_25.rtf" style=analysis;
proc print data=persons;
  title "PERSONS";
run;
ods rtf close;
data personsummary;
  attrib hhid length=$4
         phhid length=$4
         hhtype length=$10
         phhid length=$4
         personid length=$4
         age length=3
         gender length=$1
         income length=8 format=dollar12.
         educlevel length=3
         npersons length=3
         highested length=3
         hhincome  length=8 format=dollar12.
         agep01 length=3;

  if _n_=1 then do;
    declare hash p(dataset: 'persons(rename=(hhid=phhid))',ordered: 'yes');
    declare hiter pi('p');
    p.definekey('phhid','personid');
    p.definedata('phhid','personid','age','gender','income','educlevel');
    p.definedone();

    declare hash hhsumm(ordered: 'yes');
    hhsumm.definekey('hhid');
    hhsumm.definedata('hhid','hhtype','npersons','highested','hhincome',
                                'agep01');
    hhsumm.definedone();

    call missing(phhid,age,gender,educlevel,npersons,highested,
                     hhincome,agep01);

    do until(eof);
      set hh(keep=hhid hhtype) end=eof;
      npersons=0;
      hhincome=0;
      highested=0;

      rc=pi.setcur(key: hhid, key: 'P01');
      do until(rc ne 0 or hhid ne phhid);
        if rc=0 then do;
          if personid='P01' then agep01=age;
          npersons+1;
          hhincome+income;
          if educlevel gt highested then highested=educlevel;
        end;
        rc=pi.next();
      end;
      rc=hhsumm.add();
    end;
  end;

  keep hhid hhtype personid age gender educlevel npersons highested
       hhincome agep01;

  set persons;

  rc=hhsumm.find();
run;
ods rtf file="output4_26.rtf" style=analysis;
proc print data=personsummary;
  title "PERSONSUMMARY";
run;
ods rtf close;

/*******************************************************************************/
/* End Chapter 4                                                               */
/*******************************************************************************/
/*******************************************************************************/


/*******************************************************************************/
/* Start Chapter 5                                                             */
/*******************************************************************************/
ods rtf file="figure1_1.rtf" style=analysis;
proc print data=octoberevent;
  title "OCTOBEREVENT";
  var empid empname eventdate shift activity;
run;
ods rtf close;

ods rtf file="output5_1.rtf" style=analysis;
proc print data=bpmeasures;
  title "BPMEASURES";
run;
ods rtf close;

/*******************************************/
/* Example 5.1                             */
/*******************************************/
data _null_;
  attrib ptid length=$8
         bpdate length=8 format=mmddyy10.
         bptime length=8 format=timeampm8.
         systol length=8 label='Systolic BP'
         diast  length=8 label='Diastolic BP';
  if _n_=1 then do;
    declare hash bp(dataset: 'bpmeasures', ordered: 'yes');
    bp.definekey('ptid','bpdate');
    bp.definedata('ptid','bpdate','bptime','systol','diast');
    bp.definedone();
    call missing(ptid,bpdate,bptime,systol,diast);
  end;

  rc=bp.output(dataset: 'multdup1');
run;
ods rtf file="output5_2.rtf" style=analysis;
proc print data=multdup1;
  title "MULTDUP1";
run;
ods rtf close;

/*******************************************/
/* Example 5.2                             */
/*******************************************/
data _null_;
  attrib ptid length=$8
         bpdate length=8 format=mmddyy10.
         bptime length=8 format=timeampm8.
         systol length=8 label='Systolic BP'
         diast  length=8 label='Diastolic BP';
  if _n_=1 then do;
    declare hash bp(dataset: 'bpmeasures', ordered: 'yes', multidata: 'yes');
    bp.definekey('ptid','bpdate');
    bp.definedata('ptid','bpdate','bptime','systol','diast');
    bp.definedone();
    call missing(ptid,bpdate,bptime,systol,diast);
  end;

  rc=bp.output(dataset: 'multdup2');
run;
ods rtf file="output5_3.rtf" style=analysis;
proc print data=multdup2;
  title "MULTDUP2";
run;
ods rtf close;

/*******************************************/
/* Example 5.3                             */
/*******************************************/
data _null_;
  attrib ptid length=$8
         bpdate length=8 format=mmddyy10.
         bptime length=8 format=timeampm8.
         systol length=8 label='Systolic BP'
         diast  length=8 label='Diastolic BP';
  if _n_=1 then do;
    declare hash bp(dataset: 'bpmeasures', ordered: 'yes', duplicate: 'replace');
    bp.definekey('ptid','bpdate');
    bp.definedata('ptid','bpdate','bptime','systol','diast');
    bp.definedone();
    call missing(ptid,bpdate,bptime,systol,diast);
  end;

  rc=bp.output(dataset: 'multdup3');
run;
ods rtf file="output5_4.rtf" style=analysis;
proc print data=multdup3;
  title "MULTDUP3";
run;
ods rtf close;


/*******************************************/
/* Example 5.4                             */
/*******************************************/
data _null_;
  attrib ptid length=$8
         bpdate length=8 format=mmddyy10.
         bptime length=8 format=timeampm8.
         systol length=8 label='Systolic BP'
         diast  length=8 label='Diastolic BP';
  if _n_=1 then do;
    declare hash bp(dataset: 'bpmeasures', ordered: 'yes', duplicate: 'error');
    bp.definekey('ptid','bpdate');
    bp.definedata('ptid','bpdate','bptime','systol','diast');
    bp.definedone();
    call missing(ptid,bpdate,bptime,systol,diast);
  end;

  rc=bp.output(dataset: 'multdup4');
run;


/*******************************************/
/* Example 5.5                             */
/*******************************************/
ods rtf file="output5_5.rtf" style=analysis;
proc print data=octoberevent;
  title "OCTOBEREVENT";
run;
ods rtf close;

data sched4emps;
  attrib empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name'
         eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity';

  declare hash oe(dataset: 'octoberevent', multidata: 'yes', ordered: 'yes');
  oe.definekey('empid');
  oe.definedata('eventdate','shift','activity','empname');
  oe.definedone();
  call missing(eventdate,shift,activity,empname);

  drop rc;
  do empid='OYMEE3','PTBHUP','GWS2QS','K8821U';
    rc=oe.find();
    if rc=0 then do;
      do until(rc ne 0);
        output;
        rc=oe.find_next();
      end;
    end;
    else do;
      activity='** Not Scheduled';
      call missing(eventdate,shift,empname);
      output;
    end;
  end;
run;
ods rtf file="output5_6.rtf" style=analysis;
proc print data=sched4emps;
  title "SCHED4EMPS";
run;
ods rtf close;

/*******************************************/
/* Example 5.6                             */
/*******************************************/
data sched4emps;
  attrib empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name'
         eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity';

  declare hash oe2(dataset: 'octoberevent', ordered: 'yes');
  declare hiter oeiter('oe2');
  oe2.definekey('empid','eventdate','shift');
  oe2.definedata('empid','eventdate','shift','activity','empname');
  oe2.definedone();
  call missing(empid,eventdate,shift,activity,empname);

  drop rc idx i;

  array findempid{4} $ 6 _temporary_ ('OYMEE3','PTBHUP','GWS2QS','K8821U');
  array found{4} _temporary_ ;

  rc=oeiter.first();
  do until(rc ne 0);
    idx=whichc(empid,of findempid[*]);
    if idx gt 0 then do;
      found{idx}=1;
      output;
    end;
    rc=oeiter.next();
  end;
  do i=1 to dim(findempid);
    if found{i} ne 1 then do;
      empid=findempid{i};
      activity='** Not Scheduled';
      call missing(eventdate,shift,empname);
      output;
    end;
  end;
run;


/*******************************************/
/* Example 5.7                             */
/*******************************************/
ods rtf file="output5_7.rtf" style=analysis;
proc print data=octoberevent;
  where eventdate='23oct2013'd and shift='AM';
  title "OCTOBEREVENT";
run;
ods rtf close;
data _null_;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  if _n_=1 then do;
    declare hash mult1(dataset: 'octoberevent',multidata: 'yes',ordered: 'yes');
    mult1.definekey('eventdate','shift','activity');
    mult1.definedata('eventdate','shift','activity','empid','empname');
    mult1.definedone();

    call missing(eventdate,shift,activity,empid,empname);
  end;
  infile datalines eof=done;
  input @1 eventdate mmddyy8. @10 shift $2.
        @13 activity $14. @29 empid $6. @37 empname $40.;
  rc=mult1.add();
  return;
  done:
    rc=mult1.output(dataset: 'octoberevent_rev1');
datalines;
10232013 AM Cholesterol     Z1EJD9  Howard, Amanda X.
10232013 AM Dietary         YH2W10  Li, Louise L.
run;
ods rtf file="output5_8.rtf" style=analysis;
proc print data=octoberevent_rev1;
  where eventdate='23oct2013'd and shift='AM';
  title "OCTOBEREVENT_REV1";
run;
ods rtf close;

/*******************************************/
/* Example 5.8                             */
/*******************************************/
ods rtf file="output5_9.rtf" style=analysis;
proc print data=octoberevent;
  title "OCTOBEREVENT";
run;
ods rtf close;
data _null_;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  declare hash mult2(dataset: 'octoberevent',multidata: 'yes',
                     ordered: 'yes');
  mult2.definekey('shift','activity');
  mult2.definedata('eventdate','shift','activity','empid','empname');
  mult2.definedone();

  call missing(eventdate,shift,activity,empid,empname);

  rc=mult2.remove(key:'PM',key:'Dietary');
  rc=mult2.output(dataset: 'octoberevent_rev2');
run;
ods rtf file="output5_10.rtf" style=analysis;
proc print data=octoberevent_rev2;
  where shift='PM';
  title "OCTOBEREVENT_REV2";
run;
ods rtf close;

/*******************************************/
/* Example 5.9                             */
/*******************************************/
ods rtf file="output5_11.rtf" style=analysis;
proc print data=octoberevent;
  where activity=:'Coun' and eventdate='22oct2013'd;
  title "OCTOBEREVENT";
run;
ods rtf close;
data _null_;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  declare hash mult3(dataset: 'octoberevent',multidata: 'yes',
                     ordered: 'yes');
  mult3.definekey('eventdate','shift','activity');
  mult3.definedata('empid','empname','eventdate','shift','activity');
  mult3.definedone();

  call missing(eventdate,shift,activity,empid,empname);

  do shift='AM','PM';
    nemps=0;
    if shift='AM' then shiftmax=3;
    else if shift='PM' then shiftmax=2;
    rc=mult3.find(key: '22oct2013'd, key: shift, key: 'Counseling');
    do until (rc ne 0);
      nemps+1;
      rc=mult3.find_next();
    end;
    if nemps gt shiftmax then do;
      do i=1 to nemps-shiftmax;
        rc=mult3.find(key: '22oct2013'd, key: shift, key: 'Counseling');
        rc=mult3.removedup();
      end;
    end;
  end;
  rc=mult3.output(dataset: 'octoberevent_rev3');
run;
ods rtf file="output5_12.rtf" style=analysis;
proc print data=octoberevent_rev3;
  title "OCTOBEREVENT_REV3";
run;
ods rtf close;

/*******************************************/
/* Example 5.10                            */
/*******************************************/
ods rtf file="output5_13.rtf" style=analysis;
proc print data=octoberevent;
  title "OCTOBEREVENT";
run;
ods rtf close;
data _null_;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  declare hash mult4(dataset: 'octoberevent', multidata: 'yes',ordered: 'yes');
  mult4.definekey('empid');
  mult4.definedata('empid','empname','eventdate','shift','activity');
  mult4.definedone();

  call missing(eventdate,shift,activity,empid,empname);

  rc=mult4.find(key: '02QYJG');
  if rc=0 then do;
    do until (rc ne 0);
      if shift='AM' then activity='Immunization';
      else if shift='PM' then activity='Vitals';
      rcr=mult4.replacedup();
      rc=mult4.find_next();
    end;
  end;

  rc=mult4.find(key: 'ADHW3A');
  if rc=0 then do;
    do until (rc ne 0);
      if shift='PM' then do;
        empid='724RTQ';
        empname='McCormick, Annemarie L.';
        rcr=mult4.replacedup();
      end;
      rc=mult4.find_next(key: 'ADHW3A');
    end;
  end;

  rc=mult4.output(dataset: 'octoberevent_rev4');

  declare hash oerp(dataset: 'octoberevent_rev4',ordered: 'yes');
  oerp.definekey('eventdate','shift','activity','empid');
  oerp.definedata('empid','empname','eventdate','shift','activity');
  oerp.definedone();

  rc=oerp.output(dataset: 'octoberevent_rev4');

run;
ods rtf file="output5_14.rtf" style=analysis;
proc print data=octoberevent_rev4;
  title "OCTOBEREVENT_REV4";
run;
ods rtf close;

/*******************************************/
/* Example 5.11                            */
/*******************************************/
proc sort data=flushots;
  by clinicdate clinicsite;
run;
ods rtf file="output5_15.rtf" style=analysis;
proc print data=flushots(obs=25);
  title "FLUSHOTS";
run;
ods rtf close;
data ordered65plus;
  attrib clinicsite length=$50
         clinicdate length=8 format=mmddyy10.
         dayofweek  length=$9
         shots18_64 label='Adults 18-64 Immunized'
         shots65plus label='Adults 65+ Immunized'
         totalshots  label='Adults Immunized';

  keep clinicsite clinicdate dayofweek shots18_64 shots65plus totalshots;

  declare hash fs(dataset: 'flushots', ordered: 'd', multidata: 'yes');
  declare hiter fsiter('fs');
  fs.definekey('shots65plus');
  fs.definedata('shots65plus','clinicdate','clinicsite','shots18_64');
  fs.definedone();
  call missing(clinicsite,clinicdate,shots18_64,shots65plus);

  rc=fsiter.first();
  do while (rc=0);
    dayofweek=left(put(clinicdate,downame9.));
    totalshots=sum(shots18_64,shots65plus);
    output;
    rc=fsiter.next();
  end;
run;
ods rtf file="output5_16.rtf" style=analysis;
proc print data=ordered65plus(obs=25);
  title "ORDERED65PLUS";
run;
ods rtf close;

/*******************************************/
/* Example 5.12                            */
/*******************************************/
ods rtf file="output5_17.rtf" style=analysis;
proc print data=studyappts;
  where studyid le "DHZ1222";
  title "STUDYAPPTS";
run;
ods rtf close;
data baseline onemonth twomonth fourmonth sixmonth;
  attrib studyid   length=$6
         appttype  length=$15
         lastappttype length=$15
         apptdate  length=8 format=mmddyy10.
         weight    length=8
         systol    length=8
         diast     length=8;

  declare hash lastappt(dataset: 'studyappts(rename=(appttype=lastappttype))',
                        duplicate: 'replace', ordered: 'yes');
  declare hiter lastiter('lastappt');
  lastappt.definekey('studyid');
  lastappt.definedata('studyid','lastappttype');
  lastappt.definedone();

  declare hash allappts(dataset: 'studyappts', multidata: 'yes',
                             ordered: 'yes');
  allappts.definekey('studyid');
  allappts.definedata('studyid','appttype','apptdate','weight','systol',
                      'diast');
  allappts.definedone();

  call missing(studyid,appttype,lastappttype,apptdate,weight,systol,diast);

  drop rc rciter;

  rciter=lastiter.first();
  do until (rciter ne 0);
    rc=allappts.find();
    do until (rc ne 0);
      if lastappttype='Baseline' then output baseline;
      else if lastappttype='One Month' then output onemonth;
      else if lastappttype='Two Month' then output twomonth;
      else if lastappttype='Four Month' then output fourmonth;
      else if lastappttype='Six Month' then output sixmonth;
      rc=allappts.find_next();
    end;
    rciter=lastiter.next();
  end;
run;
ods rtf file="output5_18.rtf" style=analysis;
proc print data=onemonth;
  title "ONEMONTH";
run;
ods rtf close;
ods rtf file="output5_19.rtf" style=analysis;
proc print data=fourmonth;
  title "FOURMONTH";
run;
ods rtf close;

/*******************************************/
/* Example 5.13                            */
/*******************************************/
ods rtf file="output5_20.rtf" style=analysis;
proc print data=claims2013(obs=25);
  title "CLAIMS2013";
run;
ods rtf close;
data _null_;
  attrib ptid length=$8 label='Patient ID'
         claimdate length=8 format=mmddyy10. label='Claim Date'
         provider_type length=$11 label='Provider Type';

  declare hash combo(dataset: 'claims2013',ordered: 'yes');
  combo.definekey('ptid','claimdate','provider_type');
  combo.definedata('ptid','claimdate','provider_type');
  combo.definedone();

  call missing(ptid,claimdate,provider_type);

  rc=combo.output(dataset: 'claimcombos');
run;
ods rtf file="output5_21.rtf" style=analysis;
proc print data=claimcombos(obs=15);
  title "CLAIMCOMBOS";
run;
ods rtf close;

/*******************************************/
/* Example 5.14                            */
/*******************************************/
ods rtf file="output5_22.rtf" style=analysis;
proc print data=hh;
  title "HH";
run;
ods rtf close;
ods rtf file="output5_23.rtf" style=analysis;
proc print data=persons;
  title "PERSONS";
run;
ods rtf close;
data hhsummary;
  attrib hhid length=$4
         tract length=$4
         surveydate format=mmddyy10.
         hhtype length=$10
         personid length=$4
         age length=3
         gender length=$1
         income length=8 format=dollar12.
         educlevel length=3
         npersons length=3
         nplt18 length=3
         np18_64 length=3
         np65plus length=3
         highested length=3
         hhincome  length=8 format=dollar12.;

  if _n_=1 then do;
    declare hash p(dataset: 'persons',ordered: 'yes', multidata: 'yes');
    p.definekey('hhid');
    p.definedata('personid','age','gender','income','educlevel');
    p.definedone();

    call missing(personid,age,gender,income,educlevel);
  end;

  keep hhid tract surveydate hhtype npersons nplt18 np18_64 np65plus
       highested hhincome;
  array zeroes{*} npersons nplt18 np18_64 np65plus hhincome highested;

  set hh;

  do i=1 to dim(zeroes);
    zeroes{i}=0;
  end;

  rc=p.find();
  do until(rc ne 0);
    npersons+1;
    if age lt 18 then nplt18+1;
    else if 18 le age le 64 then np18_64+1;
    else if age ge 65 then np65plus+1;
    hhincome+income;
    if educlevel gt highested then highested=educlevel;
    rc=p.find_next();
  end;
run;
ods rtf file="output5_24.rtf" style=analysis;
proc print data=hhsummary;
  title "HHSUMMARY";
run;
ods rtf close;

/*******************************************************************************/
/* End Chapter 5                                                               */
/*******************************************************************************/
/*******************************************************************************/

/*******************************************************************************/
/*******************************************************************************/
/* Start Chapter 6                                                             */
/*******************************************************************************/
/*******************************************/
/* Example 6.1                             */
/*******************************************/
ods rtf file="output6_1.rtf" style=analysis;
proc print data=claims2012(obs=25);
  title "CLAIMS2012";
run;
ods rtf close;
data _null_;
  attrib ptid length=$8 label='Patient ID'
         claimdate length=8 format=mmddyy10. label='Claim Date'
         provider_id length=$15 label='Provider ID'
         charge length=8 format=dollar10.2 label='Charge'
         dsout length=$100;

  call missing(ptid,claimdate,provider_id,charge,provider_type);

  do claimyear=2012, 2013;
    dsclaims=cats('claims',put(claimyear,4.));
    dsout=cats('maxclaims',put(claimyear,4.),'_sorted');

    declare hash c(dataset: dsclaims, ordered: 'descending', multidata: 'yes');
    c.definekey('ptid','charge');
    c.definedata('ptid','claimdate','charge','provider_id');
    c.definedone();
    rc=c.output(dataset: dsout );
    rc=c.delete();

    declare hash c2(dataset: dsout, ordered: 'yes');
    c2.definekey('ptid');
    c2.definedata('ptid','claimdate','charge','provider_id');
    c2.definedone();
    rc=c2.output(dataset: dsout );
    rc=c2.delete();

    declare hash o(dataset: dsout, ordered: 'yes',multidata: 'yes');
    o.definekey('provider_id','ptid');
    o.definedata('ptid','claimdate','charge','provider_id');
    o.definedone();

    dsout=cats(dsout,'(rename=(charge=maxcharge_',put(claimyear,4.),')');

    rc=o.output(dataset: dsout );
    rc=o.delete();
  end;
run;
ods rtf file="output6_2.rtf" style=analysis;
proc print data=maxclaims2012_sorted(obs=25);
  title "MAXCLAIMS2012_SORTED";
run;
ods rtf close;

/*******************************************/
/* Example 6.2                             */
/*******************************************/
ods rtf file="output6_3.rtf" style=analysis;
proc print data=bpmeasures;
  title "BPMEASURES";
run;
ods rtf close;
data _null_;
  attrib ptid length=$8
         bpdate length=8 format=mmddyy10.
         bptime length=8 format=timeampm8.
         systol length=8 label='Systolic BP'
         diast  length=8 label='Diastolic BP';

  declare hash bpunique(dataset: 'bpmeasures',ordered: 'yes');
  bpunique.definekey('ptid','bpdate');
  bpunique.definedata('ptid','bpdate','bptime','systol','diast');
  bpunique.definedone();

  declare hash bpmult(dataset: 'bpmeasures',ordered: 'yes',multidata: 'yes');
  bpmult.definekey('ptid','bpdate');
  bpmult.definedata('ptid','bpdate','bptime','systol','diast');
  bpmult.definedone();

  call missing(ptid,bpdate,bptime,systol,diast);

  nbpunique=bpunique.num_items;
  nbpmult=bpmult.num_items;
  put '**Number of items in BPUNIQUE=' nbpunique;
  put '**Number of items in BPMULT=' nbpmult;
run;

/*******************************************/
/* Example 6.3                             */
/*******************************************/
ods rtf file="output6_4.rtf" style=analysis;
proc print data=studyappts;
  where studyid le "DHZ1222";
  title "STUDYSUBJECTS";
run;
ods rtf close;
data _null_;
  attrib studyid   length=$6
         appttype  length=$15
         apptdate  length=8 format=mmddyy10.
         weight    length=8
         systol    length=8
         diast     length=8;

  declare hash types(dataset: 'studyappts');
  declare hiter ti('types');
  types.definekey('appttype');
  types.definedata('appttype');
  types.definedone();
  ntypes=types.num_items;

  declare hash allobs(dataset: 'studyappts',multidata: 'yes',ordered: 'yes');
  allobs.definekey('appttype');
  allobs.definedata(all: 'yes');
  allobs.definedone();

  declare hash bygrp(multidata: 'yes',ordered: 'descending');
  bygrp.definekey('systol');
  bygrp.definedata('studyid','appttype','apptdate','weight','systol','diast');
  bygrp.definedone();

  call missing(appttype,studyid,apptdate,weight,systol,diast);

  rctypes=ti.first();
  do i=1 to ntypes;
    rcall=allobs.find();
    do until(rcall ne 0);
      rcadd=bygrp.add();
      rcall=allobs.find_next();
    end;
    rcout=bygrp.output(dataset: compress(appttype));
    rclr=bygrp.clear();
    rctypes=ti.next();
  end;
run;
ods rtf file="output6_5.rtf" style=analysis;
proc print data=baseline;
  title "BASELINE";
run;
ods rtf close;
ods rtf file="output6_6.rtf" style=analysis;
proc print data=sixmonth;
  title "SIXMONTH";
run;
ods rtf close;

/*******************************************/
/* Example 6.4                             */
/*******************************************/
ods rtf file="output6_7.rtf" style=analysis;
proc print data=claims2013(obs=20);
  title "CLAIMS2013";
run;
ods rtf close;
data _null_;
  attrib ptid length=$8 label='Patient ID'
         claimdate length=8 format=mmddyy10. label='Claim Date'
         provider_id length=$15 label='Provider ID'
         charge length=8 format=dollar10.2 label='Charge'
         provider_type length=$11 label='Provider Type';

  array yesno{0:1} $ 6 _temporary_ ('0: No','1: Yes');

  declare hash notordered(dataset: 'claims2013');
  notordered.definekey('ptid','claimdate');
  notordered.definedata('provider_id','charge','provider_type','claimdate',
                        'ptid');
  notordered.definedone();

  declare hash ordered(dataset: 'claims2013',ordered: 'yes');
  ordered.definekey('ptid','claimdate');
  ordered.definedata('provider_id','charge','provider_type','claimdate',
                     'ptid');
  ordered.definedone();

  declare hash ordered2(dataset: 'claims2013',ordered: 'yes');
  ordered2.definekey('ptid','claimdate','provider_id');
  ordered2.definedata('provider_id','charge','provider_type','claimdate',
                      'ptid');
  ordered2.definedone();

  declare hash ordered_d(dataset: 'claims2013',ordered: 'd');
  ordered_d.definekey('ptid','claimdate');
  ordered_d.definedata('provider_id','charge','provider_type','claimdate',
                     'ptid');
  ordered_d.definedone();

  call missing(provider_id,charge,provider_type,claimdate,ptid);

  rc=notordered.equals(hash: 'ordered',result: status1);
  put "NOTORDERED=ORDERED: " yesno{status1};

  rc=ordered.equals(hash: 'ordered2',result: status2);
  put "ORDERED=ORDERED2: " yesno{status2};

  rc=ordered.equals(hash: 'ordered_d',result: status3);
  put "ORDERED=ORDERED_D: " yesno{status3};
run;


/*******************************************/
/* Example 6.5                             */
/*******************************************/
ods rtf file="output6_8.rtf" style=analysis;
proc print data=octoberevent(obs=20);
  title "OCTOBEREVENT";
run;
ods rtf close;
data _null_;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  declare hash oeunique(dataset: 'octoberevent');
  oeunique.definekey('empid');
  oeunique.definedata('eventdate','shift','activity','empid','empname');
  oeunique.definedone();

  declare hash oemult(dataset: 'octoberevent',multidata: 'yes');
  oemult.definekey('empid');
  oemult.definedata('eventdate','shift','activity','empid','empname');
  oemult.definedone();

  declare hash oemultorder(dataset: 'octoberevent',multidata: 'yes',
                           ordered: 'yes');
  oemultorder.definekey('empid');
  oemultorder.definedata('eventdate','shift','activity','empid','empname');
  oemultorder.definedone();

  call missing(eventdate,shift,activity,empid,empname);

  uniquesize=oeunique.item_size;
  multsize=oemult.item_size;
  ordersize=oemultorder.item_size;

  put "ITEM_SIZE for OEUNIQUE=" uniquesize;
  put "ITEM_SIZE for OEMULT=" multsize;
  put "ITEM_SIZE for OEMULTORDER=" ordersize;
run;

/*******************************************************************************/
/* End Chapter 6                                                               */
/*******************************************************************************/
/*******************************************************************************/
