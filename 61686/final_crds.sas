/********************************************/
/* Create Data Set SALES - Chapters 1 and 2 */
/********************************************/
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
  attrib ProductName  label='Product'      format=prod.
         Department   label='Department'   format=dept.
         EmployeeName label='Employee'     format=emp.
         SalesDate    label='Date of Sale' format=mmddyy10.
         CustomerName label='Customer'     format=cust.
         ItemsSold    label='Items Sold'   format=5.
         ItemPrice    label='Item Price'   format=dollar8.2;

  do i=1 to 500;
   ProductName=floor(ranuni(12345)*6);
   Department=floor(ranuni(23456)*7);
   EmployeeName=floor(ranuni(34567)*5);
   SalesDate='1JAN2009'd+(floor(ranuni(45678)*750));
   CustomerName=floor(ranuni(56789)*5);
   ItemsSold=floor(50+(ranuni(67890)*500));
   ItemPrice=round(4+(5-ProductName)+((6-Department)/2)+(SalesDate/10000),.01);
   output;
  end;
run;
/************************************************/
/* End Create Data Set SALES - Chapters 1 and 2 */
/************************************************/

/****************************************************************/
/* Create Data Set BILLINGS and TOTALS - Chapters 3, 12, 14, 18 */
/****************************************************************/
proc format;
  value typex 0,1='In-house'
              2,3,4='Consulting'
                  5='Contract';
  value emp  0='Smith'
             1='Knight'
             2='Haworth'
             3='Jones'
             4='Platt';

run;
data billings;

  attrib Division     length=$15 label='Division'
         JobType      length=$12 label='Job Type'
         EmployeeName length=$8  label='Employee Name'
         WorkDate     length=8   label='Date Work Completed' format=mmddyy10.
         CustomerName length=$25 label='Customer'
         Hours        length=8   label='Hours Worked' format=8.1
         BillableAmt  length=8   label='Amount Billable' format=dollar8.2
         Quarter      length=$6  label='Quarter'
         Overtime8    length=3   label='Overtime more than 8 hours';

  array divvalues{6} $ 15 _temporary_ ('Applications','Analysis','Reporting',
                                  'Systems','Documentation','QA');
  array typevalues{3} $ 12 _temporary_ ('In-house','Consulting','Contract');
  array empvalues{5} $ 8 _temporary_ ('Smith','Knight','Haworth','Jones','Platt');
  array custvalues{5} $ 25 _temporary_ ('IPO.com','Bricks and Mortar, Inc.',
                                        'Virtual Co.','Sweat Shops Athletic','Smith & Smith');

  drop i divvalue typeval;

  do i=1 to 500;
    divvalue=ceil(ranuni(1357)*6);
    division=divvalues{divvalue};

    typeval=ceil(ranuni(2468)*6);
    if typeval in (1,2) then jobtype=typevalues{1};
    else if typeval in (3,4,5) then jobtype=typevalues{2};
    else jobtype=typevalues{3};


    employeename=empvalues{ceil(ranuni(3579)*5)};

    WorkDate='1JAN2009'd+(floor(ranuni(4680)*730));

    CustomerName=custvalues{ceil(ranuni(5791)*5)};
    Hours=1+round((ranuni(6802)*10),.5);
    BillableAmt=
      round((90*Hours)+(21-(divvalue*2))+(21-typeval)+(WorkDate/10000),.01);
    Quarter=put(workdate,yyqd6.);
    Overtime8=(hours > 8);
    output;
  end;
run;
proc sort data=billings;
  by workdate employeename jobtype;
run;
proc summary data=Billings nway;
   class EmployeeName;
   var BillableAmt;
   output out=Totals sum=;
run;
/********************************************************************/
/* End Create Data Set BILLINGS and TOTALS - Chapters 3, 12, 14, 18 */
/********************************************************************/

/****************************************************************/
/* Create Data Sets BILLOUT and PROJECTED_BILLING - Chapter 18  */
/****************************************************************/
ods output summary=work.billout(drop=nobs);
proc means data=work.billings sum;
  class Division;
  var BillableAmt;
run;

data projected_billing(rename=(BillableAmt_Sum=BillableAmt_Base));
  set work.billout;
  Grow_At_05 = BillableAmt_Sum * 1.05;
  Grow_At_10 = BillableAmt_Sum * 1.10;
  Grow_At_25 = BillableAmt_Sum * 1.25;
  Grow_At_50 = BillableAmt_Sum * 1.50;
