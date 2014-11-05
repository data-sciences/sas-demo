

/*===== Viewing Macro Variables =====*/


%PUT _ALL_;
DATA MacroVars; SET SASHELP.VMACRO; RUN;
%PUT _AUTOMATIC_;
%PUT _GLOBAL_;

%PUT &JES;
%PUT This SAS Version &SYSVER session started at &SYSTIME on 
&SYSDATE9 by user &SYSUSERID running &SYSSCP &SYSSCPL ;


/*===== Creating Macro Variables =====*/
/*===== Using a %LET statement =====*/

%LET Var1 = The project lasted for;
%LET Var2 = 99;
%PUT &VAR1 &Var2 Months;

/*===== Using CALL SYMPUT =====*/
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

DATA _NULL_; SET Tab;
	IF Test_Date='06JUL2008'd THEN DO;
		CALL SYMPUT('Vend', Vendor);
		CALL SYMPUT('NTest', Num_Test);
		CALL SYMPUT('Rate', PUT(Rate, 6.3));
		CALL SYMPUT('Test_Date', PUT(Test_Date, DATE9.));
	END;
RUN;
%PUT Vend=[&Vend] NTest=[&NTest] Rate=[&Rate] Test_Date=[&Test_Date];

/*===== Using PROC SQL =====*/

PROC SQL NOPRINT;
	SELECT Vendor, Num_Test, Rate, Test_Date 
		INTO :Vend, :NTest, :Rate, :Test_Date
	FROM Tab
	WHERE Test_Date='06JUL2008'd;
QUIT;
%PUT Vend=[&Vend] NTest=[&NTest] Rate=[&Rate] Test_Date=[&Test_Date];

PROC SQL NOPRINT;
	SELECT MAX(Rate), COUNT(*) INTO :MaxRate, :Num_Row
	FROM Tab;
QUIT;
%PUT MaxRate=[&MaxRate], Num_Row = [&Num_Row];


PROC SQL NOPRINT;
	SELECT Test_Date INTO :DateList
	SEPARATED BY " , "
	FROM Tab;
QUIT;
%PUT DateList=[&DateList];


/*===== Deleting Macro Variables =====*/
%PUT MaxRate=[&MaxRate], Num_Row = [&Num_Row]; 
%SYMDEL MaxRate Num_Row;
%PUT MaxRate=[&MaxRate], Num_Row = [&Num_Row];

%INCLUDE "&JES.utility_macros/delvars.sas";
%delvars
%PUT _GLOBAL_;


/*===== Using Macro Variables =====*/
%LET Num=1; %LET Char =one;
%LET Cash = M&Char.y;
%PUT Num=[&Num] Char=[&Char] Cash=[&Cash] Cash=[M&Char.y];


%LET theLib = JES;
DATA Temp; SET &theLib..Lifetest; RUN;


TITLE1 "The Number &Num is Spelled &Char";
TITLE2 'The Number &Num is Spelled &Char';
DATA Temp;
	Num=&Num;
	Char="&Char";
	Char2='&Char';
RUN;
PROC PRINT DATA=Temp; RUN;





