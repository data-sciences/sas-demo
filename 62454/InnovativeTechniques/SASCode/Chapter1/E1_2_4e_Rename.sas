*E1_2_4e.sas
*
* Macro to read a CSV file when the header is not in row 1;
%macro rename(headrow=3, rawcsv=, dsn=);
%local lib ds i;
data _null_       ;
    infile "&path\Data\&rawcsv"  
           scanover lrecl=32767 firstobs=&headrow;
    length temp $ 32767;
    input temp $;
    i=1;
    do while(scan(temp,i,',') ne ' ');
      call symputx('var'||left(put(i,4.)),scan(temp,i,','),'l');
      i+1;
    end;
    call symputx('varcnt',i-1,'l');
    stop;
    run;

    %* Determine the library and dataset name;
    %if %scan(&dsn,2,.) = %then %do;
      %let lib=work;
      %let ds = %scan(&dsn,1,.);
    %end;
    %else %do;
      %let lib= %scan(&dsn,1,.);
      %let ds = %scan(&dsn,2,.);
    %end;
    
    proc datasets lib=&lib nolist;
      modify &ds;
      rename
      %do i = 1 %to &varcnt;
         var&i = &&var&i
      %end;
      ;
      quit;
%mend rename;
 
%rename(headrow=3, rawcsv=classwo.csv, dsn=work.classwo)
