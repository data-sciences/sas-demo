

%INCLUDE "&JES.sample_code/ch_4/random_data.sas";
%LET USER= my_user; %LET PW = my_password; %LET PATH=my_path;
 LIBNAME Jesdb ORACLE USER=&user PW=&pw PATH=&path;
 DATA Jesdb.Units; SET Units; RUN;
 DATA Jesdb.Fails; SET Fails; RUN;
 DATA Jesdb.Modes; SET Modes; RUN;


