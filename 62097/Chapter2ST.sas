options nodate nonumber ps=60 ls=80;
data ticketsl;    
   input state $ amount @@;    
   label state='State Where Ticket Received' 
         amount='Cost of Ticket'; 
   datalines; 
AL 100 HI 200 DE 20 IL 1000 AK 300 CT 50 AR 100 IA 60 FL 250 
KS 90 AZ 250 IN 500 CA 100 LA 175 GA 150 MT 70 ID 100 KY 55 
CO 100 ME 50 NE 200 MA 85 MD 500 NV 1000 MO 500 MI 40 NM 100 
NJ 200 MN 300 NY 300 NC 1000 MS 100 ND 55 OH 100 NH 1000 OR 600
OK 75 SC 75 RI 210 PA 46.50 TN 50 SD 200 TX 200 VT 1000 UT 750 
WV 100 VA 200 WY 200 WA 77 WI 300 DC . 
; 
run;

proc print data=ticketsl label;
   title 'Speeding Ticket Data with Labels';
   run;
   

   data ticketsf1;    
   input state $ amount @@;    
   format amount dollar8.2;
   datalines; 
AL 100 HI 200 DE 20 IL 1000 AK 300 CT 50 AR 100 IA 60 FL 250 
KS 90 AZ 250 IN 500 CA 100 LA 175 GA 150 MT 70 ID 100 KY 55 
CO 100 ME 50 NE 200 MA 85 MD 500 NV 1000 MO 500 MI 40 NM 100 
NJ 200 MN 300 NY 300 NC 1000 MS 100 ND 55 OH 100 NH 1000 OR 600
OK 75 SC 75 RI 210 PA 46.50 TN 50 SD 200 TX 200 VT 1000 UT 750 
WV 100 VA 200 WY 200 WA 77 WI 300 DC . 
; 
run;

proc print data=ticketsf1;
   title 'Speeding Ticket Data with SAS Format';
   run;
   
data tickets;    
   input state $ amount @@;    
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
   format amount dollar8.2;
   title 'Speeding Ticket Data Using DOLLAR Format';
   run;

data ticketsf2;    
   input state $ amount @@;    
   statetext=stnamel(state);
   datalines; 
AL 100 HI 200 DE 20 IL 1000 AK 300 CT 50 AR 100 IA 60 FL 250 
KS 90 AZ 250 IN 500 CA 100 LA 175 GA 150 MT 70 ID 100 KY 55 
CO 100 ME 50 NE 200 MA 85 MD 500 NV 1000 MO 500 MI 40 NM 100 
NJ 200 MN 300 NY 300 NC 1000 MS 100 ND 55 OH 100 NH 1000 OR 600
OK 75 SC 75 RI 210 PA 46.50 TN 50 SD 200 TX 200 VT 1000 UT 750 
WV 100 VA 200 WY 200 WA 77 WI 300 DC . 
; 
run;

proc print data=ticketsf2;
   title 'Speeding Ticket Data with STATENAMEL Function';
   run;

proc format;
   value $sex 'm'='Male' 'f'='Female';

   data bodyfat2;
   input gender $ fatpct @@;
   format gender $sex.;
   datalines;
m 13.3 f 22 m 19 f 26 m 20 f 16 m 8 f 12 m 18 f 21.7
m 22 f 23.2 m 20 f 21 m 31 f 28 m 21 f 30 m 12 f 23
m 16 m 12 m 24
;
run;

proc print data=bodyfat2;
   title 'Body Fat Data for Fitness Program';
   run;

   data tickets2;    
   input state $ amount @@;  
   format amount dollar8.2; 
   label state='State Code'
         statetext='State Where Ticket Received' 
         amount='Cost of Ticket'; 
   statetext=stnamel(state);
   datalines; 
AL 100 HI 200 DE 20 IL 1000 AK 300 CT 50 AR 100 IA 60 FL 250 
KS 90 AZ 250 IN 500 CA 100 LA 175 GA 150 MT 70 ID 100 KY 55 
CO 100 ME 50 NE 200 MA 85 MD 500 NV 1000 MO 500 MI 40 NM 100 
NJ 200 MN 300 NY 300 NC 1000 MS 100 ND 55 OH 100 NH 1000 OR 600
OK 75 SC 75 RI 210 PA 46.50 TN 50 SD 200 TX 200 VT 1000 UT 750 
WV 100 VA 200 WY 200 WA 77 WI 300 DC . 
; 
run;

proc print data=tickets2 label;
   title 'Speeding Ticket Data with Labels and Formats';
   run;
