* E3_3_7.sas
*
* Update a data set using a transaction file;
******************************************;


title1 '3.3.7 Update a Master';

* Build a transaction file;
data trans; 
   length lname $10 fname $6 sex $1;  
   fname='Mary';  lname='Adams';   sex='N'; output;   
   fname='Joan';  lname='Adamson'; sex='x'; output;
   * The last name is misspelled; 
   fname='Peter'; lname='Anla';    sex='A'; output;
   run;
data newdemog(drop=rc); 
   declare hash upd(hashexp:10);  
      upd.definekey('lname', 'fname');  
      upd.definedata('sex');  
      upd.definedone(); 
   do until(lasttrans);  
      set trans end=lasttrans;  
      rc=upd.add(); 
   end; 
   do until(lastdemog);  
      set advrpt.demog end=lastdemog;  
      rc=upd.find();  
      output newdemog; 
   end;
   stop;
   run;

proc print data=newdemog(obs=4);
   var fname lname sex;
   run;
