
%INCLUDE "&JES.utility_macros/delvars.sas";
%delvars

/*=== Create the same Tab data set used in macro_var.sas ===*/
DATA Tab;  FORMAT Test_Date DATE9.;
	DO n=1 TO 90 BY 30; 
		Vendor="Duality Logic";
		Test_Date='05JUN2008'd+n; 
		Num_Test=1000; 
		Num_Fail=ROUND(Num_Test*RANUNI(12345)/50); 
		Rate=Num_Fail/Num_Test;
		OUTPUT; 
	END;
	DROP N;
RUN;

PROC SQL NOPRINT;
	SELECT Vendor, Num_Test, Rate, Test_Date INTO :Vend, :NTest, :Rate, :Test_Date
	FROM Tab
	WHERE Test_Date='06JUL2008'd;
QUIT;

%PUT Vend=[&Vend] NTest=[&NTest] Rate=[&Rate] Test_Date=[&Test_Date];

%LET Upper = %UPCASE(&Vend);       %PUT Upper=[&Upper];
%LET Last  = %SCAN(&Vend, 2, ' '); %PUT Last=[&Last];
%LET V9    = %SUBSTR(&Vend, 1, 9); %PUT V9=[&V9];
%LET Len   = %LENGTH(&Vend);       %PUT Len=[&Len];
%LET Loc   = %INDEX(&Vend, Log);   %PUT Loc=[&Loc]; 
%LET VTyp  = %DATATYP(&Vend);      %PUT VTyp=[&VTyp];
%LET RTyp  = %DATATYP(&Rate);      %PUT RTyp=[&RTyp];
%LET NLeft = %LEFT(&NTest);        %PUT NLeft=[&NLeft];
%PUT %UPCASE(qwerty);

%LET A=%EVAL(4*(3**2)+ (10/5) -6); %PUT A=&A;

%LET B=%EVAL(7/4);     %PUT B=&B;
%LET C=%SYSEVALF(7/4); %PUT C=&C;

%LET D=%EVAL(2*5.5);             %PUT D=&D;
%LET E=%SYSEVALF(2*5.5);         %PUT E=&E;
%LET F=%SYSEVALF(06JUL2008+30);  %PUT F=&F;

%LET G = %EVAL(&NTest+300);     %PUT G=[&G];
%LET H = %SYSEVALF(&NTest+300); %PUT H=[&H];
%LET I = %EVAL(&NTest/30);      %PUT I=[&I];
%LET J = %SYSEVALF(&NTest/30);  %PUT J=[&J];
%LET K = %EVAL(&Rate*10);       %PUT K=[&K];
%LET L = %SYSEVALF(&Rate*10);   %PUT L=[&L];
%PUT "&Test_Date"d;
%LET M = %EVAL("&Test_Date"d +1);    %PUT M=[&M];
%LET N = %SYSEVALF("&Test_Date"d +1); %PUT N=[&N];
