ods graphics on;

data ozkids;
    infile 'c:\handbook3\datasets\ozkids.dat' dlm=' ,' expandtabs missover;
    input cell origin $ sex $ grade $ type $ days @;
	do until (days=.);
	  output;
	  input days @;
	end;
	input;
run;

proc glm data=ozkids;
  class origin sex grade type;
  model days=origin sex grade type /ss1 ss3;
run;
proc glm data=ozkids;
  class origin sex grade type;
  model days=grade sex type origin  /ss1;
run;
proc glm data=ozkids;
  class origin sex grade type;
  model days=type sex origin grade /ss1;
run;
proc glm data=ozkids;
  class origin sex grade type;
  model days=sex origin type grade /ss1;
run;

proc glm data=ozkids;
  class origin sex grade type;
  model days=origin sex grade type origin|sex|grade|type /ss1 ss3;
run;

