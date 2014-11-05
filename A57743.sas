/*-------------------------------------------------------------------*/
/*    Debugging SAS Programs: A Handbook of Tools and Techniques     */
/*                      by Michele M. Burlew                         */
/*       Copyright(c) 2001 by SAS Institute Inc., Cary, NC, USA      */
/*                   SAS Publications order # 57743                  */
/*                        ISBN 1-58025-927-8                         */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* This material is provided "as is" by SAS Institute Inc.  There    */
/* are no warranties, expressed or implied, as to merchantability or */
/* fitness for a particular purpose regarding the materials or code  */
/* contained herein. The Institute is not responsible for errors     */
/* in this material as it now exists or will exist, nor does the     */
/* Institute provide technical support for it.                       */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Questions or problem reports concerning this material may be      */
/* addressed to the author:                                          */
/*                                                                   */
/* SAS Institute Inc.                                                */
/* Books by Users                                                    */
/* Attn: Michele Burlew                                              */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  sasbbu@sas.com             */
/* Use this for subject field:                                       */
/*     Comments for Michele Burlew                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated: 22OCT01                                        */
/*-------------------------------------------------------------------*/


/***************************************************************/
/* This data set contains information about the items in       */
/* circulation from the corporate library. The DATA step       */
/* generates 446 observations by using DO loops and random     */
/* number functions to fabricate the data. It obtains          */
/* information from CORPLIB.ITEMS and CORPLIB.EMPLOYEES to     */
/* retain in the observations.                                 */
/***************************************************************/
data corplib.circul(label='Corporate Library Circulation');

  attrib itemid   length=$10  label='Library Book Id'
         copynum  length=4    format=2.
                  label='Copy Number'
         checkout length=8    informat=mmddyy10.
                  format=mmddyy10. label='Check Out Date'
         duedate  length=8    informat=mmddyy10.
                  format=mmddyy10. label='Due Date'
         empno    length=8    label='Employee Number'
                  format=z6.
         canrenew length=$1   label='Item Can be Renewed'
         nrenew   length=3    label='Number of Renewals'
         checkin  length=8    informat=mmddyy10.
                  format=mmddyy10. label='Check In Date'
  ;
  drop i d dsid rc nemps nitems r;

  /* Obtain the total number of items in ITEMS data set */
  dsid=open('corplib.items');
  nitems=attrn(dsid,'NOBS');
  rc=close(dsid);

  /* Obtain the total number of emps in EMPLOYEES data set */
  dsid=open('corplib.employees');
  nemps=attrn(dsid,'NOBS');
  rc=close(dsid);

  do i=1 to 446;
    /* Randomly pick an item from the ITEMS data set */
    getobs=nitems*uniform(21)+1;
    set corplib.items(keep=itemid copynum) point=getobs;

    /* Randomly pick an employee from the EMPLOYEES data set
       who will be assigned the item */
    getobs=nemps*uniform(22)+1;
    set corplib.employees(keep=empno) point=getobs;

    /* Randomly determine a checkout date */
    d=round(185*uniform(44)+1,1.);
    r=round(30*uniform(55)+1,1.);
    checkout=datejul(2000000+d);
    duedate=checkout+30;

    /* Assign a few checkouts to be checked in */
    if r in (3,7,11,15,16,28,29) then
      checkin=checkout+d+r;
    else checkin=.;

    /* Assign a few as multiple renewals and as items that
       cannot be renewed */
    canrenew='Y';
    nrenew=0;
    if mod(i,32)=1 then nrenew=nrenew+1;
    if mod(i,46)=1 then nrenew=nrenew+1;
    if mod(i,88)=1 then nrenew=nrenew+1;
    if nrenew > 1 then canrenew='N';
    if mod(i,18)=1 then canrenew='N';
    output;

    /* Stop at 446 observations */
    if i ge 446 then stop;
  end;
run;

