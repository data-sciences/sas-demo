/**********************************************************************/
This file contains programs that appear in the book "SAS(R) Programming
Tips: A Guide to Efficient SAS Programming," pubcode 56150. 

Copyright (C) 1995 by SAS Institute Inc., Cary, NC, USA

SAS(R) is a registered trademark of SAS Institute Inc.

SAS Institute does not assume responsibility for the accuracy of
any material presented in this file.
/**********************************************************************/


/*
The following example code appears in Chapter 4, "Read and Write Data
Selectively."
*/

   data oct90;
      infile file-specification;
      input jday rcode $ sales exps
            salhrs exphrs invin
            invout;
   run;


   data oct90;
      infile file-specification\obe ;
      input jday 1 sales 5-13
            invout 42-50;
   run;



   data year90.sales;
      infile file-specification;
      input month sales3
            sales18 . . .;

      more SAS statements

   run;

   data aug90.sales;
      set year90.sales;
      if month=8;
   run;

   proc means data=aug90.sales;

       more SAS statements

   run;


   data aug90.sales;
      infile file-specification;
      input month 1 @;
      if month=8 then
         do;
            input sales3 3-9 . . .;

            more SAS statements

         end;
      else delete;

      more SAS statements

   run;

   proc means data=aug90.sales;

      more SAS statements

   run;


   data in;
      infile file-specification;
      input . . .;

      more SAS statements

   run;

   proc means data=in;

      more SAS statements

   run;


   libname mylib
           'SAS-data-library';

   proc means data=mylib.in;

      more SAS statements

   run;



   proc summary
        data=big.dataset nway;
      class x y;
      var a;
      output out=summary;
   run;

   data report;
      set summary;
      put x y a=;

      more SAS statements

   run;

   proc summary
        data=big.dataset nway;
      class x y;
      var b;
      output out=summary;
   run;

   proc chart data=summary;
      vbar b;
   run;


   proc summary
        data=big.dataset nway;
      class x y;
      var a b;
      output out=small.summary;
   run;

   data report;
      set small.summary;
      put x y a=;

      more SAS statements

   run;

   proc chart data=small.summary;
      vbar b;
   run;



   data short.rpt;
      infile file-specification;
      retain datx '17JUL90'd;
      input charges 1-8  de $ 9
            date mmddyy8.;
      if upcase( de)='A' and
         date lt datx  then
         do i=1 to 5;

         more SAS statements

   run;


   data short.rpt;
      infile file-specification;
      drop  code i;
      input charges 1-8  de $ 9
            date mmddyy8.;
      if upcase(co de)='A' and
         date lt '17JUL90'    then
         do i=1 to 5;

         more SAS statements

   run;



   data stocks.gainers;
      set stocks.oct;
      keep numshrs company;
      if net gt 0 then
         do;
            tot=net*numshrs;
            put  mpany numshrs;
            output;
         end;
   run;


 
   data stocks.gainers;
      set stocks.oct
          (keep= numshrs  mpany net);
      drop net;
      if net gt 0 then
         do;
            tot=net*numshrs;
            put  company numshrs;
            output;
         end;
   run;

   data a;
      set master;
      if sco re1;
   run;

   data b;  
      set master;
      if score1 and age lt 20;
   run;

   data c;  
      set master;
      if score1 and age ge 20;
   run;


   data a b c;  
      set master;
      if score1 then
         do;
            output a;
            if age lt 20
               then output b;
            else output c;
         end;
   run;



   data in;
      infile file-specification;
      input x $10. y $10. z $10.;
      drop x y z;
      if upcase(left(x))='ONE'
         then xnum=1;
      else if upcase(left(x))='TWO'
         then xnum=2;

      more SAS statements
   run;

   libname library
           library-specification;

      /* Run this step once to */
      /* create the informat.  */
   proc format library=library;
      invalue $onetwo (just upcase)
         'ONE'=1 'TWO'=2 'THREE'=3;
   run;

   data in;
      infile file-specification;
      input xnum $onetwo10.    
            ynum $onetwo10.
            znum $onetwo10.;

      more SAS statements
   run;

   data inv.partrec;
      infile file-specification;
      input slsman $ qty;
      select(slsman);
         when('FISHER')
           part='GALVANOMETER';
         when('SUAREZ')
           part='COMPRESSION FILTER';

         more SAS statements   run;


   proc format library=library;
      invalue $slname
              'FISHER'='F'
              'SUAREZ'='S';
      value $slname
            'F'='FISHER'
            'S'='SUAREZ';
      invalue $pname
              'F'='BG' 'S'='PCF';
      value $pname
            'BG'='GALVANOMETER'
            'PCF'='COMPRESSION FILTER';
   run;

 data inv.partrec;
      infile file-specification';
      input slsman : $slname. qty;
      part=input(slsman,$pname.);
      attrib slsman format=$slname.
             part format=$pname.;

      more SAS statements
   run;


   data _null_;
      infile file-specification;
      input    $char200. c2 $char200.
            c3 $char200.;
      file longr;
      substr(c1,10,1)='X';
      substr(c2,100,1)='X';
      substr(c3,100,1)='X';
      put (c1-c3) ($char200.);
   run;


   data _null_;
      infile file-specification;
      input;
      file longr;
      put _infile_ @10 'X'
                   @300 'X'
                   @500 'X';
   run;

   data _null_;
      infile longr;
      input;
      file longr;
      put _infile_ @10 'X'
                   @300 'X'
                   @500 'X';
   run;

   data _null_;
      infile longr  sharebuffers;
      input;
      file longr;
      put @10 'X'
          @300 'X'
          @500 'X';
   run;

   data stasu.dnoterec;
      set stasu.dnote3;
      if in_date gt '14APR90'd;
   run;

      /* Run this step once to */
      /* create the index.     */
   proc datasets library=stasu;
      modify dnote3;
      index create in_date;
   run;

   data stasu.dnoterec;
      set stasu.dnote3;
      where in_date gt '14APR90'd;
   run;

      /* Null Merge Technique */
   proc sort data=trans;
      by id;
   run;

   data _null_;
      merge master(in=inm)
            trans(in=int)
            end=endf;
      by id;
      if int then do;
         if inm then do;
            put / 'FOUND: '
                @15 id=
                @30 name=;
            fnd+1;
         end;
         else do;
            put / 'NOT FOUND: '
                @15 id=;
            nfnd+1;
         end;
      end;
      if endf then do;
         put / 'TOTAL FOUND: '
             @40 fnd;
         put / 'TOTAL INVALID: '
             @40 nfnd /;
      end;
   run;

      /* Binary Search Technique */
   data _null_;
      set trans
          (rename=(id=trid))end=endf;
      low=1;
      flag=1;
      up=nobs;
      do while(flag);
         mid=ceil((up+low)/2);
         set master point=mid
                    nobs=nobs;
         if id<trid then low=mid+1;
         else if id>trid
                 then up=mid-1;
         else do;
            put /'FOUND: '@15 trid=
                          @30 name=;
            fnd+1;
            flag=0;
         end;
         if low>up then do;
            put / 'NOT FOUND: '
               @15 trid=;
            nfnd+1;
            flag=0;
         end;
      end;
      if endf then
         do;
            put / 'TOTAL FOUND: '
               @40 fnd;
            put / 'TOTAL INVALID: '
               @40 nfnd /;
         end;
   run;

