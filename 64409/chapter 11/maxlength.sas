/*----------------------------------------------------------------
Without knowing the maximum observed length of a character variable,
  lengths are often assigned to values that are much larger than what 
  is necessary, in order to avoid truncation.  This can result in 
  file sizes that are quite inflated due to this padding.
  
When integrating the same data set across multiple studies, the 
  minimum required length of a variable, based on the maximum length 
  observed, can be dynamically assigned to avoid truncation and to 
  prevent unnecessary padding and file size inflation.  This macro
  can do that dynamic assignment.
      
DATALIST should be a list of similar data sets (for example, from
         different studies) that each contain each variable in 
         VARLIST, separated by a space
         
VARLIST should be a list of character variables for which the
        maximum length is to be examined.  Each variable in the list 
        should be separated by a space.  It is expected that each 
        variable exists in every dataset in DATALIST.                             

Both DATALIST and VARLIST can contain only one item                                          

Set INTEGRATE=1 if you want to have all datasets in DATALIST
    combined into one data set via: SET &DATALIST                                                                         
 
If INTEGRATE=1, then IDS should contain the name of the resulting
   Integrated Data Set
*----------------------------------------------------------------*/

%macro maxlength(datalist, varlist, integrate=0, ids= );

  ** create global macro variables that will contain the
  **   maximum required length for each variable in VARLIST;
  %let wrd = 1;
  %do %while(%scan(&varlist,&wrd)^= );
     %global %scan(&varlist,&wrd)max ;
     %let wrd = %eval(&wrd+1);
  %end;
 
  ** initialize each maximum length to 1;
  %do %while(%scan(&varlist,&wrd)^= );
    %let %scan(&varlist,&wrd)max=1;
    %let wrd = %eval(&wrd+1);
  %end;


  ** find the maximum required length across each data 
  ** set in DATALIST;
  %let d = 1;
  %do %while(%scan(&datalist,&d, )^= );
    %let data=%scan(&datalist,&d, );
    %*put data=&data;
             
    %let wrd = 1;
    data _null_;
      set &data end=eof;
     
      %do %while(%scan(&varlist,&wrd)^= );
        %let thisvar = %scan(&varlist,&wrd) ;
        retain &thisvar.max &&&thisvar.max ;
        &thisvar.max = max(&thisvar.max,length(&thisvar));
        if eof then
          call symput("&thisvar.max", put(&thisvar.max,4.));
        %let wrd = %eval(&wrd+1);
      %end;
    run;
 
    %let d = %eval(&d+1);
  %end;
 
  %let datasets=%eval(&d - 1);
  %if (&integrate=1 and &ids^= ) or &datasets=1 %then
    %do;
                 
      %let wrd = 1;
      data %if &integrate=1 %then &ids; %else &datalist; ;
        length %do %while(%scan(&varlist,&wrd)^= );
                 %let thisvar=%scan(&varlist,&wrd);
                 &thisvar   $&&&thisvar.max..
                 %let wrd = %eval(&wrd+1);
               %end;
        ;
        set &datalist;
      run;
    %end;
  %else %if &integrate=1 and &ids= %then
    %put PROBLEM: Integration requested but parameter IDS is blank;
  ;
 
%mend maxlength;

*code to test the macro;
/*
*options mprint mlogic symbolgen;
data a b c;
  length x y z $200 ;
 
        x = 'CDISC, SDTM, ADaM';
        y = 'Y';
        z = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        output;
        y = 'hi';
        output;
run;


%maxlength(work.a work.b c, x y z, integrate=1, ids=d);

%put xmax=&xmax ymax=&ymax zmax=&zmax;
proc contents
  data = d;
run;
*/

       
               