* E11_5_1.sas
*
* Traffic lighting format;

proc format;
   value $serious_f
      'YES','yes' = 'white'
      ;
   value $serious_b
      'YES','yes' = 'red'
      ;
   value $severity_f
      '3' = 'black'
      '4','5'= 'white'
      ;
   value $severity_b
      '3' = 'yellow'
      '4','5'= 'red'
      ;
   run;