************************************************************************
/*The following example code appears in Chapter 5, "Execute Only the
Statements You Need, in the Order You Need Them."*/

   data scores;
      infile file-specification;
      input test1-test3;

         /* Same values for X & Y */
         /* in every iteration    */
      x=5;
      y="&sysdate"d; 
   run;
   

   data scores;

         /* Same values for X & Y */
         /* in every iteration    */
      retain x 5 y "&sysdate"d;  
      infile file-specification;
      input test1-test3;
   run;


   %let base=1000;
   libname save 'SAS-data-library';

   data big;
      retain b &base;  
      set save.overnite;
      goal=productn=&base;
      lowpt=min(&base,avg);

      more SAS statements
   run;

   %let base=1000;
   libname save 'SAS-data-library';

   data big;
      set save.overnite;
      goal=productn+&base;
      lowpt=min(&base,avg);

      more SAS statements

   run;


   %let today1=520;
   %let today2=650;
   %let today3=800;
   %let today4=149;
   %let today5=720;

      /* Add 10 terms      */
      /* in each iteration */
   data current;
      infile file-specification ;
      input base1-base5;
      total=base1  + &today1  
            +base2 + &today2  
            +base3 + &today3  
            +base4 + &today4  
            +base5 + &today5;
   run;

   %let today1=520;
   %let today2=650;
   %let today3=800;
   %let today4=149;
   %let today5=720;

      /* Add 6 terms       */
      /* in each iteration */
   data current;
      infile file-specification;
      input base1-base5;
      total=base1 + base2
            +base3 + base4
            +base5 + &today1
            +&today2 + &today3
            +&today4 + &today5   ;
   run;


   data planes;
      input number city $;
      if city='Rome' then flight=654;
      if city='Dakar' then
         flight=230;
         city='Riga' then flight=165;
      cards;
   6602 Rome
   8304 Dakar
   5990 Riga
   4598 Rome
   2300 Rome
   1600 Dakar
   9400 Rome
   2812 Riga
   3379 Rome
   ;


   data planes;
      input number city $;

         /* IF-THEN/ELSE    */
      if city='Rome' then flight=654;
      else if  city='Dakar' then
           flight=230;
      else if    city='Riga' then
           flight=165;
      cards;

   data lines
   ;

   data planes;
      input number city $;

         /* SELECT without a  */
         /* SELECT expression */
         select;
         when(city='Rome')
             flight=654;
         when(city='Dakar')
             flight=230;
         when(city='Riga')
             flight=165;
         end;  
      cards;

   data lines
   ;

   data planes;
      input number city $;

         /* SELECT with a SELECT */
         /* expression           */
         select (city);
         when\   ('Rome')
             flight=654;
         when\   ('Dakar')
             flight=230;
         when\   ('Riga')
             flight=165;
         end;  
      cards;

   data lines
   ;

   libname in '\ob SAS-data-library\obe ';

   data india1 italy1 iceland1;
      set in.worldpop;

         /* India is most likely */
      select(country);
         when('Iceland') output
             iceland1;
         when('Italy') output
             italy1;
         when('India') output
             india1;
         otherwise;
      end;
   run;

   libname in 'SAS-data-library';

   data india1 italy1 iceland1;
      set in.worldpop;

         /* India is most likely */
      select(country);
         when('India') output
             india1;
         when('Italy') output
             italy1;
         when('Iceland') output
             iceland1;
         otherwise;
      end;
   run;


   data test;
      infile file-specification;
      input t1-t5;

         /* t1 is often missing */
      score=+t2/2+t3/3+t4/4+t5/5;
   run;

   data temp;
      infile file-specification;
      input t1-t5;

         /* t1 is often missing */
      score=t2/2+t3/3+t4/4+t5/5+t1;
   run;


      /* OFTMISS is often missing */
      /* Missing value propagates */
      /* and is assigned to COST, */
      /* TAX, and PROFIT          */
   data a;
      infile file-specification;
      input oftmiss wholsale sales;
      cost=wholsale+oftmiss;
      tax=oftmiss*.05;
      profit=sales-oftmiss;  
   run;

      /* OFTMISS is often missing  */
      /* When OFTMISS is missing,  */
      /* use default missing values*/
      /* for COST, TAX, & PROFIT-- */
      /* bypass propagation        */
   data a;
      infile file-specification;
      input oftmiss wholsale sales;
      if oftmiss ne . then
         do;  
            cost=wholsale+oftmiss;
            tax=oftmiss*.05;
            profit=sales-oftmiss;
         end;
   run;


   data record;
      input store $ invntry avgsales
            year;
      if invntry<10000 then
         do;
            put 'Reorder now: '
                 store= invntry=;
            delete;
         end;
      else
         do month=1 to 12
            while(invntry>10000);
            restock=invntry-avgsales;
            if year=. then year=1990;
      keep store month year;
      cards;
   Raleigh 16000 500 1989
   Cary 18000 1000 .
   Wilson 9000 600 1990
   ;

   data record;
      input store $ invntry avgsales
            year;
      if year=. then year=1990;  
      if invntry<10000 then
         do;
            put 'Reorder now: '
                 store= invntry=;
            delete;
         end;
      else
         do month=1 to 12
            while(invntry>10000);
            restock=invntry-avgsales;
         end;
      keep store month year;
      cards;
   Raleigh 16000 500 1989
   Cary 18000 1000 .
   Wilson 9000 600 1990
   ;


   libname in 'SAS-data-library';

   data new;
      set in.finance;
      length money $ 7;
      if country='US' then
         money='Dollar';
      else if country='Mexico' then
           money='Peso';
      else if country='Japan' then
           money='Yen';
      else if country='Israel' then
           money='Shekel';
      else if country='Spain' then
           money='Peseta';
      else if country='Greece' then
           money='Drachma';
      else if country='India' then
           money='Rupee';
      else if country='Iceland' then
           money='Koruna';  
   run;
   

   libname in 'SAS-data-library';

   proc format;
      value $money
            'US'='Dollar'
            'Mexico'='Peso'
            'Japan'='Yen'
            'Israel'='Shekel'
            'Spain'='Peseta'
            'Greece'='Drachma'
            'India'='Rupee'
            'Iceland'='Koruna';
   run;

   data new;
      set in.finance;
      money=put(country,$money.);  
   run;

      /* mean of non-missing costs */
      /* note programming for      */
      /* missing values            */
   data getmeans;
      array c{10} cost1-cost10;
      input c{*};
      tot=0;
      totcost=0;
      do i=1 to 10;
         if c{i} ne . then
            do;
               tot+1;
               totcost+c{i};
            end;
      end;
      if tot>0 then
         meancost=totcost/tot;
      else meancost=.;  
      cards;
   1 2 3 4 5 6 7 8 9 10
   10 . 30 . 50 . 70 . 90 .
   ;

      /* mean of non-missing costs */
      /* missing values are handled*/
      /* automatically             */
   data getmeans;
      input cost1-cost10;
      meancost=mean(of cost1-cost10);  
      cards;
   1 2 3 4 5 6 7 8 9 10
   10 . 30 . 50 . 70 . 90 .
   ;

      /* get last name */
   data lastname;
      length last $ 25;
      input name $ 1-25;
      n=1;
      do until(scan(name,n,' ')=' ');
         n+1;
      end;
      last=scan(name,n-1,' ');  
      cards;
   Christopher A. Jones
   Ann Siu
   Ernst Otto Jacob Grosz
   Julia Lincoln Romero
   ;
   

      /* get last name */
   data lastname;
      length last $ 25;
      input name $ 1-25;
      last=reverse(scan
           (reverse(name),1,' '));  
      cards;
   Christopher A. Jones
   Ann Siu
   Ernst Otto Jacob Grosz
   Julia Lincoln Romero
   ;

   data address;
      infile file-specification;
      input street $ number;
      if street='Maple' or
         street='Elm' or
         street='Willow' or
         street='Birch' or
         street='Dogwood' or
         street='Ash'  then
         city='Raleigh';
      else city='Cary';
   run;

   data address;
      infile file-specification;
      input street $ number;
      if  street in
         ('Maple','Elm','Willow',
         'Birch','Dogwood','Ash')  
         then city='Raleigh';
      else city='Cary';
   run;

   data jobs;
      infile file-specification;
      input status1-status8 jobnum;
      if  status1=3 and
         status2=7 and
         status3=9 and
         status4=1 and
         status5=44 and
         status6=6 and
         status7=4 and
         status8=1 then output;
      drop status1-status8;
   run;
   

   data jobs;
      infile file-specification;
      input status1-status8 jobnum;
      if    status1=3 then
       if status2=7 then
        if status3=9 then
         if status4=1 then
          if status5=44 then
           if status6=6 then
            if status7=4 then
             if status8=1    then
         output;
      drop status1-status8;
   run;

   libname in 'SAS-data-library-1';
   libname new 'SAS-data-library-2';

   data in.master;
      update in.master new.trans;
      by transid;
   run;

   more DATA and PROC steps
   

   libname in 'SAS-data-library-1';
   libname new 'SAS-data-library-2';

   data _null_;
      if number=0 then
         do;
            file print;
            put '**************' /
                '* no changes *' /
                '* job ends   *' /
                '**************';
            abort return;
         end;
      stop;
      set new.trans nobs=number;
   run;

   data in.master;
      update in.master new.trans;
      by transid;
   run;

   more DATA and PROC steps


      /* 20,000 iterations */
      /* 30,000 increments */
   data loops;
      do a=1 to 10000;
         do b=1 to 2;
  
            more SAS statements

         end;
      end;
   run;
   

      /* 20,000 iterations */
      /* 20,002 increments */
   data loops;
         do b=1 to 2;
         do a=1 to 10000;
  
            more SAS statements

         end;
      end;
   run;

   data scores;
      infile file-specification;
      input test1-test6;
      array test{6} test1-test6;

         /* Needed for calculation */
        array cutoff{6} s1-s6
            (100 90 80 70 60 50);  
      do i=1 to 6;
         if test{i}>=cutoff{i} then
            output;
      end;
      drop s1-s6;  
   run;
  

   data scores;
      infile file-specification;
      input test1-test6;
      array test{6} test1-test6;

         /* Needed for calculation */
         array cutoff{6} _temporary_
            (100 90 80 70 60 50);  
      do i=1 to 6;
         if test{i}>=cutoff{i} then
            output;
      end;
   run;

   data cities;
      infile file-specification;
      input oldpop city $ newpop;
      if oldpop>=800000 then  link
         more;  
      if city='London' then   link
         more;  
      if newpop>1000000 then
         do;
            link more;
            link most;  
         end;
      return;

      more:

      additional SAS statements

      return;

      most:
      
      additional SAS statements

      return;
   run;

   %macro more(add);

      SAS statements

      %if &add ne %then
         %do;
            additional SAS statements
         %end;
   %mend more;

   data cities;
      infile file-specification;
      input oldpop city $ newpop;
      if oldpop>=800000 then

         /*DO group allows for    */
         /*multiple SAS statements*/
         /*generated by the macro */
         do;
            %more()  
         end;
      if city='London' then
         do;
             %more()  
         end;
      if newpop>1000000 then
         do;
             %more(yes)  
         end;
   run;

   data _null_;
      set huge;
      income+(bonds*.06);
      call symput('inc',income);  
   run;

   data _null_;
      set huge  end=last   ;
      income+(bonds*.06);
      if last then
         call symput('inc',income);  
   run;

   data children;
      infile file-specification ;
      input  c1-c10;

         /* half in group 1 */
      array group1{5} c1-c5;

         /* all in group 2  */
      array group2{10} c1  - c10;  
      do i=1 to 5;
         group1{i}=group1{i}+10;
      end;
      do j=1 to 10;  
         group2{j}=group2{j}+10;
      end;

      more SAS statements

   run;

   data children;
      infile file-specification;
      input  c1-c10;

         /* half in group 1 */
      array group1{5} c1-c5  ;

         /* half in group 2  */
         /* use array bounds */
         /* for convenience  */
      array group2{6:10} c6-c10;  
      do i=1 to 5;
         group1{i}=group1{i}+20;
      end;

         /* change bounds of DO */
         /* loop to match array */
         do j=6 to 10;\  
         group2{j}=group2{j}+10;
      end;

      more SAS statements

   run;


      /* two retained, two not */
   data income;
      retain tax 600 fee 45;  
      array pay{4} tax fee rent
            lease;
      infile file-specification;
      input rent lease;
      do i=1 to 4;
         if pay{i}=. then pay{i}=0;
         pay{i}=pay{i}*1.05;
      end;
   run;

      /* all retained */
   data income;
      retain tax 600 fee 45 rent
         lease;\  
      array pay{4} tax fee rent
            lease;
      infile file-specification;
      input rent lease;
      do i=1 to 4;
         if pay{i}=. then pay{i}=0;
         pay{i}=pay{i}*1.05;
      end;
   run;

      /* up to 20,000 subtractions */
   data new;
      set old(keep=t1-t50 base
          obs=100);
      array test{50} t1-t50;
      do i=1 to 50;\  
         if test{i}=. then test{i}=0;
         if test{i}<base then
            test{i}=base;
      end;
   run;

      /* no subtractions */
   data new;
      set old(keep=t1-t50 base
          obs=100);
      array test{0:49} t1-t50;
      do i=0 to 49;\  
         if test{i}=. then test{i}=0;
         if test{i}<base then
            test{i}=base;
      end;
   run;

   data new;
      infile file-specification;
      input t1q1-t1q10 t2q1-t2q10
            t3q1-t3q10;
      array test1(j) t1q1-t1q10;
      array test2(j) t2q1-t2q10;
      array test3(j) t3q1-t3q10;
      array alltest(i) test1-test3; 
      do i=1 to 3;
         do j=1 to 10;
            if alltest=. then
               alltest=0;
          end;
       end;
   run;
   

   data new;
      infile file-specification;
      input t1q1-t1q10 t2q1-t2q10
            t3q1-t3q10;
      array alltest{3,10} t1q1-t1q10
                          t2q1-t2q10
                          t3q1-t3q10;  
      do i=1 to 3;
         do j=1 to 10;
            if alltest{i,j}=. then
               alltest{i,j}=0;
         end;
      end;
   run;


   libname in 'SAS-data-library-1';

   data longjob1;
      set in.region1;

      more SAS statements

   run;

   data longjob2;
      set in.region2;

      same SAS statements

   run;

   
   libname in 'SAS-data-library-1';
   libname save 'SAS-data-library-2';

      /* compile and store */
      /* SAVE SOURCE CODE! */
   data longjob1;
      set in.region1;

      more SAS statements

   run pgm=save.storejob;

   libname in 'SAS-data-library-1';
   libname save 'SAS-data-library-2';

      /* execute stored program */
   data pgm=save.storejob;
      redirect input in.region1=
         in.region1;
      redirect output longjob1=
         longjob1;
   run;

      /* execute again */
   data pgm=save.storejob;
      redirect input in.region1=
         in.region2;
      redirect output longjob1=
         longjob2;
   run;

