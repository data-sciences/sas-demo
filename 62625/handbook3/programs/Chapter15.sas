ods graphics on;

data cancer;
  infile 'c:\handbook3\datasets\time.dat' expandtabs missover;
  do i = 1 to 6;
    input temp $ @;
    censor=(index(temp,'*')>0);
        temp=substr(temp,1,4);
    days=input(temp,4.);
    group=i>3;
    if days>0 then output;
  end;
  drop temp i;
run;

proc lifetest data=cancer plots=(s);
   time days*censor(1);
   strata group;
run;

data heroin;
  infile 'c:\handbook3\datasets\heroin.dat' expandtabs;
  input id clinic status time prison dose @@;
run;
 
proc phreg data=heroin;
  model time*status(0)=prison dose / rl;
  strata clinic;
run;

proc stdize data=heroin out=heroin2;
  var dose;
run;

proc phreg data=heroin2;
  model time*status(0)=prison dose / rl;
  strata clinic;
  baseline out=phout loglogs=lls / method=ch;
run;

proc sgplot data=phout;
  step y=lls x=time / group=clinic;
run;

/*
symbol1 i=stepjr v=none l=1;
symbol2 i=stepjr v=none l=3;
axis1 label=(a=90);
proc gplot data=phout;
  plot lls*time=clinic / vaxis=axis1;
run;
*/

data SHTD;
  infile 'c:\handbook3\datasets\SHTD.dat';
  input ID Start Stop Event Age Year Surgery Transplant;
  duration=stop-start;
run;

proc phreg data=SHTD;
  model (start,stop)*event(0)=Age Year Surgery Transplant transplant*year / rl;
run;

proc phreg data=SHTD;
  model (start,stop)*event(0)=Age Year Surgery  / rl;
  strata transplant;
  baseline out=phout survival=sfest / method=ch; 
run;

proc sgplot data=phout;
  step y=sfest x=stop / group=transplant;
  xaxis label='Survival time (days)';
run;

/*
symbol1 v=none i=stepjr;
symbol2 v=none i=stepjr l=3;
axis1 label=(a=90);
proc gplot data=phout;
  plot sfest*stop=transplant /vaxis=axis1;
run;
*/




