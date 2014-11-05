ods graphics on;

data boyfriends;
  infile 'c:\handbook3\datasets\boyfriends.dat' expandtabs;
  input c1-c5;
  if _n_=1 then rowid='NoBoy';
  if _n_=2 then rowid='NoSex';
  if _n_=3 then rowid='Both';
  label c1='under 16' c2='16-17' c3='17-18' c4='18-19' c5='19-20';
run;

proc corresp data=boyfriends out=coor;
  var c1-c5;
  id rowid;
run;

*%plotit(data=coor,datatype=corresp,color=black,colors=black);

data births;
  infile 'c:\handbook3\datasets\births.dat' expandtabs;
  input c1-c4;
  length rowid $12.;
  select(_n_);
   when(1) rowid='Young NS';
   when(2) rowid='Young Smoker';
   when(3) rowid='Old NS';
   when(4) rowid='Old Smoker';
  end;
  label c1='Prem Died' c2='Prem Alive' c3='FT Died' c4='FT Alive';
run;

proc corresp data=births out=coor;
 var c1-c4;
 id rowid;
run;

*%plotit(data=coor,datatype=corresp,color=black,colors=black);

data europeans;
  infile 'c:\handbook3\datasets\europeans.dat' expandtabs;
  input country $ c1-c13;
  label c1='stylish'
        c2='arrogant'
                c3='sexy'
                c4='devious'
                c5='easy-going'
                c6='greedy'
                c7='cowardly'
                c8='boring'
                c9='efficient'
                c10='lazy'
                c11='hard working'
                c12='clever'
                c13='courageous';
run;

proc corresp data=europeans out=coor;
 var c1-c13;
 id country;
run;

*%plotit(data=coor,datatype=corresp,color=black,colors=black);