*************************************************************************
/*The following example code appears in Chapter 6, "Take Advantage
of SAS Procedures."*/


   data new(drop=count score i);
      array scores{4} col1-col4;
      retain count 1 scores;
      set exams;
      by id;
      if first.id then
         do i=1 to 4;
            scores{i}=.;
         end;
      scores{count}=score;
      count+1;
      if last.id then
         do;
            count=1;
            output;
         end;
   run;

   proc print data=new;
      title 'DATA step transpose';
   run;

   proc transpose data=exams out=new;
      by id;
   run;

   proc print data=new;
      title 'Procedure transpose';
   run;

      /*Copy the data set. */
   data jacknew.v2;
      set jack.v2;
   run;

      /* Recreate the index. */
   proc datasets library=jacknew;
      modify prods;
      index create
            ix1=(numvar1
                 numvar2
                 numvar3);
   run;
   

      /* Copy the data set and */
      /* all of the indexes.   */
   proc datasets;
      copy out=jacknew in=jack;
      select v2;
   run;

   libname permfmts
           'SAS-data-library-1';
   libname movefmts
           'SAS-data-library-2';
   libname permdata
           'SAS-data-library-3';
   libname movedata
           'SAS-data-library-4';

   proc datasets;
      copy out=movefmts in=permfmts
           memtype=catalog;
      copy out=movedata in=permdata
           memtype=data;
   run;
   

   libname permdata
           'SAS-data-library-1';
   libname movedata
           'SAS-data-library-2';

   proc datasets;
      copy out=movedata in=permdata
            memtype=(catalog data);
   run;

      /* Create data subset. */
   data temp;
      set time90.total;
      if month lt 4;
   run;

      /* Run procedure. */
   proc plot data=temp;
      plot var1*var2;
   run;

      /* Create another subset. */
   data temp;
      set time90.total;
      if month eq 7;
   run;

      /* Run procedure again. */
   proc plot data=temp;
      plot var2*var3;
   run;
   

      /* Run procedure one time. */
   proc plot data=time90.total;
      where month lt 4;
      plot var1*var2;
   run;

      /* Use RUN groups for */
      /* other subsets.     */
      where month eq 7;
      plot var2*var3;
   run;
   quit;

   data temp;
      set orders;
      cno=substr(cno,2);
      pno=substr(pno,2);
   proc sort data=temp;
      by cno;
   proc sort data=cust;
      by no;
   data temp;
      merge temp(in=t)
         cust(in=c
         rename=(no=cno));
      by cno;
      if t and c;
   proc sort data=temp;
      by pno;
   proc sort data=parts;
      by no;
   data temp;
      merge temp(in=t)
         parts(in=p
         rename=(no=pno));
      by pno;
      if t and p;
   proc print;
   run;
   

   proc sql;
      select o.cno, c.name, o.pno,
             p.desc, o.qty
      from orders o, parts p, cust c
      where substr(cno,2)=c.no
            and substr(pno,2)=p.no;
   run;


   proc sort data=lib.puts;
      by stock;
   run;

   proc sort data=lib.calls;
      by stock;
   run;

   data lib.new;
      merge lib.puts lib.calls;
         by stock;
      keep tcost stock;
      tcost=(pprice*pnum)+
            (cprice*cnum);
   run;

   proc print data=lib.new;
   run;

   proc sql;
      select puts.stock, calls.stock,
             (pprice*pnum)+
             (cprice*cnum)
                as tcost
      from sql.puts, sql.calls
      where puts.stock=calls.stock;


   proc sort data=listener;
      by sex music age;
   run;

   proc freq data=listener;
      by sex music age;
      tables sex;
      tables music;
      tables age;
      tables age*music;
      tables sex*age;
      tables sex*music*age;
   run;

   proc means data=listener;
      class sex music age;
      output out=sumdata;
   run;

   proc print data=sumdata;
   run;
