* E11_4_4.sas
*
* Using internal links;


ods pdf file="&path\results\E11_4_4.pdf"
        style=minimal;

title1 'Linking Documents';
title2 'Master Table';

proc format;
   value $genlnk
      'M' = '#males'
      'F' = '#females';
   run;

* The code in the book shows the anchor location as 'Master'
* in SAS 9.2 and SAS 9.3 the location must be converted to lc.
* The name in the LINK= option in the TITLE statement must also
* be in lowercase;
ods pdf anchor='master'; 
ods proclabel='Overall'; 
proc tabulate data=advrpt.demog;
   class sex ;
   classlev sex/ style={url=$genlnk.
                        foreground=blue};
   var wt;
   table sex=' ', 
         wt*(n median min max)
         / box='Gender';
   run;

ods pdf anchor='males'; 
ods proclabel='Males';
title2 link='#master' c=blue 'Return to Master';
title3 'Males';
proc print data=advrpt.demog(where=(sex='M'));
   var lname fname ht wt;
   run;
   
ods pdf anchor='females'; 
ods proclabel='Females';
title2 link='#master' c=blue 'Return to Master';
title3 'Females';
proc print data=advrpt.demog(where=(sex='F'));
   var lname fname ht wt;
   run;
ods pdf close;
