* E3_6_5b.sas
* 
* Variable Information functions;

title1 '3.6.5 Using Variable Information Functions';
*****************************************;
title2 'Retrieving and Using Formats';


proc format;
   value	$race
      '1'='Caucasian'			
		'2'='Black'					
		'3'='Latin'					
		'4'='Native American'		
		'5'='Asian';
   value $symptom
      '01'='Sleepiness'
      '02'='Coughing '
      '03'='Limping'
      '04'='Bleeding'
      '05'='Weak'
      '06'='Nausea'        
      '07'='Headache'
      '08'='Cramps'
      '09'='Spasms'
      '10'='Shortness of Breath';
   value $gender
      'M','m' = 'Male'
      'F','f' = 'Female';
   run;
proc print data=advrpt.demog;
   var lname fname sex symp race;
   run;
proc sort data=advrpt.demog(keep=lname fname sex symp race)
          out=codedat;
   by lname fname;
   format sex $gender. symp $symptom. race $race.;
   run;
data namelist(keep=lname fname varname varvalue);
   set codedat;
   length varname name type $15 varvalue $30;
   array vlist{5} $15 _temporary_;
   if _n_=1 then do until (name=' ');
      call vnext(name,type);
      if upcase(name) not in:('LNAME' 'FNAME'
                              'NAME' 'TYPE' 
                              'VARNAME' 'VARVALUE') 
                           and type='C' then do;
         cnt+1;
         vlist{cnt}=vnamex(name);
      end;
   end;
   do i = 1 to cnt;
      varname = vlist{i};
      varvalue = vvaluex(varname);
      output namelist;
   end;
   run;
proc transpose data=namelist out=original(drop=_name_);
by lname fname;
id varname;
var varvalue;
run;

proc print data=original;
run;