**************************************************************************

/*The following example code appears in Chapter 7, "Know SAS System
Defaults."*/


   data report;
      input local catalog;
      sales=local+catalog;
      cards;
   100 400
   200 350
   ;
   

   data report;
      length sales local catalog 4;  
      input local catalog;
      sales=local+catalog;
      cards;
   100 400
   200 350
   ;


   data years;
      infile file-specification;
      input schedule;
      yr95='01jan95'd;
   run;
   

   data years;
      infile file-specification;
      input schedule;
         /* 4 or 5 bytes */
      \   length yr95 4;\  
      yr95='01jan95'd;
   run;

      data;  
      set plants;
      file print;
      put @5 fertilzr @12 yield;

      more SAS statements

   run;
   

      data _null_;  
      set plants;
      file print;
      put @5 fertilzr @12 yield;

      more SAS statements
   run;


      /* change office addresses */
      /* (OFFICE is character--  */
      /* 101, 102, and so on)    */
   data new;
      set old;
      office=office+100;  
   run;
   

      /* change office addresses */
      /* (OFFICE is character--  */
      /* 101, 102, and so on)    */
   data new;
      set old;
      office=put(input
                (office,4.)+100,4.);  
   run;


   data inventry;
      input item start finish;
      sales=start-finish;
      cards;
   1101 500 133
   1102 650 105
   1103 400  98

    more data lines

   ;
   

   data inventry;
      length item $ 4;  
      input item $ start finish;
      sales=start-finish;
      cards;
   1101 500 133
   1102 650 105
   1103 400  98

   more data lines

   ;


   data stock;
      length code $ 9;
      input price 1-3 item $ 5-8
            store $ 10-11;
      code=item||left(price)||store;
      ptax=price*1.06;
      keep ptax code;
      cards;
   119 suit ak
   220 coat pd
   ;
   
   data stock;
      length code $ 9;
      input price 1-3 pchar $ 1-3  
            item $ 5-8 store $ 10-11;
      code=item||pchar||store;
      ptax=price*1.06;
      keep ptax code;
      cards;
   119 suit ak
   220 coat pd
   ;

   libname save 'SAS-data-library';

   data save.huge;

      more SAS statements

   run;
   

   libname save 'SAS-data-library';

   data save.huge(compress=yes);

      more SAS statements

   run;

   data large;
      length code $ 3;  
      input code;
      cards;
   108
   109
   110
   ;
   

   data large2;
      length code2 $ 1;  
      input code;
         /* encode */
      code2=byte(code);  
      drop code;
      cards;
   108
   109
   110
   ;

   data temp;
      set large2;
         /* decode */
      code=rank(code2);  
      drop code2;
   run;

