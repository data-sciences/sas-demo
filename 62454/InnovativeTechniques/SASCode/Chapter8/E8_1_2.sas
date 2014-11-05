* E8_1_2.sas
*
* Percentages in TABULATE;

ods pdf file="&path\results\E8_1_2a.pdf"
        style=printer;
title1 '8.1.2a Proc Tabulate Percentages';
title2 'Using Angle Braces';

proc tabulate data=advrpt.demog;
   class race edu;
   table (race all)*pctn<edu>='%',
         edu;
   run;
ods pdf close;

*************************************************;
ods pdf file="&path\results\E8_1_2b.pdf"
        style=minimal;
title1 '8.1.2b Proc Tabulate Percentages';
title2 'Column Percents';

proc tabulate data=advrpt.demog;
   class race;
   var wt;
   table race all,wt*(n colpctn mean colpctsum);
   run;
ods pdf close;

*************************************************;
ods pdf file="&path\results\E8_1_2c.pdf"
        style=minimal;
title1 '8.1.2c Proc Tabulate Percentages';
title2 'Using PCTSUM and PCTN';
data survey;
   do ID = 1 to 14;
      do question = 1 to 5;      
         if ranuni(999999)>.4 then resp=1;      
         else resp=0;      
         if ranuni(99999)>.3 then output;   
      end;
   end;
   run;

proc tabulate data=survey;
   class question;
   var resp;
   table question,
         resp='responses'*(n='total responders' *f= comma7.
                           sum='total yes' *f= comma7.
                           pctsum='response rate for this question'*f=5.1 
                           pctn='rate of Yes over whole survey' *f= 5.
                           mean='mean Q resp' * f=percent7.1 
                           ) /rts=40;
   run;
ods pdf close;
