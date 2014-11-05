* E4_5.sas
* 
* Using Multiple Prcessors;

title1 '4.5 Multi-Threaded Operations';
data  big;
array list {26} $1 _temporary_;
value='abcdefghijklmnopqrstuvwxyz';
do i = 1 to 26;
   list{i} = substr(value,i,1);
end;

do i = 1 to 5000000;
   scale1 = list{ceil(26*ranuni(927))};
   scale2 = list{ceil(26*ranuni(927))};
   output big;
end;
run;
options nothreads;
proc sort data=big out=newbig;
   by scale1 scale2;
   run;
options threads;
proc sort data=big out=newbig threads;
   by scale1 scale2;
   run;