/***************************************************************/
/* This data set contains information about the distributors   */
/* from whom the corporate library purchases items. The DATA   */
/* step generates 5 observations by using DO loops and random  */
/* number functions to fabricate the data.                     */
/***************************************************************/
data corplib.distrib(label='Book Distributors');

  attrib distid   length=$4  label='Distributor ID'
         distname length=$25 label='Distributor Name'
         distaddr length=$30 label='Distributor Address'
         distcity length=$25 label='Distributor City'
         diststat length=$2  label='Distributor State'
         distzip  length=8   label='Distributor Zip Code'
         distphon length=8   label='Distributor Phone Number'
         distfax  length=8   label='Distributor Fax Number';

  drop i;

  do i=1 to 5;
    distid='D' || put(i,z3.);
    distname='Distributor ' || put(i,1.);
    distaddr='Distributor ' || put(i,1.);
    distcity='Distributor ' || put(i,1.);
    if i=1 then do;
      diststat='NY';
      distzip=13021;
      distphon=3155555555;
      distfax=3155555555;
    end;
    else if i=2 then do;
      diststat='IL';
      distzip=60000;
      distphon=3125555555;
      distfax=3125555555;
    end;
    else if i=3 then do;
      diststat='CA';
      distzip=94000;
      distphon=9255555555;
      distfax=9255555555;
    end;
    else if i=4 then do;
      diststat='MN';
      distzip=55100;
      distphon=6515555555;
      distfax=6515555555;
    end;
    else if i=5 then do;
      diststat='PA';
      distzip=19000;
      distphon=2155555555;
      distfax=2155555555;
    end;
    output;
  end;
run;

/***************************************************************/
/* This data set contains information about the employees of   */
/* the corporation. The DATA step generates 3,210 observations */
/* by using DO loops and random number functions to fabricate  */
/* the data.                                                   */
/***************************************************************/
data corplib.employees(label='Corporate Employees');

  attrib empno    length=8     label='Employee Number'
                  format=z4.
         empln    length=$25   label='Employee Last Name'
         empfn    length=$15   label='Employee First Name'
         empaddr  length=$35   label='Employee Address'
         empcity  length=$25   label='Employee City'
         empstate length=$2    label='Employee State'
         empzip   length=8     label='Employee Zip Code'
         empphone length=8     label='Employee Phone'
         empdept  length=8     label='Employee Department'
                  format=z6.
  ;

  drop i m;

  /* Generate 3210 employees */
  do i=1 to 3210;
    empno=1000+i;
    empln='Last' || left(put(i,3.));
    empfn='First' || left(put(i,3.));
    empaddr=put(1000*uniform(25),4.) || ' Address Road';
    m=mod(i,8)+1;
    empcity='City ' || left(put(m,1.));
    if mod(m,2)=0 then do;
      empstate='NY';
      empzip=14000+m;
      empphone=7165555550+i;
    end;
    else if mod(m,5)=0 then do;
      empstate='NJ';
      empzip=00000+m;
      empphone=6095555550+i;
    end;
    else if mod(m,3)=0 then do;
      empstate='GA';
      empzip=30000+m;
      empphone=4045555550+i;
    end;
    else do;
      empstate='IL';
      empzip=61100+m;
      empphone=9935555550+i;
    end;
    output;
  end;
run;

