


DATA Contacts_1; SET JES.Contacts;
	City   = COMPBL(City);
	State  = UPCASE(State);
	Number = TRANSLATE(Number, '-', '.');
	Area   = SUBSTR(Number,1,3);
	First  = SCAN(Name, 1, ' ');
	Last   = SCAN(Name,-1,' ');
	City_State = City||", "||State;
RUN;

DATA Contacts_2; SET JES.Contacts;
	FORMAT Phone_Ck $15.; L=length(Number);
	IF LENGTH(Number) NE 12                    THEN Phone_Ck="Invalid Length";
	IF VERIFY(STRIP(Number), '.-0123456789')>0 THEN Phone_Ck="Invalid Char";
RUN;



DATA CharNum;
	Char = "7.654";     Num = 3.1415927; OUTPUT;
	Char = "9.0";       Num = 100;       OUTPUT;
	Char = "9999";      Num = 0.55;      OUTPUT;
RUN;
DATA CharNum_1; set CharNum;
	Char2Num = INPUT(Char, 8.4);
	Num2Char = PUT(Num, 8.2); 
RUN;


DATA TestDates; SET JES.TimeStamp;
	M=UPCASE(SCAN(Time,2,' '));
	D=SCAN(Time,3,' ');
	Y=SCAN(Time,6);
	DMY=CATS(D, M, Y);
	TestDate = INPUT(DMY, date9.); 
	FORMAT TestDate mmddyy10.;
RUN;