run;
/********************************************************************/
/* End Create Data Sets BILLOUT and PROJECTED_BILLING - Chapter 18  */
/********************************************************************/


/******************************************************/
/* Create Data Set CLINICAL - Chapter 3, 18, Appendix */
/******************************************************/
proc format;
  value txfmt 1='Control'
              2='Low Dose'
              3='High Dose';
  value sexft 1='Male'
              2='Female';
  value agegroup 18-34='18-34'
                 35-54='35-54'
                 55-74='55-74'
                 75-high='75+';
run;
data clinical;
  attrib tx length=3 label='Treatment Group'
         age label='Age in Years'
         gender length=$6 label='Gender'
         basedbp label='Baseline Diastolic BP'
         basesbp label='Baseline Systolic BP'
         postdbp label='Post-Treatment Diastolic BP'
         postsbp label='Post-Treatment Systolic BP'
         chgsbp  label='Change in Systolic BP'
         chgdbp  label='Change in Diastolic BP';

   drop i;

   do I=1 to 220;
     tx=ceil(ranuni(1234)*3);
     age=21+floor(ranuni(2345)*55);
     if ceil(ranuni(3456)*2)=1 then gender='Male';
     else gender='Female';
     basedbp=60+floor(ranuni(4567)*60);
     basesbp=100+floor(ranuni(5678)*90);
     postdbp=60+floor(ranuni(6789)*40);
     postsbp=100+floor(ranuni(7890)*30);
     if age<50 then postdbp=postdbp-floor(ranuni(8901)*10);
     if gender='M' then postdbp=postdbp+floor(ranuni(9012)*20);
     if tx=3 then postdbp=postdbp-floor(ranuni(123)*40);
     if basesbp-basedbp>50 then do;
       basesbp=basesbp-10; basedbp=basedbp+10;
     end;
     if postsbp-postdbp>50 then do;
       postsbp=postsbp-10; postdbp=postdbp+10;
     end;
     chgsbp=postsbp-basesbp;
     chgdbp=postdbp-basedbp;
     output;
  end;
run;
/************************************************/
/* End Create Data Set CLINICAL - Chapter 3, 18 */
/************************************************/


/***************************************************/
/* Create Data Set HR - Chapters 4, 10, 11, 14     */
/***************************************************/
proc format;
  value dept 0='Administration'
             1='Marketing'
             2='R&D'
             3,4,5='Manufacturing';
  value typej 0,1='Hourly'
              2,3,4='Salaried'
              5='Contract';
  value salft  0-39999='<$40,000'
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
  attrib Department length=$15 label='Department'
         Category   length=$10 label='Position Category'
         AnnualSalary label='Annual Salary' format=dollar10.
         HoursWeek  label='Usual Weekly Hours' format=8.1;

  keep department category annualsalary hoursweek;

  do i=1 to 397;
    Department=put(floor(ranuni(1357)*6),dept.);
    Category=put(floor(ranuni(2468)*6),typej.);
    HoursWeek=1+round((ranuni(6802)*39),.5);
    If HoursWeek>40 then HoursWeek=40;
    else if HoursWeek<12 then HoursWeek=12;
    AnnualSalary=ranuni(3579)*155000;
    AnnualSalary=round(floor(AnnualSalary*(HoursWeek/40)),500);
    If AnnualSalary<35000 then AnnualSalary=35000;
    output;
  end;
run;
/* Added this later to add country and city so department and   */
/* category counts would not be off if included this code above */
data hr;
  set hr;
  attrib Country    length=$6 label='Country'
         City       length=$13 label='City';

  keep department category annualsalary hoursweek country city;

  y=floor(ranuni(1115)*5);

  if y=0 then city='New York';
  else if y=1 then city='Toronto';
  else if y=2 then city='Mexico City';
  else if y=3 then city='San Francisco';
  else if y=4 then city='Montreal';
  else if y=5 then city='Guadalajara';
  if y in (0,3) then country='USA';
  else if y in (1,4) then country='Canada';
  else if y in (2,5) then country='Mexico';

run;
/*******************************************************/
/* End Create Data Set HR - Chapters 4, 10, 11, 14     */
/*******************************************************/


/**************************************/
/* Create Data Set CLIPS - Chapter 4  */
/**************************************/
proc format;
  value tone 0='Negative'
             1='Neutral'
             2='Positive';
  value media 1='Newspaper'
              2='Magazine'
              3='Radio'
              4='TV'
              5='Web'
              6='Other';
