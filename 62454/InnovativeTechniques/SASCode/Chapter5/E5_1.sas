* E5_1.sas
* 
* Automated COMPARE;

title1 '5.1 Automated Comparisons';
* to make things more interesting, make sodium character;
data lab_chem;
   set advrpt.lab_chemistry(rename=(sodium=Na));
   sodium = put(na*10,3.);
   run;

proc sort data=lab_chem
           noduplicates;
   by subject visit labdt;
   run;

* Create some data differences.
* We will use COMPARE to find them.;
data lab_chem2;
   set lab_chem;
   if _n_ in (2,20) then substr(sodium,2,1)='A';
   run;

proc compare
         data=lab_chem
         compare=lab_chem2
         out=cmpr
         outbase outcomp
         noprint outnoequal;
   id subject visit labdt;
   run;

title2 'Obs with differences';
proc print data=cmpr;
   run;

proc sort data=cmpr;
   by subject visit labdt _obs_;
   run;

proc transpose data=cmpr
                 out=tdiff(drop=_label_ rename=(_name_=variable));
   by subject visit labdt _obs_;
   var _numeric_ _character_;
   id _type_;
   run;

title3 'After Transpose';
proc print data=tdiff(where=(variable ne '_TYPE_' & base ne compare));
   run;
