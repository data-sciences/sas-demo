options nodate nonumber ps=60 ls=80;
data tickets;    
input State $ Amount @@;    
datalines; 
AL 100 HI 200 DE 20 IL 1000 AK 300 CT 50 AR 100 IA 60 FL 250 
KS 90 AZ 250 IN 500 CA 100 LA 175 GA 150 MT 70 ID 100 KY 55 
CO 100 ME 50 NE 200 MA 85 MD 500 NV 1000 MO 500 MI 40 NM 100 
NJ 200 MN 300 NY 300 NC 1000 MS 100 ND 55 OH 100 NH 1000 OR 600
OK 75 SC 75 RI 210 PA 46.50 TN 50 SD 200 TX 200 VT 1000 UT 750 
WV 100 VA 200 WY 200 WA 77 WI 300 DC . 
; 
run;

proc print data=tickets;
   title 'Speeding Ticket Data';
   run;
   
proc print data=tickets noobs;
   title 'Speeding Ticket Variables';
   run;
      
proc print data=tickets double;
   title 'Double-spacing for Speeding Ticket Data';
   run;
   
proc sort data=tickets; 
   by amount;
run;

proc print data=tickets;
   title 'Speeding Ticket Data: Sorted by Amount';
run;

proc sort data=tickets; 
   by descending amount;
run;

proc print data=tickets;
   title 'Speeding Ticket Data by Descending Amount';
run;