run;
data clips (drop=i);
  attrib Tone length=$10 label='Tone of content'
         Mentions label='Number of references to company'
         Compete label='Number of references to competition'
         Media length=$10 label='Media'
         Words label='Length of article (words)';

   do I=1 to 330;
     tone=put(floor(ranuni(1234)*3),tone.);
     mentions=ceil(ranuni(2345)*12);
     compete=ceil(ranuni(3456)*6);
     media=put(ceil(ranuni(4567)*5),media.);
     words=50+ceil(ranuni(4567)*1000);
     if compete>mentions then do;
       if tone="Neutral" then tone="Negative";
       else if tone="Positive" then tone="Neutral";
     end;
     if media='Web' then do;
       if tone="Negative" then tone="Neutral";
       else if tone="Neutral" then tone="Positive";
     end;
     if media in('Radio','TV') then words=round(words/2,1);
     output;
   end;
run;
/*****************************************/
/* End Create Data Set CLIPS - Chapter 4 */
/*****************************************/

/*****************************************/
/* Create Data Set CHEMTEST - Chapter 4  */
/*****************************************/
data chemtest;
  infile datalines missover;
  input Sample $ 1-15 ChemPPB;
datalines;
lab.57175       1250.3
desk.71309      2.53E3
lab.28009       0.940
warehouse.40035 14.30185
truck.55128     390
desk.41930      .
unknown         0.00087
;;;
/*********************************************/
/* End Create Data Set CHEMTEST - Chapter 4  */
/*********************************************/




/******************************************/
/* Create Data Set COMPLAINTS - Chapter 5 */
/******************************************/
proc format;
   value prod 0,1,2='Books'
              3,4='CDs'
              5='DVDs';
   value locate 0,1='New York'
                2,3,4='Boston'
                5='Washington, D.C.';
   value comp 0='Damaged'
              1='Not Delivered'
              2='Wrong Product'
              3='Not Satisfied'
              4='Salesperson'
              5='Price';
   value outc 0,1,2='Refund'
              3,4='Apology'
              5='Unresolved';
run;
data complaints;
  attrib Product length=$5 label='Type of Product'
         Complaint length=$13 label='Complaint Category'
         Outcome length=$10 label='Outcome of Complaint'
         Location length=$17 label='Store Location'
         NumComplaints label='Number of Complaints';
  drop i;
  do i=1 to 582;
    Product=put(floor(ranuni(1357)*6),prod.);
    Complaint=put(floor(ranuni(2468)*6),comp.);
    Outcome=put(floor(ranuni(8642)*6),outc.);
    Location=put(floor(ranuni(7531)*6),locate.);
    NumComplaints=floor(ranuni(34567)*8);
    output;
  end;
run;
/**********************************************/
/* End Create Data Set COMPLAINTS - Chapter 5 */
/**********************************************/



/******************************************/
/* Create Data Set GALLERY - Chapter 5    */
/******************************************/
data gallery;
  attrib limited length=$3 label='Limited Edition'
         medium length=$10 label='Medium'
         artist length=$6  label='Name of Artist'
         gallery length=$9 label='Name of Gallery'
         sales label='Sales'
         revenue label='Revenue' format=dollar8.
         price label='Price' format=dollar8.;
  drop i a g;

  do i=1 to 579;
    if floor(ranuni(1234)*2)=0 then limited='Yes';
    else limited='No';

    if floor(ranuni(2345)*3) in (0,1) then medium='Oil';
    else medium='Watercolor';

    a=ceil(ranuni(3456)*5);
    if a=1 then artist='Turner';
    else if a in (2,3) then artist='Smith';
    else if a=4 then artist='Doe';
    else if a=5 then artist='Knight';

    g=ceil(ranuni(4567)*3);
    if g=1 then gallery='East Side';
    else if g=2 then gallery='Downtown';
    else if g=3 then gallery='Mall';

    price=100+ceil(ranuni(6789)*1500);
    sales=3+ceil(ranuni(7890)*20);
    if limited='Yes' then do;
      price=price*3;
      sales=round(sales/2,1);
    end;
    if medium='Oil' then price=price*2;
    revenue=sales*price;

    output;
  end;
run;
/**********************************************/
/* End Create Data Set GALLERY - Chapter 5    */
/**********************************************/


/******************************************/
/* Create Data Set UNIFORMS - Chapter 5   */
/******************************************/
data uniforms;
  attrib UniformType length=$40 label='Type of Uniform'
         Color length=$5 label='Color of Uniform'
         Sales label='Uniforms Sold';
  drop i;
  do i=1 to 800;
    if i<200 then UniformType='Maid';
    else UniformType='Extremely Pretentious Doorman';

    sales=floor(ranuni(12345)*500);

    if sales>300 then color='Red';
    else if sales<100 then color='Green';
    else color='White';

    output;
  end;
