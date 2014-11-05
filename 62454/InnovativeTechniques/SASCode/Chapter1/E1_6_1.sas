* E1_6_1.sas
*
* Using the XML engine;
* *********************************;

title1 '1.6.1 Using ODS MARKUP';
ods markup file="&path\data\E1_6_1Names.xml";

* create a xml file of the report;
proc print data=advrpt.demog;
   var lname fname sex dob;
   run;
ods markup close;

