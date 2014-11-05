*E14_5.sas
*
* Using SAS to send e-mail;
title '14.5 Using SAS to Send E-Mail';

* Define the email host information;
* The values of the email options are site specific;
options emailsys=SMTP 
        emailid="sam@caloxy.com" 
        emailhost="caloxy.com" 
        emailport=25;

* Define the fileref with the email engine;
FILENAME genmail 
      email
      subject= "Patient 205 ConMeds"
      to     = "Fred@caloxy.com"
      from   = "Sam@caloxy.com"
      attach = "&path\results\E14_5.pdf";

ods pdf file="&path\results\E14_5.pdf"
        style=journal2;
proc print data=advrpt.conmed(where=(subject='205'));
   id subject;
   var medstdt medspdt drug;
   run;
ods pdf close;

data _null_;
   file genmail;
   put "Here are the ConMeds for Subject 205";
   run;