*************************************************************************

/*The following example code appears in Chapter 8, "Control Sorting."*/

/*Sorting Before Each Procedure*/
      /* four sorts  */
      /* sort by sex */
   proc sort data=test;
      by sex;
   run;  
   proc print data=test;
      by sex;
   run;

      /* sort by age */
   proc sort data=test;
      by age;
   run;  
   proc print data=test;
      by age;
   run;

      /* sort by sex */
   proc sort data=test;
      by sex;
   run;  
   proc chart data=test;
      hbar score;
      by sex;
   run;

      /* sort by age */
   proc sort data=test;
      by age;
   run;  
   proc chart data=test;
      hbar score;
      by sex;
   run;

  
/*Grouping Procedures*/
      /* two sorts   */
      /* sort by sex */
   proc sort data=test;
      by sex;
   run;  
   proc print data=test;
      by sex;
   run;
   proc chart data=test;
      hbar score;
      by sex;
   run;

      /* sort by age */
   proc sort data=test;
      by age;
   run;  
   proc print data=test;
      by age;
   run;
   proc chart data=test;
      hbar score;
      by age;
   run;

      /* OUT=LARGE2 is optional */
   proc sort data=large out=large2;
      by id;
   run;

   data new;
      set large2(keep=id city state);
      where city in('Apex','Cary');
  
      more SAS statements

   run;

      /* must use OUT=LARGE2     */
      /* to avoid altering LARGE */
   proc sort data=large(keep=id city 
      state)out=large2;
      where city in('Apex','Cary');  
      by id;
   run;

   data new;
      set large2;

      more SAS statements

   run;


   proc sort data=big;
      by city;
   run;
   

   proc sort data=big noequals;
      by city;
   run;

   proc sort data=new;
      by state;
   run;

   proc means data=new;
      var tv;
      by state;
   run;
   

   proc means data=new;
      var tv;
      class state;
   run;


   libname in 'SAS-data-library-1';
   libname out 'SAS-data-library-2';

   proc sort data=in.huge
        out=out.huge2;
      by state city houshold;
   run;
   

   libname in 'SAS-data-library-1';
   libname out 'SAS-data-library-2';

      /* divide by STATE */
   data state1 ... state50;
      set in.huge;
      select;
         when(state=1) output state1;
         \ob more WHEN statements\obe
         when(state=50) output
             state50;
         otherwise put _all_;
      end;
   run;

      /* sort by other BY variables */
   proc sort data=state1;
      by city houshold;
   run;

   more PROC SORT steps

   proc sort data=state50;
      by city houshold;
   run;

      /* Recombine              */
      /* Sorted by STATE, CITY, */
      /* and HOUSHOLD           */
   data out.huge2;
      set state1 ... state50;
   run;