run;
/**********************************************/
/* End Create Data Set UNIFORMS - Chapter 5   */
/**********************************************/



/******************************************/
/* Create Data Set TRAFFIC - Chapter 7    */
/******************************************/
proc format;
  value hwy 0,1,2='80'
            3,4  ='101'
            5    ='280';
  value locate 0,1  ='East Bay'
               2,3,4='San Francisco'
               5    ='South Bay';
  value accid 0='Disabled'
              1='Minor'
              2='Injury'
              3='Fatal';
  value outc  0-<25  ='Major Jam'
              25-<45 ='Slowdown'
              45-high='Unaffected';
run;
data traffic;
  attrib Highway   length=$3 label='Highway'
         Location  length=$13 label='Location'
         Event     length=$8 label='Event'
         Impact    length=$10 label='Effect on Traffic'
         MPH       label='Average Speed'
         TimeofDay label='Time (24 hour format)'
         Fatal     label='Accident Fatal';

   drop i;

   do i=1 to 189;
     Highway=put(floor(ranuni(1357)*6),hwy.);
     Location=put(floor(ranuni(2468)*6),locate.);
     Event=put(floor(ranuni(8642)*4),accid.);
     MPH=floor(ranuni(7531)*66);

     if highway='101' and location='East Bay' then location='San Francisco';
     else if highway='280' then location='San Francisco';

     TimeOfDay=floor(ranuni(8642)*25);
     if TimeOfDay in(6,7,8,15,16,17) then MPH=MPH/2;

     Impact=put(MPH,outc.);

     fatal=(event='Fatal');

     output;
  end;
run;
/**********************************************/
/* End Create Data Set TRAFFIC - Chapter 7    */
/**********************************************/



/******************************************/
/* Create Data Set PRODUCT - Chapter 7    */
/******************************************/
proc format;
  value yesno 0='No'
              1-high='Yes';
  value product 0,1='Widgets'
                  2='Gizmos';
  value plant 1='Pittsburgh'
              2,3='Detroit'
              4='Lansing'
              5='Milwaukee';
  value shift 1='Day'
              2='Swing'
              3='Graveyard';
run;
data product;
  attrib passed length=$3 label='Passed Inspection?'
         product length=$8 label='Product'
         plant label='Plant'
         shift length=$12 label='Shift'
         units label='Units Produced';

   drop i;

   do i=1 to 791;
     passed=put(floor(ranuni(1234)*20),yesno.);
     product=put(floor(ranuni(2345)*3),product.);
     plant=ceil(ranuni(3456)*5);
     shift=put(ceil(ranuni(4567)*3),shift.);
     units=3+ceil(ranuni(7890)*200);
     if passed='Yes' then units=units*.9;
     if plant=3 then units=units*1.1;
     if shift='Swing' then units=units*1.2;
     units=round(units,1);
     output;
   end;
run;
/**********************************************/
/* End Create Data Set TRAFFIC - Chapter 7    */
/**********************************************/



/******************************************/
/* Create Data Set VOTERS - Chapter 8     */
/******************************************/
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
  attrib gender length=$6 label='Gender'
         age    label='Age'
         party  length=$12 label='Political Affiliation'
         voted  label='Voted in Last General Election'
         income format=dollar12. label='Income';
   drop i;
   do i=1 to 276;
     gender=put(floor(ranuni(1234)*2),sex.);
     age=floor(ranuni(2345)*60)+18;
     party=put(floor(ranuni(3456)*5),party.);
     voted=floor(ranuni(4567)*2);
     income=floor(ranuni(5678)*200000)+20000;
     if income<50000 then party='Democrat';
     output;
  end;
run;
/**********************************************/
/* End Create Data Set TRAFFIC - Chapter 7    */
/**********************************************/




/******************************************/
/* Create Data Set SALESDATA - Chapter 10 */
/******************************************/
data salesdata;
  infile datalines dlm=',';
  input Type $ Sales PctCom By $;
return;
datalines;
TEL,10,0.02,cz
TEL,200,0.07,lh
WEB,3,0.02,pt
WEB,40,0.03,pt
TEL,5,0.02,lh
TEL,-15,0.02,return
WEB,70,0.03,cz
TEL,800,0.10,lh
WEB,90,0.05,cz
;;;;
/**********************************************/
/* End Create Data Set SALESDATA - Chapter 10 */
/**********************************************/

