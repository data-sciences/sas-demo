
/*--Adverse Events timeline data--*/
data ae0;
   retain aestdateMin;
   retain aeendateMax;
   attrib aestdate informat=yymmdd10. format=date7.;
   attrib aeendate informat=yymmdd10. format=date7.;
   format aestdateMin aeendateMax date7.;
   drop aestdateMin aeendateMax;
   input aeseq aedecod $ 5-39 aesev $ aestdate aeendate;

   aestdateMin=min(aestdate, aestdateMin);
   aeendateMax=max(aeendate, aeendateMax);
   call symputx('mindate', aestdateMin);
   call symputx('maxdate', aeendateMax);
   y=aeseq;
   if aedecod="DUMMY" then y=-100;

   cards;
1   DUMMY                               MILD      2013-03-06  2013-03-06     3        3
1   DUMMY                               MODERATE  2013-03-06  2013-03-06     3        3
1   DUMMY                               SEVERE    2013-03-06  2013-03-06     3        3
1   DIZZINESS                           MODERATE  2013-03-06  2013-03-06     3        3
2   COUGH                               MILD      2013-03-20  .             17        .
3   APPLICATION SITE DERMATITIS         MILD      2013-03-26  2013-06-18    23      107
4   DIZZINESS                           MILD      2013-03-27  2013-03-27    24       24
5   ELECTROCARDIOGRAM T WAVE INVERSION  MILD      2013-03-30  .             27        .
6   DIZZINESS                           MILD      2013-04-01  2013-04-11    29       39
7   DIZZINESS                           MILD      2013-04-01  2013-04-11    29       39
8   APPLICATION SITE DERMATITIS         MODERATE  2013-03-26  2013-06-18    23      107
9   HEADACHE                            MILD      2013-05-17  2013-05-18    75       76
10  APPLICATION SITE DERMATITIS         MODERATE  2013-03-26  2013-06-18    23      107
11  PRURITUS                            MODERATE  2013-05-27  2013-06-18    85      107
;
run;

/*--Evaluate min and max day and dates--*/
data _null_;
  set ae0;
  minday=0;
  maxday= &maxdate - &mindate;
  minday10 = -10;
  mindate10=&mindate - 10;
  call symputx('minday', minday);
  call symputx('maxday', maxday);
  call symputx('minday10', minday10);
  call symputx('mindate10', mindate10);
  run;

/*--Graph Width in pixels--*/
%let grwidth=700;
%let grwpx=625px;

/*--Compute start and end date and days and X position of event name--*/
data ae1;
  set ae0;
  drop len dur xoff;
  format xc 4.2;

  aestdy= aestdate-&mindate+0;
  aeendy= aeendate-&mindate+0;
  startday=aestdy;
  endday=aeendy;
  if aestdy=. then startday=&minday;
  if aeendy=. then endday=&maxday;

  len = length(aedecod)+3;
  dur = abs(&maxday - &minday10);
  xoff=len*dur / &grwidth; 
  xc=aestdy-3.4*xoff;

  run;


/*ods escapechar="^";*/
/*--Custom style for severity of events--*/
proc template;
   define Style AETimeline; parent = styles.listing;
      style GraphColors from graphcolors /
           "gcdata" = cx000000
           "gcdata1" = cx1fcf1f
           "gcdata2" = cxdfbf1f
           "gcdata3" = cxbf1f1f;
      style GraphFonts from GraphFonts /                                   
         'GraphDataFont' = ("<sans-serif>, <MTsans-serif>",5pt)  
         'GraphValueFont' = ("<sans-serif>, <MTsans-serif>",7pt) 
         'GraphTitleFont' = ("<sans-serif>, <MTsans-serif>",11pt);  
   end;
run;

/*--Draw the Graph--*/
ods listing style=AETimeline image_dpi=200;
ods graphics / reset width=6in height=3in imagename="Fig12_5_AE_Timeline_V92";
title "Adverse Events for Patient Id = xx-xxx-xxxx";
proc sgplot data=ae1 noautolegend nocycleattrs;
   refline 0 / axis=x lineattrs=(thickness=1 color=black);

   /*--Draw the events--*/
   vector x=endday y=y / xorigin=startday yorigin=y noarrowheads lineattrs=(thickness=9px);
   vector x=endday y=y / xorigin=startday yorigin=y noarrowheads lineattrs=(thickness=7px pattern=solid) 
        transparency=0 group=aesev  name='sev';

   /*--Draw start and end events--*/
   scatter x=aestdy y=y / markerattrs=(size=13px symbol=trianglefilled); 
   scatter x=aestdy y=y / markerattrs=(size=9px symbol=trianglefilled) group=aesev;
   scatter x=aeendy y=y / markerattrs=(size=13px symbol=trianglefilled); 
   scatter x=aeendy y=y / markerattrs=(size=9px symbol=trianglefilled) group=aesev;

   /*--Draw the event names--*/ 
   scatter x=xc y=y / markerchar=aedecod;

   /*--Assign dummy plot to create independent X2 axis--*/
   scatter x=aestdate y=y /  markerattrs=(size=0) x2axis;

   /*--Assign axis properties data extents and offsets--*/
   yaxis display=(nolabel noticks novalues) min=0;
   xaxis grid label='Study Days' offsetmin=0.02 offsetmax=0.02 
         values=(&minday10 to &maxday by 2);
   x2axis notimesplit display=(nolabel) offsetmin=0.02 offsetmax=0.02 
         values=(&mindate10 to &maxdate);

   /*--Draw the legend--*/
   keylegend 'sev'/ title='Severity :';
run;