*************************************************************************

/*The following example code appears in Chapter 9, "Test Your Programs,
Know Your Data."*/

   /* Create a test data set. */

   data new;
      input x $ 1-10
            y 11-15 z $ 16-17;
      cards;
   3/4" NUT  12345 Q
   5/16" SCRW12346XV

   more data lines

   ;
   

   /* Create a test data     */
   /* set from master file   */
   /* with random record     */
   /* selection, 10% sample. */

   data new;
      set product.master;
      if ranuni(-1) le 0.10;
   run;


      /* Test the entire program. */  
   proc contents data=&inds noprint
        out=temp (keep=name type);
   run;

   data _null_;
      set temp;
      if name="%upcase(&byvar)" then
         call symput('bvtype',type);
   run;

   proc sort;
      by state;
   run;

   data _null_;
      set sales end=eof;
      by state;
      if first.state then
         do;

      more SAS statements
   run;

       /* Test this. */  
   proc contents data=&inds noprint
        out=temp (keep=name type);
   run;

       /* Then test this. */  
   data _null_;
      set temp;
      if name="%upcase(&byvar)" then
         call symput('bvtype',type);
   run;

       /* Then test this. */  
   proc sort;
      by state;
   run;

       /* Then test this. */  
   data _null_;
      set sales end=eof;
      by state;
      if first.state then
         do;

      more SAS statements

   run;

   data perm.zoober;
      set perm.zoober;
      if _n_ lt 50 then do;
      accum=accum+_n_;
      zgroup=0;
   run;

   proc means data=perm.zoober
        mean css skewness;
   run;

   data words;
      set words;
      by term;
      if first.term;
   run;

   data words;
      set words;
      if _n_ le 19 then
         do;
            c=_n_;
            col='A1 ';
         end;

      more SAS statements

   run;

   data words;
      set words;
      by term;
      if first.term;
   run;

      /* Check data. */
   proc print data=words;
   run;  

   data words;
      set words;
      if _n_ le 19 then
         do;
            c=_n_;
            col='A1 ';
            /* Check values. */
            put 'For group A1'
                 _n_= c= col=
                 term=;  
         end;

      more SAS statements

   run;

   data test.payrol;
      set real.payrol;
      wage40=wagehr-(wageot*1.5);

      more SAS statements

   run;  
   

   data test.payrol;
      set real.payrol;
      wage40=wagehr-(wageot*1.5);

      more SAS statements

      run cancel;  

   data test.volatls;
      set real.gcmsdata;

      more SAS statements
   run;
   

   options noreplace;  

   data test.volatls;
      set real.gcmsdata;

      more SAS statements

   run;


   proc format library=libref;
      value $gnjob
            '1'='MALE, DEVELOPMENT'
            '2'='MALE, WRITING'
            '3'='MALE, TESTING'
            '4'='FEMALE, DEVELOPMENT'
            '5'='FEMALE, WRITING'
            '6'='FEMALE, TESTING';
   run;

   data persnl.jobdesc;
      set persnl.jobdesc;
      length combo $ 1;
      drop gender dept;
      format combo $gnjob.;
      if gender='M' then do;
         if dept='DVLP'
            then combo='1';
         else if dept='WRTG'
              then combo='2';
         else combo='3';
      end;
      else do;
         if dept='DVLP'
            then combo='4';
         else if dept='TSTG'
              then combo='5';
         else combo='6';
      end;
   run;