/*********************************************/
/* Create Data Set PARTSAUCTION - Chapter 12 */
/*********************************************/
data partsauction;
  length partnum 8 partdesc $40 sellerid $10;
  infile datalines dsd dlm=',';
  input partnum partdesc $ sellerid $ askprice;
  return;
  datalines;
123456,"4 Truck Tires","TYW23918",100
121212,"Sedan Shop Manual","JHC73619",15
987654,"Minivan Rearview Mirror","UEM17640",55
989898,"SUV Foglights","BND32080",125
;;;;
/*************************************************/
/* End Create Data Set PARTSAUCTION - Chapter 12 */
/*************************************************/



/*****************************************/
/* Create Data Set FASHIONS - Chapter 13 */
/*****************************************/
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
  attrib skirts length=$12 label='Skirt Length'
         heels length=$12  label='Heel Height'
         colors length=$8  label='Clothing Colors'
         sales  length=8   label='Sales';

  keep skirts heels colors sales;
  do i=1 to 510;
    Skirts=put(ceil(ranuni(1360)*6),skirtl.);
    Heels=put(ceil(ranuni(2536)*6),heelh.);
    Colors=put(ceil(ranuni(3647)*13),colorn.);
    Sales=ceil(ranuni(5869)*100000)+10000;
    output;
  end;
run;
/*********************************************/
/* End Create Data Set FASHIONS - Chapter 13 */
/*********************************************/




/******************************************/
/* Create Data Set POSITIONS - Chapter 15 */
/******************************************/
proc format;
  value dept   1='Administration'
               2,3='Sales'
               4,5='Technical';
  value grade  1,2='I'
               3,4='II'
               5='III'
               6='IV';
  value position 1-10='Trainee'
                 11-35='Specialist'
                 36-44='Manager'
                 45-49='Associate'
                 50='VP' ;
run;

data positions;
  attrib Department length=$15 label='Department'
         Grade length=$3 label='Experience Level'
         Position length=$10 label='Position'
         Salary length=8 label='Annual Compensation';

  drop i ngrade;

  do i=1 to 777;
    Department=put(ceil(ranuni(1360)*5),dept.);
    ngrade=ceil(ranuni(2536)*6);
    Grade=put(ngrade,grade.);
    Position=put(ceil(ranuni(3647)*50),position.);
    Salary=ceil(ranuni(5869)*200000)+10000;
    if position in ('Manager','Associate') then salary=salary*1.8;
    else if position='VP' then salary=salary*5;
    else if position='Trainee' then do;
      salary=salary/2;
      if salary > 60000 then salary=salary-20000;
    end;
    salary=salary*ngrade/6;
    if salary<25000 then salary=salary+20000;
    if position in ('Manager','Associate') and salary lt 60000
       then salary=salary+50000;
    output;
  end;
run;
/**********************************************/
/* End Create Data Set POSITIONS - Chapter 15 */
/**********************************************/




/******************************************/
/* Create Data Set BUILDINGS - Chapter 16 */
/******************************************/
proc format;
  value material 1,2='Wood'
                 3,4='Concrete'
                 5,6='Brick'
                 7='Steel';
  value height 1,2='1 story'
               3,4='2 stories'
               5='mid-rise'
               6='high-rise';
  value type 1='Retail'
             2,3,4,5='Residential'
             6,7='Office'
             8,9='Warehouse';
run;

data buildings;
  attrib Material length=$8 label='Primary construction material'
         Height length=$12 label='Building height'
         Type length=$12 label='Building type'
         CostSqFt label='Cost per square foot' format=dollar10.;

  drop i ntype;
  do i=1 to 342;
    material=put(ceil(ranuni(1360)*7),material.);
    height=put(ceil(ranuni(2536)*6),height.);
    ntype=ceil(ranuni(3647)*9);
    type=put(ntype,type.);
    costsqft=ceil(ranuni(5869)*200)+200;

    if height='high-rise' then do;
      material='Steel';
      type='Office';
    end;
    else if height='mid-rise' then do;
      if material='Wood' then material='Concrete';
      if ntype=2 then type='Retail';
      else if ntype in (3,4) then type='Office';
      else if ntype=5 then type='Warehouse';
    end;
    if ntype in (2,3,4,5) and material='Steel' then material='Wood';
    output;
  end;
run;
/**********************************************/
/* End Create Data Set BUILDINGS - Chapter 16 */
/**********************************************/