/***************************************************************/
/* This data set contains information about the items in the   */
/* corporate library. The DATA step generates 3,750            */
/* observations by using DO loops and random number functions  */
/* to fabricate the data.                                      */
/***************************************************************/
data corplib.items(label='Corporate Library Items');

  attrib itemid   length=$10  label='Library Book Id'
         title    length=$100 label='Title'
         author   length=$50  label='Author'
         copynum  length=4    format=2.
                  label='Copy Number'
         callnum  length=8    label='Call Number'
                  format=7.2
         publish  length=$50  label='Publisher'
         pubcity  length=$50  label='City where Published'
         pubyear  length=4    label='Year Published'
         libsect  length=$11  label='Library Section'
         itemtype length=$1   label='Type of Material'

         orderdat length=8    informat=mmddyy10.
                  format=mmddyy10. label='Order Date'
         ordernum length=3    label='Order Number'

         itemcost length=8    format=dollar6.2
                  label='Cost of Item'

         subscdat length=8    informat=mmddyy10.
                   ormat=mmddyy10.
                  label='Subscription Renewal Date'
  ;

  retain sect1 'Reference' sect2 'Science'
         sect3 'Business'  sect4 'Computers'
         sect5 'General'   sect6 'Serials';

  drop i m p sect1-sect6;
  array sect{6} sect1-sect6;

  /* Randomly generate 3000 items in the library */
  do i=1 to 3000;
    author='Last' || left(put(i,3.)) || ',  First' ||
            left(put(i,3.));
    title='Title ' || left(put(i,3.));
    callnum=4000*uniform(10)*.1;
    copynum=1;
    p=10*uniform(5);
    publish='Publisher ' || left(put(p,2.));
    pubcity='City ' || left(put(p,2.));
    pubyear=1995 + round(p,1);
    itemid='LIB' || put(1000*uniform(100),z4.);

    /* Assign a library section to the item */
    m=mod(i,6)+1;
    libsect=sect{m};

    /* Assign a material type to the item */
    if 2 le m le 5 then itemtype='B';
    else if m=1 then itemtype='R';
    else if m=6 then itemtype='S';
    output;

    /* Generate multiple copies of selected items */
    if mod(i,16)=1 then do;
      copynum=copynum+1;
      output;
    end;
    if mod(i,22)=1 then do;
      copynum=copynum+1;
      output;
    end;
    if mod(i,34)=1 then do;
      copynum=copynum+1;
      output;
    end;
    if mod(i,44)=1 or mod(i,32)=1 then do;
      title='Title 2-' || left(put(i,3.));
      callnum=4000*uniform(10)*.1;
      copynum=1;
      p=10*uniform(4);
      publish='Publisher ' || left(put(p,2.));
      pubcity='City ' || left(put(p,2.));
      pubyear=1995 + round(p,1);
      itemid='LIB' || put(1000*uniform(99),z4.);
      m=mod(i,6)+1;
      libsect=sect{m};
      if 2 le m le 5 then itemtype='B';
      else if m=1 then itemtype='R';
      else if m=6 then itemtype='S';
      output;
      if mod(i,16)=1 then do;
        copynum=copynum+1;
        output;
      end;
      if mod(i,22)=1 then do;
        copynum=copynum+1;
        output;
      end;
      if mod(i,34)=1 then do;
        copynum=copynum+1;
        output;
      end;
    end;
  end;
run;

/***************************************************************/
/* This data set contains information about the orders placed  */
/* by the corporate library. The DATA step generates 53        */
/* observations by using DO loops and random number functions  */
/* to fabricate the data.                                      */
/***************************************************************/
data corplib.orders(label='Corporate Library Orders');

  keep ordernum ordrdate nitems distid ordertot datercvd ;
  attrib ordernum label='Order Number' format=z4.
         ordrdate informat=mmddyy10. format=mmddyy10.
                  label='Order Date'
         nitems   label='Number of Items Ordered' format=4.
         distid   length=$4 label='Distributor ID'
         ordertot label='Order Total' format=dollar10.2
         datercvd informat=mmddyy10. format=mmddyy10.
                  label='Date Order Received'
  ;

  /* Set starting date */
  baseval='31DEC1998'd;

  /* Generate 53 orders */
  do ordernum=1 to 53;
    /* Determine a distributor id for the order */
    dnum=int(5*uniform(55))+1;
    if mod(ordernum,3)=1 then dnum=2;
    distid='D' || put(dnum,z3.);

    /* Determine a date for the order */
    ordrdate=baseval+int(30*uniform(33));
    baseval=ordrdate;
    if ordernum not in (37,48,50,51,53) then
      datercvd=ordrdate+int(60*uniform(66));
    else datercvd=.;

    /* Determine the number of items and average price per
       item for the order */
    nitems=int(20*uniform(22))+1;

    avgprice=(20*uniform(222))+20;
    ordertot=nitems*avgprice;
    output;
  end;
run;

