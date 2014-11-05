ods graphics on;

data vision;
  infile 'c:\handbook3\datasets\visual.dat';
  input idno x1-x8;
run;

proc glm data=vision;
  model x1-x8= /nouni;
  repeated eye 2, strength 4 /summary ;
run;


proc glm data=vision;
  model x1-x8= /nouni;
  repeated eye 2, strength 4 (1 3 6 10) polynomial /summary;
run;


