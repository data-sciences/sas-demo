* S10_1_4.sas
*
* Build a Vertically Concatenated table;

ods listing;
proc format;
   value $Reggrp
      '1','2','3','4' = 'a'
      '5'-'9','10'    = 'b'
      other           = 'c';
   value $RegName
      'a' = 'Eastern'
      'b' = 'Western'
      'c' = 'Overall';
   value class
      1 = 'Sex'
      2 = 'Height'
      3 = 'Weight';
   value subclass
      1 = 'Female'
      2 = 'Male'
      3 = 'All'
      4 = 'N'
      5 = 'Median'
      6 = 'Mean (Std)';
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
   format region $reggrp.;
   run;
*proc print data=clinsum; 
*run;
proc transpose data=clinsum
               out=tran1;
   by _type_ region sex;
   var _freq_ ht: wt:;
   run;
*proc print data=tran1;
*var _type_ region sex _name_ col1; 
*run;


data prep1(keep=class subclass reggrp val1 val2);
   set tran1(Keep=_type_ region sex _name_ col1);
   length class subclass 4 val1 val2 8 reggrp $1;
 
   * Retain MEAN and N (denominator);
   retain holdmean holdn .;

   * Assign a region group code;
   reggrp = put(region,$reggrp.);

   * Build the stats for SEX;
   if _name_='_FREQ_' then do;
      * Only use observation counts (_FREQ_);
      class = 1;
      subclass = 1*(sex="F") + 2*(sex='M') + 3*(sex=' ');
      * Retain the denominator for future use;
      if _type_ = 0 then holdn = col1;
      * Value is count (%);
      val1 = col1; val2=holdn;
      output;
   end;

   * Build the stats for HEIGHT and WEIGHT;
   * Ignore observations that contain _FREQ_;
   else if _type_ in(0,2) then do;
      if _name_ =: 'ht' then class=2;
      else class=3;
      * Retain the MEAN for future use;
      if index(_name_,'mean') then holdmean=col1;
      else do;
         if index(_name_,'std') then do;
            subclass=6;
         * Value is a combination of MEAN and STD;
            val1 =col1; val2 = holdmean; 
         end;
         else do;
            * Other statistics;
            if upcase(substr(_name_,3))='N' then subclass=4;
            else if upcase(substr(_name_,3))='MEDIAN' then subclass=5;
            val1=col1; val2=.;
         end;
         output;
      end;
   end;
   run;
*proc print data=prep1; 
*run;

title1 'Common REPORT Problems';
title2 'Vertically Concatenated Tables';
title3 'Using ACROSS';
proc report data=prep1 nowd out=outdata;
   column class subclass reggrp,(val1 val2 value);
   define class    / group ' ' 
                     format=class. order=data;
   define subclass / group ' ' 
                     format=subclass. order=internal;
   define reggrp   / across 'Region'
                     format=$regname. order=internal;
   define val1     / analysis noprint;
   define val2     / analysis noprint;
   define value    / computed ' ';

   compute value / char length=15;
      if subclass in(1,2,3) then do;
         _c5_  = trim(put(_c3_,3.0))||' ('||trim(left(put(_c3_/_c4_,percent8.1)))||')';
         _c8_  = trim(put(_c6_,3.0))||' ('||trim(left(put(_c6_/_c7_,percent8.1)))||')';
         _c11_ = trim(put(_c9_,3.0))||' ('||trim(left(put(_c9_/_c10_,percent8.1)))||')';
      end;
      else do;
         if subclass=4 then do;
            * N;
            _c5_  = put(_c3_,3.);
            _c8_  = put(_c6_,3.);
            _c11_ = put(_c9_,3.);
         end;
         else if subclass=5 then do;
            * Median;
            _c5_  = put(_c3_,6.2);
            _c8_  = put(_c6_,6.2);
            _c11_ = put(_c9_,6.2);
         end;
         else if subclass=6 then do;
            * Mean (std);
            * Value is a combination of MEAN and STD;
            _c5_  =  trim(put(_c4_,6.2))||' ('||trim(left(put(_c3_,5.2)))||')';
            _c8_  =  trim(put(_c7_,6.2))||' ('||trim(left(put(_c6_,5.2)))||')';
            _c11_ =  trim(put(_c10_,6.2))||' ('||trim(left(put(_c9_,5.2)))||')';
         end;
      end;
   endcomp;

   compute after class;
      line ' ';
   endcomp;
   run;
proc print data=outdata;
run;
