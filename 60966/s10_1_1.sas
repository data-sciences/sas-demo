* S10_1_1.sas
*
* Creating a Vertically concatenated table.;

ods listing;

proc format;
   value $EWReg
      '1','2','3','4' = 'Eastern'
      '5'-'9','10'    = 'Western'
      other           = 'Overall';
   value $gender
      'F'   = 'Female'
      'M'   = 'Male'
      other = 'All';
   run;


proc summary data=rptdata.clinics;
   class region /order=internal;
   class sex;
   var ht wt;
   output out=clinsum 
          n= htn wtn
          mean=htmean wtmean
          median=htmedian wtmedian
          std=htstd wtstd;
   format region $ewreg.;
   run;
proc print data=clinsum; run;
proc transpose data=clinsum
               out=tran1;
   by _type_ region sex;
   var _freq_ ht: wt:;
   run;
*proc print data=tran1;
*var _type_ region sex _name_ col1; 
*run;


data prep1(keep=class subclass regname value);
   set tran1(Keep=_type_ region sex _name_ col1);
   length class subclass value $12 regname $7;

   * Retain MEAN and N (denominator);
   retain holdmean holdn .;

   * Save the region name;
   regname = put(region,$ewreg.);

   * Build the stats for SEX;
   if _name_='_FREQ_' then do;
      * Only use observation counts (_FREQ_);
      class = 'Gender';
      subclass = put(sex,$gender.);
      * Retain the denominator for future use;
      if _type_ = 0 then holdn = col1;
      * Value is count (%);
      value = trim(left(put(col1,4.)))||' ('||trim(left(put(col1/holdn,percent.)))||')';
      output;
   end;

   * Build the stats for HEIGHT and WEIGHT;
   * Ignore observations that contain _FREQ_;
   else if _type_ in(0,2) then do;
      if _name_ =: 'ht' then class='Height';
      else class='Weight';
      * Retain the MEAN for future use;
      if index(_name_,'mean') then holdmean=col1;
      else do;
         if index(_name_,'std') then do;
            subclass='MEAN (STD)';
         * Value is a combination of MEAN and STD;
            value =  trim(left(put(holdmean,4.1)))||' ('||trim(left(put(col1,5.2)))||')';
         end;
         else do;
            * Other statistics;
            subclass = upcase(substr(_name_,3));
            value = put(col1,6.2);
         end;
         output;
      end;
   end;
   run;
*proc print data=prep1; 
*run;
proc sort data=prep1;
   by class subclass regname;
   run;

proc transpose data=prep1 out=tran2;
   by class subclass;
   id regname;
   var value;
   run;
*proc print data=tran2;
*run;

title1 'Common REPORT Problems';
title2 'Vertically Concatenated Tables';
proc report data=tran2 nowd;
   column class subclass eastern western overall;
   define class    / group ' ';
   define subclass / group ' ';
   define eastern  / display;
   define western  / display;
   define overall  / display;
   compute after class;
      line ' ';
   endcomp;
   run;