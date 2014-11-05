* E12_5_4.sas
* 
* Using Perl Regular Expressions;

title1 '12.5.4 Using Perl Regular Expressions';
*********************************************;
proc format; 
   invalue $abc2def (default=20) 
      's/abc/def/' (REGEXPE) = _same_; 
   run;

data _null_; 
x=input('abc',$abc2def.);   put x=; 
x=input('xabcx',$abc2def.); put x=; 
x=input('xyz',$abc2def.);   put x=; 
x=input('def',$abc2def.);   put x=;
x=input('ABC',$abc2def.);   put x=;  
run;

******************************************;
* Show a series of formats - just for fun;
proc format; 
     invalue $abc2def (default=20) 's/abc/def/' (regexpe) = [def2ghi.]; 
     invalue $def2ghi (default=20) 's/def/ghi/' (regexpe) = [ghi2jkl.]; 
     invalue $ghi2jkl (default=20) 's/ghi/jkl/' (regexpe) = [jkl2mno.]; 
     invalue $jkl2mno (default=20) 's/jkl/mno/' (regexpe) = _same_; 
     run;

data _null_; 
     x=input('abc',$abc2def.); 
     put x=; 
     run;