***************************************************************************

/*The following example code appears in Chapter 10, "Code Clearly."*/

   options nodsnferr;

   data _null_;
      call symput('tot',total);
      stop;
      set tempds nobs=total;
   run;

   options dsnferr;


   /***************************/
   /* Turn off error messages */
   /* in case data set is     */
   /* missing.                */
   /***************************/

   options nodsnferr;

   /***************************/
   /* Use a null DATA step    */
   /* with SET to find number */
   /* of obs and store in     */
   /* macro variable.         */
   /***************************/

   data _null_;
      call symput('tot',total);
      stop;
      set tempds nobs=total;
   run;

   /***************************/
   /* Turn missing data set   */
   /* error messages back on. */
   /***************************/

   options dsnferr;


   data x;
      retain x4 0;
      input x1 $ 1-10
            x2 11-15
            x3 16-20;
      do x5=1 to 15;

      more SAS statements

   run;
   

   data checks;
      retain subtot 0;
      input  payee  $ 1-10
             deposit 11-15
             payment 16-20;
      do counter=1 to 15;

      more SAS statements

   run;

   data temp;
      infile file-specification;
      input x y z;
   proc sort data=temp;
   options pagesize=55;
   proc print data=temp;
   proc plot data=temp;
      plot x*z;
      plot x*y;

   more SAS statements

   run;
   

   data temp;
      infile file-specification;
      input x y z;
   run;  

   page;  
   proc sort data=temp;
   run;  

   skip 2;  
   options pagesize=55;
   skip 2;  
   proc print data=temp;
   run;  

   page;  
   proc plot data=temp;
      plot x*z;
      plot x*y;

   more SAS statements

  run;  


   SAS statements

   xflag=htin>ftin*htout>ftout;

   more SAS statements
   

   SAS statements
   if (htin gt ftin)
      and
      (htout gt ftout)
      then xflag=1;
   else xflag=0;

   more SAS statements

   data stats91.balance;
      infile file-specification;
      input a $ 1-10 b 11-15
            c $ 16-20;
      retain d 0 e 0.15
             f 'Account';
      if b lt 33 then g=e*b;
      label g 'Sales Tax';
      drop b;
      length h $ 20;
      h=f||a;

      more SAS statements
   run;
   

   data stats91.balance;
      retain d 0 e 0.15
             f 'Account';
      length h $ 20;  
      infile file-specification;
      input a $ 1-10 b 11-15
            c $ 16-20;
      if b lt 33 then g=e*b;
      h=f||a;

      more SAS statements

      label g 'Sales Tax';
      drop b;  
   run;


