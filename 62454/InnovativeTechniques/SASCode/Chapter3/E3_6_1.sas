* E3_6_1.sas
* 
* Using the ANY Functions;

title1 '3.6.1 Using ANYALPHA';

* Make some bad data values for this example;
* For this example convert lab values to character;
* so that we will have something to pretend to convert back to numeric;
data lab_chem;
   set advrpt.lab_chemistry(rename=(potassium=p sodium=s chloride=c));
   potassium = put(p,6.2);
   sodium    = put(s,6.2);
   chloride  = put(c,6.2);
   if _n_ = 5 then sodium='1A0';
   else if _n_ =10 then potassium='4.7x';
   else if _n_ =13 then chloride='9A';
   run;

* Show how the BEST. format can produce a note in the LOG;
data usebest;
   set lab_chem;
   sodium_n = input(sodium, best.);
   run;

* Suppress the note using the ?? format modifier;
data usebest;
   set lab_chem;
   sodium_n = input(sodium, ?? best.);
   run;

* Use ANYALPHA to detect inappropriate values.;
data lab_chem_n(keep=subject visit labdt sodium_n potassium_n chloride_n)  
     Valcheck(keep=subject visit variable value note);
   set lab_chem;
   length variable $15 value $5 note $25;
   array val {3} $6 sodium potassium chloride;
   array nval {3} sodium_n potassium_n chloride_n;
   do i = 1 to 3;
      if anyalpha(left(val{i})) then do;
         variable = vname(val{i});
         value=val{i};
         note = 'Value is non-numeric';
         output valcheck;
      end;
      else do;
         * Convert value;
         nval{i} = input(val{i},best.);
      end;
   end;
   output lab_chem_n;
run;

proc print data=valcheck;
   run; 

proc print data=lab_chem_n;
   run; 

****************************************;
* Redo the example using the NOTNUMERIC function;
* Use ANYALPHA to detect inappropriate values.;
data lab_chem_n(keep=subject visit labdt sodium_n potassium_n chloride_n)  
     Valcheck(keep=subject visit variable value note);
   set lab_chem;
   length variable $15 value $5 note $25;
   array val {3} $6 sodium potassium chloride;
   array nval {3} sodium_n potassium_n chloride_n;
   do i = 1 to 3;
      if notdigit(trim(left(compress(val{i},'+-.')))) then do;
         variable = vname(val{i});
         value=val{i};
         note = 'Value is non-numeric';
         output valcheck;
      end;
      else do;
         * Convert value;
         nval{i} = input(val{i},best.);
      end;
   end;
   output lab_chem_n;
run;

proc print data=valcheck;
   run; 

****************************************;
* Demonstrate the START argument;
data a;
text = '1234x6yz9';
pos = anyalpha(text,-6);
put text= pos=;
run; 
