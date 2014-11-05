ods graphics on;

data uscrime;
    infile 'c:\handbook3\datasets\uscrime.dat' expandtabs;
    input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;

data ozkids;
    infile 'c:\handbook3\datasets\ozkids.dat' dlm=' ,' expandtabs missover;
    input cell origin $ sex $ grade $ type $ days @;
        do until (days=.);
          output;
          input days @;
        end;
run;

proc genmod data=uscrime;
  model R=ex1 x ed age u2 / dist=normal link=identity;
run;

proc genmod data=ozkids;
  class origin sex grade type;
  model days=sex origin type grade / dist=p link=log type1 type3;
run;

proc genmod data=ozkids;
  class origin sex grade type;
  model days=sex|origin|type|grade@2 / dist=p link=log scale=d;
run;


proc genmod data=ozkids;
  class origin sex grade type;
  model days=sex origin type grade / dist=p link=log type1 type3 scale=3.1892;
  output out=genout pred=pr_days stdreschi=resid;
run;

proc sgplot data=genout;
  scatter y=resid x=pr_days;
run;

/*
proc gplot data=genout;
  plot resid*pr_days;
run;
*/

data fap;
  infile 'c:\handbook3\datasets\fap.dat';
  input male treat base_n age resp_n;
run;

proc genmod data=fap;
  model resp_n=male treat base_n age / dist=g link=log;  
run;


