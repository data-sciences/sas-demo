* E3_6_5.sas
* 
* Variable Information functions;

title1 '3.6.5 Using Variable Information Functions';
*****************************************;
title2 'VNEXT - Attributes of the first Variable';
data attrib;
   set advrpt.lab_chemistry;
   retain name '        ' p_type ' ' p_len .;
   if _n_=1 then do;
      call vnext(name,p_type,p_len);
      output attrib;
   end;
   stop;
   run;
proc print data=attrib;
   run;
*******************************
* List all the variables;
title2 'Using VNEXT to List All the Variables';
%let dsn = advrpt.lab_chemistry;
data listallvar(keep=dsn name type len);
   if 0 then set &dsn;
   length name $15;
   retain dsn "&dsn" type ' ' len .;
   name= ' ';
   do until (name=' ');
      call vnext(name,type,len);
      output listallvar;
   end;
   stop;
   run;
proc print data=listallvar;
   run;


*******************************
* List the primary variables;
title2 'Using VNEXT to List the Primary Variables';
%let dsn = advrpt.lab_chemistry;
data listvar(keep=dsn name type len);
   if 0 then set &dsn;
   length name $15;
   retain dsn "&dsn" type ' ' len .;
   name= ' ';
   do until (name='name');
      call vnext(name,type,len);
      if name ne 'name' then output listvar;
   end;
   stop;
   run;
proc print data=listvar;
   run;


