* E1_6_2.sas
*
* Using the XML engine;
* *********************************;

title1 '1.6.2 Using the XML Engine';
filename xmllst "&path\data\E1_6_2list.xml";
libname toxml xml xmlfileref=xmllst;

* create a xml file (E1_6_2list.xml);
data toxml.patlist;
   set advrpt.demog(keep=lname fname sex dob);
   run;

* convert xml to sas 
* (use the XML file just created);
data fromxml;
   set toxml.patlist; 
   run;

title2 'XML Engine';
proc print data=toxml.patlist;
run;
