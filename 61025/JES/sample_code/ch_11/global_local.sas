
%INCLUDE "&JES.utility_macros/delvars.sas";
%delvars;

%LET One=1; %LET Two=2;
%PUT Before Test: One=&One, Two=&Two, Three=&Three, Four=&Four;
%MACRO Test;
	%LOCAL Two;
	%GLOBAL Four;
	%LET One=1000;
	%LET Two=2000;
	%LET Three = 3000;
	%LET Four=4000;
	%PUT Inside Test: One=&One, Two=&Two, Three=&Three, Four=&Four;
%MEND Test;
%Test;
%PUT After Test: One=&One, Two=&Two, Three=&Three, Four=&Four;

%delvars
%MACRO Test_2;
	%LET Four=400;
	%Test;
%MEND Test_2;
%Test_2;








