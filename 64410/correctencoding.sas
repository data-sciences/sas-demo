/* You may want to replace the libref and the encoding value */
%macro correctencoding(path= );
  %local i n;
  libname temp  "&path" ;
  options nofmterr;
  data _null_;
    set sashelp.vtable(where=(libname='TEMP' and memtype='DATA'));
    call symput('table'!!left(put(_n_,2.)),memname);
    call symput('n',left(put(_n_,2.)));
  run;
  %do i=1 %to &n;
 proc datasets nolist library=temp;
     modify &&table&i /correctencoding=ASCIIANY;
    run;
    quit;
  %end;
%mend;