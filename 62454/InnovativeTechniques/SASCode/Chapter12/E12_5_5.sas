* E12_5_5.sas
* 
* Functions as Format labels;

title1 '12.5.5 Functions as Format Labels';
*********************************************;
proc format; 
     value fipstate other=[fipstate()]; 
     run;

data _null_; 
     x=37; put x=fipstate.; 
     run;

*********************************************;
proc format; 
  value daten   (default=10) other=[date()]; 
  value $datec  (default=10) other=[date()];
  value dpartn  (default=10) other=[datepart()];
  value $dpartc (default=10) other=[datepart()];
  value lenn    (default=10) other=[length()]; 
  value $lenc   (default=10) other=[length()]; 
  run;
data _null_; 
  x=datetime(); 
  y=put(datetime(),best12.);  
  z=put(date(),best12.); 
  a=datepart(x); 
  put x= y= z= a=; 
  put x=daten.  x=dpartn.  x=lenn.; 
  put y=$datec. y=$dpartc. y=$lenc.; 
  put z=$datec. z=$dpartc. z=$lenc.; 
  run;





*********************************************;
proc fcmp outlib=Advrpt.functions.Conversions;
   function c2ff(c) $;
      return(cats(((9*c)/5)+32,'°F')); 
   endsub;

   function f2cc(f) $; 
      return(cats((f-32)*5/9,'°C')); 
   endsub;
   run;
options cmplib=(advrpt.functions);
data _null_; 
     f=c2ff(100); put f=; 
     c=f2cc(212); put c=; 
     run;
proc format; 
     value c2ff (default=10) other=[c2ff()]; 
     value f2cc (default=10) other=[f2cc()]; 
     run;
data _null_; 
     c=100; put c=c2ff.; 
     f=212; put f=f2cc.; 
     run; 

******************************************************;
* the QFMT() function is created in Section 15.2.2;
proc format; 
   value qfmt other=[qfmt()]; 
run;

options cmplib=(advrpt.functions);
proc freq data=advrpt.lab_chemistry
          order=formatted;
   table visit*labdt;
   format labdt qfmt.;
   run;

**************************************************;
proc fcmp outlib=work.functions.smd;
   function tsgn(text $);
      put 'in tsgn: ' text=; 
      x = input(text,trailsgn10.);
      x = x/100; 
      return(x);
   endsub;
run;
options cmplib=(work.functions);
proc format; 
  invalue tsgn(default=10) 
    other=[tsgn()];
data _null_; 
   input x: tsgn.; 
   put x=; 
cards; 
1
1-
12-
123-
123+
1+
0
run;