/******************************************/
/* Create Data Set PAINTS - Chapter 17    */
/******************************************/
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
  attrib Type length=$8 label='Type of Finish'
         Base length=$5 label='Base'
         Color length=$6 label='Color'
         Warranty label='Year of Warranty'
         Price format=dollar8.2;
  drop i;
  do i=1 to 767;
    Type=put(ceil(ranuni(9876)*6),type.);
    Base=put(ceil(ranuni(8765)*3),base.);
    Color=put(ceil(ranuni(7654)*9),color.);
    Warranty=floor(ranuni(5869)*10)+2;
    Price=(ranuni(4321)*10)+5.99;
    output;
  end;
run;
/**********************************************/
/* End Create Data Set PAINTS - Chapter 17    */
/**********************************************/


/******************************************/
/* Create Data Set FURNITURE - Chapter 19 */
/******************************************/
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

data furniture;
  attrib Type length=$6 label='Type of Table'
         Material length=$12 label='Table Material'
         Color length=$8 label='Color of Table'
         Height label='Height of Table'
         Price format=dollar12.2 label='Table Price';

  drop i;

  do i=1 to 2043;
    type=put(ceil(ranuni(9876)*6),type.);
    material=put(ceil(ranuni(8765)*5),material.);
    color=put(ceil(ranuni(7654)*7),color.);

    if type='Dining' then height=floor(ranuni(5869)*10)+15;
    else if type='Coffee' then height=floor(ranuni(5869)*10)+28;
    else if type='End' then height=floor(ranuni(5869)*10)+20;

    price=(ranuni(4321)*300)+49.99;
    if material=:'Glass' then price=price*2;
    if type in ('Coffee' 'End') then price=price/4;
    price=max(price,49.99);

    output;
  end;
run;
/**********************************************/
/* End Create Data Set FURNITURE - Chapter 19 */
/**********************************************/



/****************************************************************/
/* Create Data Set CANDYBARS, PIESTATS, MOVIEPLOTS - Chapter 20 */
/****************************************************************/
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
  value PieAbbr  1='BB'
                 2,3,4,5='AP'
                 6,7='CH'
                 8='BC'
                 9='PC'
                10='LM';
  value Theme 1,2,3='Drama'
              4,5='Comedy'
              6,7,8='Action'
              9='Thriller';
run;

data CandyBars(keep=Filling Sales Chocolate Year)
     PieStats (keep=PieType Sales Year pieabbr)
     MoviePlots(keep=Theaters TicketsSold Theme Year Sales Concessions);

  attrib Filling length=$8
         Sales format=dollar14.
         Chocolate length=$6
         Year label='Year of Sales'
         PieType length=$15 label='Type of Pie'
         PieAbbr length=$2 label='Abbreviation for Type of Pie'
         Theaters label='Number of Theaters'
         TicketsSold label='Number of Theater Tickets Sold'
         Theme length=$10 label='Movie Theme'
         Concessions label="Sales for Theater Concessions" format=dollar14.;


  do i=1 to 547;
    Chocolate=put(ceil(ranuni(1472)*6),choc.);
    Filling=put(ceil(ranuni(5836)*8),filling.);
    num = ceil(ranuni(9014)*10);
    PieType=Put(num,pietype.);
    PieAbbr=Put(num,pieabbr.);
    Sales=(ranuni(3690)*134567)+50000;
    Year=ceil(ranuni(9638)*3)+2005;
    numt=ceil(ranuni(7258)*9);
    Theme=put(numt,theme.);

    TicketsSold=(ranuni(1472)*30000)+10000;
    If Theme='Action/Adventure' then TicketsSold=TicketsSold*1.5;
    Else If Theme='Drama' Then TicketsSold=TicketsSold*.5;
    Else If Theme='Comedy' Then TicketsSold=TicketsSold*1.25;

    Theaters=(TicketsSold/1000)+ceil(ranuni(5836)*10000);
    Concessions = (Sales/777)+(_n_ * 10)-(_n_ * 13);

    if concessions lt 1000 then concessions = concessions + 1113;
    if concessions lt 1500 then do;
      diff = 1500 - concessions;
      concessions = concessions + diff + (ranuni(_n_)*133);
    end;
    ticketssold = round(ticketssold,1);
    sales = round(sales,.01);
    theater = round(theaters,.01);
    concessions = round(concessions,.01);
    output;
  end;
run;
/********************************************************************/
/* End Create Data Set CANDYBARS, PIESTATS, MOVIEPLOTS - Chapter 20 */
/********************************************************************/