\%   %macro revex(acct,bud,ytd);
\%      do;
\%         name=&acct;
\%         &bud=&bud+moneyb;
\%         &ytd=&ytd+moneyytd;
\%      end;
\%   %mend revex;
\% This macro definition was originally in the "more efficienct" code.
\% -+----|----+----|----+----|----+----|
   data budg.genfund;
      infile file-specification;
      retain revb revytd
             expb expytd 0;
      input type $ moneyb moneyytd;
      select(type);
         when('A')
            do;
               name='Property';
               revb=revb+moneyb;
               revytd=revytd+
                      moneyytd;  
            end;
         when('B')
            do;
               name='Sales';
               revb=revb+moneyb;
               revytd=revytd+
                      moneyytd;  
            end;

            more SAS statements      end;
   run;
   
\% -+----|----+----|----+----|----+----|
   options sasautos=
           library-specification;  

   data budg.genfund;
      infile file-specification;
      retain revb revytd
             expb expytd 0;
      input type $ moneyb moneyytd;
      select(type);
         when('A')
            %revex(Property,
                   revb,revytd);  
         when('B')
            %revex(Sales,
                   revb,revytd);
  
            more SAS statements

      end;
   run;


   filename prox file-specification;

   proc sort data=sales;
      by state;
   run;
   %include prox;

   more SAS statements
   

   proc sort data=sales;
      by state;
   run;

   proc freq data=sales;
      where state='NC';
      tables product*rep;
   run;

   proc means min max range maxdec=2;
      where state='NC';
      var gross;
   run;

   more SAS statements


   data profit;
      infile file-specification;
      input carsls 5. applsls 5.
            clthsls 5. foodsls 5.
            lawnsls 5.;
      avgsales=mean(carsls,applsls,
                    clthsls,foodsls,
                    lawnsls);
      put carsls applsls clthsls
          foodsls lawnsls;  
   run;
   

   data profit;
      infile file-specification;
      array sales{5} carsls applsls
                     clthsls foodsls
                     lawnsls;
      input sales{*} 5.;
      avgsales=mean(of sales{*});
      put sales{*};  
   run;

   data totals;
      set returns;
      if not (salary lt cuoff1)
         then rate=0.75;  
      else rate=0.67;

   more SAS statements

   run;
   

   data totals;
      set returns;
      if salary ge cuoff1
         then rate=0.75;  
      else rate=0.67;

   more SAS statements

   run;

   data oldies contemp easy;
      set listener.all;
      if pref lt 70
         then output oldies;
      else if pref ge 85
           and pref ne 99
           then output contemp;
      else output easy;
   run;

      proc sort;  
      by group;
   run;

      proc freq;  
      where style="JAZZ";
      tables group*age;
   run;

   more DATA and PROC steps


   data oldies contemp easy;
      set listener.all;
      if pref lt 70
         then output oldies;
      else if pref ge 85
           and pref ne 99
           then output contemp;
      else output easy;
   run;

      proc sort data=easy;  
      by group;
   run;

      proc freq data=easy;  
      where style="JAZZ";
      tables group*age;
   run;

   more DATA and PROC steps

   if score=1 then action-1;
   else if score=2 then action-2;
   else if score=3 then action-3;
  

   if score=1 then action-1;
   else if score=2 then action-2;
   else if score=3 then action-3;
   else put '****** ' id= score= ;  
***************************************************************************

/*The following example code appears in the Appendix, "Generating
Data for Testing Program Efficiency."*/


libname eff 'library-specification';
   filename rawdata 'file-specification';
   data eff.sasdata(drop=i);
      file rawdata;
      do test=1 to 4;
         do status=1 to 5;
            do flag=1 to 10;
               do code=1 to 5;
                  do i=1 to 10;
                     value=uniform(0);
                     do j=1 to 25;
                        random=uniform=(0);
                        output;
                        put @1 test @10 status
                            @20 flag @30 code
                            @40 value @60 random;
                     end;
                  end;
               end;
            end;
         end;
      end;
      stop;
   run;

%macro gen(mult,round);
      round((ranuni(-1)*&mult),&round)
   %mend gen;
   proc format;
      value nlet 1='A'  2='B'  3='C'
                 4='D'  5='E'  6='F'
                 7='G'  8='H'  9='I'
                10='J' 11='K' 12='L'
                13='M' 14='N' 15='O'
                16='P' 17='Q' 18='R'
                19='S' 20='T' 21='U'
                22='V' 23='W' 24='X'
                25='Y' 26='Z';
   run;

   libname eff 'library-specification';
   filename rawdata 'file-specification';

   data eff.sasdata;
      file rawdata;
      retain p1-p26 0.0384615 j1-j9 0.1111111 seed -1;
      drop p1-p26 j1-j9 seed i x1-x2;
      do i=1 to 25000;
         call rantbl(seed,of j1-j9,jday);
         call rantbl(seed,of p1-p26,x1);
         call rantbl(seed,of p1-p26,x2);
         rcode=put(x1,nlet.)||put(x2,nlet.);
         sales=%gen(1000,1);
         exps=%gen(1000,1);
         salhrs=%gen(1000,1);
         exphrs=%gen(1000,1);
         invin=%gen(1000,1);
         invout=%gen(1000,1);
         output;
         put @1 jday @3 rcode @6 sales @15 exps @22 salhrs
             @30 exphrs @36 invin @42 invout;
      end;
   run;













































