
%INCLUDE "&JES.sample_code/ch_2/sort_merge.sas";
PROC COMPARE BASE= Units_U COMPARE=Units_Fails; ID SN; RUN;
